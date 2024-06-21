import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/api/_common/response/body/CryptocurrencyResponseData.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Remote Http Rest Crypto tests', () {
    test('fromResponse() test', () {
      final CryptocurrencyResponseData cryptocurrencyResponseData = 
        CryptocurrencyResponseData(
          name: 'test',
          symbol: 'test',
          quote: QuoteResponseData(
            usd: USDQuoteResponseData(
              price: 1,
              marketCap: 1
            )
          )
        );

      final expectedRemoteHttpRestCrypto = RemoteHttpRestCrypto(
        token: cryptocurrencyResponseData.symbol,
        name: cryptocurrencyResponseData.name,
        price: cryptocurrencyResponseData.quote.usd.price, 
        capitalization: cryptocurrencyResponseData.quote.usd.marketCap
      );

      final gottenRemoteHttpRestCrypto = RemoteHttpRestCrypto.fromResponse(cryptocurrencyResponseData);

      expect(gottenRemoteHttpRestCrypto, expectedRemoteHttpRestCrypto);
    });
  });
}