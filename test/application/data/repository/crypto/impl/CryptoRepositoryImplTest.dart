import 'package:async/async.dart';
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

      StreamQueue queuedDataCryptoStream = StreamQueue(cryptoRepositoryImpl.dataCryptoStream);

      await cryptoRepositoryImpl.loadCryptocurrencies(count);

      final List<DataCrypto> gottenDataCryptoListFromLocal = await queuedDataCryptoStream.next;
      final List<DataCrypto> gottenDataCryptoListFromRemote = await queuedDataCryptoStream.next;

      verify(localCryptoDatabaseDataSourceMock.getCryptocurrencies(any));
      verify(remoteCryptoHttpRestDataSourceMock.getCryptocurrencies(any));
      verify(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any));
      verify(cryptocurrencyUpdaterMock.setCallback(any));

      expect(listEquals(gottenDataCryptoListFromLocal, expectedDataCryptoListFromLocal), isTrue);
      expect(listEquals(gottenDataCryptoListFromRemote, expectedDataCryptoListFromRemote), isTrue);
      expect(listEquals(gottenLocalDatabaseCryptoToSaveList, expectedLocalDatabaseCryptoToSaveList), isTrue);
    });

    test('addToFavorites() test', () async {
      const LocalDatabaseCrypto localDatabaseCrypto = 
        LocalDatabaseCrypto(
          token: 'token', 
          name: 'name', 
          price: 1, 
          isFavorite: false, 
          capitalization: 2
        );

      final LocalDatabaseCrypto expectedLocalDatabaseCryptoToSave = localDatabaseCrypto.copyWith(newIsFavorite: true);

      late LocalDatabaseCrypto gottenLocalDatabaseCryptoToSave;    

      final MockLocalCryptoDatabaseDataSource localCryptoDatabaseDataSourceMock =
        MockLocalCryptoDatabaseDataSource();
        
      when(localCryptoDatabaseDataSourceMock.getCryptocurrencyByToken(localDatabaseCrypto.token))
        .thenAnswer((invocation) async => localDatabaseCrypto);
      when(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any))
        .thenAnswer((invocation) async {
          gottenLocalDatabaseCryptoToSave = 
            (invocation.positionalArguments.first as List<LocalDatabaseCrypto>).first;
        });

      final MockRemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSourceMock =
        MockRemoteCryptoHttpRestDataSource();
      final MockCryptocurrencyUpdater cryptocurrencyUpdaterMock = MockCryptocurrencyUpdater();
      
      final CryptoRepositoryImpl cryptoRepositoryImpl = CryptoRepositoryImpl(
        localCryptoDatabaseDataSource: localCryptoDatabaseDataSourceMock, 
        remoteCryptoHttpRestDataSource: remoteCryptoHttpRestDataSourceMock, 
        cryptocurrencyUpdater: cryptocurrencyUpdaterMock
      );

      await cryptoRepositoryImpl.addToFavorites(localDatabaseCrypto.token);

      verify(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any));

      expect(gottenLocalDatabaseCryptoToSave, expectedLocalDatabaseCryptoToSave);
    });

    test('removeFromFavorites() test', () async {
      const LocalDatabaseCrypto localDatabaseCrypto = 
        LocalDatabaseCrypto(
          token: 'token', 
          name: 'name', 
          price: 1, 
          isFavorite: true, 
          capitalization: 2
        );

      final LocalDatabaseCrypto expectedLocalDatabaseCryptoToSave = localDatabaseCrypto.copyWith(newIsFavorite: false);

      late LocalDatabaseCrypto gottenLocalDatabaseCryptoToSave;    

      final MockLocalCryptoDatabaseDataSource localCryptoDatabaseDataSourceMock =
        MockLocalCryptoDatabaseDataSource();
        
      when(localCryptoDatabaseDataSourceMock.getCryptocurrencyByToken(localDatabaseCrypto.token))
        .thenAnswer((invocation) async => localDatabaseCrypto);
      when(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any))
        .thenAnswer((invocation) async {
          gottenLocalDatabaseCryptoToSave = 
            (invocation.positionalArguments.first as List<LocalDatabaseCrypto>).first;
        });

      final MockRemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSourceMock =
        MockRemoteCryptoHttpRestDataSource();
      final MockCryptocurrencyUpdater cryptocurrencyUpdaterMock = MockCryptocurrencyUpdater();
      
      final CryptoRepositoryImpl cryptoRepositoryImpl = CryptoRepositoryImpl(
        localCryptoDatabaseDataSource: localCryptoDatabaseDataSourceMock, 
        remoteCryptoHttpRestDataSource: remoteCryptoHttpRestDataSourceMock, 
        cryptocurrencyUpdater: cryptocurrencyUpdaterMock
      );

      await cryptoRepositoryImpl.removeFromFavorites(localDatabaseCrypto.token);

      verify(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any));

      expect(gottenLocalDatabaseCryptoToSave, expectedLocalDatabaseCryptoToSave);
    });

    test('onCryptocurrenciesGotten() test', () async {
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

      final List<DataCrypto> expectedDataCryptoListFromRemote = 
        remoteHttpRestCryptoList.map((elem) => DataCrypto.fromRemoteHttpRest(
          remoteHttpRestCrypto: elem,
          isFavorite: localDatabaseCrypto.isFavorite
        )).toList();
      final List<LocalDatabaseCrypto> expectedLocalDatabaseCryptoToSaveList = 
        expectedDataCryptoListFromRemote.map((elem) => elem.toLocalDatabase()).toList();

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

      final MockCryptocurrencyUpdater cryptocurrencyUpdaterMock = MockCryptocurrencyUpdater();
      
      when(cryptocurrencyUpdaterMock.setCallback(any)).thenAnswer((invocation) {
        updaterCallback = invocation.positionalArguments.first;
      });
      
      final CryptoRepositoryImpl cryptoRepositoryImpl = CryptoRepositoryImpl(
        localCryptoDatabaseDataSource: localCryptoDatabaseDataSourceMock, 
        remoteCryptoHttpRestDataSource: remoteCryptoHttpRestDataSourceMock, 
        cryptocurrencyUpdater: cryptocurrencyUpdaterMock
      );

      StreamQueue queuedDataCryptoStream = StreamQueue(cryptoRepositoryImpl.dataCryptoStream);

      await cryptoRepositoryImpl.onCryptocurrenciesGotten(count, remoteHttpRestCryptoList);

      final List<DataCrypto> gottenDataCryptoListFromRemote = await queuedDataCryptoStream.next;

      verify(localCryptoDatabaseDataSourceMock.getCryptocurrencies(any));
      verifyNever(remoteCryptoHttpRestDataSourceMock.getCryptocurrencies(any));
      verify(localCryptoDatabaseDataSourceMock.saveCryptocurrencies(any));
      verify(cryptocurrencyUpdaterMock.setCallback(any));

      expect(listEquals(gottenDataCryptoListFromRemote, expectedDataCryptoListFromRemote), isTrue);
      expect(listEquals(gottenLocalDatabaseCryptoToSaveList, expectedLocalDatabaseCryptoToSaveList), isTrue);
    });
  });
}