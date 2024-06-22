import 'package:crypto_pulse/application/data/repository/crypto/_common/source/local/database/_common/dao/_common/entity/CryptoEntity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Crypto Entity tests', () {
    test('fromMap() test', () {
      const String token = 'test';
      const String name = 'test';
      const double price = 1;
      const double capitalization = 1;
      const int isFavorite = 0;

      const Map<String, dynamic> entityMap = {
        CryptoEntity.TOKEN_PROP_NAME: token,
        CryptoEntity.NAME_PROP_NAME: name,
        CryptoEntity.PRICE_PROP_NAME: price,
        CryptoEntity.CAPITALIZATION_PROP_NAME: capitalization,
        CryptoEntity.IS_FAVORITE_PROP_NAME: isFavorite
      }; 

      const expectedCryptoEntity = CryptoEntity(
        token: token, 
        name: name, 
        price: price, 
        isFavorite: isFavorite == 0 ? false : true, 
        capitalization: capitalization
      );

      final gottenCryptoEntity = CryptoEntity.fromMap(entityMap);

      expect(gottenCryptoEntity, expectedCryptoEntity);
    });

    test('toMap() test', () {
      const CryptoEntity cryptoEntity = CryptoEntity(
        token: 'test', 
        name: 'test', 
        price: 1, 
        isFavorite: false, 
        capitalization: 2
      );

      final expectedEntityMap = {
        CryptoEntity.TOKEN_PROP_NAME: cryptoEntity.token,
        CryptoEntity.NAME_PROP_NAME: cryptoEntity.name,
        CryptoEntity.PRICE_PROP_NAME: cryptoEntity.price,
        CryptoEntity.CAPITALIZATION_PROP_NAME: cryptoEntity.capitalization,
        CryptoEntity.IS_FAVORITE_PROP_NAME: cryptoEntity.isFavorite ? 1 : 0
      };

      final gottenEntityMap = cryptoEntity.toMap();

      expect(mapEquals(gottenEntityMap, expectedEntityMap), isTrue);
    });
  });
}