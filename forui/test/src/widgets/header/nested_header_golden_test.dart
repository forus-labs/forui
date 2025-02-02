@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  group('FNestedHeader', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FHeader.nested(
            style: TestScaffold.blueScreen.headerStyle.nestedStyle,
            title: const Text('Title'),
            prefixActions: [
              FHeaderAction.back(onPress: () {}),
              FHeaderAction(
                icon: FIcon(FAssets.icons.alarmClock),
                onPress: null,
              ),
            ],
            suffixActions: [
              FHeaderAction(
                icon: FIcon(FAssets.icons.plus),
                onPress: () {},
              ),
              FHeaderAction.x(onPress: () {}),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with FNestedHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FHeader.nested(
              title: const Text('Title'),
              prefixActions: [
                FHeaderAction.back(onPress: () {}),
                FHeaderAction(
                  icon: FIcon(FAssets.icons.alarmClock),
                  onPress: null,
                ),
              ],
              suffixActions: [
                FHeaderAction(
                  icon: FIcon(FAssets.icons.plus),
                  onPress: () {},
                ),
                FHeaderAction.x(onPress: () {}),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}.png'));
      });

      testWidgets('${theme.name} with no FNestedHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FHeader.nested(
              title: Text('Title'),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-no-actions.png'));
      });

      testWidgets('${theme.name} with focused FNestedHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FHeader.nested(
              title: const Text('Title'),
              prefixActions: [
                FHeaderAction.back(onPress: () {}),
                FHeaderAction(
                  icon: FIcon(FAssets.icons.alarmClock),
                  onPress: null,
                ),
              ],
              suffixActions: [
                FHeaderAction(
                  autofocus: true,
                  icon: FIcon(FAssets.icons.plus),
                  onPress: () {},
                ),
                FHeaderAction.x(onPress: () {}),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-focused.png'));
      });

      testWidgets('${theme.name} with RTL FNestedHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            textDirection: TextDirection.rtl,
            child: FHeader.nested(
              title: const Text('Title'),
              prefixActions: [
                FHeaderAction.back(onPress: () {}),
                FHeaderAction(
                  icon: FIcon(FAssets.icons.alarmClock),
                  onPress: null,
                ),
              ],
              suffixActions: [
                FHeaderAction(
                  icon: FIcon(FAssets.icons.plus),
                  onPress: () {},
                ),
                FHeaderAction.x(onPress: () {}),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-rtl.png'));
      });
    }
  });
}
