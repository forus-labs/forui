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

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('forui icon - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
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
          matchesGoldenFile('bottom-navigation-bar/$name-forui-icon.png'),
        );
      });
    }
  });
}
