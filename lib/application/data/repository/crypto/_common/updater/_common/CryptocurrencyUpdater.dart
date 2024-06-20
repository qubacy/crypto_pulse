import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';

abstract class CryptocurrencyUpdaterCallback {
  void onCryptocurrenciesGotten(int count, List<RemoteHttpRestCrypto> cryptocurrencies);
}

abstract class CryptocurrencyUpdater {
  static const UPDATE_TIMEOUT_DURATION = Duration(seconds: 10);

  late CryptocurrencyUpdaterCallback _callback;
  CryptocurrencyUpdaterCallback get callback => _callback;

  void setCallback(CryptocurrencyUpdaterCallback callback) {
    _callback = callback;
  }

  void start(int count);
  void stop();
}