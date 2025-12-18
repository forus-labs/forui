import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;

  setUp(() {
    controller = FSelectController<String>();
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
            children: [
              .richSection(
                label: const Text('1st'),
                children: [const .item(title: Text('A'), value: 'A')],
              ),
              .richSection(
                label: const Text('2nd'),
                children: [const .item(title: Text('B'), value: 'B')],
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.enter);
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
            children: [
              .item(title: const Text('A'), value: 'A'),
              .item(title: const Text('B'), value: 'B'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowDown);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(find.text('B'), findsOne);
      expect(controller.value, 'B');
    });
  });
}
