import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/RemoteCryptoHttpRestDataSource.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/CryptocurrencyUpdater.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/_common/_di/initializer/CryptocurrencyUpdaterGraphInitializer.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/impl/CryptocurrencyUpdaterImpl.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/updater/impl/_di/CryptocurrencyUpdaterGraph.dart';
import 'package:crypto_pulse/application/data/repository/token/_common/source/local/environment/_common/LocalTokenEnvironmentDataSource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'CryptocurrencyUpdaterImplTest.mocks.dart';

@GenerateMocks([RemoteCryptoHttpRestDataSource, CryptocurrencyUpdaterCallback, HttpContext, LocalTokenEnvironmentDataSource, CryptocurrencyUpdaterGraphInitializer])
void main() {
  group('Cryptocurrency Updater Implementation tests', () {
    test('initialization & update receiving test', () async {
      const String accessToken = 'token';
      const String uri = 'uri';
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

      final MockLocalTokenEnvironmentDataSource localTokenEnvironmentDataSourceMock =
        MockLocalTokenEnvironmentDataSource();

      when(localTokenEnvironmentDataSourceMock.loadToken()).thenAnswer((_) async => accessToken);

      final MockHttpContext httpContextMock = MockHttpContext();

      when(httpContextMock.loadUri()).thenAnswer((_) async => uri);

      final MockCryptocurrencyUpdaterGraphInitializer mockCryptocurrencyUpdaterGraphInitializer =
        MockCryptocurrencyUpdaterGraphInitializer();

      when(mockCryptocurrencyUpdaterGraphInitializer.initGraph(any)).thenAnswer((_) async {
        cryptocurrencyUpdaterGetIt.registerFactory<RemoteCryptoHttpRestDataSource>(() => remoteCryptoHttpRestDataSourceMock);
      });

      final CryptocurrencyUpdaterImpl cryptocurrencyUpdaterImpl = CryptocurrencyUpdaterImpl(
        remoteCryptoHttpRestDataSource: remoteCryptoHttpRestDataSourceMock,
        localTokenEnvironmentDataSource: localTokenEnvironmentDataSourceMock,
        httpContext: httpContextMock,
        cryptocurrencyUpdaterGraphInitializer: mockCryptocurrencyUpdaterGraphInitializer
      );

      cryptocurrencyUpdaterImpl.setCallback(cryptocurrencyUpdaterCallbackMock);
      
      cryptocurrencyUpdaterImpl.start(expectedCount);

      await Future.delayed(Duration(
        seconds: CryptocurrencyUpdater.UPDATE_TIMEOUT_DURATION.inSeconds * 2
      ));

      verify(cryptocurrencyUpdaterCallbackMock.onCryptocurrenciesGotten(any, any));

      expect(gottenCount, expectedCount);
      expect(listEquals(gottenRemoteHttpRestCryptoList, expectedRemoteHttpRestCryptoList), isTrue);

      cryptocurrencyUpdaterImpl.stop();
    });
  });
}