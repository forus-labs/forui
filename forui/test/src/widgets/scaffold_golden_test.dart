@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FScaffold', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets(name, (tester) async {
        Widget buildColor(Color color) => Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                    child: const SizedBox(height: 100),
                  ),
                ),
              ],
            );

        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: FScaffold(
              header: buildColor(Colors.red),
              content: const Placeholder(),
              footer: buildColor(Colors.green),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('scaffold/$name-scaffold.png'));
      });
    }
  });
}
