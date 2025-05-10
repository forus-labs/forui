import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCollapsible', () {

    for (final theme in TestScaffold.themes) {
      testWidgets('fully expanded', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FCollapsible(
              value: 1.0,
              child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('collapsible/${theme.name}/fully_expanded.png'));
      });

      testWidgets('half expanded', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FCollapsible(
              value: 0.5,
              child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('collapsible/${theme.name}/half_expanded.png'));
      });

      testWidgets('fully collapsed', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FCollapsible(
              value: 0.0,
              child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('collapsible/${theme.name}/fully_collapsed.png'));
      });
    }
  });
}
