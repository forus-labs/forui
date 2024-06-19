@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

void main() {
  group('FHeader', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      testWidgets('$name with FHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FHeader(
                  title: title,
                  actions: [
                    FHeaderAction(
                      icon: FAssets.icons.alarmClock,
                      onPress: null,
                    ),
                    FHeaderAction(
                      icon: FAssets.icons.plus,
                      onPress: () {},
                    ),
                  ],
                ),
              )
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('header/$name-header.png'),
        );
      });

      testWidgets('$name with raw title', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FHeader(
                  rawTitle: const Text('Title'),
                  actions: [
                    FHeaderAction(
                      icon: FAssets.icons.alarmClock,
                      onPress: null,
                    ),
                    FHeaderAction(
                      icon: FAssets.icons.plus,
                      onPress: () {},
                    ),
                  ],
                ),
              )
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('header/$name-raw-title.png'),
        );
      });
    }
  });
}
