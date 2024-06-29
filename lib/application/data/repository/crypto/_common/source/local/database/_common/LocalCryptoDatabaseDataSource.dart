import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/_common/LocalCryptoDatabaseDataSourceDao.dart';

abstract class LocalCryptoDatabaseDataSource {
  late final LocalCryptoDatabaseDataSourceDao dao;

  Future<List<LocalDatabaseCrypto>> getCryptocurrencies(int count);
  Future<LocalDatabaseCrypto?> getCryptocurrencyByToken(String token);
  Future<List<LocalDatabaseCrypto>> getFavorites();
  Future<void> saveCryptocurrencies(List<LocalDatabaseCrypto> cryptocurrencies);
}