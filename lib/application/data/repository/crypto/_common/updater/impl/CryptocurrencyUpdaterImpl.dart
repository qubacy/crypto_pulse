import 'dart:isolate';

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/_di/initializer/CryptocurrencyUpdaterGraphInitializer.dart';
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart';
import 'package:crypto_pulse/di/di.dart';
import 'package:injectable/injectable.dart';

import '../../../../_common/source/http/context/_common/HttpContext.dart';

class IntWrapper {
  int _value;
  int get value => _value;
  set value(int value) => _value = value;

  IntWrapper({int value = 0}) : _value = value;
}

@Injectable(as: CryptocurrencyUpdater)
class CryptocurrencyUpdaterImpl extends CryptocurrencyUpdater {
  final RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource;

  final LocalTokenEnvironmentDataSource localTokenEnvironmentDataSource;
  final HttpContext httpContext;
  final CryptocurrencyUpdaterGraphInitializer cryptocurrencyUpdaterGraphInitializer;

  CryptocurrencyUpdaterImpl({
    required this.remoteCryptoHttpRestDataSource,
    required this.localTokenEnvironmentDataSource,
    required this.httpContext,
    required this.cryptocurrencyUpdaterGraphInitializer
  });

  ReceivePort? _receivePort;
  Stream<dynamic>? _receiveBroadcastStream;
  Isolate? _isolate;
  late SendPort _sendPort;

  late int _lastCount;

  @override
  void start(int count) async {
    _lastCount = count;

    if (_isolate == null) await _initIsolate();

    _sendPort.send(count);
  }

  Future<void> _initIsolate() async {
    final baseUri = await httpContext.loadUri();
    final token = await localTokenEnvironmentDataSource.loadToken();

    ReceivePort receivePort = ReceivePort();
    List args = [receivePort.sendPort, baseUri, token, cryptocurrencyUpdaterGraphInitializer];

    _isolate = await Isolate.spawn(_update, args);

    _receiveBroadcastStream = receivePort.asBroadcastStream();
    _sendPort = await _receiveBroadcastStream!.first;

    _receivePort = receivePort;

    _startListeningForIsolateData();
  }

  Future<void> _startListeningForIsolateData() async {
    await for (var data in _receiveBroadcastStream!) {
      switch (data) {
        case List<RemoteHttpRestCrypto> remoteHttpRestCryptoList: 
          callback.onCryptocurrenciesGotten(_lastCount, remoteHttpRestCryptoList);
        default: throw const FormatException();
      }
    }
  }

  @override
  void stop() async {
    _receivePort?.close();
    _isolate?.kill();

    _lastCount = 0; // todo: rethink twice;
    _isolate = null;
  }
  
  static void _update(List args) async {
    CryptocurrencyUpdaterGraphInitializer cryptocurrencyUpdaterGraphInitializer = args[3];

    await cryptocurrencyUpdaterGraphInitializer.initGraph([args[1], args[2]]);

    SendPort sendPort = args[0];
    ReceivePort receivePort = ReceivePort();

    RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource = getIt.get<RemoteCryptoHttpRestDataSource>();

    sendPort.send(receivePort.sendPort);

    IntWrapper cryptoCount = IntWrapper();
    
    _startListeningForMessagesInIsolate(receivePort, cryptoCount);

    while (true) {
      print("_update(): ${cryptoCount._value}");

      if (cryptoCount.value > 0) {
        final cryptocurrencies = await remoteCryptoHttpRestDataSource
          .getCryptocurrencies(cryptoCount.value);

        sendPort.send(cryptocurrencies);
      }

      await Future.delayed(CryptocurrencyUpdater.UPDATE_TIMEOUT_DURATION);
    }
  }

  static Future<void> _startListeningForMessagesInIsolate(
    ReceivePort receivePort, 
    IntWrapper cryptoCount
  ) async {
    await for (var data in receivePort) {
      switch (data) {
        case int count: cryptoCount.value = count;
        default: throw const FormatException();
      }
    }
  }
}