import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FMultiValueNotifier<int> controller;

  setUp(() => controller = FMultiValueNotifier.radio());

  tearDown(() => controller.dispose());

  testWidgets('lifted', (tester) async {
    Set<int> value = {};

    await tester.pumpWidget(
      TestScaffold(
        child: StatefulBuilder(
          builder: (context, setState) => FSelectTileGroup<int>(
            control: FSelectGroupControl.lifted(value: value, onChange: (v) => setState(() => value = v)),
            children: const [
              FSelectTile(title: Text('1'), value: 1),
              FSelectTile(title: Text('2'), value: 2),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(value, {1});

    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();

    expect(value, {1, 2});

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(value, {2});
  });

  group('managed', () {
    testWidgets('onChange callback called on controller value change', (tester) async {
      final controller = autoDispose(FMultiValueNotifier<int>());
      Set<int>? changedValue;

      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup<int>(
            control: FSelectGroupControl.managed(controller: controller, onChange: (value) => changedValue = value),
            children: const [
              FSelectTile(title: Text('1'), value: 1),
              FSelectTile(title: Text('2'), value: 2),
            ],
          ),
        ),
      );

      controller.value = {1, 2};
      await tester.pump();

      expect(changedValue, {1, 2});
    });
  });

  testWidgets('press select tile with prefix check icon', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup(
          control: FSelectGroupControl.managed(controller: controller),
          children: const [
            FSelectTile(title: Text('1'), value: 1),
            FSelectTile(title: Text('2'), value: 2),
          ],
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
          control: FSelectGroupControl.managed(controller: controller),
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
    final controller = autoDispose(FMultiValueNotifier<int>.radio(2));

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup(
          control: FSelectGroupControl.managed(controller: controller),
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
          control: FSelectGroupControl.managed(controller: controller),
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
            FTileGroup(
              children: [
                FTile(title: const Text('A')),
                FTile(title: const Text('B')),
              ],
            ),
            FSelectTileGroup(
              control: FSelectGroupControl.managed(controller: controller),
              children: const [
                FSelectTile(title: Text('1'), value: 1),
                FSelectTile(title: Text('2'), value: 2),
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

  testWidgets('set initial value', (tester) async {
    final key = GlobalKey<FormState>();

    Set<int>? initial;
    await tester.pumpWidget(
      TestScaffold(
        child: Form(
          key: key,
          child: FSelectTileGroup<int>(
            control: FSelectGroupControl.managed(controller: autoDispose(FMultiValueNotifier(value: {1}))),
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

  testWidgets('onChange callback called', (tester) async {
    var changes = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          control: FSelectGroupControl.managed(controller: controller, onChange: (_) => changes++),
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(changes, 1);
  });

  testWidgets('update callbacks', (tester) async {
    final controller = autoDispose(FMultiValueNotifier<int>());

    var firstChanges = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          control: FSelectGroupControl.managed(controller: controller, onChange: (_) => firstChanges++),
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(firstChanges, 1);
    expect(controller.hasListeners, true);

    var secondChanges = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          control: FSelectGroupControl.managed(controller: controller, onChange: (_) => secondChanges++),
          children: const [FSelectTile(title: Text('1'), value: 1)],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(firstChanges, 1);
    expect(secondChanges, 1);
  });

  testWidgets('update controller', (tester) async {
    final first = autoDispose(FMultiValueNotifier<int>());
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectTileGroup<int>(
          control: FSelectGroupControl.managed(controller: first),
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
          control: FSelectGroupControl.managed(controller: second),
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
          control: FSelectGroupControl.managed(controller: controller),
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
