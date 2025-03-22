import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
  });

  group('FSelectSection', () {
    testWidgets('focus skips title', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            controller: controller,
            children: [
              FSelectSection(title: const Text('1st'), children: [FSelectItem.text('A')]),
              FSelectSection(title: const Text('2nd'), children: [FSelectItem.text('B')]),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(find.text('B'), findsOne);
      expect(controller.value, 'B');
    });
  });

  group('FSelectItem', () {
    testWidgets('focus changes', (tester) async {
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

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(find.text('B'), findsOne);
      expect(controller.value, 'B');
    });
  });

  tearDown(() {
    controller.dispose();
  });
}
