import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FMultiValueNotifier<int> controller;

  setUp(() => controller = .radio());

  tearDown(() => controller.dispose());

  testWidgets('lifted', (tester) async {
    Set<int> value = {};

    await tester.pumpWidget(
      TestScaffold(
        child: StatefulBuilder(
          builder: (context, setState) => FSelectTileGroup<int>(
            control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
            children: const [
              .tile(title: Text('1'), value: 1),
              .tile(title: Text('2'), value: 2),
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
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            children: const [
              .tile(title: Text('1'), value: 1),
              .tile(title: Text('2'), value: 2),
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
          control: .managed(controller: controller),
          children: const [
            .tile(title: Text('1'), value: 1),
            .tile(title: Text('2'), value: 2),
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
          control: .managed(controller: controller),
          children: const [
            .suffix(title: Text('1'), value: 1),
            .suffix(title: Text('2'), value: 2),
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
          control: .managed(controller: controller),
          children: const [
            .suffix(title: Text('1'), value: 1),
            .suffix(title: Text('2'), value: 2),
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
          control: .managed(controller: controller),
          autovalidateMode: .always,
          validator: (values) => values?.isEmpty ?? true ? 'error message' : null,
          children: const [
            .suffix(title: Text('1'), value: 1),
            .suffix(title: Text('2'), value: 2),
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
            .group(
              children: [
                .tile(title: const Text('A')),
                .tile(title: const Text('B')),
              ],
            ),
            .selectGroup(
              control: .managed(controller: controller),
              children: const [
                .tile(title: Text('1'), value: 1),
                .tile(title: Text('2'), value: 2),
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
            control: const .managed(initial: {1}),
            children: const [.tile(title: Text('1'), value: 1)],
            onSaved: (value) => initial = value,
          ),
        ),
      ),
    );

    key.currentState!.save();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(initial, {1});
  });
}
