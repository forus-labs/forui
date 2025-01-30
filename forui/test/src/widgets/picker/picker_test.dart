import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  group('FPicker', () {
    Widget buildPicker(FPickerController? controller) => TestScaffold(
          child: FPicker(
            controller: controller,
            children: const [
              FPickerWheel(
                key: ValueKey('A'),
                children: [
                  Text('A1'),
                  Text('A2'),
                  Text('A3'),
                ],
              ),
              FPickerWheel(
                children: [
                  Text('B1'),
                  Text('B2'),
                  Text('B3'),
                ],
              ),
            ],
          ),
        );

    testWidgets('maintains wheel positions when controller changes', (tester) async {
      final initialController = FPickerController(initialIndexes: [1, 1]);

      await tester.pumpWidget(buildPicker(initialController));

      await tester.drag(find.byKey(const ValueKey('A')), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(initialController.value, [2, 1]);
      expect(initialController.wheels.map((w) => w.selectedItem).toList(), [2, 1]);

      final previousPositions = [2, 1];

      final newController = FPickerController(initialIndexes: [0, 0]);

      await tester.pumpWidget(buildPicker(newController));

      expect(initialController.disposed, true);
      expect(newController.value, previousPositions);
      expect(newController.wheels.map((w) => w.selectedItem).toList(), [2, 1]);

      // Verify wheels remain interactive
      await tester.drag(find.byKey(const ValueKey('A')), const Offset(0, 100));
      await tester.pumpAndSettle();

      expect(newController.wheels[0].selectedItem, isNot(previousPositions[0]));
      expect(newController.value[0], newController.wheels[0].selectedItem);
    });

    testWidgets('preserves positions when switching from null to explicit controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FPicker(
            children: [
              FPickerWheel(
                key: ValueKey('A'),
                children: [
                  Text('A1'),
                  Text('A2'),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.drag(find.byKey(const ValueKey('A')), const Offset(0, -100));
      await tester.pumpAndSettle();

      final newController = FPickerController(initialIndexes: [0]);
      await tester.pumpWidget(
        TestScaffold(
          child: FPicker(
            controller: newController,
            children: const [
              FPickerWheel(
                key: ValueKey('A'),
                children: [
                  Text('A1'),
                  Text('A2'),
                  Text('A3'),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify position was maintained
      expect(newController.value, [1]);
      expect(newController.wheels.map((w) => w.selectedItem), [1]);
    });
  });
}
