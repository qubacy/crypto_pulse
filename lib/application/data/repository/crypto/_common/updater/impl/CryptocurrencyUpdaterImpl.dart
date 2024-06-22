import 'dart:isolate';

import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';

class IntWrapper {
  int _value;
  int get value => _value;
  set value(int value) => _value = value;

  IntWrapper({int value = 0}) : _value = value;
}

class CryptocurrencyUpdaterImpl extends CryptocurrencyUpdater {
  RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource;

  CryptocurrencyUpdaterImpl({required this.remoteCryptoHttpRestDataSource});

  ReceivePort? _receivePort;
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
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_update, _receivePort!.sendPort);
    _sendPort = await _receivePort!.first;

    _startListeningForIsolateData();
  }

  Future<void> _startListeningForIsolateData() async {
    await for (var data in _receivePort!) {
      final cryptocurrencies = data as List<RemoteHttpRestCrypto>;

      callback.onCryptocurrenciesGotten(_lastCount, cryptocurrencies);
    }
  }

  @override
  void stop() async {
    _receivePort?.close();
    _isolate?.kill();

    _lastCount = 0; // todo: rethink twice;
    _isolate = null;
  }
  
  void _update(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();

    sendPort.send(receivePort.sendPort);

    IntWrapper cryptoCount = IntWrapper();
    
    _startListeningForMessagesInIsolate(receivePort, cryptoCount);

    while (true) {
      if (cryptoCount.value > 0) {
        final cryptocurrencies = await remoteCryptoHttpRestDataSource
          .getCryptocurrencies(cryptoCount.value);

        sendPort.send(cryptocurrencies);
      }

      await Future.delayed(CryptocurrencyUpdater.UPDATE_TIMEOUT_DURATION);
    }
  }

  Future<void> _startListeningForMessagesInIsolate(
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