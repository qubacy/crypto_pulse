import 'dart:async';

import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyList.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyListItem.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/CryptocurrenciesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'CryptocurrencyListTest.mocks.dart';

Widget buildList(MockCryptocurrenciesModel model) {
  return MaterialApp(
    home: ChangeNotifierProvider(
      create: (context) => model as CryptocurrenciesModel,
      builder: (context, child) => const CryptocurrencyList()
    )
  );
}

@GenerateMocks([CryptocurrenciesModel])
void main() {
  testWidgets('CryptocurrencyList displays items from a model stream', (tester) async {
    const CryptoPresentation cryptoPresentation = CryptoPresentation(
      token: 'test', 
      name: 'test', 
      price: 'test', 
      capitalization: 1, 
      isFavorite: false
    );
    const List<CryptoPresentation> cryptoPresentationList = [cryptoPresentation];

    final StreamController<List<CryptoPresentation>> cryptoPresentationListController = StreamController();

    final MockCryptocurrenciesModel cryptocurrenciesModelMock = MockCryptocurrenciesModel();

    when(cryptocurrenciesModelMock.getAllCryptoPresentations())
      .thenAnswer((_) => cryptoPresentationListController.stream);

    final Widget widget = buildList(cryptocurrenciesModelMock);

    tester.pumpWidget(widget);

    final listItemFinder = find.byElementType(CryptocurrencyListItem);

    expect(listItemFinder, findsNothing);

    cryptoPresentationListController.add(cryptoPresentationList);

    tester.pumpAndSettle();

    for (CryptoPresentation cryptoPresentation in cryptoPresentationList) {
      final itemTextFinder = find.text(cryptoPresentation.name);

      expect(itemTextFinder, findsOneWidget);
    }
  });
}