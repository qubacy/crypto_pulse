import 'dart:async';

import 'package:crypto_pulse/application/data/repository/crypto/_common/CryptoRepository.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/impl/HomeModelImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'HomeModelImplTest.mocks.dart';

MockCryptoRepository createCryptoRepositoryMock({
  Stream<List<DataCrypto>>? dataCryptoStreamArg
}) {
  final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamArg ?? const Stream.empty();

  final MockCryptoRepository cryptoRepositoryMock = MockCryptoRepository();

  when(cryptoRepositoryMock.favoriteDataCryptoStream).thenAnswer((_) => dataCryptoStream);

  return cryptoRepositoryMock;
}

@GenerateMocks([CryptoRepository])
void main() {
  group('Home Model Implementation tests', () {
    test('favoriteCryptoPresentationStream test', () async {
      final StreamController<List<DataCrypto>> dataCryptoStreamController = StreamController();
      final Stream<List<DataCrypto>> dataCryptoStream = dataCryptoStreamController.stream;

      const DataCrypto dataCrypto = DataCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2, 
        isFavorite: true
      );
      final List<DataCrypto> dataCryptoList = [dataCrypto];

      const expectedIsLoading = false;
      final expectedCryptoPresentationList = dataCryptoList.map((item) => CryptoPresentation.fromDataCrypto(item)).toList();

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock(dataCryptoStreamArg: dataCryptoStream);

      final HomeModelImpl homeModelImpl = HomeModelImpl(cryptoRepositoryMock);

      final cryptoPresentationListStream = homeModelImpl.favoriteCryptoPresentationStream;

      homeModelImpl.getFavoriteCryptoPresentations();
      dataCryptoStreamController.add(dataCryptoList);

      final gottenCryptoPresentationList = await cryptoPresentationListStream.first;
      final gottenIsLoading = homeModelImpl.isLoading;

      verify(cryptoRepositoryMock.favoriteDataCryptoStream);

      expect(gottenIsLoading, expectedIsLoading);
      expect(listEquals(gottenCryptoPresentationList, expectedCryptoPresentationList), isTrue);
    });

    test('getFavoriteCryptoPresentations() test', () async {
      const expectedIsFavoriteCryptoRequested = true;
      const expectedLoadingState = true;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock();

      final HomeModelImpl homeModelImpl = HomeModelImpl(cryptoRepositoryMock);

      homeModelImpl.getFavoriteCryptoPresentations();

      final gottenIsFavoriteCryptoRequested = homeModelImpl.isFavoriteCryptoRequested;
      final gottenLoadingState = homeModelImpl.isLoading;

      verify(cryptoRepositoryMock.loadFavorites());

      expect(gottenIsFavoriteCryptoRequested, expectedIsFavoriteCryptoRequested);
      expect(gottenLoadingState, expectedLoadingState);
    });

    test('clear() test', () {
      const expectedIsLoading = HomeModelImpl.DEFAULT_IS_LOADING;
      const expectedIsFavoriteCryptoRequested = HomeModelImpl.DEFAULT_IS_FAVORITE_CRYPTO_REQUESTED;

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock();

      final HomeModelImpl homeModelImpl = HomeModelImpl(cryptoRepositoryMock);

      homeModelImpl.getFavoriteCryptoPresentations();
      homeModelImpl.clear();

      final gottenIsLoading = homeModelImpl.isLoading;
      final gottenIsFavoriteCryptoRequested = homeModelImpl.isFavoriteCryptoRequested;

      expect(gottenIsLoading, expectedIsLoading);
      expect(gottenIsFavoriteCryptoRequested, expectedIsFavoriteCryptoRequested);
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

      final MockCryptoRepository cryptoRepositoryMock = createCryptoRepositoryMock();

      when(cryptoRepositoryMock.removeFromFavorites(any)).thenAnswer((invocation) {
        gottenCryptoToken = invocation.positionalArguments.first;
      });

      final HomeModelImpl homeModelImpl = HomeModelImpl(cryptoRepositoryMock);

      homeModelImpl.removeFromFavorites(cryptoPresentation);

      verify(cryptoRepositoryMock.removeFromFavorites(any));

      expect(gottenCryptoToken, expectedCryptoToken);
    });
  });
}