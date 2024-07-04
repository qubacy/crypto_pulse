import '../../../data/repository/crypto/_common/model/DataCrypto.dart';

class CryptoPresentation {
  final String token;
  final String name;
  final String price;
  final double capitalization;
  final bool isFavorite;

  const CryptoPresentation({
    required this.token, 
    required this.name, 
    required this.price, 
    required this.capitalization,
    required this.isFavorite
  });

  CryptoPresentation copyWith({
    String? token,
    String? name,
    String? price,
    double? capitalization,
    bool? isFavorite
  }) {
    return CryptoPresentation(
      token: token ?? this.token,
      name: name ?? this.name,
      price: price ?? this.price,
      capitalization: capitalization ?? this.capitalization,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is! CryptoPresentation) return false;

    return (
      other.token == token &&
      other.name == name &&
      other.price == price &&
      other.capitalization == capitalization &&
      other.isFavorite == isFavorite
    );
  }

  factory CryptoPresentation.fromDataCrypto(DataCrypto dataCrypto) {
    final pricePrecision = getFractionDigitCountByValue(dataCrypto.price);

    return CryptoPresentation(
      token: dataCrypto.token, 
      name: dataCrypto.name, 
      price: "\$${dataCrypto.price.toStringAsFixed(pricePrecision)}",
      capitalization: dataCrypto.capitalization,
      isFavorite: dataCrypto.isFavorite
    );
  }

  @override
  int get hashCode => Object.hash(token, name, price, capitalization, isFavorite);

  static int getFractionDigitCountByValue(double value) {
    if (value <= 0) return 0;

    const int valuableDigitNumber = 3;

    int fractionMultiplier = 10;
    int fractionMultiplierIterationCount = 0;

    while (fractionMultiplier * value < 1) {
      fractionMultiplier *= 10;

      ++fractionMultiplierIterationCount;
    }

    return fractionMultiplierIterationCount + valuableDigitNumber;
  }
}