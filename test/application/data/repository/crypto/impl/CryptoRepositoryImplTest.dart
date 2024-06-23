import 'dart:ffi';

import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/LocalCryptoDatabaseDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';
import 'package:crypto_pulse/application/data/repository/crypto/impl/CryptoRepositoryImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'CryptoRepositoryImplTest.mocks.dart';

@GenerateMocks([LocalCryptoDatabaseDataSource, RemoteCryptoHttpRestDataSource, CryptocurrencyUpdater])
void main() {
  group('Crypto Repository Implementation tests', () {
    test('loadCryptocurrencies() test', () async {
      const int count = 1;

      const LocalDatabaseCrypto localDatabaseCrypto = LocalDatabaseCrypto(
        token: 'test local', 
        name: 'test local', 
        price: 1, 
        isFavorite: false, 
        capitalization: 2
      );
      const List<LocalDatabaseCrypto> localDatabaseCryptoList = [
        localDatabaseCrypto
      ];

      const RemoteHttpRestCrypto remoteHttpRestCrypto = RemoteHttpRestCrypto(
        token: 'test remote', 
        name: 'test remote', 
        price: 1, 
        capitalization: 2
      );
      const List<RemoteHttpRestCrypto> remoteHttpRestCryptoList = [
        remoteHttpRestCrypto
      ];

      final List<DataCrypto> expectedDataCryptoListFromLocal = 
        localDatabaseCryptoList.map((elem) => DataCrypto.fromLocalDatabase(elem)).toList();
      final List<DataCrypto> expectedDataCryptoListFromRemote = 
        remoteHttpRestCryptoList.map((elem) => DataCrypto.fromRemoteHttpRest(
          remoteHttpRestCrypto: elem,
          isFavorite: localDatabaseCrypto.isFavorite
        )).toList();
      final List<LocalDatabaseCrypto> expectedLocalDatabaseCryptoToSaveList = 
        expectedDataCryptoListFromRemote.map((elem) => elem.toLocalDatabase()).toList();
      final int expectedDataCryptoStreamResultCount = 2;

      late CryptocurrencyUpdaterCallback updaterCallback;
      late List<LocalDatabaseCrypto> gottenLocalDatabaseCryptoToSaveList;

      final MockLocalCryptoDatabaseDataSource localCryptoDatabaseDataSourceMock =
        MockLocalCryptoDatabaseDataSource();

      when(localCryptoDatabaseDataSourceMock.getCryptocurrencies(any))
        .thenAnswer((_) async => localDatabaseCryptoList);
      when(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any))
        .thenAnswer((invocation) async {
          gottenLocalDatabaseCryptoToSaveList = invocation.positionalArguments.first;
        });

      final MockRemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSourceMock =
        MockRemoteCryptoHttpRestDataSource();

      when(remoteCryptoHttpRestDataSourceMock.getCryptocurrencies(any))
        .thenAnswer((_) async => remoteHttpRestCryptoList);

      final MockCryptocurrencyUpdater cryptocurrencyUpdaterMock = MockCryptocurrencyUpdater();
      
      when(cryptocurrencyUpdaterMock.setCallback(any)).thenAnswer((invocation) {
        updaterCallback = invocation.positionalArguments.first;
      });
      
      final CryptoRepositoryImpl cryptoRepositoryImpl = CryptoRepositoryImpl(
        localCryptoDatabaseDataSource: localCryptoDatabaseDataSourceMock, 
        remoteCryptoHttpRestDataSource: remoteCryptoHttpRestDataSourceMock, 
        cryptocurrencyUpdater: cryptocurrencyUpdaterMock
      );

      cryptoRepositoryImpl.loadCryptocurrencies(count);

      final gottenDataCryptoListFromLocal = await cryptoRepositoryImpl.dataCryptoStream.first;
      final gottenDataCryptoListFromRemote = await cryptoRepositoryImpl.dataCryptoStream.skip(1).first;

      verify(localCryptoDatabaseDataSourceMock.getCryptocurrencies(any));
      verify(remoteCryptoHttpRestDataSourceMock.getCryptocurrencies(any));
      verify(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any));
      verify(cryptocurrencyUpdaterMock.setCallback(any));

      // int dataCryptoStreamResultCount = 0;

      // await for (List<DataCrypto> dataCryptoList in cryptoRepositoryImpl.dataCryptoStream) {
      //   switch (dataCryptoStreamResultCount) {
      //     case 0: expect(listEquals(dataCryptoList, expectedDataCryptoListFromLocal), isTrue);
      //     case 1: expect(listEquals(dataCryptoList, expectedDataCryptoListFromRemote), isTrue);
      //     default: break;
      //   }

      //   ++dataCryptoStreamResultCount;
      // }

      expect(listEquals(gottenLocalDatabaseCryptoToSaveList, expectedLocalDatabaseCryptoToSaveList), isTrue);
    });

    test('addToFavorites() test', () {

    });

    test('removeFromFavorites() test', () {

    });

    test('onCryptocurrenciesGotten() test', () {

    });
  });
}