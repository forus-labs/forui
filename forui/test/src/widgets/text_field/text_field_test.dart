import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTextField', () {
    testWidgets('embedded in CupertinoApp', (tester) async {
      await tester.pumpWidget(CupertinoApp(home: TestScaffold(child: const FTextField())));

      expect(tester.takeException(), null);
    });

    testWidgets('embedded in MaterialApp', (tester) async {
      await tester.pumpWidget(MaterialApp(home: TestScaffold(child: const FTextField())));

      expect(tester.takeException(), null);
    });

    testWidgets('not embedded in any App', (tester) async {
      await tester.pumpWidget(TestScaffold(child: const FTextField()));

      expect(tester.takeException(), null);
    });

    testWidgets('non-English Locale', (tester) async {
      await tester.pumpWidget(
        Localizations(
          locale: const Locale('fr', 'FR'),
          delegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          child: TestScaffold(theme: FThemes.zinc.light, child: const FTextField()),
        ),
      );

      expect(tester.takeException(), null);
    });

    group('clearable', () {
      testWidgets('no icon when clearable return false', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(theme: FThemes.zinc.light, child: FTextField(clearable: (_) => false)),
        );

        expect(find.bySemanticsLabel('Clear'), findsNothing);
      });

      testWidgets('no icon when disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(theme: FThemes.zinc.light, child: FTextField(enabled: false, clearable: (_) => true)),
        );
        await tester.pumpAndSettle();

        expect(find.bySemanticsLabel('Clear'), findsNothing);
      });

      testWidgets('suffix & no icon when disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: FThemes.zinc.light,
            child: FTextField(enabled: false, clearable: (_) => true, suffixBuilder: (_, _, _) => const SizedBox()),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.bySemanticsLabel('Clear'), findsNothing);
      });

      testWidgets('clears text-field', (tester) async {
        final controller = TextEditingController(text: 'Testing');

        await tester.pumpWidget(
          TestScaffold.app(
            theme: FThemes.zinc.light,
            child: FTextField(controller: controller, clearable: (value) => value.text.isNotEmpty),
          ),
        );

        expect(find.text('Testing'), findsOneWidget);

        await tester.tap(find.bySemanticsLabel('Clear'));
        await tester.pumpAndSettle();

        expect(find.text('Testing'), findsNothing);
      });

      testWidgets('suffix & clears text-field', (tester) async {
        final controller = TextEditingController(text: 'Testing');

        await tester.pumpWidget(
          TestScaffold.app(
            theme: FThemes.zinc.light,
            child: FTextField(
              controller: controller,
              clearable: (value) => value.text.isNotEmpty,
              suffixBuilder: (_, _, _) => const SizedBox(),
            ),
          ),
        );

        expect(find.text('Testing'), findsOneWidget);

        await tester.tap(find.bySemanticsLabel('Clear'));
        await tester.pumpAndSettle();

        expect(find.text('Testing'), findsNothing);
      });
    });
  });

  group('state', () {
    for (final (type, field) in [
      ('normal', (text, controller, saved) => FTextField(initialValue: text, controller: controller, onSaved: saved)),
      (
        'email',
        (text, controller, saved) => FTextField.email(initialValue: text, controller: controller, onSaved: saved),
      ),
      (
        'password',
        (text, controller, saved) => FTextField.password(initialValue: text, controller: controller, onSaved: saved),
      ),
      (
        'multiline',
        (text, controller, saved) => FTextField.multiline(initialValue: text, controller: controller, onSaved: saved),
      ),
    ]) {
      testWidgets('$type - set initial value using initialValue', (tester) async {
        final key = GlobalKey<FormState>();

        String? initial;
        await tester.pumpWidget(
          TestScaffold.app(child: Form(key: key, child: field('initial', null, (value) => initial = value))),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, 'initial');
      });

      testWidgets('$type - both provided', (tester) async {
        final key = GlobalKey<FormState>();

        String? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: field(null, autoDispose(TextEditingController(text: 'initial')), (value) => initial = value),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, 'initial');
      });
    }
  });
}
