import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('embedding', () {
    testWidgets('embedded in CupertinoApp', (tester) async {
      await tester.pumpWidget(
        CupertinoApp(home: TestScaffold(child: const FTextField())),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('embedded in MaterialApp', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: TestScaffold(child: const FTextField())),
      );

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
          child: TestScaffold(
            theme: FThemes.zinc.light,
            child: const FTextField(),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });
  });

  group('clearable', () {
    testWidgets('no icon when clearable return false', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(clearable: (_) => false),
        ),
      );

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('no icon when disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(enabled: false, clearable: (_) => true),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('suffix & no icon when disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: FThemes.zinc.light,
          child: FTextField(
            enabled: false,
            clearable: (_) => true,
            suffixBuilder: (_, _, _) => const SizedBox(),
          ),
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
          child: FTextField(
            controller: controller,
            clearable: (value) => value.text.isNotEmpty,
          ),
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

  testWidgets('error does not cause overlay to fail', (tester) async {
    final controller = autoDispose(FPopoverController(vsync: tester));

    await tester.pumpWidget(
      TestScaffold.app(
        child: FTextField(
          builder:
              (_, _, child) => FPopover(
                controller: controller,
                popoverBuilder:
                    (_, _, _) =>
                        Container(height: 100, width: 100, color: Colors.blue),
                child: child!,
              ),
        ),
      ),
    );

    unawaited(controller.show());
    await tester.pumpAndSettle();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FTextField(
          error: Container(height: 100, width: 100, color: Colors.red),
          builder:
              (_, _, child) => FPopover(
                controller: controller,
                popoverBuilder:
                    (_, _, _) =>
                        Container(height: 100, width: 100, color: Colors.blue),
                child: child!,
              ),
        ),
      ),
    );

    expect(tester.takeException(), null);
  });
}
