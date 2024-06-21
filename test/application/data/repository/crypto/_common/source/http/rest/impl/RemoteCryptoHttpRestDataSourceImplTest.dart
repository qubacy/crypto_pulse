import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/RemoteCryptoHttpRestDataSourceApi.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/impl/RemoteCryptoHttpRestDataSourceImpl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'RemoteCryptoHttpRestDataSourceImplTest.mocks.dart';

@GenerateMocks([RemoteCryptoHttpRestDataSourceApi])
void main() {
  group('Remote Crypto Http Rest Data Source Implementation tests', () {
    test('getCryptocurrencies() test', () async {
      const count = 1;

      CryptocurrencyResponseData cryptocurrencyResponseData = CryptocurrencyResponseData(
        name: 'test', 
        symbol: 'test', 
        quote: QuoteResponseData(usd: USDQuoteResponseData(price: 1, marketCap: 2))
      );
      GetCryptocurrenciesResponse getCryptocurrenciesResponse = GetCryptocurrenciesResponse(
        cryptocurrencyResponseDataList: [cryptocurrencyResponseData]
      );

      MockRemoteCryptoHttpRestDataSourceApi remoteCryptoHttpRestDataSourceApiMock =
        MockRemoteCryptoHttpRestDataSourceApi();

      when(remoteCryptoHttpRestDataSourceApiMock.getCryptocurrencies(any))
        .thenAnswer((_) async => getCryptocurrenciesResponse);

      final RemoteCryptoHttpRestDataSourceImpl remoteCryptoHttpRestDataSourceImpl = 
        RemoteCryptoHttpRestDataSourceImpl(api: remoteCryptoHttpRestDataSourceApiMock);

      final expectedRemoteHttpRestCryptoList = [RemoteHttpRestCrypto.fromResponse(cryptocurrencyResponseData)];

      final gottenRemoteHttpRestCryptoList = await remoteCryptoHttpRestDataSourceImpl.getCryptocurrencies(count);

      expect(listEquals(gottenRemoteHttpRestCryptoList, expectedRemoteHttpRestCryptoList), isTrue);
    });
  });
}