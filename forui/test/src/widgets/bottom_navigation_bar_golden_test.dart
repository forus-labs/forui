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
            children: const [
              FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
              FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Browse')),
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
            child: const FBottomNavigationBar(
              index: 2,
              children: [
                FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
                FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Browse')),
                FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Radio')),
                FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Library')),
                FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Search')),
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
            child: const FBottomNavigationBar(
              index: 2,
              children: [
                FBottomNavigationBarItem(icon: Icon(FIcons.house), label: Text('Home')),
                FBottomNavigationBarItem(icon: Icon(FIcons.layoutGrid), label: Text('Browse')),
                FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Radio')),
                FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Library')),
                FBottomNavigationBarItem(icon: Icon(FIcons.radio), label: Text('Search')),
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
