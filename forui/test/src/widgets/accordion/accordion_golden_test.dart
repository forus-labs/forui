@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FAccordion', () {
    testWidgets('shown', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FAccordion(
                  items: [
                    FAccordionItem(
                      title: const Text('Title'),
                      initiallyExpanded: true,
                      child: const ColoredBox(
                        color: Colors.yellow,
                        child: SizedBox.square(
                          dimension: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/shown.png'));
    });

    testWidgets('hidden', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FAccordion(
                  items: [
                    FAccordionItem(
                      title: const Text('Title'),
                      initiallyExpanded: true,
                      child: const ColoredBox(
                        color: Colors.yellow,
                        child: SizedBox.square(
                          dimension: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Title'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/hidden.png'));
    });
  });
}
