import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

class Foo extends StatelessWidget {
  final Widget child;

  const Foo({required this.child, super.key});

  @override
  Widget build(BuildContext context) => FTheme(
    data: FThemes.zinc.dark,
    textDirection: TextDirection.ltr,
    child: child,
  );
}

void main() {
  group('FTheme', () {
    testWidgets('ThemeData is visible in child widgets', (tester) async {
      await tester.pumpWidget(Foo(
        child: Builder(builder: (context) => Text('${context.theme == FThemes.zinc.dark}')),
      ));

      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('Changes to ThemData is propagated to children widgets', (tester) async {
      const key = ValueKey('dependent');

      await tester.pumpWidget(
        FTheme(
          data: FThemes.zinc.light,
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) => Text(context.theme.toString(), key: key),
          ),
        ),
      );
      final initial = tester.widget<Text>(find.byKey(key)).data;

      await tester.pumpWidget(
        FTheme(
          data: FThemes.zinc.dark,
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) => Text(context.theme.toString(), key: key),
          ),
        ),
      );
      final updated = tester.widget<Text>(find.byKey(key)).data;

      expect(initial, isNot(updated));
    });

    testWidgets('no ThemeData in ancestor', (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(builder: (context) => Text('${context.theme == FThemes.zinc.dark}')),
      ));

      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('inherit TextDirection from parent', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: FTheme(
          data: FThemes.zinc.dark,
          child: const Text(''),
        ),
      ));

      expect(tester.takeException(), null);
    });

    test('debugFillProperties(...)', () {
      final theme = FTheme(data: FThemes.zinc.dark, child: Container());
      final builder = DiagnosticPropertiesBuilder();

      theme.debugFillProperties(builder);

      expect(
        builder.properties.map((p) => p.toString()),
        [
          DiagnosticsProperty<FThemeData>('data', FThemes.zinc.dark, showName: false)
        ].map((p) => p.toString()),
      );
    });
  });

}
