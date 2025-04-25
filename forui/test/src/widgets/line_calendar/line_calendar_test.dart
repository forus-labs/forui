import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  group('controller', () {
    testWidgets('initialSelection and controller provided', (tester) async {
      expect(
        () => TestScaffold.app(
          child: FLineCalendar(controller: FCalendarController.date(), initialSelection: DateTime(2023)),
        ),
        throwsAssertionError,
      );
    });

    testWidgets('old controller is not disposed', (tester) async {
      final first = FCalendarController.date(initialSelection: DateTime(2023));
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: first)));

      final second = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: second)));

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('old controller is not disposed', (tester) async {
      final first = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: first)));

      final second = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: second)));

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('update controller', (tester) async {
      final first = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: first)));

      expect(first.disposed, false);

      final second = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: second)));

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: controller)));

      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

      expect(controller.disposed, false);
    });
  });

  group('onChange', () {
    testWidgets('when controller changes but onChange callback is the same', (tester) async {
      int count = 0;
      void onChange(DateTime? _) => count++;

      final firstController = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: firstController, onChange: onChange)));

      firstController.value = DateTime.utc(2023);
      await tester.pump();

      expect(count, 1);

      final secondController = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: secondController, onChange: onChange)));

      firstController.value = DateTime.utc(2024);
      secondController.value = DateTime.utc(2025);
      await tester.pump();

      expect(count, 2);
    });

    testWidgets('when onChange callback changes but controller is the same', (tester) async {
      int first = 0;
      int second = 0;

      final controller = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: controller, onChange: (_) => first++)));

      controller.value = DateTime.utc(2023);
      await tester.pump();

      expect(first, 1);

      await tester.pumpWidget(
        TestScaffold.app(child: FLineCalendar(controller: controller, onChange: (_) => second++)),
      );

      controller.value = DateTime.utc(2024);
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('when both controller and onChange callback change', (tester) async {
      int first = 0;
      int second = 0;

      final firstController = FCalendarController.date();
      await tester.pumpWidget(
        TestScaffold.app(child: FLineCalendar(controller: firstController, onChange: (_) => first++)),
      );

      firstController.value = DateTime.utc(2023);
      await tester.pump();

      expect(first, 1);

      final secondController = FCalendarController.date();
      await tester.pumpWidget(
        TestScaffold.app(child: FLineCalendar(controller: secondController, onChange: (_) => second++)),
      );

      firstController.value = DateTime.utc(2024);
      secondController.value = DateTime.utc(2025);
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('disposed when controller is external', (tester) async {
      int count = 0;

      final controller = FCalendarController.date();
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(controller: controller, onChange: (_) => count++)));

      controller.value = DateTime.utc(2023);
      await tester.pump();

      expect(count, 1);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

      controller.value = DateTime.utc(2024);
      await tester.pump();

      expect(count, 1);
    });
  });
}
