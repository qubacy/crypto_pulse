import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';

abstract class CryptoRepository {
  late final Stream<List<DataCrypto>> dataCryptoStream;

  void loadCryptocurrencies(int count);
  void addToFavorites(DataCrypto crypto);
  void removeFromFavorites(DataCrypto crypto);
}