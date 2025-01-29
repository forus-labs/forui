import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  group('FPickerController value setter', () {
    test('setting value updates internal state', () {
      final controller = FPickerController(initialIndexes: [0, 1])..value = [2, 3];
      expect(controller.value, [2, 3]);
    });

    test('setting value throws if length mismatch with wheels', () {
      final controller = FPickerController(initialIndexes: [0, 1]);
      controller.wheels.addAll([
        FixedExtentScrollController(),
        FixedExtentScrollController(),
      ]);

      expect(() => controller.value = [1], throwsAssertionError);
      expect(() => controller.value = [1, 2, 3], throwsAssertionError);
    });

    testWidgets('setting value updates wheel positions', (tester) async {
      final controller = FPickerController(initialIndexes: [0, 1]);

      await tester.pumpWidget(
        TestScaffold(
          child: FPicker(
            controller: controller,
            children: const [
              FPickerWheel(
                children: [Text('A1'), Text('A2'), Text('A3')],
              ),
              FPickerWheel(
                children: [Text('B1'), Text('B2'), Text('B3')],
              ),
            ],
          ),
        ),
      );

      controller.value = [2, 0];
      await tester.pumpAndSettle();

      expect(controller.wheels.map((w) => w.selectedItem), [2, 0]);
    });

    testWidgets('setting value works in RTL direction', (tester) async {
      final controller = FPickerController(initialIndexes: [0, 1]);

      await tester.pumpWidget(
        TestScaffold(
          textDirection: TextDirection.rtl,
          child: FPicker(
            controller: controller,
            children: const [
              FPickerWheel(
                children: [Text('A1'), Text('A2'), Text('A3')],
              ),
              FPickerWheel(
                children: [Text('B1'), Text('B2'), Text('B3')],
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      controller.value = [2, 0];
      await tester.pumpAndSettle();

      expect(controller.wheels.map((w) => w.selectedItem), [2, 0]);
    });

    test('dispose cleans up wheel controllers', () {
      final controller = FPickerController(initialIndexes: [0, 1]);
      controller.wheels.addAll([
        FixedExtentScrollController(),
        FixedExtentScrollController(),
      ]);

      controller.dispose();

      expect(controller.disposed, true);
      for (final wheel in controller.wheels) {
        expect(wheel.notifyListeners, throwsFlutterError);
      }
    });
  });
}
