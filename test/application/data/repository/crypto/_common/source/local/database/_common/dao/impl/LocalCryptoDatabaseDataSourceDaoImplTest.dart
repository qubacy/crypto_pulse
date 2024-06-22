import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/impl/LocalCryptoDatabaseDataSourceDaoImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'LocalCryptoDatabaseDataSourceDaoImplTest.mocks.dart';

MockDatabase mockDatabaseForSaveCryptocurrencies(MockTransaction transactionMock) {
  final MockDatabase databaseMock = MockDatabase();

  when(databaseMock.transaction(any)).thenAnswer((invocation) async {
    final transactionBody = invocation.positionalArguments.first as Function;

    transactionBody(transactionMock);
  });

  return databaseMock;
}

@GenerateMocks([Database, Transaction])
void main() {
  group('Local Crypto Database Data Source Dao Implementation tests', () {
    test('getCryptocurrencies() test', () async {
      const count = 1;

      const cryptoEntity = CryptoEntity(
        token: 'test', 
        name: 'test', 
        price: 1, 
        isFavorite: true, 
        capitalization: 2
      );
      final expectedCryptoEntityList = [cryptoEntity];
      final entityMap = cryptoEntity.toMap();
      final entityMapList = [entityMap];

      final MockDatabase databaseMock = MockDatabase();

      when(databaseMock.query(any, orderBy: anyNamed("orderBy"), limit: anyNamed("limit")))
        .thenAnswer((_) async => entityMapList);

      final localCryptoDatabaseDataSourceDaoImpl = LocalCryptoDatabaseDataSourceDaoImpl(database: databaseMock);

      final gottenCryptoEntityList = await localCryptoDatabaseDataSourceDaoImpl.getCryptocurrencies(count);

      verify(databaseMock.query(any, orderBy: anyNamed("orderBy"), limit: anyNamed("limit")));

      expect(listEquals(gottenCryptoEntityList, expectedCryptoEntityList), isTrue);
    });

    test('saveCryptocurrencies() on new data test', () async {
      const cryptoEntity = CryptoEntity(
        token: 'text', 
        name: 'text', 
        price: 1, 
        isFavorite: false, 
        capitalization: 2
      );
      final cryptoEntityList = [cryptoEntity];
      final List<Map<String, Object?>> selectedEntityMapList = [];

      final MockTransaction transactionMock = MockTransaction();

      when(transactionMock.query(any, where: anyNamed("where"), whereArgs: anyNamed("whereArgs")))
        .thenAnswer((_) async => selectedEntityMapList);
      when(transactionMock.insert(any, any)).thenAnswer((_) async => cryptoEntityList.length);

      final MockDatabase databaseMock = mockDatabaseForSaveCryptocurrencies(transactionMock);

      final LocalCryptoDatabaseDataSourceDaoImpl localCryptoDatabaseDataSourceDaoImpl =
        LocalCryptoDatabaseDataSourceDaoImpl(database: databaseMock);

      await localCryptoDatabaseDataSourceDaoImpl.saveCryptocurrencies(cryptoEntityList);

      verify(databaseMock.transaction(any));
      verify(transactionMock.query(any, where: anyNamed("where"), whereArgs: anyNamed("whereArgs")));
      verify(transactionMock.insert(any, any));
    });

    test('saveCryptocurrencies() on existing data test', () async {
      const cryptoEntity = CryptoEntity(
        token: 'text', 
        name: 'text', 
        price: 1, 
        isFavorite: false, 
        capitalization: 2
      );
      final cryptoEntityList = [cryptoEntity];
      final List<Map<String, Object?>> selectedEntityMapList = [{}];

      final MockTransaction transactionMock = MockTransaction();

      when(transactionMock.query(any, where: anyNamed("where"), whereArgs: anyNamed("whereArgs")))
        .thenAnswer((_) async => selectedEntityMapList);
      when(transactionMock.update(any, any)).thenAnswer((_) async => cryptoEntityList.length);

      final MockDatabase databaseMock = mockDatabaseForSaveCryptocurrencies(transactionMock);

      final LocalCryptoDatabaseDataSourceDaoImpl localCryptoDatabaseDataSourceDaoImpl =
        LocalCryptoDatabaseDataSourceDaoImpl(database: databaseMock);

      await localCryptoDatabaseDataSourceDaoImpl.saveCryptocurrencies(cryptoEntityList);

      verify(databaseMock.transaction(any));
      verify(transactionMock.query(any, where: anyNamed("where"), whereArgs: anyNamed("whereArgs")));
      verify(transactionMock.update(any, any));
    });
  });
}