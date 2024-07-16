@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../test_scaffold.dart';

void main() {
  group('FBottomNavigationBar', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('$name with FBottomNavigationBar', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: FBottomNavigationBar(
              activeIndex: 2,
              items: [
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
          matchesGoldenFile('bottom-navigation-bar/$name-bottom-navigation-bar.png'),
        );
      });
    }
  });
}
