import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cryptocurrency Response Data tests', () {
    test('fromJson() test', () {
      final String name = 'test';
      final String symbol = 'TST';

      final USDQuoteResponseData usdQuoteResponseData = USDQuoteResponseData(price: 1, marketCup: 2);
      final QuoteResponseData quoteResponseData = QuoteResponseData(usd: usdQuoteResponseData);
      final json = {
        CryptocurrencyResponseData.NAME_PROP_NAME: name,
        CryptocurrencyResponseData.SYMBOL_PROP_NAME: symbol,
        CryptocurrencyResponseData.QUOTE_PROP_NAME: {
          QuoteResponseData.USD_PROP_NAME: {
            USDQuoteResponseData.MARKET_CUP_PROP_NAME: usdQuoteResponseData.marketCup,
            USDQuoteResponseData.PRICE_PROP_NAME: usdQuoteResponseData.price
          }
        }
      };

      CryptocurrencyResponseData expectedCryptocurrencyResponseData = 
        CryptocurrencyResponseData(name: name, symbol: symbol, quote: quoteResponseData);

      CryptocurrencyResponseData gottenCryptocurrencyResponseData = CryptocurrencyResponseData.fromJson(json);

      expect(gottenCryptocurrencyResponseData, expectedCryptocurrencyResponseData);
    });
  });
}