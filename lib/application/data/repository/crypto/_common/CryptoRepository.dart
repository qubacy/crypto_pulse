import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';

import 'source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';

abstract class CryptoRepository {
  late final LocalCryptoDatabaseDataSource localCryptoDatabaseDataSource;
  late final RemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSource;
  late final CryptocurrencyUpdater cryptocurrencyUpdater;

  late final Stream<List<DataCrypto>> dataCryptoStream;

  void loadCryptocurrencies(int count);
  void addToFavorites(String cryptoToken);
  void removeFromFavorites(String cryptoToken);
}