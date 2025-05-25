// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

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
              children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
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
              children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
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
            children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
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
          child: FSelect<String>.fromMap(const {'A': 'A', 'B': 'B'}, key: key, controller: controller),
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

      expect(controller.value, 'B');
    });
  });

  group('controller', () {
    testWidgets('update', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.fromMap(letters, key: key, controller: controller),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, true);
      expect(controller.popover.hasListeners, false);

      await tester.pumpWidget(TestScaffold.app(child: FSelect<String>.fromMap(letters, key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, false);
      expect(controller.popover.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });

    testWidgets('dispose', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.fromMap(letters, key: key, controller: controller),
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
          child: FSelect<String>.fromMap(letters, controller: firstController, onChange: onChange),
        ),
      );

      firstController.value = 'A';
      await tester.pump();

      expect(count, 1);

      final secondController = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.fromMap(letters, controller: secondController, onChange: onChange),
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
          child: FSelect<String>.fromMap(letters, controller: controller, onChange: (_) => first++),
        ),
      );

      controller.value = 'A';
      await tester.pump();

      expect(first, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.fromMap(letters, controller: controller, onChange: (_) => second++),
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
          child: FSelect<String>.fromMap(letters, controller: firstController, onChange: (_) => first++),
        ),
      );

      firstController.value = 'A';
      await tester.pump();

      expect(first, 1);

      final secondController = FSelectController<String>(vsync: const TestVSync());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.fromMap(letters, controller: secondController, onChange: (_) => second++),
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
          child: FSelect<String>.fromMap(letters, controller: controller, onChange: (_) => count++),
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

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.fromMap(
            const {'A': 'A', 'B': 'B'},
            key: key,
            focusNode: focus,
            controller: controller,
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('refocus after selection', (tester) async {
      final focus = autoDispose(FocusNode());
      const itemKey = ValueKey('item');

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            format: (s) => s,
            focusNode: focus,
            controller: controller,
            children: [
              FSelectItem('A', 'A', key: itemKey),
              FSelectItem('B', 'B'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(itemKey));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('tap on text-field should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('escape should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('tap outside unfocuses on Android/iOS', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);
    });

    testWidgets('tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
