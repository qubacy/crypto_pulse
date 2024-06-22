import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cryptocurrency Response Data tests', () {
    test('fromJson() test', () {
      const String name = 'test';
      const String symbol = 'TST';

      const USDQuoteResponseData usdQuoteResponseData = USDQuoteResponseData(price: 1, marketCap: 2);
      const QuoteResponseData quoteResponseData = QuoteResponseData(usd: usdQuoteResponseData);
      final json = {
        CryptocurrencyResponseData.NAME_PROP_NAME: name,
        CryptocurrencyResponseData.SYMBOL_PROP_NAME: symbol,
        CryptocurrencyResponseData.QUOTE_PROP_NAME: {
          QuoteResponseData.USD_PROP_NAME: {
            USDQuoteResponseData.MARKET_CUP_PROP_NAME: usdQuoteResponseData.marketCap,
            USDQuoteResponseData.PRICE_PROP_NAME: usdQuoteResponseData.price
          }
        }
      };

      const CryptocurrencyResponseData expectedCryptocurrencyResponseData = 
        CryptocurrencyResponseData(name: name, symbol: symbol, quote: quoteResponseData);

      CryptocurrencyResponseData gottenCryptocurrencyResponseData = CryptocurrencyResponseData.fromJson(json);

      expect(gottenCryptocurrencyResponseData, expectedCryptocurrencyResponseData);
    });
  });
}