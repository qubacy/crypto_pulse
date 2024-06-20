import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('USD Quote Response Data tests', () {
    test('fromJson() test', () {
      const price = 1.0;
      const marketCup = 2.0;
      const json = {
        USDQuoteResponseData.PRICE_PROP_NAME: price,
        USDQuoteResponseData.MARKET_CUP_PROP_NAME: marketCup
      };

      final expectedUSDQuoteResponseData = USDQuoteResponseData(marketCup: marketCup, price: price);

      final gottenUSDQuoteResponseData = USDQuoteResponseData.fromJson(json);

      expect(gottenUSDQuoteResponseData, expectedUSDQuoteResponseData);
    });
  });
}