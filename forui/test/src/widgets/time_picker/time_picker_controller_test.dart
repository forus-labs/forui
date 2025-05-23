import 'dart:async';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_picker/time_picker_controller.dart';
import '../../test_scaffold.dart';

void main() {
  late FTimePickerController controller;

  setUp(() => controller = FTimePickerController());

  tearDown(() {
    controller.dispose();
  });

  for (final (grouping, function) in [
    ('animateTo(...)', (time) => unawaited(controller.animateTo(time))),
    ('set value', (time) => controller.value = time),
  ]) {
    group(grouping, () {
      testWidgets('does nothing', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller)));

        function(const FTime());
        await tester.pumpAndSettle();

        expect(controller.value, const FTime());
        expect(controller.mutating, false);
      });

      testWidgets('set to rounded hour', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller, hourInterval: 2)));

        function(const FTime(13, 31));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, const FTime(14, 31));
        expect(controller.picker?.value, [7, 31, 1]);
        expect(controller.mutating, false);
      });

      testWidgets('set to rounded minute', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller, minuteInterval: 5)));

        function(const FTime(13, 31));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, const FTime(13, 30));
        expect(controller.picker?.value, [13, 6, 1]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 12-hour time before noon', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller)));

        function(const FTime(5, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, const FTime(5, 30));
        expect(controller.picker?.value, [5, 30, 0]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 12-hour time after noon', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller)));

        function(const FTime(13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, const FTime(13, 30));
        expect(controller.picker?.value, [13, 30, 1]);
        expect(controller.mutating, false);
      });

      testWidgets('set to 24-hour time', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller, hour24: true)));

        function(const FTime(13, 30));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(controller.value, const FTime(13, 30));
        expect(controller.picker?.value, [13, 30]);
        expect(controller.mutating, false);
      });
    });
  }

  testWidgets('dispose()', (tester) async {
    final controller = FTimePickerController();

    await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller)));

    controller.dispose();
    expect(controller.disposed, true);
    expect(controller.picker?.disposed, true);
  });

  group('encode()', () {
    group('period first', () {
      testWidgets('12-hour time after noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FTimePicker(controller: controller),
          ),
        );

        expect(controller.encode(const FTime(13, 30)), [1, 13, 30]);
      });

      testWidgets('12-hour time before noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FTimePicker(controller: controller),
          ),
        );

        expect(controller.encode(const FTime(5, 30)), [0, 5, 30]);
      });

      testWidgets('24-hour time', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FTimePicker(controller: controller, hour24: true),
          ),
        );

        expect(controller.encode(const FTime(13, 30)), [13, 30]);
      });
    });
  });

  group('decode()', () {
    group('period first', () {
      testWidgets('12-hour time after noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FTimePicker(controller: controller),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [1, 13, 30])
          ..decode();

        expect(controller.value, const FTime(13, 30));
      });

      testWidgets('12-hour time before noon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('ko'),
            child: FTimePicker(controller: controller),
          ),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [0, 5, 30])
          ..decode();

        expect(controller.value, const FTime(5, 30));
      });
    });

    group('period last', () {
      testWidgets('12-hour time after noon', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller)));

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [13, 30, 1])
          ..decode();

        expect(controller.value, const FTime(13, 30));
      });

      testWidgets('12-hour time before noon', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller)));

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [5, 30, 0])
          ..decode();

        expect(controller.value, const FTime(5, 30));
      });
    });

    group('24 hours', () {
      testWidgets('24-hour time', (tester) async {
        await tester.pumpWidget(TestScaffold.app(child: FTimePicker(controller: controller, hour24: true)));

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [14, 30])
          ..decode();

        expect(controller.value, const FTime(14, 30));
      });

      testWidgets('rounded hour', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(child: FTimePicker(controller: controller, hour24: true, hourInterval: 6)),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [2, 30])
          ..decode();

        expect(controller.value, const FTime(12, 30));
      });

      testWidgets('rounded minute', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(child: FTimePicker(controller: controller, hour24: true, minuteInterval: 5)),
        );

        controller
          ..picker?.dispose()
          ..picker = FPickerController(initialIndexes: [14, 7])
          ..decode();

        expect(controller.value, const FTime(14, 35));
      });
    });
  });
}
