import 'dart:async';

import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteList.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteListItem.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'FavoriteListTest.mocks.dart';

Widget buildWidget(MockHomeModel homeModelMock) {
  return MaterialApp(
    home: Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => homeModelMock as HomeModel,
        builder: (context, child) => FavoriteList()
      )
    )
  );
}

@GenerateMocks([HomeModel])
void main() {
  group('Favorite List tests', () {
    testWidgets('Items are displayed using a model stream', (tester) async {
      final List<CryptoPresentation> cryptoPresentationList = List.generate(5, (index) {
        return CryptoPresentation(
          token: 'test token $index', 
          name: 'test name $index', 
          price: 'test price $index', 
          capitalization: 0, 
          isFavorite: false
        );
      });

      final StreamController<List<CryptoPresentation>> streamController = StreamController();
      final Stream<List<CryptoPresentation>> favoriteCryptoPresentationListStream = streamController.stream;

      final MockHomeModel homeModelMock = MockHomeModel();

      when(homeModelMock.getFavoriteCryptoPresentations()).thenAnswer((_) => favoriteCryptoPresentationListStream);

      Widget widgetToTest = buildWidget(homeModelMock);

      await tester.pumpWidget(widgetToTest);

      final listItemFinder = find.byType(FavoriteListItem);

      expect(listItemFinder, findsNothing);

      streamController.add(cryptoPresentationList);

      await tester.pumpAndSettle();

      for (final cryptoPresentation in cryptoPresentationList) {
        final listItemNameFinder = find.text(cryptoPresentation.name);
        final listItemPriceFinder = find.text(cryptoPresentation.price);

        expect(listItemNameFinder, findsOne);
        expect(listItemPriceFinder, findsOne);
      }
    });

    testWidgets('Swiping an item to the right leads to removal', (tester) async {
      const CryptoPresentation expectedCryptoPresentationToRemove = CryptoPresentation(
        token: 'test token', 
        name: 'test name', 
        price: 'test price', 
        capitalization: 0, 
        isFavorite: false
      );
      const List<CryptoPresentation> cryptoPresentationList = [expectedCryptoPresentationToRemove];

      final Stream<List<CryptoPresentation>> favoriteCryptoPresentationListStream = 
        Stream.value(cryptoPresentationList);

      late CryptoPresentation gottenCryptoPresentationToRemove;

      final MockHomeModel homeModelMock = MockHomeModel();

      when(homeModelMock.getFavoriteCryptoPresentations()).thenAnswer((_) => favoriteCryptoPresentationListStream);
      when(homeModelMock.removeFromFavorites(any)).thenAnswer((invocation) {
        gottenCryptoPresentationToRemove = invocation.positionalArguments.first;
      });

      Widget widgetToTest = buildWidget(homeModelMock);

      await tester.pumpWidget(widgetToTest);
      await tester.pumpAndSettle();

      final listItemFinder = find.byType(FavoriteListItem);

      final swipeDistance = tester.view.display.size.width / 2;

      await tester.drag(listItemFinder, Offset(swipeDistance, 0));
      await tester.pumpAndSettle();

      verify(homeModelMock.removeFromFavorites(any));

      expect(gottenCryptoPresentationToRemove, expectedCryptoPresentationToRemove);
    });
  });
}