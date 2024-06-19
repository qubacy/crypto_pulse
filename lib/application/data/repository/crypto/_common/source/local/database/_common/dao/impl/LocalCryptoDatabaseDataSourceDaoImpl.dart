
import 'package:sqflite_common/sqlite_api.dart';

import '../_common/LocalCryptoDatabaseDataSourceDao.dart';
import '../_common/entity/CryptoEntity.dart';

class LocalCryptoDatabaseDataSourceDaoImpl implements LocalCryptoDatabaseDataSourceDao {
  @override
  Database database;

  LocalCryptoDatabaseDataSourceDaoImpl({required this.database});
  
  @override
  Future<List<CryptoEntity>> getCryptocurrencies(int count) {
    // TODO: implement getCryptocurrencies
    throw UnimplementedError();
  }
  
  @override
  Future<void> saveCryptocurrencies(List<CryptoEntity> cryptocurrencies) {
    // TODO: implement saveCryptocurrencies
    throw UnimplementedError();
  }
}