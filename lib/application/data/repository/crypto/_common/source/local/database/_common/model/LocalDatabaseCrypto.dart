import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';

class LocalDatabaseCrypto {
  final String token;
  final String name;
  final double price;
  final bool isFavorite;
  final double capitalization;

  const LocalDatabaseCrypto({
    required this.token, 
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.capitalization
  });

  @override
  bool operator==(Object other) {
    if (other is! LocalDatabaseCrypto) return false;

    return (
      other.token == token && 
      other.name == name &&
      other.price == price &&
      other.capitalization == capitalization &&
      other.isFavorite == isFavorite
    );
  }

  factory LocalDatabaseCrypto.fromEntity(CryptoEntity entity) {
    return LocalDatabaseCrypto(
      token: entity.token, 
      name: entity.name, 
      price: entity.price, 
      isFavorite: entity.isFavorite, 
      capitalization: entity.capitalization
    );
  }

  CryptoEntity toEntity() {
    return CryptoEntity(
      token: token,
      name: name,
      price: price,
      isFavorite: isFavorite,
      capitalization: capitalization
    );
  }

  @override
  int get hashCode => Object.hash(token, name, price, capitalization, isFavorite);
}