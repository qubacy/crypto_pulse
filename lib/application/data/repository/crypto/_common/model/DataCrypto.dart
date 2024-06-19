class DataCrypto {
  final String token;
  final String name;
  final double price;
  final double capitalization;
  final bool isFavorite;

  const DataCrypto({
    required this.token, 
    required this.name, 
    required this.price, 
    required this.capitalization,
    required this.isFavorite
  });

  DataCrypto copyWith({
    String? token,
    String? name,
    double? price,
    double? capitalization,
    bool? isFavorite
  }) {
    return DataCrypto(
      token: token ?? this.token,
      name: name ?? this.name,
      price: price ?? this.price,
      capitalization: capitalization ?? this.capitalization,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}