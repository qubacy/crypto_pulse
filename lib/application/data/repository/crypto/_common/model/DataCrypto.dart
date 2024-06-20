import 'package:crypto_pulse/application/data/repository/crypto/_common/source/http/rest/_common/model/RemoteHttpRestCrypto.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';

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

  @override
  bool operator==(Object other) {
    if (other is! DataCrypto) return false;

    return (
      other.token == token && 
      other.name == name &&
      other.price == price &&
      other.capitalization == capitalization &&
      other.isFavorite == isFavorite
    );
  }

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

  factory DataCrypto.fromLocalDatabase(LocalDatabaseCrypto localDatabaseCrypto) {
    return DataCrypto(
      token: localDatabaseCrypto.token, 
      name: localDatabaseCrypto.name, 
      price: localDatabaseCrypto.price, 
      capitalization: localDatabaseCrypto.capitalization, 
      isFavorite: localDatabaseCrypto.isFavorite
    );
  }

  LocalDatabaseCrypto toLocalDatabase({bool? newIsFavorite}) {
    return LocalDatabaseCrypto(
      token: token,
      name: name,
      price: price,
      capitalization: capitalization,
      isFavorite: newIsFavorite ?? isFavorite
    );
  }

  factory DataCrypto.fromRemoteHttpRest({
    required RemoteHttpRestCrypto remoteHttpRestCrypto,
    bool? isFavorite
  }) {
    return DataCrypto(
      token: remoteHttpRestCrypto.token, 
      name: remoteHttpRestCrypto.name, 
      price: remoteHttpRestCrypto.price, 
      capitalization: remoteHttpRestCrypto.capitalization, 
      isFavorite: isFavorite ?? false
    );
  }
  
  @override
  int get hashCode => Object.hash(token, name, price, capitalization, isFavorite);
}