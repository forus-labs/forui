// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const fruits = [
  'Apple',
  'Banana',
  'Blueberry',
  'Grapes',
  'Lemon',
  'Mango',
  'Kiwi',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Plum',
  'Raspberry',
  'Strawberry',
  'Watermelon',
];

void main() {
  const key = ValueKey('autocomplete');

  late FAutocompleteController controller;

  setUp(() {
    controller = FAutocompleteController(vsync: const TestVSync());
  });

  tearDown(() => controller.dispose());

  group('controller', () {
    testWidgets('update', (tester) async {
      final controller = FAutocompleteController(vsync: const TestVSync());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, items: fruits, controller: controller),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, true);
      expect(controller.popover.hasListeners, false);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, items: fruits),
        ),
      );

      expect(controller.hasListeners, false);
      expect(controller.popover.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });

    testWidgets('dispose', (tester) async {
      final controller = FAutocompleteController(vsync: const TestVSync());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, items: fruits, controller: controller),
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

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, items: fruits, focusNode: focus),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('tab to focus', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, controller: controller, focusNode: focus, items: fruits),
        ),
      );

      expect(focus.hasFocus, false);
      expect(controller.popover.status.isForwardOrCompleted, false);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
      expect(controller.popover.status.isForwardOrCompleted, true);
    });

    testWidgets('tab when completion available completes text', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete(key: key, controller: controller, focusNode: autocompleteFocus, items: fruits),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'b');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      expect(controller.popover.status.isForwardOrCompleted, false);
      expect(autocompleteFocus.hasFocus, true);
      expect(buttonFocus.hasFocus, false);
      expect(find.text('Banana'), findsOne);
    });

    testWidgets('tab when no completion available shifts focus', (tester) async {
      final autocompleteFocus = autoDispose(FocusNode());
      final buttonFocus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FAutocomplete(key: key, focusNode: autocompleteFocus, items: fruits),
              FButton(onPress: () {}, focusNode: buttonFocus, child: const Text('button')),
            ],
          ),
        ),
      );

      await tester.enterText(find.byKey(key), 'zebra');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      expect(controller.popover.status.isForwardOrCompleted, false);
      expect(autocompleteFocus.hasFocus, false);
      expect(buttonFocus.hasFocus, true);
    });
  });

  group('keyboard navigation', () {
    testWidgets('arrow key navigation & selection', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, controller: controller, focusNode: focus, items: fruits),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      expect(find.text('app'), findsNothing);
      expect(find.text('Apple'), findsNWidgets(2));

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
      expect(controller.popover.status.isForwardOrCompleted, false);
      expect(find.text('app'), findsNothing);
      expect(find.text('Apple'), findsOne);
    });

    testWidgets('arrow key navigation and escape', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, controller: controller, focusNode: focus, items: fruits),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      expect(find.text('app'), findsNothing);
      expect(find.text('Apple'), findsNWidgets(2));

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
      expect(controller.popover.status.isForwardOrCompleted, false);
      expect(find.text('app'), findsOne);
      expect(find.text('Apple'), findsNothing);
    });

    testWidgets('arrow key navigation and tap outside', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAutocomplete(key: key, controller: controller, focusNode: focus, items: fruits),
        ),
      );

      await tester.enterText(find.byKey(key), 'app');
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      expect(find.text('app'), findsNothing);
      expect(find.text('Apple'), findsNWidgets(2));

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
      expect(controller.popover.status.isForwardOrCompleted, false);
      expect(find.text('app'), findsOne);
      expect(find.text('Apple'), findsNothing);
    });
  });

  // TODO: Add tests for - not selecting entire text on focus after using arrow key navigation & enter on desktop & mobile.
  // Requires features only available in Flutter 3.35.
}
