// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('tap on tile opens menu', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile(
          prefix: const Icon(FIcons.calendar),
          label: const Text('Label'),
          description: const Text('Description'),
          title: const Text('Repeat'),
          subtitle: const Text('Fee, Fo, Fum'),
          details: const Text('None'),
          menu: const [
            FSelectTile(title: Text('Item 1'), value: 1),
            FSelectTile(title: Text('Item 2'), value: 2),
          ],
        ),
      ),
    );

    expect(find.text('Item 1'), findsNothing);
    expect(find.text('Item 2'), findsNothing);

    await tester.tap(find.byType(FSelectMenuTile<int>));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);
  });

  testWidgets('selecting item in menu does not close it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile(
          autoHide: false,
          prefix: const Icon(FIcons.calendar),
          label: const Text('Label'),
          description: const Text('Description'),
          title: const Text('Repeat'),
          subtitle: const Text('Fee, Fo, Fum'),
          details: const Text('None'),
          menu: const [
            FSelectTile(title: Text('Item 1'), value: 1),
            FSelectTile(title: Text('Item 2'), value: 2),
          ],
        ),
      ),
    );
    await tester.tap(find.byType(FSelectMenuTile<int>));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);

    await tester.tap(find.text('Item 1'));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);
  });

  testWidgets('selecting item in menu closes it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile(
          prefix: const Icon(FIcons.calendar),
          label: const Text('Label'),
          description: const Text('Description'),
          title: const Text('Repeat'),
          subtitle: const Text('Fee, Fo, Fum'),
          details: const Text('None'),
          menu: const [
            FSelectTile(title: Text('Item 1'), value: 1),
            FSelectTile(title: Text('Item 2'), value: 2),
          ],
        ),
      ),
    );
    await tester.tap(find.byType(FSelectMenuTile<int>));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);

    await tester.tap(find.text('Item 1'));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsNothing);
    expect(find.text('Item 2'), findsNothing);
  });

  group('state', () {
    group('FSelectMenuTile.new', () {
      testWidgets('set initial value', (tester) async {
        final key = GlobalKey<FormState>();

        Set<int>? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: FSelectMenuTile<int>(
                initialValue: 1,
                title: const Text('Repeat'),
                onSaved: (value) => initial = value,
                menu: const [FSelectTile(title: Text('1'), value: 1)],
              ),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, {1});
      });

      testWidgets('set initial value via controller', (tester) async {
        final key = GlobalKey<FormState>();

        Set<int>? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: FSelectMenuTile<int>(
                selectController: autoDispose(FMultiValueNotifier(values: {1})),
                title: const Text('Repeat'),
                onSaved: (value) => initial = value,
                menu: const [FSelectTile(title: Text('1'), value: 1)],
              ),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, {1});
      });

      testWidgets('detailsBuilder updates when selecting value', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSelectMenuTile<int>(
              title: const Text('Repeat'),
              detailsBuilder: (_, value, _) => Text('Selected: ${value.firstOrNull}'),
              menu: const [FSelectTile(title: Text('1'), value: 1)],
            ),
          ),
        );

        await tester.tap(find.byType(FSelectMenuTile<int>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('Selected: 1'), findsOne);
      });
    });

    group('FSelectMenuTile.builder', () {
      testWidgets('set initial value', (tester) async {
        final key = GlobalKey<FormState>();

        Set<int>? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: FSelectMenuTile<int>.builder(
                initialValue: 0,
                title: const Text('Repeat'),
                onSaved: (value) => initial = value,
                menuBuilder: (context, index) => FSelectTile(title: Text('$index'), value: index),
              ),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, {0});
      });

      testWidgets('set initial value via controller', (tester) async {
        final key = GlobalKey<FormState>();

        Set<int>? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: FSelectMenuTile<int>.builder(
                selectController: autoDispose(FMultiValueNotifier(values: {0})),
                title: const Text('Repeat'),
                onSaved: (value) => initial = value,
                menuBuilder: (context, index) => FSelectTile(title: Text('$index'), value: index),
              ),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, {0});
      });

      testWidgets('detailsBuilder updates when selecting value', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSelectMenuTile<int>.builder(
              count: 1,
              title: const Text('Repeat'),
              detailsBuilder: (_, value, _) => Text('Selected: ${value.firstOrNull}'),
              menuBuilder: (context, index) => FSelectTile(title: Text('$index'), value: index),
            ),
          ),
        );

        await tester.tap(find.byType(FSelectMenuTile<int>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('0'));
        await tester.pumpAndSettle();

        expect(find.text('Selected: 0'), findsOne);
      });
    });

    testWidgets('update callbacks', (tester) async {
      final controller = autoDispose(FMultiValueNotifier<int>());

      var firstChanges = 0;
      var firstSelections = 0;
      (int, bool)? firstSelection;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            selectController: controller,
            title: const Text('Repeat'),
            onChange: (_) => firstChanges++,
            onSelect: (value) {
              firstSelections++;
              firstSelection = value;
            },
            menu: const [FSelectTile(title: Text('1'), value: 1)],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(firstChanges, 1);
      expect(firstSelections, 1);
      expect(firstSelection, (1, true));

      var secondChanges = 0;
      var secondSelections = 0;
      (int, bool)? secondSelection;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            selectController: controller,
            title: const Text('Repeat'),
            onChange: (_) => secondChanges++,
            onSelect: (value) {
              secondSelections++;
              secondSelection = value;
            },
            menu: const [FSelectTile(title: Text('1'), value: 1)],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(firstChanges, 1);
      expect(firstSelections, 1);
      expect(firstSelection, (1, true));

      expect(secondChanges, 1);
      expect(secondSelections, 1);
      expect(secondSelection, (1, false));
    });

    testWidgets('update controller', (tester) async {
      final firstController = autoDispose(FMultiValueNotifier<int>());
      final firstPopoverController = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            selectController: firstController,
            popoverController: firstPopoverController,
            title: const Text('Repeat'),
            onChange: (_) {},
            onSelect: (_) {},
            menu: const [FSelectTile(title: Text('1'), value: 1)],
          ),
        ),
      );

      expect(firstController.hasListeners, true);
      expect(firstController.disposed, false);
      expect(firstPopoverController.hasListeners, false);
      expect(firstPopoverController.disposed, false);

      final secondController = autoDispose(FMultiValueNotifier<int>(values: {1}));
      final secondPopoverController = autoDispose(FPopoverController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            selectController: secondController,
            popoverController: secondPopoverController,
            title: const Text('Repeat'),
            onChange: (_) {},
            onSelect: (_) {},
            menu: const [FSelectTile(title: Text('1'), value: 1)],
          ),
        ),
      );

      expect(firstController.hasListeners, false);
      expect(firstController.disposed, false);
      expect(firstPopoverController.hasListeners, false);
      expect(firstPopoverController.disposed, false);

      expect(secondController.hasListeners, true);
      expect(secondController.disposed, false);
      expect(secondPopoverController.hasListeners, false);
      expect(secondPopoverController.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FMultiValueNotifier<int>());
      final popoverController = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            selectController: controller,
            popoverController: popoverController,
            title: const Text('Repeat'),
            onChange: (_) {},
            onSelect: (_) {},
            menu: const [FSelectTile(title: Text('1'), value: 1)],
          ),
        ),
      );

      expect(controller.hasListeners, true);
      expect(controller.disposed, false);

      expect(popoverController.hasListeners, false);
      expect(popoverController.disposed, false);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);

      expect(popoverController.hasListeners, false);
      expect(popoverController.disposed, false);
    });
  });
}
