// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O'];

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
  });

  group('form', () {
    testWidgets('set initial value using initialValue', (tester) async {
      final key = GlobalKey<FormState>();

      String? initial;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FSelect<String>(
              format: (value) => '$value!',
              onSaved: (value) => initial = value,
              initialValue: 'A',
              children: [FSelectItem.text('A'), FSelectItem.text('B')],
            ),
          ),
        ),
      );

      expect(find.text('A!'), findsOneWidget);

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial, 'A');
    });

    testWidgets('controller provided', (tester) async {
      final key = GlobalKey<FormState>();

      String? initial;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FSelect<String>(
              controller: autoDispose(FSelectController(vsync: tester, value: 'A')),
              format: (value) => '$value!',
              onSaved: (value) => initial = value,
              children: [FSelectItem.text('A'), FSelectItem.text('B')],
            ),
          ),
        ),
      );

      expect(find.text('A!'), findsOneWidget);

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial, 'A');
    });
  });

  group('FSelect', () {
    testWidgets('custom format', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            format: (value) => '$value!',
            controller: controller,
            children: [FSelectItem.text('A'), FSelectItem.text('B')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(find.text('A!'), findsOne);
      expect(controller.value, 'A');
    });

    testWidgets('keyboard navigation', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            controller: controller,
            children: [FSelectItem.text('A'), FSelectItem.text('B')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(controller.value, 'A');
    });

    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            focusNode: focus,
            controller: controller,
            children: [FSelectItem.text('A'), FSelectItem.text('B')],
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('does not refocus after selection', (tester) async {
      final focus = autoDispose(FocusNode());
      const itemKey = ValueKey('item');

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            focusNode: focus,
            controller: controller,
            children: [FSelectItem.text('A', key: itemKey), FSelectItem.text('B')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(itemKey));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);
    });
  });

  group('controller', () {
    testWidgets('update', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            controller: controller,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, true);
      expect(controller.popover.hasListeners, false);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(key: key, children: [for (final letter in letters) FSelectItem.text(letter)]),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, false);
      expect(controller.popover.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });

    testWidgets('dispose', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            controller: controller,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, true);
      expect(controller.popover.hasListeners, false);

      await tester.pumpWidget(const SizedBox());

      expect(controller.hasListeners, false);
      expect(controller.popover.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });
  });

  group('onChange', () {
    testWidgets('when controller changes but onChange callback is the same', (tester) async {
      int count = 0;
      void onChange(String? _) => count++;

      final firstController = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: firstController,
            onChange: onChange,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      firstController.value = 'A';
      await tester.pump();

      expect(count, 1);

      final secondController = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: secondController,
            onChange: onChange,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      firstController.value = 'B';
      secondController.value = 'C';
      await tester.pump();

      expect(count, 2);
    });

    testWidgets('when onChange callback changes but controller is the same', (tester) async {
      int first = 0;
      int second = 0;

      final controller = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: controller,
            onChange: (_) => first++,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      controller.value = 'A';
      await tester.pump();

      expect(first, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: controller,
            onChange: (_) => second++,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      controller.value = 'B';
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('when both controller and onChange callback change', (tester) async {
      int first = 0;
      int second = 0;

      final firstController = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: firstController,
            onChange: (_) => first++,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      firstController.value = 'A';
      await tester.pump();

      expect(first, 1);

      final secondController = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: secondController,
            onChange: (_) => second++,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      firstController.value = 'B';
      secondController.value = 'C';
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('disposed when controller is external', (tester) async {
      int count = 0;

      final controller = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            controller: controller,
            onChange: (_) => count++,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      controller.value = 'A';
      await tester.pump();

      expect(count, 1);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

      controller.value = 'B';
      await tester.pump();

      expect(count, 1);
    });
  });
}
