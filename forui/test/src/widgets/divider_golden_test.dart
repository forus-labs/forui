import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FDivider(style: TestScaffold.blueScreen.dividerStyles.verticalStyle, axis: .vertical),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    for (final axis in Axis.values) {
      testWidgets('${theme.name} - $axis', (tester) async {
        final children = [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: theme.data.style.borderRadius,
              border: .all(color: theme.data.colors.secondary),
            ),
          ),
          FDivider(axis: axis),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: theme.data.style.borderRadius,
              border: .all(color: theme.data.colors.secondary),
            ),
          ),
        ];

        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: axis == .vertical
                ? Row(mainAxisAlignment: .center, children: children)
                : Column(mainAxisAlignment: .center, children: children),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('divider/${theme.name}-$axis.png'));
      });
    }
  }
}
