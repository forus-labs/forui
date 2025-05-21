import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FFocusedOutline', () {
    testWidgets('hit test', (tester) async {
      var count = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FFocusedOutline(
            focused: true,
            child: GestureDetector(
              onTap: () => count++,
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Container).last);
      await tester.pumpAndSettle();

      expect(count, 1);
    });

    testWidgets('hit test spacing', (tester) async {
      var count = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FFocusedOutline(
            focused: true,
            child: GestureDetector(
              onTap: () => count++,
              child: Container(width: 100, height: 100, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.tapAt(
        tester.getCenter(find.byType(Container).last).translate(51, 0),
      );
      await tester.pumpAndSettle();

      expect(count, 0);
    });
  });
}
