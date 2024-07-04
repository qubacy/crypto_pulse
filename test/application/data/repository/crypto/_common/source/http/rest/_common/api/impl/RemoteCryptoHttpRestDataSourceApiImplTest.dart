import 'dart:ffi';

import 'package:crypto_pulse/application/data/repository/_common/source/http/context/_common/HttpContext.dart';
import 'package:crypto_pulse/application/data/repository/_common/source/http/header/interceptor/authorization/_common/AuthorizationHttpHeaderInterceptor.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/impl/RemoteCryptoHttpRestDataSourceApiImpl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'RemoteCryptoHttpRestDataSourceApiImplTest.mocks.dart';

@GenerateMocks([HttpContext, AuthorizationHttpHeaderInterceptor, Client, Response])
void main() {
  group('Remote Crypto Http Rest Data Source Api Implementation tests', () {
    test('getCryptocurrencies() test', () async {
      const int count = 1;

      final USDQuoteResponseData usdQuoteResponseData =
        USDQuoteResponseData(price: 9283.92, marketCap: 852164659250.2758);
      final QuoteResponseData quoteResponseData =
        QuoteResponseData(usd: usdQuoteResponseData);
      final CryptocurrencyResponseData cryptocurrencyResponseData =
       CryptocurrencyResponseData(name: 'Bitcoin', symbol: 'BTC', quote: quoteResponseData);

      const String baseUri = 'test';
      final String responseBodyJson = """{
        "data": [
          {
            "id": 1,
            "name": "${cryptocurrencyResponseData.name}",
            "symbol": "${cryptocurrencyResponseData.symbol}",
            "slug": "bitcoin",
            "cmc_rank": 5,
            "num_market_pairs": 500,
            "circulating_supply": 16950100,
            "total_supply": 16950100,
            "max_supply": 21000000,
            "infinite_supply": false,
            "last_updated": "2018-06-02T22:51:28.209Z",
            "date_added": "2013-04-28T00:00:00.000Z",
            "tags": [
              "mineable"
            ],
            "platform": null,
            "self_reported_circulating_supply": null,
            "self_reported_market_cap": null,
            "quote": {
              "USD": {
                "price": ${usdQuoteResponseData.price},
                "volume_24h": 7155680000,
                "volume_change_24h": -0.152774,
                "percent_change_1h": -0.152774,
                "percent_change_24h": 0.518894,
                "percent_change_7d": 0.986573,
                "market_cap": ${usdQuoteResponseData.marketCap},
                "market_cap_dominance": 51,
                "fully_diluted_market_cap": 952835089431.14,
                "last_updated": "2018-08-09T22:53:32.000Z"
              },
                "BTC": {
                "price": 1,
                "volume_24h": 772012,
                "volume_change_24h": 0,
                "percent_change_1h": 0,
                "percent_change_24h": 0,
                "percent_change_7d": 0,
                "market_cap": 17024600,
                "market_cap_dominance": 12,
                "fully_diluted_market_cap": 952835089431.14,
                "last_updated": "2018-08-09T22:53:32.000Z"
              }
            }
          }
        ]
      }""";

      MockHttpContext httpContextMock = MockHttpContext();

      when(httpContextMock.loadUri()).thenAnswer((_) async => baseUri);

      MockResponse httpResponseMock = MockResponse();

      when(httpResponseMock.body).thenReturn(responseBodyJson);

      MockClient httpClientMock = MockClient();

      when(httpClientMock.get(any, headers: anyNamed("headers"))).thenAnswer((_) async => httpResponseMock);

      MockAuthorizationHttpHeaderInterceptor authorizationHttpHeaderInterceptorMock = 
        MockAuthorizationHttpHeaderInterceptor();

      when(authorizationHttpHeaderInterceptorMock.intercept(any)).thenAnswer((_) async => Void);

      RemoteCryptoHttpRestDataSourceApiImpl remoteCryptoHttpRestDataSourceApiImpl = 
        RemoteCryptoHttpRestDataSourceApiImpl(
          httpClient: httpClientMock, 
          httpContext: httpContextMock, 
          authorizationHttpHeaderInterceptor: authorizationHttpHeaderInterceptorMock
        );

      final GetCryptocurrenciesResponse expectedGetCryptocurrenciesResponse = 
        GetCryptocurrenciesResponse(cryptocurrencyResponseDataList: [cryptocurrencyResponseData]);

      final GetCryptocurrenciesResponse gottenGetCryptocurrenciesResponse = 
        await remoteCryptoHttpRestDataSourceApiImpl.getCryptocurrencies(count);

      verify(httpContextMock.loadUri());
      verify(authorizationHttpHeaderInterceptorMock.intercept(any));
      verify(httpClientMock.get(any, headers: anyNamed("headers")));
      verify(httpResponseMock.body);

      expect(gottenGetCryptocurrenciesResponse, expectedGetCryptocurrenciesResponse);
    });
  });
}