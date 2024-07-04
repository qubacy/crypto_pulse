import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/model/_common/AppModel.dart';
import 'package:crypto_pulse/application/ui/model/impl/AppModelImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'AppModelImplTest.mocks.dart';

@GenerateMocks([CryptoRepository])
void main() {
  group('App Model Implementation tests', () {
    test('getAllCryptoPresentations() test', () async {
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

      final expectedCryptoPresentationList = dataCryptoList.map((item) => CryptoPresentation.fromDataCrypto(item)).toList();

      final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

      when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => dataCryptoStream);

      final AppModelImpl appModelImpl = AppModelImpl(cryptoRepositoryMock);

      final cryptoPresentationListStream = appModelImpl.getAllCryptoPresentations();

      dataCryptoStreamController.add(dataCryptoList);

      final gottenCryptoPresentationList = await cryptoPresentationListStream.first;

      verify(cryptoRepositoryMock.dataCryptoStream);

      expect(listEquals(gottenCryptoPresentationList, expectedCryptoPresentationList), isTrue);
    });

    test('getFavoriteCryptoPresentations() test', () async {
      final StreamController<List<DataCrypto>> dataCryptoStreamController = StreamController();
      final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamController.stream;

      const DataCrypto favoriteDataCrypto = DataCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2, 
        isFavorite: true
      );
      const DataCrypto dataCrypto = DataCrypto(
        token: 'test 2', 
        name: 'test 2', 
        price: 1, 
        capitalization: 2, 
        isFavorite: false
      );

      final List<DataCrypto> dataCryptoList = [favoriteDataCrypto, dataCrypto];

      final expectedCryptoPresentationList = dataCryptoList
        .where((item) => item.isFavorite)
        .map((item) => CryptoPresentation.fromDataCrypto(item)).toList();

      final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

      when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => dataCryptoStream);

      final AppModelImpl appModelImpl = AppModelImpl(cryptoRepositoryMock);

      final cryptoPresentationListStream = appModelImpl.getFavoriteCryptoPresentations();

      dataCryptoStreamController.add(dataCryptoList);

      final gottenCryptoPresentationList = await cryptoPresentationListStream.first;

      verify(cryptoRepositoryMock.dataCryptoStream);

      expect(listEquals(gottenCryptoPresentationList, expectedCryptoPresentationList), isTrue);
    });

    test('getNextChunk() test', () {
      const int expectedChunkCount = 1;
      const int expectedCount = AppModel.CHUNK_SIZE * 1;
      late int gottenCount;

      final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

      when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => const Stream.empty());
      when(cryptoRepositoryMock.loadCryptocurrencies(any)).thenAnswer((invocation) {
        gottenCount = invocation.positionalArguments.first;
      });

      final AppModelImpl appModelImpl = AppModelImpl(cryptoRepositoryMock);

      appModelImpl.getNextChunk();

      final int gottenChunkCount = appModelImpl.chunkIndex;

      verify(cryptoRepositoryMock.loadCryptocurrencies(any));

      expect(gottenCount, expectedCount);
      expect(gottenChunkCount, expectedChunkCount);
    });

    test('removeFromFavorites() test', () {
      const CryptoPresentation cryptoPresentation = CryptoPresentation(
        token: 'test', 
        name: 'test', 
        price: '\$1', 
        capitalization: 2, 
        isFavorite: false
      );

      final String expectedCryptoToken = cryptoPresentation.token;
      late String gottenCryptoToken;

      final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

      when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => const Stream.empty());
      when(cryptoRepositoryMock.removeFromFavorites(any)).thenAnswer((invocation) {
        gottenCryptoToken = invocation.positionalArguments.first;
      });

      final AppModelImpl appModelImpl = AppModelImpl(cryptoRepositoryMock);

      appModelImpl.removeFromFavorites(cryptoPresentation);

      verify(cryptoRepositoryMock.removeFromFavorites(any));

      expect(gottenCryptoToken, expectedCryptoToken);
    });

    test('toggleFavoriteCrypto() on not favorite crypto test', () {
      const CryptoPresentation cryptoPresentation = CryptoPresentation(
        token: 'test', 
        name: 'test', 
        price: '\$1', 
        capitalization: 2, 
        isFavorite: false
      );

      final String expectedCryptoToken = cryptoPresentation.token;
      late String gottenCryptoToken;

      final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

      when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => const Stream.empty());
      when(cryptoRepositoryMock.addToFavorites(any)).thenAnswer((invocation) {
        gottenCryptoToken = invocation.positionalArguments.first;
      });

      final AppModelImpl appModelImpl = AppModelImpl(cryptoRepositoryMock);

      appModelImpl.toggleFavoriteCrypto(cryptoPresentation);

      verify(cryptoRepositoryMock.addToFavorites(any));

      expect(gottenCryptoToken, expectedCryptoToken);
    });

    test('toggleFavoriteCrypto() on favorite crypto test', () {
      const CryptoPresentation cryptoPresentation = CryptoPresentation(
        token: 'test', 
        name: 'test', 
        price: '\$1', 
        capitalization: 2, 
        isFavorite: true
      );

      final String expectedCryptoToken = cryptoPresentation.token;
      late String gottenCryptoToken;

      final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

      when(cryptoRepositoryMock.dataCryptoStream).thenAnswer((_) => const Stream.empty());
      when(cryptoRepositoryMock.removeFromFavorites(any)).thenAnswer((invocation) {
        gottenCryptoToken = invocation.positionalArguments.first;
      });

      final AppModelImpl appModelImpl = AppModelImpl(cryptoRepositoryMock);

      appModelImpl.toggleFavoriteCrypto(cryptoPresentation);

      verify(cryptoRepositoryMock.removeFromFavorites(any));

      expect(gottenCryptoToken, expectedCryptoToken);
    });
  });
}