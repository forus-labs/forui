import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSidebarItem', () {
    testWidgets('press', (tester) async {
      var press = 0;
      var longPress = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FSidebarItem(
            label: const Text('Item'),
            onPress: () => press++,
            onLongPress: () => longPress++,
          ),
        ),
      );

      await tester.tap(find.text('Item'));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(press, 1);
      expect(longPress, 0);
    });

    testWidgets('long press', (tester) async {
      var press = 0;
      var longPress = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FSidebarItem(
            label: const Text('Item'),
            onPress: () => press++,
            onLongPress: () => longPress++,
          ),
        ),
      );

      await tester.longPress(find.text('Item'));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(press, 0);
      expect(longPress, 1);
    });
  });
}
