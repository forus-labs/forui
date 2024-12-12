@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../test_scaffold.dart';

void main() {
  group('FBottomNavigationBar', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FBottomNavigationBar(
            style: TestScaffold.blueScreen.bottomNavigationBarStyle,
            index: 2,
            children: [
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.house),
                label: const Text('Home'),
              ),
              FBottomNavigationBarItem(
                icon: FIcon(FAssets.icons.layoutGrid),
                label: const Text('Browse'),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('forui icon - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBottomNavigationBar(
              index: 2,
              children: [
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.house),
                  label: const Text('Home'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.layoutGrid),
                  label: const Text('Browse'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.radio),
                  label: const Text('Radio'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.radio),
                  label: const Text('Library'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.radio),
                  label: const Text('Search'),
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('bottom-navigation-bar/${theme.name}-forui-icon.png'),
        );
      });

      testWidgets('focused - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBottomNavigationBar(
              index: 2,
              children: [
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.house),
                  label: const Text('Home'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.layoutGrid),
                  label: const Text('Browse'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.radio),
                  label: const Text('Radio'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.radio),
                  label: const Text('Library'),
                ),
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.radio),
                  label: const Text('Search'),
                ),
              ],
            ),
          ),
        );

        Focus.of(tester.element(find.text('Radio'))).requestFocus();
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('bottom-navigation-bar/${theme.name}-focused.png'),
        );
      });
    }
  });
}
