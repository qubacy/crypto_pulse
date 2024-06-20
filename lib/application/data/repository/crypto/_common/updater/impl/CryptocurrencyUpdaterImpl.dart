import 'dart:isolate';

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';

class CryptocurrencyUpdaterImpl extends CryptocurrencyUpdater {
  RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource;

  CryptocurrencyUpdaterImpl({required this.remoteCryptoHttpRestDataSource});

  final ReceivePort _receivePort = ReceivePort();
  Isolate? _isolate;
  late SendPort _sendPort;

  late int _lastCount;

  @override
  void start(int count) async {
    _lastCount = count;

    if (_isolate == null) _initIsolate();

    _sendPort.send(count);
  }

  void _initIsolate() async {
    _isolate = await Isolate.spawn(_update, _receivePort.sendPort);
    _sendPort = await _receivePort.first;

    _receivePort.listen((data) {
      final cryptocurrencies = data as List<RemoteHttpRestCrypto>;

      callback.onCryptocurrenciesGotten(_lastCount, cryptocurrencies);
    });
  }

  @override
  void stop() async {
    _isolate?.kill();

    _lastCount = 0; // todo: rethink twice;
    _isolate = null;
  }
  
  void _update(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();

    sendPort.send(receivePort.sendPort);

    int cryptoCount = 0;

    receivePort.listen((dynamic data) {
      switch (data) {
        case int count: cryptoCount = count;
        default: throw FormatException();
      }
    });

    while (true) {
      await Future.delayed(CryptocurrencyUpdater.UPDATE_TIMEOUT_DURATION);

      final cryptocurrencies = await remoteCryptoHttpRestDataSource.getCryptocurrencies(cryptoCount);

      sendPort.send(cryptocurrencies);
    }
  }
}