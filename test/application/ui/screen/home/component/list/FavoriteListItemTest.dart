import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildWidget(String name, String price) {
  return MaterialApp(
    home: Scaffold(
      body: FavoriteListItem(name: name, price: price,),
    )
  );
}

void main() {
  group('Favorite List Item tests', () {
    testWidgets('Appearance test', (tester) async {
      const cryptoPresentation = CryptoPresentation(
        token: 'test token', 
        name: 'test name', 
        price: 'test price', 
        capitalization: 0, 
        isFavorite: false
      );

      final Widget widgetToTest = buildWidget(cryptoPresentation.name, cryptoPresentation.price);

      await tester.pumpWidget(widgetToTest);

      final nameFinder = find.text(cryptoPresentation.name);
      final priceFinder = find.text(cryptoPresentation.price);

      expect(nameFinder, findsOne);
      expect(priceFinder, findsOne);
    });
  });
}