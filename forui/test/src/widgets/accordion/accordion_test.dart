import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FAccordion', () {
    testWidgets('hit test', (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        TestScaffold(
          child: FAccordion(
            children: [
              FAccordionItem(
                title: const Text('Title'),
                initiallyExpanded: true,
                child: SizedBox.square(
                  dimension: 1,
                  child: GestureDetector(onTap: () => taps++, child: const Text('button')),
                ),
              ),
            ],
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

    testWidgets('old controller is not disposed', (tester) async {
      final first = autoDispose(FAccordionController());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            controller: first,
            children: const [FAccordionItem(title: Text('Title'), child: Text('button'))],
          ),
        ),
      );

      final second = autoDispose(FAccordionController());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            controller: second,
            children: const [FAccordionItem(title: Text('Title'), child: Text('button'))],
          ),
        ),
      );

      expect(first.disposed, false);
      expect(second.disposed, false);
    });
  });
}
