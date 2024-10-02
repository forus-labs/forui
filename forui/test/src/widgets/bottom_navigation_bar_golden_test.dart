@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FBottomNavigationBar', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('forui icon - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: FBottomNavigationBar(
              index: 2,
              children: [
                FBottomNavigationBarItem(
                  icon: FIcon(FAssets.icons.home),
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
          matchesGoldenFile('bottom-navigation-bar/forui-icon-$name.png'),
        );
      });
    }
  });
}
