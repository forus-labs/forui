@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FNestedHeader', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      testWidgets('$name with FNestedHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FNestedHeader(
                title: 'Title',
                rightActions: [
                  FNestedHeaderAction(
                    icon: FAssets.icons.alarmClock,
                    onPress: null,
                  ),
                  FNestedHeaderAction(
                    icon: FAssets.icons.plus,
                    onPress: () {},
                  ),
                ],
                leftActions: [
                  FNestedHeaderAction.back(onPress: () {}),
                ],
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('nested-header/$name-header.png'),
        );
      });

      testWidgets('$name with raw title', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FNestedHeader(
                rawTitle: const Text('Title'),
                leftActions: [
                  FNestedHeaderAction(
                    icon: FAssets.icons.alarmClock,
                    onPress: () {},
                  ),
                  FNestedHeaderAction(
                    icon: FAssets.icons.cookingPot,
                    onPress: null,
                  ),
                ],
                rightActions: [
                  FNestedHeaderAction.x(onPress: () {}),
                ],
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('nested-header/$name-raw-title.png'),
        );
      });
    }
  });
}
