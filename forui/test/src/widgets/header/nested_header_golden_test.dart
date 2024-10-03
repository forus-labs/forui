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
              child: FHeader.nested(
                title: const Text('Title'),
                leftActions: [
                  FHeaderAction.back(onPress: () {}),
                  FHeaderAction(
                    icon: FIcon(FAssets.icons.alarmClock),
                    onPress: null,
                  ),
                ],
                rightActions: [
                  FHeaderAction(
                    icon: FIcon(FAssets.icons.plus),
                    onPress: () {},
                  ),
                  FHeaderAction.x(onPress: () {}),
                ],
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('header/nested/$name-header.png'),
        );
      });
    }
  });
}
