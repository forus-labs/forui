// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../locale_scaffold.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, field) in [
    (
    'input only',
        (Key key, FTime? value, ValueChanged<FTime?> onChange) => FTimeField(
      key: key,
      control: .lifted(value: value, onChange: onChange),
    ),
    ),
    (
    'picker only',
        (Key key, FTime? value, ValueChanged<FTime?> onChange) => FTimeField.picker(
      key: key,
      control: .lifted(value: value, onChange: onChange),
    ),
    ),
  ]) {
    testWidgets('$name - lifted', (tester) async {
      const key = Key('field');
      FTime? value;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(builder: (context, setState) => field(key, value, (v) => setState(() => value = v))),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });
  }

  for (final (name, field) in [
    (
      'picker',
      (controller, initial, save) => FTimeField.picker(
        control: .managed(controller: controller, initial: initial),
        onSaved: save,
      ),
    ),
    (
      'input',
      (controller, initial, save) => FTimeField(
        control: .managed(controller: controller, initial: initial),
        onSaved: save,
      ),
    ),
  ]) {
    group('$name - form', () {
      testWidgets('set initial value using initial', (tester) async {
        final key = GlobalKey<FormState>();

        FTime? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: Form(key: key, child: field(null, const FTime(10, 30), (v) => initial = v)),
          ),
        );

        expect(find.text('10:30 am'), findsOne);

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, const FTime(10, 30));
      });

      testWidgets('controller provided', (tester) async {
        final key = GlobalKey<FormState>();

        FTime? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: Form(
              key: key,
              child: field(
                autoDispose(FTimeFieldController(vsync: tester, initialTime: const FTime(10, 30))),
                null,
                (v) => initial = v,
              ),
            ),
          ),
        );

        expect(find.text('10:30 am'), findsOne);

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, const FTime(10, 30));
      });
    });
  }

  for (final (name, field) in [
    (
      'input only',
      (controller, focus) => FTimeField(
        control: .managed(controller: controller),
        focusNode: focus,
      ),
    ),
    (
      'picker only',
      (controller, focus) => FTimeField.picker(
        control: .managed(controller: controller),
        focusNode: focus,
      ),
    ),
  ]) {
    group(name, () {
      testWidgets('update focus', (tester) async {
        final first = autoDispose(FocusNode());

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));

        expect(first.hasListeners, true);

        final second = autoDispose(FocusNode());

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, second))));

        expect(first.hasListeners, false);
        expect(second.hasListeners, true);
      });

      testWidgets('dispose focus', (tester) async {
        final first = autoDispose(FocusNode());

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));
        expect(first.hasListeners, true);

        await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
        expect(first.hasListeners, false);
      });
    });
  }

  for (final (name, field) in [
    (
      'input only',
      (controller, onChange) => FTimeField(
        control: .managed(controller: controller, onChange: onChange),
      ),
    ),
    (
      'picker only',
      (controller, onChange) => FTimeField.picker(
        control: .managed(controller: controller, onChange: onChange),
      ),
    ),
  ]) {
    group('$name - onChange', () {
      testWidgets('when controller changes but onChange callback is the same', (tester) async {
        int count = 0;
        void onChange(FTime? _) => count++;

        final firstController = autoDispose(FTimeFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(firstController, onChange)));

        firstController.value = const FTime(1);
        await tester.pump();

        expect(count, 1);

        final secondController = autoDispose(FTimeFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(secondController, onChange)));

        secondController.value = const FTime(2);
        await tester.pump();

        expect(count, 2);
      });

      testWidgets('when onChange callback changes but controller is the same', (tester) async {
        int first = 0;
        int second = 0;

        final controller = autoDispose(FTimeFieldController(vsync: tester));
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

        final firstController = autoDispose(FTimeFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(firstController, (_) => first++)));

        firstController.value = const FTime(1);
        await tester.pump();
        expect(first, 1);

        final secondController = autoDispose(FTimeFieldController(vsync: tester));
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

        final controller = autoDispose(FTimeFieldController(vsync: tester));
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
