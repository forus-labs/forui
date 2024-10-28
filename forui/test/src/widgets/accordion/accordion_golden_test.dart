@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FAccordion', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAccordion(
            style: TestScaffold.blueScreen.accordionStyle,
            items: [
              FAccordionItem(
                title: const Text('Title'),
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (name, theme, _) in TestScaffold.themes) {
      testWidgets('shown', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FAccordion(
              items: [
                FAccordionItem(
                  initiallyExpanded: true,
                  title: const Text('Title'),
                  child: const ColoredBox(
                    color: Colors.yellow,
                    child: SizedBox.square(
                      dimension: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/$name/shown.png'));
      });

      testWidgets('hidden', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FAccordion(
              items: [
                FAccordionItem(
                  initiallyExpanded: true,
                  title: const Text('Title'),
                  child: const ColoredBox(
                    color: Colors.yellow,
                    child: SizedBox.square(
                      dimension: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.text('Title'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/$name/hidden.png'));
      });
    }
  });
}
