import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/impl/CryptocurrencyUpdaterImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'CryptocurrencyUpdaterImplTest.mocks.dart';

@GenerateMocks([RemoteCryptoHttpRestDataSource, CryptocurrencyUpdaterCallback])
void main() {
  group('Cryptocurrency Updater Implementation tests', () {
    test('initialization & update receiving test', () async {
      const RemoteHttpRestCrypto remoteHttpRestCrypto = RemoteHttpRestCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2
      );

      const int expectedCount = 1;
      const List<RemoteHttpRestCrypto> expectedRemoteHttpRestCryptoList = [remoteHttpRestCrypto];

      late int gottenCount;
      late List<RemoteHttpRestCrypto> gottenRemoteHttpRestCryptoList;

      final MockRemoteCryptoHttpRestDataSource remoteCryptoHttpRestDataSourceMock = 
        MockRemoteCryptoHttpRestDataSource();

      when(remoteCryptoHttpRestDataSourceMock.getCryptocurrencies(any))
        .thenAnswer((_) async => expectedRemoteHttpRestCryptoList);

      final MockCryptocurrencyUpdaterCallback cryptocurrencyUpdaterCallbackMock = 
        MockCryptocurrencyUpdaterCallback();

      when(cryptocurrencyUpdaterCallbackMock.onCryptocurrenciesGotten(any, any)).thenAnswer((invocation) {
        gottenCount = invocation.positionalArguments[0];
        gottenRemoteHttpRestCryptoList = invocation.positionalArguments[1];
      });

      final CryptocurrencyUpdaterImpl cryptocurrencyUpdaterImpl =
        CryptocurrencyUpdaterImpl(remoteCryptoHttpRestDataSource: remoteCryptoHttpRestDataSourceMock);

      cryptocurrencyUpdaterImpl.setCallback(cryptocurrencyUpdaterCallbackMock);
      
      cryptocurrencyUpdaterImpl.start(expectedCount);

      await Future.delayed(Duration(
        milliseconds: CryptocurrencyUpdater.UPDATE_TIMEOUT_DURATION.inMilliseconds + 200
      ));

      verify(remoteCryptoHttpRestDataSourceMock.getCryptocurrencies(any));
      verify(cryptocurrencyUpdaterCallbackMock.onCryptocurrenciesGotten(any, any));

      expect(gottenCount, expectedCount);
      expect(listEquals(gottenRemoteHttpRestCryptoList, expectedRemoteHttpRestCryptoList), isTrue);
    });
  });
}