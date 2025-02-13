import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPicker', () {
    Widget picker([FPickerController? controller]) => TestScaffold(
      child: FPicker(
        controller: controller,
        children: [
          for (var i = 0; i < (controller?.initialIndexes.length ?? 2); i++)
            FPickerWheel(children: [Text('${i}A'), Text('${i}B'), Text('${i}C')]),
        ],
      ),
    );

    testWidgets('different controller size', (tester) async {
      final initialController = FPickerController(initialIndexes: [1, 1]);

      await tester.pumpWidget(picker(initialController));

      await tester.drag(find.text('0A'), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(initialController.value, [2, 1]);
      expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1]);

      final newController = FPickerController(initialIndexes: [1, 2, 0]);

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

    testWidgets('same controller size', (tester) async {
      final initialController = FPickerController(initialIndexes: [1, 1, 1]);

      await tester.pumpWidget(picker(initialController));

      await tester.drag(find.text('0A'), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(initialController.value, [2, 1, 1]);
      expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1, 1]);

      final newController = FPickerController(initialIndexes: [1, 2, 0]);

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

      final newController = FPickerController(initialIndexes: [0, 1]);
      await tester.pumpWidget(picker(newController));
      await tester.pumpAndSettle();

      expect(newController.value, [2, 0]);
      expect(newController.wheels.map((w) => w.selectedItem), [2, 0]);
    });
  });
}
