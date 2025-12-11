import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('lifted', (tester) async {
    Set<int> value = {};

    await tester.pumpWidget(
      TestScaffold(
        child: StatefulBuilder(
          builder: (context, setState) => FSelectGroup<int>(
            control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
            children: [
              .checkbox(value: 1, label: const Text('1')),
              .checkbox(value: 2, label: const Text('2')),
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
          child: FSelectGroup<int>(
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            children: [
              .checkbox(value: 1, label: const Text('1')),
              .checkbox(value: 2, label: const Text('2')),
            ],
          ),
        ),
      );

      controller.value = {1, 2};
      await tester.pump();

      expect(changedValue, {1, 2});
    });
  });

  testWidgets('set initial value', (tester) async {
    final key = GlobalKey<FormState>();

    Set<int>? initial;
    await tester.pumpWidget(
      TestScaffold(
        child: Form(
          key: key,
          child: FSelectGroup<int>(
            control: .managed(controller: autoDispose(FMultiValueNotifier(value: {1}))),
            children: [.radio(label: const Text('1'), value: 1)],
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
        child: FSelectGroup<int>(
          control: .managed(controller: autoDispose(FMultiValueNotifier()), onChange: (_) => changes++),
          children: [
            .radio(value: 1, label: const Text('1')),
            .radio(value: 2, label: const Text('2')),
            .radio(value: 3, label: const Text('3')),
          ],
        ),
      ),
    );

    await tester.tap(find.text('2'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(changes, 1);
  });

  testWidgets('update callbacks', (tester) async {
    final controller = autoDispose(FMultiValueNotifier<int>());

    var firstChanges = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          control: .managed(controller: controller, onChange: (_) => firstChanges++),
          children: [.checkbox(value: 1, label: const Text('1'))],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(firstChanges, 1);
    expect(controller.hasListeners, true);

    var secondChanges = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          control: .managed(controller: controller, onChange: (_) => secondChanges++),
          children: [.checkbox(value: 1, label: const Text('1'))],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(firstChanges, 1);
    expect(secondChanges, 1);
  });

  testWidgets('update controller', (tester) async {
    final first = autoDispose(FMultiValueNotifier<int>());
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          control: .managed(controller: first, onChange: (_) {}),
          children: [.checkbox(value: 1, label: const Text('1'))],
        ),
      ),
    );

    expect(first.hasListeners, true);
    expect(first.disposed, false);

    final second = autoDispose(FMultiValueNotifier<int>());
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          control: .managed(controller: second, onChange: (_) {}),
          children: [.checkbox(value: 1, label: const Text('1'))],
        ),
      ),
    );

    expect(first.hasListeners, false);
    expect(first.disposed, false);
    expect(second.hasListeners, true);
    expect(second.disposed, false);
  });

  testWidgets('dispose controller', (tester) async {
    final controller = autoDispose(FMultiValueNotifier<int>());
    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          control: .managed(controller: controller, onChange: (_) {}),
          children: [.checkbox(value: 1, label: const Text('1'))],
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
