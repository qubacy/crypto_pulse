import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';
import 'package:injectable/injectable.dart';

import '../_common/LocalCryptoDatabaseDataSource.dart';

@Injectable(as: LocalCryptoDatabaseDataSource)
class LocalCryptoDatabaseDataSourceImpl implements LocalCryptoDatabaseDataSource {
  @override
  LocalCryptoDatabaseDataSourceDao dao;

  LocalCryptoDatabaseDataSourceImpl({required this.dao});
  
  @override
  Future<List<LocalDatabaseCrypto>> getCryptocurrencies(int count) async {
    final cryptoEntities = await dao.getCryptocurrencies(count);

    return cryptoEntities.map((entity) => LocalDatabaseCrypto.fromEntity(entity)).toList();
  }

  @override
  Future<LocalDatabaseCrypto?> getCryptocurrencyByToken(String token) async {
    final cryptocurrencyEntity = await dao.getCryptocurrencyByToken(token);

    if (cryptocurrencyEntity == null) return null;
  
    return LocalDatabaseCrypto.fromEntity(cryptocurrencyEntity);
  }

  @override
  Future<List<LocalDatabaseCrypto>> getFavorites() async {
    final cryptoEntities = await dao.getFavorites();

    return cryptoEntities.map((entity) => LocalDatabaseCrypto.fromEntity(entity)).toList();
  }

  @override
  Future<void> saveCryptocurrencies(List<LocalDatabaseCrypto> cryptocurrencies) {
    return dao.saveCryptocurrencies(cryptocurrencies.map((item) => item.toEntity()).toList());
  }

  @override
  Future<void> updateCryptocurrency(LocalDatabaseCrypto cryptocurrency) {
    return dao.updateCryptocurrency(cryptocurrency.toEntity());
  }
}