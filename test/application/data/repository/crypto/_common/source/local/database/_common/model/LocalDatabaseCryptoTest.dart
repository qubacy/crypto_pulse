import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/model/LocalDatabaseCrypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Local Database Crypto tests', () {
    test('fromEntity() test', () {
      const CryptoEntity cryptoEntity = CryptoEntity(
        token: 'test',
        name: 'test', 
        price: 1, 
        isFavorite: false, 
        capitalization: 2
      );

      final LocalDatabaseCrypto expectedLocalDatabaseCrypto =
        LocalDatabaseCrypto(
          token: cryptoEntity.token, 
          name: cryptoEntity.name, 
          price: cryptoEntity.price, 
          isFavorite: cryptoEntity.isFavorite, 
          capitalization: cryptoEntity.capitalization
        );
      
      final LocalDatabaseCrypto gottenLocalDatabaseCrypto =
        LocalDatabaseCrypto.fromEntity(cryptoEntity);

      expect(gottenLocalDatabaseCrypto, expectedLocalDatabaseCrypto);
    });

    test('toEntity() test', () {
      const LocalDatabaseCrypto localDatabaseCrypto = LocalDatabaseCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        isFavorite: false, 
        capitalization: 2
      );

      final CryptoEntity expectedCryptoEntity = CryptoEntity(
        token: localDatabaseCrypto.token, 
        name: localDatabaseCrypto.name, 
        price: localDatabaseCrypto.price, 
        isFavorite: localDatabaseCrypto.isFavorite, 
        capitalization: localDatabaseCrypto.capitalization
      );

      final CryptoEntity gottenCryptoEntity = localDatabaseCrypto.toEntity();

      expect(gottenCryptoEntity, expectedCryptoEntity);
    });
  });
}