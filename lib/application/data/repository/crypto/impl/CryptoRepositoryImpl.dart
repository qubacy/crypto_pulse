import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:rxdart/rxdart.dart';

class CryptoRepositoryImpl extends CryptoRepository {
  final BehaviorSubject<List<DataCrypto>> _cryptoStreamController = BehaviorSubject();

  CryptoRepositoryImpl() {
    dataCryptoStream = _cryptoStreamController.stream;
  }
  
  @override
  void loadCryptocurrencies(int count) {
    // TODO: implement loadCryptocurrencies


  }
  
  @override
  void addToFavorites(DataCrypto crypto) {
    // TODO: implement addToFavorites


  }
  
  @override
  void removeFromFavorites(DataCrypto crypto) {
    // TODO: implement removeFromFavorites


  }
}