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
            theme: FThemes.zinc.light,
            child: FAccordion(
              items: [
                FAccordionItem(
                  title: const Text('Title'),
                  initiallyExpanded: true,
                  child: SizedBox.square(
                    dimension: 1,
                    child: GestureDetector(
                      onTap: () => taps++,
                      child: const Text('button'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('button'), warnIfMissed: false);
      expect(taps, 0);

      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('button'));
      expect(taps, 1);
    });
  });
}
