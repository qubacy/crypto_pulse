import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/Cryptocurrencies.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/component/CryptocurrencyList.dart';
import 'package:crypto_pulse/application/ui/screen/cryptocurrency/model/_common/CryptocurrenciesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'CryptocurrenciesTest.mocks.dart';

MockCryptocurrenciesModel mockCryptocurrenciesModel(
  {
    Stream<List<CryptoPresentation>>? cryptoPresentationStreamArg,
    isLoading = false
  }
) {
  final cryptoPresentationStream = cryptoPresentationStreamArg ?? const Stream.empty();
  final cryptocurrenciesModelMock = MockCryptocurrenciesModel();

  when(cryptocurrenciesModelMock.cryptoPresentationStream).thenAnswer((_) => cryptoPresentationStream);
  when(cryptocurrenciesModelMock.isLoading).thenReturn(isLoading);

  return cryptocurrenciesModelMock;
}

Widget buildWidget(MockCryptocurrenciesModel model) {
  return MaterialApp(
    home: Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => model as CryptocurrenciesModel,
        builder: (context, child) => const Cryptocurrencies()
      )
    )
  );
}

@GenerateMocks([CryptocurrenciesModel, GoRouter])
void main() {
  group('Cryptocurrencies tests', () {
    testWidgets('Cryptocurrencies page appearance test', (tester) async {
      const isLoading = false;

      final cryptocurrenciesModelMock = mockCryptocurrenciesModel(isLoading: isLoading);

      final widget = buildWidget(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      final appBarFinder = find.byType(AppBar);
      final listFinder = find.byType(CryptocurrencyList);

      expect(appBarFinder, findsOneWidget);
      expect(listFinder, findsOneWidget);
    });

    testWidgets('AppBar appearance test', (tester) async {
      const isLoading = false;

      final cryptocurrenciesModelMock = mockCryptocurrenciesModel(isLoading: isLoading);

      final widget = buildWidget(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      final titleFinder = find.byElementPredicate((elem) {
        final titleFinder = find.text(Cryptocurrencies.NAME);

        if (elem.findAncestorWidgetOfExactType<AppBar>() == null) return false;

        return titleFinder.evaluate().contains(elem);
      });

      expect(titleFinder, findsOneWidget);
    });

    // TODO: should be modified in order to test an actual change:
    testWidgets('UI changes according to isLoading test', (tester) async {      
      const IsLoading = true;

      final cryptocurrenciesModelMock = mockCryptocurrenciesModel(isLoading: IsLoading);

      final widget = buildWidget(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      final progressIndicatorFinder = find.byType(LinearProgressIndicator);

      expect(progressIndicatorFinder, findsOneWidget);
    });
  });
}