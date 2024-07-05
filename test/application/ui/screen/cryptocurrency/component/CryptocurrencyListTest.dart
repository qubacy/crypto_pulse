import 'dart:async';

import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyList.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyListItem.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'CryptocurrencyListTest.mocks.dart';

Widget buildList(MockCryptocurrenciesModel model) {
  return MaterialApp(
    home: Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => model as CryptocurrenciesModel,
        builder: (context, child) => CryptocurrencyList()
      )
    )
  );
}

@GenerateMocks([CryptocurrenciesModel])
void main() {
  group('Cryptocurrency List tests', () {
    testWidgets('Items are displayed using a model stream', (tester) async {
      const CryptoPresentation cryptoPresentation = CryptoPresentation(
        token: 'test token', 
        name: 'test name', 
        price: 'test price', 
        capitalization: 1, 
        isFavorite: false
      );
      const List<CryptoPresentation> cryptoPresentationList = [cryptoPresentation];

      final StreamController<List<CryptoPresentation>> cryptoPresentationListController = StreamController();

      final MockCryptocurrenciesModel cryptocurrenciesModelMock = MockCryptocurrenciesModel();

      when(cryptocurrenciesModelMock.cryptoPresentationStream)
        .thenAnswer((_) => cryptoPresentationListController.stream);

      final Widget widget = buildList(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      verify(cryptocurrenciesModelMock.cryptoPresentationStream);
      verify(cryptocurrenciesModelMock.getAllCryptoPresentations());

      final listItemFinder = find.byElementType(CryptocurrencyListItem);

      expect(listItemFinder, findsNothing);

      cryptoPresentationListController.add(cryptoPresentationList);

      await tester.pumpAndSettle();

      for (CryptoPresentation cryptoPresentation in cryptoPresentationList) {
        final itemNameFinder = find.text(cryptoPresentation.name);
        final itemPriceFinder = find.text(cryptoPresentation.price);
        final itemFavoriteIconFinder = find.byElementPredicate((elem) {
          final iconFinder = find.byIcon(cryptoPresentation.isFavorite ? Icons.favorite : Icons.favorite_border);
          final keyFinder = find.byKey(CryptocurrencyListItem.getFavoriteIconKey(cryptoPresentation.token));

          bool iconFinderSuccess = iconFinder.evaluate().contains(elem);
          bool keyFinderSuccess = keyFinder.evaluate().contains(elem);

          return iconFinderSuccess && keyFinderSuccess;
        });

        expect(itemNameFinder, findsOneWidget);
      }
    });

    testWidgets('Clicking on Favorite icon leads to interaction with a model', (tester) async {
      const CryptoPresentation expectedCryptoPresentationToToggleFavorite = CryptoPresentation(
        token: 'test token', 
        name: 'test name', 
        price: 'test price', 
        capitalization: 1, 
        isFavorite: false
      );
      const List<CryptoPresentation> cryptoPresentationList = [expectedCryptoPresentationToToggleFavorite];
      final Stream<List<CryptoPresentation>> getAllCryptoPresentationStream = Stream.value(cryptoPresentationList);

      late CryptoPresentation gottenCryptoPresentationToToggleFavorite;  

      final MockCryptocurrenciesModel cryptocurrenciesModelMock = MockCryptocurrenciesModel();

      when(cryptocurrenciesModelMock.cryptoPresentationStream).thenAnswer((_) => getAllCryptoPresentationStream);
      when(cryptocurrenciesModelMock.toggleFavoriteCrypto(any))
        .thenAnswer((invocation) {
          gottenCryptoPresentationToToggleFavorite = invocation.positionalArguments.first;
        });

      final Widget widget = buildList(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      verify(cryptocurrenciesModelMock.cryptoPresentationStream);
      verify(cryptocurrenciesModelMock.getAllCryptoPresentations());

      final itemListFinder = find.byType(CryptocurrencyListItem);

      expect(itemListFinder, findsExactly(cryptoPresentationList.length));

      final itemFavoriteIconKey = CryptocurrencyListItem.getFavoriteIconKey(
        expectedCryptoPresentationToToggleFavorite.token);
      final itemListFavoriteIconFinder = find.byKey(itemFavoriteIconKey);
      
      await tester.tap(itemListFavoriteIconFinder);
      await tester.pumpAndSettle();

      verify(cryptocurrenciesModelMock.toggleFavoriteCrypto(any));

      expect(gottenCryptoPresentationToToggleFavorite, expectedCryptoPresentationToToggleFavorite);
    });

    testWidgets('Scrolling to the end leads to requesting a new chunk', (tester) async {
      List<CryptoPresentation> cryptoPresentationList = List.generate(20, (index) {
        return CryptoPresentation(
          token: 'test token $index', 
          name: 'test name $index', 
          price: 'test price $index', 
          capitalization: 0, 
          isFavorite: false
        );
      });
      final Stream<List<CryptoPresentation>> getAllCryptoPresentationStream = Stream.value(cryptoPresentationList);

      final MockCryptocurrenciesModel cryptocurrenciesModelMock = MockCryptocurrenciesModel();

      when(cryptocurrenciesModelMock.cryptoPresentationStream).thenAnswer((_) => getAllCryptoPresentationStream);

      final Widget widget = buildList(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      verify(cryptocurrenciesModelMock.cryptoPresentationStream);
      verify(cryptocurrenciesModelMock.getAllCryptoPresentations());

      final lastListItemNameFinder = find.text(cryptoPresentationList.last.name);

      await tester.scrollUntilVisible(lastListItemNameFinder, 60);

      verify(cryptocurrenciesModelMock.getNextChunk());
    });
  });
}