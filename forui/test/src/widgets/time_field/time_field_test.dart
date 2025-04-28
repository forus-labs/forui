// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/time_field/time_field.dart';
import '../../locale_scaffold.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, constructor) in [
    ('input only', (controller, time) => FTimeField(controller: controller, initialTime: time)),
    ('picker only', (controller, time) => FTimeField.picker(controller: controller, initialTime: time)),
  ]) {
    group('$name - constructor', () {
      testWidgets('cannot provide both controller and initialTime', (tester) async {
        expect(() => constructor(FTimeFieldController(vsync: tester), const FTime()), throwsAssertionError);
      });
    });
  }

  for (final (name, field) in [
    ('input only', (controller, focus) => FTimeField(controller: controller, focusNode: focus)),
    ('picker only', (controller, focus) => FTimeField.picker(controller: controller, focusNode: focus)),
  ]) {
    group(name, () {
      testWidgets('update controller', (tester) async {
        final first = FTimeFieldController(vsync: tester);

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(first, null))));

        expect(first.disposed, false);

        final second = FTimeFieldController(vsync: tester);

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(second, null))));

        // We remove the internal update controllers to prevent interference with the assertion.
        first.removeValueListener(first.update);
        second.removeValueListener(second.update);

        expect(first.popover.hasListeners, false);
        expect(first.disposed, false);
        expect(second.disposed, false);
      });

      testWidgets('dispose controller', (tester) async {
        final controller = FTimeFieldController(vsync: tester);

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(controller, null))));

        expect(controller.hasListeners, true);
        expect(controller.disposed, false);

        await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
        await tester.pumpAndSettle();

        // We remove the internal update controllers to prevent interference with the assertion.
        controller.removeValueListener(controller.update);

        expect(controller.popover.hasListeners, false);
        expect(controller.disposed, false);
      });

      testWidgets('update focus', (tester) async {
        final first = FocusNode();

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));

        expect(first.hasListeners, true);

        final second = FocusNode();

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, second))));

        expect(first.hasListeners, false);
        expect(second.hasListeners, true);
      });

      testWidgets('dispose focus', (tester) async {
        final first = FocusNode();

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));
        expect(first.hasListeners, true);

        await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
        expect(first.hasListeners, false);
      });
    });
  }

  for (final (name, field) in [
    ('input only', (controller, onChange) => FTimeField(controller: controller, onChange: onChange)),
    ('picker only', (controller, onChange) => FTimeField.picker(controller: controller, onChange: onChange)),
  ]) {
    group('$name - onChange', () {
      testWidgets('when controller changes but onChange callback is the same', (tester) async {
        int count = 0;
        void onChange(FTime? _) => count++;

        final firstController = FTimeFieldController(vsync: tester);
        await tester.pumpWidget(TestScaffold.app(child: field(firstController, onChange)));

        firstController.value = const FTime(1);
        await tester.pump();

        expect(count, 1);

        final secondController = FTimeFieldController(vsync: tester);
        await tester.pumpWidget(TestScaffold.app(child: field(secondController, onChange)));

        secondController.value = const FTime(2);
        await tester.pump();

        expect(count, 2);
      });

      testWidgets('when onChange callback changes but controller is the same', (tester) async {
        int first = 0;
        int second = 0;

        final controller = FTimeFieldController(vsync: tester);
        await tester.pumpWidget(TestScaffold.app(child: field(controller, (_) => first++)));

        controller.value = const FTime(1);
        await tester.pump();

        expect(first, 1);

        await tester.pumpWidget(TestScaffold.app(child: field(controller, (_) => second++)));

        controller.value = const FTime(2);
        await tester.pump();

        expect(first, 1);
        expect(second, 1);
      });

      testWidgets('when both controller and onChange callback change', (tester) async {
        int first = 0;
        int second = 0;

        final firstController = FTimeFieldController(vsync: tester);
        await tester.pumpWidget(TestScaffold.app(child: field(firstController, (_) => first++)));

        firstController.value = const FTime(1);
        await tester.pump();
        expect(first, 1);

        final secondController = FTimeFieldController(vsync: tester);
        await tester.pumpWidget(TestScaffold.app(child: field(secondController, (_) => second++)));

        secondController.value = const FTime(2);
        await tester.pump();

        firstController.value = const FTime(3);
        await tester.pump();

        expect(first, 1);
        expect(second, 1);
      });

      testWidgets('disposed when controller is external', (tester) async {
        int count = 0;

        final controller = FTimeFieldController(vsync: tester);
        await tester.pumpWidget(TestScaffold.app(child: field(controller, (_) => count++)));

        controller.value = const FTime(1);
        await tester.pump();

        expect(count, 1);

        await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

        controller.value = const FTime(2);
        await tester.pump();

        expect(count, 1);
      });
    });
  }
}
