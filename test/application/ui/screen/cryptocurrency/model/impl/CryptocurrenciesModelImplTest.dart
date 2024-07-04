import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/impl/CryptocurrenciesModelImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'CryptocurrenciesModelImplTest.mocks.dart';

MockCryptoRepository createCryptoRepositoryMock({
  Stream<List<DataCrypto>>? dataCryptoStreamArg
}) {
  final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamArg ?? const Stream.empty();

  final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

  when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => dataCryptoStream);

  return cryptoRepositoryMock;
}

@GenerateMocks([CryptoRepository])
void main() {
  group('Cryptocurrencies Model Implementation tests', () {
    test('cryptoPresentationStream test', () async {
      final StreamController<List<DataCrypto>> dataCryptoStreamController = StreamController();
      final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamController.stream;

      const DataCrypto dataCrypto = DataCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2, 
        isFavorite: false
      );
      final List<DataCrypto> dataCryptoList = [dataCrypto];

      const expectedIsLoading = false;
      final expectedCryptoPresentationList = dataCryptoList.map((item) => CryptoPresentation.fromDataCrypto(item)).toList();
      final expectedLastChunkSize = expectedCryptoPresentationList.length;
      final expectedLastCryptoPresentationList = expectedCryptoPresentationList;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock(dataCryptoStreamArg: dataCryptoStream);

      final CryptocurrenciesModelImpl cryptocurrenciesModelImpl = CryptocurrenciesModelImpl(cryptoRepositoryMock);

      final cryptoPresentationListStream = cryptocurrenciesModelImpl.cryptoPresentationStream;

      cryptocurrenciesModelImpl.getAllCryptoPresentations();
      dataCryptoStreamController.add(dataCryptoList);

      final gottenCryptoPresentationList = await cryptoPresentationListStream.first;
      final gottenIsLoading = cryptocurrenciesModelImpl.isLoading;
      final gottenLastChunkSize = cryptocurrenciesModelImpl.lastChunkSize;
      final gottenLastCryptoPresentationList = cryptocurrenciesModelImpl.lastCryptoPresentationList;

      verify(cryptoRepositoryMock.dataCryptoStream);

      expect(gottenIsLoading, expectedIsLoading);
      expect(listEquals(gottenCryptoPresentationList, expectedCryptoPresentationList), isTrue);
      expect(gottenLastChunkSize, expectedLastChunkSize);
      expect(listEquals(gottenLastCryptoPresentationList, expectedLastCryptoPresentationList), isTrue);
    });

    test('getAllCryptoPresentations() test', () async {
      const expectedIsCryptoRequested = true;
      const expectedLoadingState = true;
      const expectedCount = 1 * CryptocurrenciesModel.CHUNK_SIZE;

      late int gottenCount;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock();

      when(cryptoRepositoryMock.loadCryptocurrencies(any)).thenAnswer((invocation) {
        gottenCount = invocation.positionalArguments.first;
      });

      final CryptocurrenciesModelImpl cryptocurrenciesModelImpl = CryptocurrenciesModelImpl(cryptoRepositoryMock);

      cryptocurrenciesModelImpl.getAllCryptoPresentations();

      final gottenIsCryptoRequested = cryptocurrenciesModelImpl.isCryptoRequested;
      final gottenLoadingState = cryptocurrenciesModelImpl.isLoading;

      verify(cryptoRepositoryMock.loadCryptocurrencies(any));

      expect(gottenIsCryptoRequested, expectedIsCryptoRequested);
      expect(gottenLoadingState, expectedLoadingState);
      expect(gottenCount, expectedCount);
    });

    test('clear() test', () {
      const expectedChunkIndex = CryptocurrenciesModelImpl.DEFAULT_CHUNK_INDEX;
      const expectedIsGettingChunk = CryptocurrenciesModelImpl.DEFAULT_IS_GETTING_CHUNK;
      const expectedIsCryptoRequested = CryptocurrenciesModelImpl.DEFAULT_IS_CRYPTO_REQUESTED;
      const expectedIsLoading = CryptocurrenciesModelImpl.DEFAULT_IS_LOADING;
      const expectedLastChunkSize = CryptocurrenciesModelImpl.DEFAULT_LAST_CHUNK_SIZE;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock();

      final CryptocurrenciesModelImpl cryptocurrenciesModelImpl = CryptocurrenciesModelImpl(cryptoRepositoryMock);

      cryptocurrenciesModelImpl.getAllCryptoPresentations();
      cryptocurrenciesModelImpl.clear();

      final gottenChunkIndex = cryptocurrenciesModelImpl.chunkIndex;
      final gottenIsGettingChunk = cryptocurrenciesModelImpl.isGettingChunk;
      final gottenIsCryptoRequested = cryptocurrenciesModelImpl.isCryptoRequested;
      final gottenIsLoading = cryptocurrenciesModelImpl.isLoading;
      final gottenLastChunkSize = cryptocurrenciesModelImpl.lastChunkSize;

      expect(gottenChunkIndex, expectedChunkIndex);
      expect(gottenIsGettingChunk, expectedIsGettingChunk);
      expect(gottenIsCryptoRequested, expectedIsCryptoRequested);
      expect(gottenIsLoading, expectedIsLoading);
      expect(gottenLastChunkSize, expectedLastChunkSize);
    });

    test('getNextChunk() test', () {
      const expectedIsLoading = true;
      const expectedIsGettingChunk = true;
      const expectedChunkCount = 2;
      const expectedCount = expectedChunkCount * CryptocurrenciesModel.CHUNK_SIZE;

      late int gottenCount;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock();

      when(cryptoRepositoryMock.loadCryptocurrencies(any)).thenAnswer((invocation) {
        gottenCount = invocation.positionalArguments.first;
      });

      final CryptocurrenciesModelImpl cryptocurrenciesModelImpl = CryptocurrenciesModelImpl(cryptoRepositoryMock);

      cryptocurrenciesModelImpl.getNextChunk();

      final gottenIsLoading = cryptocurrenciesModelImpl.isLoading;
      final gottenIsGettingChunk = cryptocurrenciesModelImpl.isGettingChunk;
      final gottenChunkCount = cryptocurrenciesModelImpl.chunkIndex;

      verify(cryptoRepositoryMock.loadCryptocurrencies(any));

      expect(gottenIsLoading, expectedIsLoading);
      expect(gottenIsGettingChunk, expectedIsGettingChunk);
      expect(gottenCount, expectedCount);
      expect(gottenChunkCount, expectedChunkCount);
    });

    test('toggleFavoriteCrypto() on not favorite crypto test', () async {
      const dataCrypto = DataCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2, 
        isFavorite: false
      );
      final dataCryptoList = [dataCrypto];
      final cryptoPresentation = CryptoPresentation.fromDataCrypto(dataCrypto);

      final expectedCryptoPresentationList = [cryptoPresentation.copyWith(isFavorite: true)];
      final expectedCryptoToken = cryptoPresentation.token;

      late String gottenCryptoToken;

      final StreamController<List<DataCrypto>> dataCryptoStreamController = StreamController();
      final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamController.stream;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock(dataCryptoStreamArg: dataCryptoStream);

      when(cryptoRepositoryMock.addToFavorites(any)).thenAnswer((invocation) {
        gottenCryptoToken = invocation.positionalArguments.first;
      });

      final CryptocurrenciesModelImpl cryptocurrenciesModelImpl = CryptocurrenciesModelImpl(cryptoRepositoryMock);

      dataCryptoStreamController.add(dataCryptoList);

      // for sync. purposes:
      await cryptocurrenciesModelImpl.cryptoPresentationStream.first;

      cryptocurrenciesModelImpl.toggleFavoriteCrypto(cryptoPresentation);

      final gottenCryptoPresentationList = await cryptocurrenciesModelImpl.cryptoPresentationStream.first;

      verify(cryptoRepositoryMock.addToFavorites(any));

      expect(gottenCryptoToken, expectedCryptoToken);
      expect(listEquals(gottenCryptoPresentationList, expectedCryptoPresentationList), isTrue);
    });

    test('toggleFavoriteCrypto() on favorite crypto test', () async {
      const dataCrypto = DataCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2, 
        isFavorite: true
      );
      final dataCryptoList = [dataCrypto];
      final cryptoPresentation = CryptoPresentation.fromDataCrypto(dataCrypto);

      final expectedCryptoPresentationList = [cryptoPresentation.copyWith(isFavorite: false)];
      final expectedCryptoToken = cryptoPresentation.token;

      late String gottenCryptoToken;

      final StreamController<List<DataCrypto>> dataCryptoStreamController = StreamController();
      final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamController.stream;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock(dataCryptoStreamArg: dataCryptoStream);

      when(cryptoRepositoryMock.removeFromFavorites(any)).thenAnswer((invocation) {
        gottenCryptoToken = invocation.positionalArguments.first;
      });

      final CryptocurrenciesModelImpl cryptocurrenciesModelImpl = CryptocurrenciesModelImpl(cryptoRepositoryMock);

      dataCryptoStreamController.add(dataCryptoList);

      // for sync. purposes:
      await cryptocurrenciesModelImpl.cryptoPresentationStream.first;

      cryptocurrenciesModelImpl.toggleFavoriteCrypto(cryptoPresentation);

      final gottenCryptoPresentationList = await cryptocurrenciesModelImpl.cryptoPresentationStream.first;

      verify(cryptoRepositoryMock.removeFromFavorites(any));

      expect(gottenCryptoToken, expectedCryptoToken);
      expect(listEquals(gottenCryptoPresentationList, expectedCryptoPresentationList), isTrue);
    });
  });
}