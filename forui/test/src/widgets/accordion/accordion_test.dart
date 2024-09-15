@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FAccordion', () {
    testWidgets('hit test', (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: FAccordion(
              title: const Text('Title'),
              child: FButton(
                onPress: () => taps++,
                label: const Text('button'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FButton), warnIfMissed: false);
      expect(taps, 0);

      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FButton));
      expect(taps, 1);
    });
  });
}
