import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTabs', () {
    testWidgets('embedded in CupertinoApp', (tester) async {
      await tester.pumpWidget(
        CupertinoApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: FTabs(tabs: [
              FTabEntry(label: 'Account', content: Container(height: 100))
            ]),
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
            child: FTabs(tabs: [
              FTabEntry(label: 'Account', content: Container(height: 100))
            ]),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('not embedded in any App', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FTabs(tabs: [
            FTabEntry(label: 'Account', content: Container(height: 100))
          ]),
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
            child: FTabs(tabs: [
              FTabEntry(label: 'Account', content: Container(height: 100))
            ]),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

      for (final (string, raw) in [
        ('', null),
        (null, const Text('test')),
      ]) {
        testWidgets('constructor does not throw error', (tester) async {
          expect(
              () => FTabEntry(label: string, rawLabel: raw, content: const SizedBox()),
              returnsNormally,
          );
        });
      }

      for (final (string, raw) in [
        (null, null),
        ('', const Text('test')),
      ]) {
        testWidgets('constructor throws assertion error', (tester) async {
          expect(() => FTabEntry(label: string, rawLabel: raw, content: const SizedBox()), throwsAssertionError,);
        });
      }
  });
}
