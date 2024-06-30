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
  Future<List<CryptoEntity>> getFavorites() async {
    final rawEntities = await database.query(
      CryptoEntity.TABLE_NAME, 
      where: '${CryptoEntity.IS_FAVORITE_PROP_NAME} = ?', 
      whereArgs: [1]
    );

    return rawEntities.map((element) => CryptoEntity.fromMap(element)).toList();
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

          cryptocurrencyMap.remove(CryptoEntity.IS_FAVORITE_PROP_NAME);

          await tx.update(
            CryptoEntity.TABLE_NAME, 
            cryptocurrencyMap, 
            where: '${CryptoEntity.TOKEN_PROP_NAME} = ?', 
            whereArgs: [token]
          );
        }
      }
    });

    return Future.value();
  }
  
  @override
  Future<void> updateCryptocurrency(CryptoEntity cryptocurrency) async {
    final cryptocurrencyMap = cryptocurrency.toMap();
    final token = cryptocurrencyMap.remove(CryptoEntity.TOKEN_PROP_NAME);

    await database.update(
      CryptoEntity.TABLE_NAME, 
      cryptocurrencyMap,
      where: '${CryptoEntity.TOKEN_PROP_NAME} = ?', 
      whereArgs: [token]
    );
  }
}