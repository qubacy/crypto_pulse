import 'package:injectable/injectable.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../_common/LocalCryptoDatabaseDataSourceDao.dart';
import '../_common/entity/CryptoEntity.dart';

@Injectable(as: LocalCryptoDatabaseDataSourceDao)
class LocalCryptoDatabaseDataSourceDaoImpl implements LocalCryptoDatabaseDataSourceDao {
  @override
  Database database;

  LocalCryptoDatabaseDataSourceDaoImpl({required this.database});
  
  @override
  Future<List<CryptoEntity>> getCryptocurrencies(int count) async {
    final rawCryptoEntities = await database.query(
      CryptoEntity.TABLE_NAME, 
      orderBy: '${CryptoEntity.CAPITALIZATION_PROP_NAME} DESC', 
      limit: count
    );

    return rawCryptoEntities.map((entity) => CryptoEntity.fromMap(entity)).toList();
  }

  @override
  Future<CryptoEntity?> getCryptocurrencyByToken(String token) async {
    final rawCryptoEntity = (await database.query(
      CryptoEntity.TABLE_NAME, 
      where: "${CryptoEntity.TOKEN_PROP_NAME} = ?",
      whereArgs: [token]
    )).firstOrNull;

    if (rawCryptoEntity == null) return null;
    
    return CryptoEntity.fromMap(rawCryptoEntity);
  }
  
  @override
  Future<void> saveCryptocurrencies(List<CryptoEntity> cryptocurrencies) async {
    await database.transaction((tx) async {
      for (CryptoEntity cryptocurrency in cryptocurrencies) {
        final selectedCryptocurrency = await tx.query(
          CryptoEntity.TABLE_NAME,
          where: '${CryptoEntity.TOKEN_PROP_NAME} = ?',
          whereArgs: [cryptocurrency.token]
        );
        final cryptocurrencyMap = cryptocurrency.toMap();

        if (selectedCryptocurrency.isEmpty) {
          await tx.insert(CryptoEntity.TABLE_NAME, cryptocurrencyMap);
        } else {
          final token = cryptocurrencyMap.remove(CryptoEntity.TOKEN_PROP_NAME);

          await tx.update(CryptoEntity.TABLE_NAME, cryptocurrencyMap, where: '${CryptoEntity.TOKEN_PROP_NAME} = ?', whereArgs: [token]);
        }
      }
    });

    return Future.value();
  }
}