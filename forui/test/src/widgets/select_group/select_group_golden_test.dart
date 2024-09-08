@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCard', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('$name with checkbox', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: FSelectGroup(
                    label: const Text('Select Group'),
                    description: const Text('Select Group Description'),
                    controller: FMultiSelectGroupController(values: {1}),
                    items: [
                      FSelectGroupItem.checkbox(
                        value: 1,
                        label: const Text('Checkbox 1'),
                        semanticLabel: 'Checkbox 1',
                      ),
                      FSelectGroupItem.checkbox(
                        value: 2,
                        label: const Text('Checkbox 2'),
                        semanticLabel: 'Checkbox 2',
                      ),
                      FSelectGroupItem.checkbox(
                        value: 3,
                        label: const Text('Checkbox 3'),
                        semanticLabel: 'Checkbox 3',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-group/$name-checkbox.png'),
        );
      });

      testWidgets('$name with checkbox error', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: FSelectGroup(
                    label: const Text('Select Group'),
                    description: const Text('Select Group Description'),
                    error: const Text('Some error message.'),
                    controller: FMultiSelectGroupController(values: {1}),
                    items: [
                      FSelectGroupItem.checkbox(
                        value: 1,
                        label: const Text('Checkbox 1'),
                        semanticLabel: 'Checkbox 1',
                      ),
                      FSelectGroupItem.checkbox(
                        value: 2,
                        label: const Text('Checkbox 2'),
                        semanticLabel: 'Checkbox 2',
                      ),
                      FSelectGroupItem.checkbox(
                        value: 3,
                        label: const Text('Checkbox 3'),
                        semanticLabel: 'Checkbox 3',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-group/$name-checkbox-error.png'),
        );
      });
    }
  });
}
