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

    for (final theme in TestScaffold.themes) {
      testWidgets('shown', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/shown.png'));
      });

      testWidgets('focused', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FAccordion(
              items: [
                FAccordionItem(
                  initiallyExpanded: true,
                  autofocus: true,
                  title: const Text('Title'),
                  child: const ColoredBox(
                    color: Colors.yellow,
                    child: SizedBox.square(
                      dimension: 50,
                    ),
                  ),
                ),
                FAccordionItem(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/focused.png'));
      });

      testWidgets('hidden', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('accordion/${theme.name}/hidden.png'));
      });
    }
  });
}
