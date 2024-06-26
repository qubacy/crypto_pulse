import '../api/_common/response/body/CryptocurrencyResponseData.dart';

class RemoteHttpRestCrypto {
  final String token;
  final String name;
  final double price;
  final double capitalization;

  const RemoteHttpRestCrypto({
    required this.token, 
    required this.name, 
    required this.price, 
    required this.capitalization
  });

  RemoteHttpRestCrypto copyWith({
    String? token,
    String? name,
    double? price,
    double? capitalization
  }) {
    return RemoteHttpRestCrypto(
      token: token ?? this.token,
      name: name ?? this.name,
      price: price ?? this.price,
      capitalization: capitalization ?? this.capitalization
    );
  }

  @override
  bool operator==(Object other) {
    if (other is! RemoteHttpRestCrypto) return false;

    return (
      other.token == token &&
      other.name == name &&
      other.price == price &&
      other.capitalization == capitalization
    );
  }

  factory RemoteHttpRestCrypto.fromResponse(CryptocurrencyResponseData response) {
    return RemoteHttpRestCrypto(
      token: response.symbol, 
      name: response.name, 
      price: response.quote.usd.price, 
      capitalization: response.quote.usd.marketCap
    );
  }

  @override
  int get hashCode => Object.hash(token, name, price, capitalization);
}