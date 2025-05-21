import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FMultiValueNotifier<int> controller;

  setUp(() => controller = FMultiValueNotifier.radio());

  tearDown(() => controller.dispose());

  group('FSelectTileGroup', () {
    testWidgets('press select tile with prefix check icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            children: const [FSelectTile(title: Text('1'), value: 1), FSelectTile(title: Text('2'), value: 2)],
          ),
        ),
      );
      expect(controller.value, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.value, {2});
    });

    testWidgets('press select tile with suffix check icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            children: const [
              FSelectTile.suffix(title: Text('1'), value: 1),
              FSelectTile.suffix(title: Text('2'), value: 2),
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
      final controller = autoDispose(FMultiValueNotifier<int>.radio(value: 2));

      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            children: const [
              FSelectTile.suffix(title: Text('1'), value: 1),
              FSelectTile.suffix(title: Text('2'), value: 2),
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
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            selectController: controller,
            autovalidateMode: AutovalidateMode.always,
            validator: (values) => values?.isEmpty ?? true ? 'error message' : null,
            children: const [
              FSelectTile.suffix(title: Text('1'), value: 1),
              FSelectTile.suffix(title: Text('2'), value: 2),
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
      await tester.pumpWidget(
        TestScaffold(
          child: FTileGroup.merge(
            children: [
              FTileGroup(children: [FTile(title: const Text('A')), FTile(title: const Text('B'))]),
              FSelectTileGroup(
                selectController: controller,
                children: const [FSelectTile(title: Text('1'), value: 1), FSelectTile(title: Text('2'), value: 2)],
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

  testWidgets('set initial value', (tester) async {
    final key = GlobalKey<FormState>();

    Set<int>? initial;
    await tester.pumpWidget(
      TestScaffold(
        child: Form(
          key: key,
          child: FSelectTileGroup<int>(
            selectController: autoDispose(FMultiValueNotifier(values: {1})),
            children: const [FSelectTile(title: Text('1'), value: 1)],
            onSaved: (value) => initial = value,
          ),
        ),
      ),
    );

    key.currentState!.save();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(initial, {1});
  });

  testWidgets('callbacks called', (tester) async {
    var changes = 0;
    var selections = 0;
    (int, bool)? selection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: controller,
          onChange: (_) => changes++,
          onSelect: (value) {
            selections++;
            selection = value;
          },
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(changes, 1);
    expect(selections, 1);
    expect(selection, (1, true));
  });

  testWidgets('update callbacks', (tester) async {
    final controller = autoDispose(FMultiValueNotifier<int>());

    var firstChanges = 0;
    var firstSelections = 0;
    (int, bool)? firstSelection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: controller,
          onChange: (_) => firstChanges++,
          onSelect: (value) {
            firstSelections++;
            firstSelection = value;
          },
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(firstChanges, 1);
    expect(firstSelections, 1);
    expect(firstSelection, (1, true));

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
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

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
    final first = autoDispose(FMultiValueNotifier<int>());
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: first,
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    expect(first.hasListeners, true);
    expect(first.disposed, false);

    final second = autoDispose(FMultiValueNotifier<int>());
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: second,
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    expect(first.hasListeners, false);
    expect(first.disposed, false);
    expect(second.hasListeners, true);
    expect(second.disposed, false);
  });

  testWidgets('dispose controller', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          selectController: controller,
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    expect(controller.hasListeners, true);
    expect(controller.disposed, false);

    await tester.pumpWidget(TestScaffold(child: const SizedBox()));

    expect(controller.hasListeners, false);
    expect(controller.disposed, false);
  });
}
