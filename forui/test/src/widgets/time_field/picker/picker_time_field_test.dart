import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/widgets/picker/picker_wheel.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  for (final (index, (locale, date))
      in const [
        (null, '10:00 AM'),
        (Locale('en', 'SG'), '10:00 am'),
      ].indexed) {
    testWidgets('formatted date - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(locale: locale, child: const FTimeField.picker(key: key)),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(BuilderWheel).first, const Offset(0, 50));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text(date), findsOneWidget);
    });
  }

  testWidgets('24 hours', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(locale: const Locale('en', 'SG'), child: const FTimeField.picker(key: key, hour24: true)),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('00:00'), findsOneWidget);
  });

  testWidgets('validator', (tester) async {
    final controller = FTimeFieldController(
      vsync: const TestVSync(),
      validator: (date) {
        if (date == const FTime(10)) {
          return 'Custom error.';
        }

        return null;
      },
    );

    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FTimeField.picker(controller: controller, key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(BuilderWheel).first, const Offset(0, 50));
    await tester.pumpAndSettle();

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('Custom error.'), findsOneWidget);
  });


  testWidgets('custom format', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FTimeField.picker(key: key, format: DateFormat.jms('en_SG')),
      ),
    );

    expect(find.text('12:00:00 am'), findsOneWidget);
  });
}
