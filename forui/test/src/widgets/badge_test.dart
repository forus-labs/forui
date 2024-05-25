@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FBadge', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      for (final variant in FBadgeVariant.values) {
        testWidgets('$name with FBadgeContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: FBadge(
                label: 'Badge',
                design: variant,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('badge/$name-$variant-badge-content.png'),
          );
        });

        testWidgets('$name with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: FBadge.raw(
                design: variant,
                builder: (_, style) => Padding(
                    padding: const EdgeInsets.all(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blueAccent,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: style.background,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    )
                )
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('badge/$name-$variant-raw-content.png'),
          );
        });
      }
    }
  });
}
