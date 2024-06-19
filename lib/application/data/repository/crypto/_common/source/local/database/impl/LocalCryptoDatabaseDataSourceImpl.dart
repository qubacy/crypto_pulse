import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';

import 'package:sqflite_common/sqlite_api.dart';

import '../_common/LocalCryptoDatabaseDataSource.dart';

class LocalCryptoDatabaseDataSourceImpl implements LocalCryptoDatabaseDataSource {
  @override
  LocalCryptoDatabaseDataSourceDao dao;

  LocalCryptoDatabaseDataSourceImpl({required this.dao});
  
  @override
  Future<List<LocalDatabaseCrypto>> getCryptocurrencies(int count) {
    // TODO: implement getCryptocurrencies
    throw UnimplementedError();
  }

  @override
  Future<void> saveCryptocurrencies(List<LocalDatabaseCrypto> cryptocurrencies) {
    // TODO: implement saveCryptocurrencies
    throw UnimplementedError();
  }
}