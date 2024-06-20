import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Quote Response Data tests', () {
    test('fromJson() test', () {
      final USDQuoteResponseData usdQuoteResponseData = USDQuoteResponseData(price: 1, marketCup: 2);
      final json = {
        QuoteResponseData.USD_PROP_NAME: {
          USDQuoteResponseData.MARKET_CUP_PROP_NAME: usdQuoteResponseData.marketCup,
          USDQuoteResponseData.PRICE_PROP_NAME: usdQuoteResponseData.price
        }
      };

      QuoteResponseData expectedQuoteResponseData = QuoteResponseData(usd: usdQuoteResponseData);

      QuoteResponseData gottenQuoteResponseData = QuoteResponseData.fromJson(json);

      expect(gottenQuoteResponseData, expectedQuoteResponseData);
    });
  });
}