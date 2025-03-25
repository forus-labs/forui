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
            child: FTabs(tabs: [FTabEntry(label: const Text('Account'), content: Container(height: 100))]),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('embedded in MaterialApp', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            child: FTabs(tabs: [FTabEntry(label: const Text('Account'), content: Container(height: 100))]),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('not embedded in any App', (tester) async {
      await tester.pumpWidget(
        TestScaffold(child: FTabs(tabs: [FTabEntry(label: const Text('Account'), content: Container(height: 100))])),
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
            child: FTabs(tabs: [FTabEntry(label: const Text('Account'), content: Container(height: 100))]),
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('tap on current entry', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('foo'));
      await tester.pumpAndSettle();

      expect(find.text('foo content'), findsOneWidget);
      expect(find.text('bar content'), findsNothing);
    });

    testWidgets('tapping on tab with internal controller switches tab entry', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('bar'));
      await tester.pumpAndSettle();

      expect(find.text('bar content'), findsOneWidget);
    });

    testWidgets('tapping on tab with external controller switches tab entry', (tester) async {
      final controller = FTabController(length: 2, vsync: tester);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            controller: controller,
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('bar content'), findsNothing);

      await tester.tap(find.text('bar'));
      await tester.pumpAndSettle();

      expect(find.text('bar content'), findsOneWidget);
    });

    testWidgets('using controller to switch tab entry', (tester) async {
      final controller = FTabController(length: 2, vsync: tester);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            controller: controller,
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      expect(find.text('bar content'), findsNothing);

      controller.animateTo(1);
      await tester.pumpAndSettle();

      expect(find.text('bar content'), findsOneWidget);
    });

    testWidgets('update controller', (tester) async {
      final first = FTabController(length: 2, vsync: tester);
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            controller: first,
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      expect(first.hasListeners, true);
      expect(first.disposed, false);

      final second = FTabController(length: 2, vsync: tester);
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            controller: second,
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);
      expect(second.hasListeners, true);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = FTabController(length: 2, vsync: tester);
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTabs(
            controller: controller,
            tabs: const [
              FTabEntry(label: Text('foo'), content: Text('foo content')),
              FTabEntry(label: Text('bar'), content: Text('bar content')),
            ],
          ),
        ),
      );

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);
    });
  });
}
