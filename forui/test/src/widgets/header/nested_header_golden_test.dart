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

    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('$themeName with FNestedHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/$themeName-header.png'));
      });
    }
  });
}
