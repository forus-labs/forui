@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FDivider', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FDivider(
            style: TestScaffold.blueScreen.dividerStyles.verticalStyle,
            axis: Axis.vertical,
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final (name, theme, _) in TestScaffold.themes) {
      for (final axis in Axis.values) {
        testWidgets('$name - $axis', (tester) async {
          final children = [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: theme.style.borderRadius,
                border: Border.all(color: theme.colorScheme.secondary),
              ),
            ),
            FDivider(axis: axis),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: theme.style.borderRadius,
                border: Border.all(color: theme.colorScheme.secondary),
              ),
            ),
          ];

          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: axis == Axis.vertical
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('divider/$name-$axis.png'),
          );
        });
      }
    }
  });
}
