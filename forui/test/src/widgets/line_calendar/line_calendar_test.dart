import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('managed', () {
    testWidgets('calls onChange', (tester) async {
      DateTime? changed;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(
            control: .managed(onChange: (date) => changed = date),
            today: DateTime(2024, 7, 14),
          ),
        ),
      );

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(changed, DateTime.utc(2024, 7, 15));
    });
  });

  group('controller', () {
    testWidgets('controller and initial both provided', (tester) async {
      expect(
        () => TestScaffold.app(
          child: FLineCalendar(
            control: .managed(controller: autoDispose(FCalendarController.date()), initial: DateTime(2023)),
          ),
        ),
        throwsAssertionError,
      );
    });

    testWidgets('old controller is not disposed', (tester) async {
      final first = autoDispose(FCalendarController.date(initialSelection: DateTime(2023)));
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: first))));

      final second = autoDispose(FCalendarController.date());
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: second))));

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('old controller is not disposed', (tester) async {
      final first = autoDispose(FCalendarController.date());
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: first))));

      final second = autoDispose(FCalendarController.date());
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: second))));

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('update controller', (tester) async {
      final first = autoDispose(FCalendarController.date());
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: first))));

      expect(first.disposed, false);

      final second = autoDispose(FCalendarController.date());
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: second))));

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FCalendarController.date());
      await tester.pumpWidget(TestScaffold.app(child: FLineCalendar(control: .managed(controller: controller))));

      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

      expect(controller.disposed, false);
    });
  });

  group('onChange', () {
    testWidgets('when controller changes but onChange callback is the same', (tester) async {
      int count = 0;
      void onChange(DateTime? _) => count++;

      final firstController = autoDispose(FCalendarController.date());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: firstController, onChange: onChange)),
        ),
      );

      firstController.value = DateTime.utc(2023);
      await tester.pump();

      expect(count, 1);

      final secondController = autoDispose(FCalendarController.date());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: secondController, onChange: onChange)),
        ),
      );

      firstController.value = DateTime.utc(2024);
      secondController.value = DateTime.utc(2025);
      await tester.pump();

      expect(count, 2);
    });

    testWidgets('when onChange callback changes but controller is the same', (tester) async {
      int first = 0;
      int second = 0;

      final controller = autoDispose(FCalendarController.date());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: controller, onChange: (_) => first++)),
        ),
      );

      controller.value = DateTime.utc(2023);
      await tester.pump();

      expect(first, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: controller, onChange: (_) => second++)),
        ),
      );

      controller.value = DateTime.utc(2024);
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('when both controller and onChange callback change', (tester) async {
      int first = 0;
      int second = 0;

      final firstController = autoDispose(FCalendarController.date());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: firstController, onChange: (_) => first++)),
        ),
      );

      firstController.value = DateTime.utc(2023);
      await tester.pump();

      expect(first, 1);

      final secondController = autoDispose(FCalendarController.date());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: secondController, onChange: (_) => second++)),
        ),
      );

      firstController.value = DateTime.utc(2024);
      secondController.value = DateTime.utc(2025);
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('disposed when controller is external', (tester) async {
      int count = 0;

      final controller = autoDispose(FCalendarController.date());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(control: .managed(controller: controller, onChange: (_) => count++)),
        ),
      );

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
