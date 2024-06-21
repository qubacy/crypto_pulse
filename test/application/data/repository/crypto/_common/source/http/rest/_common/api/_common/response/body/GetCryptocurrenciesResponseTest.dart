import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/GetCryptocurrenciesResponse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Get Cryptocurrencies Response tests', () {
    test('fromJson() test', () {
      final USDQuoteResponseData usdQuoteResponseData = USDQuoteResponseData(price: 1, marketCap: 2);
      final QuoteResponseData quoteResponseData = QuoteResponseData(usd: usdQuoteResponseData);
      final CryptocurrencyResponseData cryptocurrencyResponseData = 
        CryptocurrencyResponseData(name: 'test', symbol: 'TST', quote: quoteResponseData);
      final json = {
        GetCryptocurrenciesResponse.DATA_PROP_NAME: [
          {
            CryptocurrencyResponseData.NAME_PROP_NAME: cryptocurrencyResponseData.name,
            CryptocurrencyResponseData.SYMBOL_PROP_NAME: cryptocurrencyResponseData.symbol,
            CryptocurrencyResponseData.QUOTE_PROP_NAME: {
              QuoteResponseData.USD_PROP_NAME: {
                USDQuoteResponseData.MARKET_CUP_PROP_NAME: usdQuoteResponseData.marketCap,
                USDQuoteResponseData.PRICE_PROP_NAME: usdQuoteResponseData.price
              }
            }
          },
        ]
      };

      GetCryptocurrenciesResponse expectedGetCryptocurrenciesResponse = 
        GetCryptocurrenciesResponse(cryptocurrencyResponseDataList: [cryptocurrencyResponseData]);

      GetCryptocurrenciesResponse gottenGetCryptocurrenciesResponse = GetCryptocurrenciesResponse.fromJson(json);

      expect(gottenGetCryptocurrenciesResponse, expectedGetCryptocurrenciesResponse);
    });
  });
}