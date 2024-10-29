@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FScaffold', () {
    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets(themeName, (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FScaffold(
              header: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.red),
                      height: 100,
                    ),
                  ),
                ],
              ),
              content: const Placeholder(),
              footer: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.green),
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('scaffold/$themeName-scaffold.png'));
      });
    }
  });
}
