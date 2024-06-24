import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';

import '../_common/LocalCryptoDatabaseDataSource.dart';

class LocalCryptoDatabaseDataSourceImpl implements LocalCryptoDatabaseDataSource {
  @override
  LocalCryptoDatabaseDataSourceDao dao;

  LocalCryptoDatabaseDataSourceImpl({required this.dao});
  
  @override
  Future<List<LocalDatabaseCrypto>> getCryptocurrencies(int count) async {
    final cryptocurrencyEntities = await dao.getCryptocurrencies(count);

    return cryptocurrencyEntities.map((entity) => LocalDatabaseCrypto.fromEntity(entity)).toList();
  }

  @override
  Future<LocalDatabaseCrypto?> getCryptocurrencyByToken(String token) async {
    final cryptocurrencyEntity = await dao.getCryptocurrencyByToken(token);

    if (cryptocurrencyEntity == null) return null;
  
    return LocalDatabaseCrypto.fromEntity(cryptocurrencyEntity);
  }

  @override
  Future<void> saveCryptocurrencies(List<LocalDatabaseCrypto> cryptocurrencies) {
    return dao.saveCryptocurrencies(cryptocurrencies.map((item) => item.toEntity()).toList());
  }
}