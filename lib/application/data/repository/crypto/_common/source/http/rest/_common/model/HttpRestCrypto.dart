import '../api/_common/response/body/CryptocurrencyResponseData.dart';

class HttpRestCrypto {
  final String token;
  final String name;
  final double price;
  final double capitalization;

  const HttpRestCrypto({
    required this.token, 
    required this.name, 
    required this.price, 
    required this.capitalization
  });

  HttpRestCrypto copyWith({
    String? token,
    String? name,
    double? price,
    double? capitalization
  }) {
    return HttpRestCrypto(
      token: token ?? this.token,
      name: name ?? this.name,
      price: price ?? this.price,
      capitalization: capitalization ?? this.capitalization
    );
  }

  factory HttpRestCrypto.fromResponse(CryptocurrencyResponseData response) {
    return HttpRestCrypto(
      token: response.symbol, 
      name: response.name, 
      price: response.quote.usd.price, 
      capitalization: response.quote.usd.marketCup
    );
  }
}