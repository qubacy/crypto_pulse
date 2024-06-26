import 'package:crypto_pulse/application/ui/screen/home/component/TopHint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildWidget(String hint) {
  return MaterialApp(
    home: Scaffold(
      body: TopHint(hint: hint),
    ),
  );
}

void main() {
  group('Top Hint tests', () {
    testWidgets('Appearance test', (tester) async {
      const String hint = 'test hint';

      final Widget widgetToTest = buildWidget(hint);

      await tester.pumpWidget(widgetToTest);

      final hintFinder = find.text(hint);

      expect(hintFinder, findsOne);
    });
  });
}