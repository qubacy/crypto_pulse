import 'package:crypto_pulse/application/ui/_common/presentation/CryptoPresentation.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/TopHint.dart';
import 'package:crypto_pulse/application/ui/screen/home/component/list/FavoriteList.dart';
import 'package:crypto_pulse/application/ui/screen/home/home.dart';
import 'package:crypto_pulse/application/ui/screen/home/model/_common/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'HomeTest.mocks.dart';

MockHomeModel mockCryptocurrenciesModel(
  {
    Stream<List<CryptoPresentation>>? favoriteCryptoPresentationStreamArg,
    isLoading = false
  }
) {
  final favoriteCryptoPresentationStream = favoriteCryptoPresentationStreamArg ?? const Stream.empty();
  final cryptocurrenciesModelMock = MockHomeModel();

  when(cryptocurrenciesModelMock.favoriteCryptoPresentationStream).thenAnswer((_) => favoriteCryptoPresentationStream);
  when(cryptocurrenciesModelMock.isLoading).thenReturn(isLoading);

  return cryptocurrenciesModelMock;
}

Widget buildWidget(MockHomeModel model) {
  return MaterialApp(
    home: Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => model as HomeModel,
        builder: (context, child) => Home()
      )
    )
  );
}

@GenerateMocks([HomeModel])
void main() {
  group('Home tests', () {
    testWidgets('Home page appearance test', (tester) async {
      const isLoading = false;

      final cryptocurrenciesModelMock = mockCryptocurrenciesModel(isLoading: isLoading);

      final widget = buildWidget(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      final appBarFinder = find.byType(AppBar);
      final hintFinder = find.byType(TopHint);
      final listFinder = find.byType(FavoriteList);

      expect(appBarFinder, findsOneWidget);
      expect(hintFinder, findsOneWidget);
      expect(listFinder, findsOneWidget);
    });

    testWidgets('AppBar appearance test', (tester) async {
      const isLoading = false;

      final cryptocurrenciesModelMock = mockCryptocurrenciesModel(isLoading: isLoading);

      final widget = buildWidget(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      final titleFinder = find.byElementPredicate((elem) {
        final titleFinder = find.text(Home.NAME);

        if (elem.findAncestorWidgetOfExactType<AppBar>() == null) return false;

        return titleFinder.evaluate().contains(elem);
      });
      final infoButtonFinder = find.byIcon(Icons.info);

      expect(titleFinder, findsOneWidget);
      expect(infoButtonFinder, findsOneWidget);
    });

    testWidgets('Taping the AppBar\'s Info button toggles the hint\'s visibility test', (tester) async {
      const isLoading = false;

      final cryptocurrenciesModelMock = mockCryptocurrenciesModel(isLoading: isLoading);

      final widget = buildWidget(cryptocurrenciesModelMock);

      await tester.pumpWidget(widget);

      final infoButtonFinder = find.byIcon(Icons.info);
      final initHintSize = tester.getSize(infoButtonFinder);

      expect(initHintSize.height, greaterThan(0));

      await tester.tap(infoButtonFinder);
      await tester.pumpAndSettle(); // todo: not good;

      expect(initHintSize.height, equals(0));
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