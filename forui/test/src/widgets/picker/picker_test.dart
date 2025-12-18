import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  Widget picker([FPickerController? controller, ValueChanged<List<int>>? onChange]) => TestScaffold(
    child: FPicker(
      control: .managed(controller: controller, onChange: onChange),
      children: [
        for (var i = 0; i < (controller?.value.length ?? 2); i++)
          FPickerWheel(children: [Text('${i}A'), Text('${i}B'), Text('${i}C')]),
      ],
    ),
  );

  testWidgets('different controller size', (tester) async {
    final initialController = autoDispose(FPickerController(indexes: [1, 1]));

    await tester.pumpWidget(picker(initialController));

    await tester.drag(find.text('0A'), const Offset(0, -100));
    await tester.pumpAndSettle();

    expect(initialController.value, [2, 1]);
    expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1]);

    final newController = autoDispose(FPickerController(indexes: [1, 2, 0]));

    await tester.pumpWidget(picker(newController));
    await tester.pumpAndSettle();

    expect(initialController.disposed, false);
    expect(newController.value, [2, 1, 0]);
    expect(newController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 0]);

    await tester.drag(find.text('0A'), const Offset(0, 100));
    await tester.pumpAndSettle();

    expect(newController.wheels[0].selectedItem, isNot(2));
    expect(newController.value[0], newController.wheels[0].selectedItem);
  });

  testWidgets('placeholders does not cause errors', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPicker(
          children: [
            FPickerWheel.builder(builder: (context, index) => const Text('a')),
            const Text(':'),
            FPickerWheel.builder(builder: (context, index) => const Text('b')),
          ],
        ),
      ),
    );

    expect(tester.takeException(), null);
  });

  testWidgets('same controller size', (tester) async {
    final initialController = autoDispose(FPickerController(indexes: [1, 1, 1]));

    await tester.pumpWidget(picker(initialController));

    await tester.drag(find.text('0A'), const Offset(0, -100));
    await tester.pumpAndSettle();

    expect(initialController.value, [2, 1, 1]);
    expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 1]);

    final newController = autoDispose(FPickerController(indexes: [1, 2, 0]));

    await tester.pumpWidget(picker(newController));
    await tester.pumpAndSettle();

    expect(initialController.disposed, false);
    expect(newController.value, [2, 1, 1]);
    expect(newController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 1]);

    await tester.drag(find.text('0A'), const Offset(0, 100));
    await tester.pumpAndSettle();

    expect(newController.wheels[0].selectedItem, isNot(2));
    expect(newController.value[0], newController.wheels[0].selectedItem);
  });

  testWidgets('null to explicit controller', (tester) async {
    await tester.pumpWidget(picker());
    await tester.drag(find.text('0A'), const Offset(0, -100));
    await tester.pumpAndSettle();

    final newController = autoDispose(FPickerController(indexes: [0, 1]));
    await tester.pumpWidget(picker(newController));
    await tester.pumpAndSettle();

    expect(newController.value, [2, 0]);
    expect(newController.wheels.map((w) => w.selectedItem), [2, 0]);
  });

  group('lifted', () {
    testWidgets('onChange receives correct indexes', (tester) async {
      List<int> value = [0, 0];

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (_, setState) => TestScaffold(
            child: FPicker(
              control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
              children: const [
                FPickerWheel(key: ValueKey('first'), children: [Text('0A'), Text('0B'), Text('0C')]),
                FPickerWheel(key: ValueKey('second'), children: [Text('1A'), Text('1B'), Text('1C')]),
              ],
            ),
          ),
        ),
      );
      expect(value, [0, 0]);

      await tester.drag(find.byKey(const ValueKey('first')), const Offset(0, -100));
      await tester.pumpAndSettle();
      expect(value, isNot([0, 0]));
      expect(value[0], isNot(0));

      final firstWheelValue = value[0];
      await tester.drag(find.byKey(const ValueKey('second')), const Offset(0, -100));
      await tester.pumpAndSettle();
      expect(value[0], firstWheelValue);
      expect(value[1], isNot(0));

      final secondWheelValue = value[1];
      await tester.drag(find.byKey(const ValueKey('first')), const Offset(0, 100));
      await tester.pumpAndSettle();
      expect(value[0], isNot(firstWheelValue));
      expect(value[1], secondWheelValue);
    });
  });

  testWidgets('adding wheels and indexes dynamically', (tester) async {
    List<int> value = [0];

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (_, setState) => TestScaffold(
          child: FPicker(
            control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
            children: const [
              FPickerWheel(children: [Text('0A'), Text('0B'), Text('0C')]),
            ],
          ),
        ),
      ),
    );

    expect(value, [0]);

    value = [value[0], 0];

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (_, setState) => TestScaffold(
          child: FPicker(
            key: const ValueKey('expanded'),
            control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
            children: const [
              FPickerWheel(children: [Text('0A'), Text('0B'), Text('0C')]),
              FPickerWheel(children: [Text('1A'), Text('1B'), Text('1C')]),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
    expect(find.text('0A'), findsOneWidget);
    expect(find.text('1A'), findsOneWidget);

    await tester.drag(find.text('1A'), const Offset(0, -50));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
    expect(value.length, 2);
  });
}
