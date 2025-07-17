// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

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

  late FMultiSelectController<String> controller;

  setUp(() {
    controller = FMultiSelectController<String>(vsync: const TestVSync());
  });

  tearDown(() => controller.dispose());

  group('form', () {
    testWidgets('set initial value using initialValue', (tester) async {
      final key = GlobalKey<FormState>();

      Set<String> initial = {'A', 'B'};
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FMultiSelect<String>(
              format: (value) => Text('$value!'),
              onSaved: (value) => initial = value,
              initialValue: initial,
              children: [FSelectItem('A', 'A'), FSelectItem('B', 'B'), FSelectItem('C', 'C')],
            ),
          ),
        ),
      );

      expect(find.text('A!'), findsOneWidget);
      expect(find.text('B!'), findsOneWidget);

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial, {'A', 'B'});
    });

    testWidgets('controller provided', (tester) async {
      final key = GlobalKey<FormState>();

      Set<String> initial = {};
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FMultiSelect<String>(
              controller: autoDispose(FMultiSelectController(vsync: tester, value: {'A', 'B'})),
              format: (value) => Text('$value!'),
              onSaved: (value) {
                initial = value;
              },
              children: [FSelectItem('A', 'A'), FSelectItem('B', 'B'), FSelectItem('C', 'C')],
            ),
          ),
        ),
      );

      expect(find.text('A!'), findsOneWidget);
      expect(find.text('B!'), findsOneWidget);

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial, {'A', 'B'});
    });
  });

  group('FMultiSelect', () {
    testWidgets('custom format', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>(
            key: key,
            format: (value) => Text('$value!'),
            controller: controller,
            children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A!'), findsOne);
      expect(controller.value, {'A'});
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(child: FMultiSelect.fromMap(letters, enabled: false, clearable: true, key: key)),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A'), findsNothing);
    });

    testWidgets('tag clears itself', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>(
            key: key,
            format: (value) => Text('$value!'),
            controller: controller,
            children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A!'), findsOne);
      expect(find.byIcon(FIcons.check), findsNWidgets(1));
      expect(controller.value, {'A'});

      await tester.tap(find.text('A!'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A!'), findsNothing);
      expect(find.byIcon(FIcons.check), findsNothing);
      expect(controller.value, <String>{});
    });

    testWidgets('clear button clears everything', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>(
            key: key,
            format: (value) => Text('$value!'),
            controller: controller,
            clearable: true,
            children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
          ),
        ),
      );

      expect(find.byIcon(FIcons.x), findsNothing);

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      controller.value = {'A', 'B'};
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A!'), findsOne);
      expect(find.text('B!'), findsOne);

      await tester.tap(find.byIcon(FIcons.x).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A!'), findsNothing);
      expect(find.text('B!'), findsNothing);
      expect(controller.value, <String>{});
    });

    testWidgets('keyboard navigation', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(const {'A': 'A', 'B': 'B'}, key: key, controller: controller),
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

      expect(controller.value, {'B'});
    });
  });

  group('controller', () {
    testWidgets('update', (tester) async {
      final controller = FMultiSelectController<String>(vsync: const TestVSync());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, key: key, controller: controller),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, true);
      expect(controller.popover.hasListeners, false);

      await tester.pumpWidget(TestScaffold.app(child: FMultiSelect<String>.fromMap(letters, key: key)));

      expect(controller.hasListeners, false);
      expect(controller.popover.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });

    testWidgets('dispose', (tester) async {
      final controller = FMultiSelectController<String>(vsync: const TestVSync());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, key: key, controller: controller),
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
      void onChange(Set<String> _) => count++;

      final firstController = autoDispose(FMultiSelectController<String>(vsync: const TestVSync()));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: firstController, onChange: onChange),
        ),
      );

      firstController.value = {'A'};
      await tester.pump();

      expect(count, 1);

      final secondController = autoDispose(FMultiSelectController<String>(vsync: const TestVSync()));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: secondController, onChange: onChange),
        ),
      );

      firstController.value = {'B'};
      secondController.value = {'C'};
      await tester.pump();

      expect(count, 2);
    });

    testWidgets('when onChange callback changes but controller is the same', (tester) async {
      int first = 0;
      int second = 0;

      final controller = autoDispose(FMultiSelectController<String>(vsync: const TestVSync()));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: controller, onChange: (_) => first++),
        ),
      );

      controller.value = {'A'};
      await tester.pump();

      expect(first, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: controller, onChange: (_) => second++),
        ),
      );

      controller.value = {'B'};
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('when both controller and onChange callback change', (tester) async {
      int first = 0;
      int second = 0;

      final firstController = autoDispose(FMultiSelectController<String>(vsync: const TestVSync()));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: firstController, onChange: (_) => first++),
        ),
      );

      firstController.value = {'A'};
      await tester.pump();

      expect(first, 1);

      final secondController = autoDispose(FMultiSelectController<String>(vsync: const TestVSync()));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: secondController, onChange: (_) => second++),
        ),
      );

      firstController.value = {'B'};
      secondController.value = {'C'};
      await tester.pump();

      expect(first, 1);
      expect(second, 1);
    });

    testWidgets('disposed when controller is external', (tester) async {
      int count = 0;

      final controller = autoDispose(FMultiSelectController<String>(vsync: const TestVSync()));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(letters, controller: controller, onChange: (_) => count++),
        ),
      );

      controller.value = {'A'};
      await tester.pump();

      expect(count, 1);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

      controller.value = {'B'};
      await tester.pump();

      expect(count, 1);
    });
  });

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>.fromMap(
            const {'A': 'A', 'B': 'B'},
            key: key,
            focusNode: focus,
            controller: controller,
          ),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('tap on field should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
          child: FMultiSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
          child: FMultiSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
          child: FMultiSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
