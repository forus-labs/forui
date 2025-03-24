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

    testWidgets('didUpdateWidget does not dispose external controller', (tester) async {
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

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(key: key, children: [for (final letter in letters) FSelectItem.text(letter)]),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(controller.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });

    testWidgets('dispose() does not dispose external controller', (tester) async {
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

      await tester.pumpWidget(const SizedBox());

      expect(controller.hasListeners, false);
      expect(controller.dispose, returnsNormally);
    });
  });
}
