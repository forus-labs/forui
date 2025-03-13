import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSelectTileGroup', () {
    testWidgets('press select tile with prefix check icon', (tester) async {
      final controller = FSelectController<int>.radio();

      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            children: [FSelectTile(title: const Text('1'), value: 1), FSelectTile(title: const Text('2'), value: 2)],
          ),
        ),
      );
      expect(controller.value, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.value, {2});
    });

    testWidgets('press select tile with suffix check icon', (tester) async {
      final controller = FSelectController<int>.radio();

      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            children: [
              FSelectTile.suffix(title: const Text('1'), value: 1),
              FSelectTile.suffix(title: const Text('2'), value: 2),
            ],
          ),
        ),
      );
      expect(controller.value, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.value, {2});
    });

    testWidgets('press already selected tile', (tester) async {
      final controller = FSelectController<int>.radio(value: 2);

      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            children: [
              FSelectTile.suffix(title: const Text('1'), value: 1),
              FSelectTile.suffix(title: const Text('2'), value: 2),
            ],
          ),
        ),
      );
      expect(controller.value, {2});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.value, {2});
    });

    testWidgets('press tile hides error', (tester) async {
      final controller = FSelectController<int>.radio();

      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            autovalidateMode: AutovalidateMode.always,
            validator: (values) => values?.isEmpty ?? true ? 'error message' : null,
            children: [
              FSelectTile.suffix(title: const Text('1'), value: 1),
              FSelectTile.suffix(title: const Text('2'), value: 2),
            ],
          ),
        ),
      );

      expect(find.text('error message'), findsOneWidget);
      expect(controller.value, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(find.text('error message'), findsNothing);
      expect(controller.value, {2});
    });

    testWidgets('press nested select tile', (tester) async {
      final controller = FSelectController<int>.radio();

      await tester.pumpWidget(
        TestScaffold(
          child: FTileGroup.merge(
            children: [
              FTileGroup(children: [FTile(title: const Text('A')), FTile(title: const Text('B'))]),
              FSelectTileGroup(
                selectController: controller,
                children: [
                  FSelectTile(title: const Text('1'), value: 1),
                  FSelectTile(title: const Text('2'), value: 2),
                ],
              ),
            ],
          ),
        ),
      );
      expect(controller.value, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.value, {2});
    });
  });

  testWidgets('callbacks called', (tester) async {
    var changes = 0;
    var selections = 0;
    (int, bool)? selection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: FSelectController(),
          onChange: (_) => changes++,
          onSelect: (value) {
            selections++;
            selection = value;
          },
          children: [FSelectTile(title: const Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(changes, 1);
    expect(selections, 1);
    expect(selection, (1, true));
  });

  testWidgets('update widget', (tester) async {
    final controller = FSelectController<int>();

    var firstChanges = 0;
    var firstSelections = 0;
    (int, bool)? firsSelection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: controller,
          onChange: (_) => firstChanges++,
          onSelect: (value) {
            firstSelections++;
            firsSelection = value;
          },
          children: [FSelectTile(title: const Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(firstChanges, 1);
    expect(firstSelections, 1);
    expect(firsSelection, (1, true));

    var secondChanges = 0;
    var secondSelections = 0;
    (int, bool)? secondSelection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: controller,
          onChange: (_) => secondChanges++,
          onSelect: (value) {
            secondSelections++;
            secondSelection = value;
          },
          children: [FSelectTile(title: const Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(firstChanges, 1);
    expect(firstSelections, 1);
    expect(firsSelection, (1, true));

    expect(secondChanges, 1);
    expect(secondSelections, 1);
    expect(secondSelection, (1, false));
  });
}
