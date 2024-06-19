class CryptoPresentation {
  final String token;
  final String name;
  final String price;
  final bool isFavorite;

  const CryptoPresentation({
    required this.token, 
    required this.name, 
    required this.price, 
    required this.isFavorite
  });

  CryptoPresentation copyWith({
    String? token,
    String? name,
    String? price,
    bool? isFavorite
  }) {
    return CryptoPresentation(
      token: token ?? this.token,
      name: name ?? this.name,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}