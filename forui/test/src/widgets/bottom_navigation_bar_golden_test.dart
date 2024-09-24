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
                  icon: FAssets.icons.home,
                  label: const Text('Home'),
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.layoutGrid,
                  label: const Text('Browse'),
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.radio,
                  label: const Text('Radio'),
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.libraryBig,
                  label: const Text('Library'),
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.search,
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

      testWidgets('custom icon - $name', (tester) async {
        Widget icon(BuildContext _, FBottomNavigationBarData data, Widget? __) => Container(
              height: data.itemStyle.iconSize,
              width: data.itemStyle.iconSize,
              color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
            );

        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: FBottomNavigationBar(
              index: 2,
              children: [
                FBottomNavigationBarItem.custom(
                  iconBuilder: icon,
                  label: const Text('Home'),
                ),
                FBottomNavigationBarItem.custom(
                  iconBuilder: icon,
                  label: const Text('Browse'),
                ),
                FBottomNavigationBarItem.custom(
                  iconBuilder: icon,
                  label: const Text('Radio'),
                ),
                FBottomNavigationBarItem.custom(
                  iconBuilder: icon,
                  label: const Text('Library'),
                ),
                FBottomNavigationBarItem.custom(
                  iconBuilder: icon,
                  label: const Text('Search'),
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('bottom-navigation-bar/custom-icon-$name.png'),
        );
      });
    }
  });
}
