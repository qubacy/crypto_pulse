import 'package:crypto_pulse/application/data/repository/crypto/_common/model/DataCrypto.dart';
import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Crypto Presentation tests', () {
    test('fromDataCrypto() test', () {
      const DataCrypto dataCrypto = DataCrypto(
        token: 'test', 
        name: 'test', 
        price: 1, 
        capitalization: 2, 
        isFavorite: false
      );

      final CryptoPresentation expectedCryptoPresentation = CryptoPresentation(
        token: dataCrypto.token, 
        name: dataCrypto.name, 
        price: "\$${dataCrypto.price}", 
        capitalization: dataCrypto.capitalization, 
        isFavorite: dataCrypto.isFavorite
      );

      final CryptoPresentation gottenCryptoPresentation = CryptoPresentation.fromDataCrypto(dataCrypto);

      expect(gottenCryptoPresentation, expectedCryptoPresentation);
    });
  });  
}