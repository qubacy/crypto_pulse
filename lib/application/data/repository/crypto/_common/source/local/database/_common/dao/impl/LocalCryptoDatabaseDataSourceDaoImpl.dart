import 'package:sqflite_common/sqlite_api.dart';

import '../_common/LocalCryptoDatabaseDataSourceDao.dart';
import '../_common/entity/CryptoEntity.dart';

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
  Future<void> saveCryptocurrencies(List<CryptoEntity> cryptocurrencies) async {
    return database.transaction((tx) async {
      for (CryptoEntity cryptocurrency in cryptocurrencies) {
        final selectedCryptocurrency = await tx.query(
          CryptoEntity.TABLE_NAME,
          where: '${CryptoEntity.TOKEN_PROP_NAME} = ?',
          whereArgs: [cryptocurrency.token]
        );
        final cryptocurrencyMap = cryptocurrency.toMap();

        if (selectedCryptocurrency.isEmpty) {
          database.insert(CryptoEntity.TABLE_NAME, cryptocurrencyMap);
        } else {
          database.update(CryptoEntity.TABLE_NAME, cryptocurrencyMap);
        }
      }

      return Future.value();
    });
  }
}