import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTextField', () {
    testWidgets('embedded in CupertinoApp', (tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: const FTextField(),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('embedded in MaterialApp', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: const FTextField(),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('not embedded in any App', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: const FTextField(),
        ),
      );

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
          child: TestScaffold(
            data: FThemes.zinc.light,
            child: const FTextField(),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    for (final constructor in [
      (string, raw) => FTextField(label: string, rawLabel: raw),
      (string, raw) => FTextField(help: string, rawHelp: raw),
      (string, raw) => FTextField(error: string, rawError: raw),
      (string, raw) => FTextField.email(label: string, rawLabel: raw),
      (string, raw) => FTextField.email(help: string, rawHelp: raw),
      (string, raw) => FTextField.email(error: string, rawError: raw),
      (string, raw) => FTextField.password(label: string, rawLabel: raw),
      (string, raw) => FTextField.password(help: string, rawHelp: raw),
      (string, raw) => FTextField.password(error: string, rawError: raw),
      (string, raw) => FTextField.multiline(label: string, rawLabel: raw),
      (string, raw) => FTextField.multiline(help: string, rawHelp: raw),
      (string, raw) => FTextField.multiline(error: string, rawError: raw),
    ]) {
      for (final (string, raw) in [
        (null, null),
        ('', null),
        (null, const SizedBox()),
      ]) {
        testWidgets('constructor does not throw error', (tester) async {
          expect(() => constructor(string, raw), returnsNormally);
        });
      }

      testWidgets('constructor title throws error', (tester) async {
        expect(() => constructor('', const SizedBox()), throwsAssertionError);
      });
    }
  });
}
