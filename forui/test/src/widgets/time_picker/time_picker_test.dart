import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_picker/time_picker_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../test_scaffold.dart';

void main() {
  setUpAll(initializeDateFormatting);

  group('state', () {
    testWidgets('swap external controller', (tester) async {
      final initial = FTimePickerController(initial: const FTime(10, 30));
      final current = FTimePickerController(initial: const FTime(14, 45));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: initial)));
      expect(initial.value, const FTime(10, 30));
      expect(initial.picker?.value, [10, 30, 0]);

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: current)));

      expect(initial.disposed, false);
      expect(current.value, const FTime(10, 30));
      expect(current.picker?.value, [10, 30, 0]);
    });

    testWidgets('change 12-hour format', (tester) async {
      final controller = FTimePickerController();

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      expect(controller.hours12, true);

      await tester.pumpWidget(
        TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller, hour24: true)),
      );
      expect(controller.hours12, false);
    });

    testWidgets('change intervals', (tester) async {
      final controller = FTimePickerController(initial: const FTime(10, 31));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)));
      expect(controller.hourInterval, 1);
      expect(controller.minuteInterval, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: FTimePicker(controller: controller, hourInterval: 2, minuteInterval: 15),
        ),
      );
      expect(controller.value, null);
      // TODO: Change unexpected values once https://github.com/flutter/flutter/issues/162972 is resolved.
      expect(controller.hourInterval, 8);
      expect(controller.minuteInterval, 45);
    });

    testWidgets('swap internal controller with external controller', (tester) async {
      final controller = FTimePickerController(initial: const FTime(10, 30));

      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: const FTimePicker()));

      await tester.pumpWidget(
        TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)),
      );
      expect(controller.value, const FTime());
    });

    testWidgets('swap external controller with internal controller', (tester) async {
      final controller = FTimePickerController(initial: const FTime(10, 30));

      await tester.pumpWidget(
        TestScaffold.app(locale: const Locale('en'), child: FTimePicker(controller: controller)),
      );
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en'), child: const FTimePicker()));

      expect(controller.disposed, false);
    });
  });
}
