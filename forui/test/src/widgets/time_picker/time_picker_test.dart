// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker_wheel.dart';
import 'package:forui/src/widgets/time_picker/time_picker_controller.dart';
import '../../test_scaffold.dart';

void main() {
  setUpAll(initializeDateFormatting);

  group('state', () {
    testWidgets('crossing 12pm does not cause controller value to update', (tester) async {
      final controller = autoDispose(FTimePickerController(initial: const FTime(10, 30)));

      await tester.pumpWidget(
        TestScaffold.app(locale: const Locale('en', 'SG'), child: FTimePicker(controller: controller)),
      );

      final gesture = await tester.startGesture(tester.getCenter(find.byType(BuilderWheel).first));
      await tester.pump(const Duration(milliseconds: 100));
      await gesture.moveBy(const Offset(0, -100));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(controller.value, const FTime(10, 30));

      // Release the gesture
      await gesture.up();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(controller.value, isNot(const FTime(10, 30)));
    });

    testWidgets('swap external controller', (tester) async {
      final initial = autoDispose(FTimePickerController(initial: const FTime(10, 30)));
      final current = autoDispose(FTimePickerController(initial: const FTime(14, 45)));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: initial)));
      expect(initial.value, const FTime(10, 30));
      expect(initial.picker?.value, [10, 30, 0]);

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: current)));

      expect(initial.disposed, false);
      expect(current.value, const FTime(10, 30));
      expect(current.picker?.value, [10, 30, 0]);
    });

    testWidgets('change 12-hour format', (tester) async {
      final controller = autoDispose(FTimePickerController());

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      expect(controller.hours24, false);

      await tester.pumpWidget(
        TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller, hour24: true)),
      );
      expect(controller.hours24, true);
    });

    testWidgets('change intervals', (tester) async {
      final controller = autoDispose(FTimePickerController(initial: const FTime(10, 31)));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      expect(controller.hourInterval, 1);
      expect(controller.minuteInterval, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: FTimePicker(controller: controller, hourInterval: 2, minuteInterval: 15),
        ),
      );
      expect(controller.value, const FTime(8, 45));
      // TODO: Change unexpected values once https://github.com/flutter/flutter/issues/162972 is resolved.
      expect(controller.hourInterval, 2);
      expect(controller.minuteInterval, 15);
    });

    testWidgets('swap internal controller with external controller', (tester) async {
      final controller = autoDispose(FTimePickerController(initial: const FTime(10, 30)));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: const FTimePicker()));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      expect(controller.value, const FTime());
    });

    testWidgets('swap external controller with internal controller', (tester) async {
      final controller = autoDispose(FTimePickerController(initial: const FTime(10, 30)));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: const FTimePicker()));

      expect(controller.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FTimePickerController(initial: const FTime(10, 30)));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: const SizedBox()));

      expect(controller.disposed, false);
    });
  });

  testWidgets('period first', (tester) async {
    final controller = autoDispose(FTimePickerController(initial: const FTime(22)));

    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('ko'),
        child: SizedBox(width: 300, height: 300, child: FTimePicker(controller: controller)),
      ),
    );

    // Period uses a different picker wheel implementation, only hour & minute uses BuilderWheel.
    await tester.drag(find.byType(BuilderWheel).at(0), const Offset(0, -50));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(controller.value, const FTime());
  });
}
