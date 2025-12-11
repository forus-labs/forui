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

  tearDown(() {
    controller.dispose();
  });

  group('FSelectSection', () {
    testWidgets('focus skips title', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            control: .managed(controller: controller),
            children: const [
              FSelectSection.rich(
                label: Text('1st'),
                children: [FSelectItem(title: Text('A'), value: 'A')],
              ),
              FSelectSection.rich(
                label: Text('2nd'),
                children: [FSelectItem(title: Text('B'), value: 'B')],
              ),
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
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            control: .managed(controller: controller),
            children: const [
              FSelectItem(title: Text('A'), value: 'A'),
              FSelectItem(title: Text('B'), value: 'B'),
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
}
