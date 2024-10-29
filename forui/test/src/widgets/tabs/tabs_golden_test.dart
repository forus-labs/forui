@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTabs', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FTabs(
            style: TestScaffold.blueScreen.tabsStyle,
            tabs: const [
              FTabEntry(
                label: Text('Account'),
                content: SizedBox(),
              ),
              FTabEntry(
                label: Text('Settings'),
                content: SizedBox(),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('default - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            child: FTabs(
              tabs: [
                FTabEntry(
                  label: const Text('Account'),
                  content: FCard(
                    title: const Text('Account'),
                    subtitle: const Text('Make changes to your account here. Click save when you are done.'),
                    child: Container(
                      color: Colors.blue,
                      height: 100,
                    ),
                  ),
                ),
                FTabEntry(
                  label: const Text('Password'),
                  content: FCard(
                    title: const Text('Password'),
                    subtitle: const Text('Change your password here. After saving, you will be logged out.'),
                    child: Container(
                      color: Colors.red,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tabs/$themeName-tabs.png'));
      });
    }
  });
}
