import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/LocalCryptoDatabaseDataSourceDao.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/impl/LocalCryptoDatabaseDataSourceImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'LocalCryptoDatabaseDataSourceImplTest.mocks.dart';

@GenerateMocks([LocalCryptoDatabaseDataSourceDao])
void main() {
  group('Local Crypto Database Data Source Implementation tests', () {
    test('getCryptocurrencies() test', () async {
      const int count = 1;

      const CryptoEntity cryptoEntity = CryptoEntity(
        token: 'test', 
        name: 'test', 
        price: 1, 
        isFavorite: true, 
        capitalization: 2
      );
      const List<CryptoEntity> cryptoEntityList = [cryptoEntity];

      final LocalDatabaseCrypto localDatabaseCrypto = LocalDatabaseCrypto.fromEntity(cryptoEntity);
      final List<LocalDatabaseCrypto> expectedLocalDatabaseCryptoList = [localDatabaseCrypto];

      final MockLocalCryptoDatabaseDataSourceDao localCryptoDatabaseDataSourceDaoMock =
        MockLocalCryptoDatabaseDataSourceDao();

      when(localCryptoDatabaseDataSourceDaoMock.getCryptocurrencies(any))
        .thenAnswer((_) async => cryptoEntityList);

      final LocalCryptoDatabaseDataSourceImpl localCryptoDatabaseDataSourceImpl =
       LocalCryptoDatabaseDataSourceImpl(dao: localCryptoDatabaseDataSourceDaoMock);

      final List<LocalDatabaseCrypto> gottenLocalDatabaseCryptoList = 
        await localCryptoDatabaseDataSourceImpl.getCryptocurrencies(count);

      verify(localCryptoDatabaseDataSourceDaoMock.getCryptocurrencies(any));

      expect(listEquals(gottenLocalDatabaseCryptoList, expectedLocalDatabaseCryptoList), isTrue);
    });

    test('saveCryptocurrencies() test', () async {
      const LocalDatabaseCrypto localDatabaseCrypto = LocalDatabaseCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        isFavorite: true, 
        capitalization: 2
      );
      const List<LocalDatabaseCrypto> localDatabaseCryptoList = [localDatabaseCrypto];

      final List<CryptoEntity> expectedCryptoEntityList = 
        localDatabaseCryptoList.map((elem) => elem.toEntity()).toList();

      final MockLocalCryptoDatabaseDataSourceDao localCryptoDatabaseDataSourceDaoMock =
        MockLocalCryptoDatabaseDataSourceDao();

      late List<CryptoEntity> gottenCryptoEntityList;

      when(localCryptoDatabaseDataSourceDaoMock.saveCryptocurrencies(any))
        .thenAnswer((invocation) async {
          gottenCryptoEntityList = invocation.positionalArguments.first;
        });

      final LocalCryptoDatabaseDataSourceImpl localCryptoDatabaseDataSourceImpl =
       LocalCryptoDatabaseDataSourceImpl(dao: localCryptoDatabaseDataSourceDaoMock);

      await localCryptoDatabaseDataSourceImpl.saveCryptocurrencies(localDatabaseCryptoList);

      verify(localCryptoDatabaseDataSourceDaoMock.saveCryptocurrencies(any));

      expect(listEquals(gottenCryptoEntityList, expectedCryptoEntityList), isTrue);
    });
  });
}