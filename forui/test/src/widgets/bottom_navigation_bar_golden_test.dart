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
                  label: 'Home',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.layoutGrid,
                  label: 'Browse',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.radio,
                  label: 'Radio',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.libraryBig,
                  label: 'Library',
                ),
                FBottomNavigationBarItem(
                  icon: FAssets.icons.search,
                  label: 'Search',
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
                FBottomNavigationBarItem.customIcon(
                  iconBuilder: icon,
                  label: 'Home',
                ),
                FBottomNavigationBarItem.customIcon(
                  iconBuilder: icon,
                  label: 'Browse',
                ),
                FBottomNavigationBarItem.customIcon(
                  iconBuilder: icon,
                  label: 'Radio',
                ),
                FBottomNavigationBarItem.customIcon(
                  iconBuilder: icon,
                  label: 'Library',
                ),
                FBottomNavigationBarItem.customIcon(
                  iconBuilder: icon,
                  label: 'Search',
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
