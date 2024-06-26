import 'package:sqflite/sqflite.dart';

import 'entity/CryptoEntity.dart';

abstract class LocalCryptoDatabaseDataSourceDao {
  late final Database database;

  Future<List<CryptoEntity>> getCryptocurrencies(int count);
  Future<CryptoEntity?> getCryptocurrencyByToken(String token);
  Future<List<CryptoEntity>> getFavorites();
  Future<void> saveCryptocurrencies(List<CryptoEntity> cryptocurrencies);
  Future<void> updateCryptocurrency(CryptoEntity cryptocurrency);
}