import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  Widget picker([FPickerController? controller, ValueChanged<List<int>>? onChange]) => TestScaffold(
    child: FPicker(
      controller: controller,
      onChange: onChange,
      children: [
        for (var i = 0; i < (controller?.initialIndexes.length ?? 2); i++)
          FPickerWheel(children: [Text('${i}A'), Text('${i}B'), Text('${i}C')]),
      ],
    ),
  );

  group('FPicker', () {
    testWidgets('different controller size', (tester) async {
      final initialController = autoDispose(FPickerController(initialIndexes: [1, 1]));

      await tester.pumpWidget(picker(initialController));

      await tester.drag(find.text('0A'), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(initialController.value, [2, 1]);
      expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1]);

      final newController = autoDispose(FPickerController(initialIndexes: [1, 2, 0]));

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
      final initialController = autoDispose(FPickerController(initialIndexes: [1, 1, 1]));

      await tester.pumpWidget(picker(initialController));

      await tester.drag(find.text('0A'), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(initialController.value, [2, 1, 1]);
      expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 1]);

      final newController = autoDispose(FPickerController(initialIndexes: [1, 2, 0]));

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

      final newController = autoDispose(FPickerController(initialIndexes: [0, 1]));
      await tester.pumpWidget(picker(newController));
      await tester.pumpAndSettle();

      expect(newController.value, [2, 0]);
      expect(newController.wheels.map((w) => w.selectedItem), [2, 0]);
    });
  });

  // The onChange callback may be called more than once for each change.
  group('onChange', () {
    testWidgets('when controller changes but onChange callback is the same', (tester) async {
      int count = 0;
      void onChange(List<int> indexes) {
        count++;
      }

      final firstController = autoDispose(FPickerController(initialIndexes: [0, 0]));
      await tester.pumpWidget(picker(firstController, onChange));

      firstController.value = [1, 1];
      await tester.pump();

      expect(count, 7);

      final secondController = autoDispose(FPickerController(initialIndexes: [0, 0]));
      await tester.pumpWidget(picker(secondController, onChange));

      firstController.value = [2, 2];
      secondController.value = [3, 3];
      await tester.pump();

      expect(count, 11);
    });

    testWidgets('when onChange callback changes but controller is the same', (tester) async {
      int first = 0;
      int second = 0;

      final controller = autoDispose(FPickerController(initialIndexes: [0, 0]));
      await tester.pumpWidget(picker(controller, (_) => first++));

      controller.value = [1, 1];
      await tester.pump();

      expect(first, 7);

      await tester.pumpWidget(picker(controller, (_) => second++));

      controller.value = [2, 2];
      await tester.pump();

      expect(first, 7);
      expect(second, 5);
    });

    testWidgets('when both controller and onChange callback change', (tester) async {
      int first = 0;
      int second = 0;

      final firstController = autoDispose(FPickerController(initialIndexes: [0, 0]));
      await tester.pumpWidget(picker(firstController, (_) => first++));

      firstController.value = [1, 1];
      await tester.pump();

      expect(first, 7);

      final secondController = autoDispose(FPickerController(initialIndexes: [0, 0]));
      await tester.pumpWidget(picker(secondController, (_) => second++));

      firstController.value = [2, 2];
      secondController.value = [3, 3];
      await tester.pump();

      expect(first, 7);
      expect(second, 4);
    });

    testWidgets('disposed when controller is external', (tester) async {
      int count = 0;

      final controller = autoDispose(FPickerController(initialIndexes: [0, 0]));
      await tester.pumpWidget(picker(controller, (_) => count++));

      controller.value = [1, 1];
      await tester.pump();

      expect(count, 7);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      controller.value = [2, 2];
      await tester.pump();

      expect(count, 7);
    });
  });
}
