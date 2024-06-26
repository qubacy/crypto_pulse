import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'CryptocurrencyListItemTest.mocks.dart';

class Flag {
  bool? flag;

  Flag(flag) : this.flag = flag;
}

Widget buildWidget(CryptoPresentation cryptoPresentation, CryptocurrencyListItemCallback callback) {
  return MaterialApp(
    home: Scaffold(
      body: CryptocurrencyListItem(
        cryptoPresentation: cryptoPresentation, 
        callback: callback
      )
    )
  );
}

@GenerateMocks([CryptocurrencyListItemCallback])
void main() {
  group('Cryptocurrency List Item tests', () {
    testWidgets('A callback function is called on clicking Favorite button', (tester) async {
      const CryptoPresentation expectedCryptoPresentation = CryptoPresentation(
        token: 'test token', 
        name: 'test name', 
        price: 'test price', 
        capitalization: 0, 
        isFavorite: false
      );

      late CryptoPresentation gottenCryptoPresentation;

      final MockCryptocurrencyListItemCallback callbackMock = MockCryptocurrencyListItemCallback();

      when(callbackMock.onFavoriteToggled(any)).thenAnswer((invocation) {
        gottenCryptoPresentation = invocation.positionalArguments.first;
      });

      final cryptocurrencyListItem = buildWidget(expectedCryptoPresentation, callbackMock);

      await tester.pumpWidget(cryptocurrencyListItem);

      final favoriteIcon = expectedCryptoPresentation.isFavorite ? Icons.favorite : Icons.favorite_border;
      final favoriteButtonFinder = find.byIcon(favoriteIcon);

      await tester.tap(favoriteButtonFinder);

      verify(callbackMock.onFavoriteToggled(any));

      expect(gottenCryptoPresentation, expectedCryptoPresentation);
    });
  });
}