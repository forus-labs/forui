@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCheckbox', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelectGroup(
            style: TestScaffold.blueScreen.selectGroupStyle,
            label: const Text('Select Group'),
            description: const Text('Select Group Description'),
            controller: FMultiSelectGroupController(values: {1}),
            items: const [
              FSelectGroupItem.checkbox(
                value: 1,
                label: Text('Checkbox 1'),
                semanticLabel: 'Checkbox 1',
              ),
              FSelectGroupItem.radio(
                value: 2,
                label: Text('Checkbox 2'),
                semanticLabel: 'Checkbox 2',
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('$themeName with checkbox', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              controller: FMultiSelectGroupController(values: {1}),
              items: const [
                FSelectGroupItem.checkbox(
                  value: 1,
                  label: Text('Checkbox 1'),
                  semanticLabel: 'Checkbox 1',
                ),
                FSelectGroupItem.checkbox(
                  value: 2,
                  label: Text('Checkbox 2'),
                  semanticLabel: 'Checkbox 2',
                ),
                FSelectGroupItem.checkbox(
                  value: 3,
                  label: Text('Checkbox 3'),
                  semanticLabel: 'Checkbox 3',
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/$themeName/checkbox.png'));
      });

      testWidgets('$themeName with checkbox error', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              forceErrorText: 'Some error message.',
              controller: FMultiSelectGroupController(values: {1}),
              items: const [
                FSelectGroupItem.checkbox(
                  value: 1,
                  label: Text('Checkbox 1'),
                  semanticLabel: 'Checkbox 1',
                ),
                FSelectGroupItem.checkbox(
                  value: 2,
                  label: Text('Checkbox 2'),
                  semanticLabel: 'Checkbox 2',
                ),
                FSelectGroupItem.checkbox(
                  value: 3,
                  label: Text('Checkbox 3'),
                  semanticLabel: 'Checkbox 3',
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/$themeName/checkbox-error.png'));
      });
    }
  });

  group('FRadio', () {
    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('$themeName with radio', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              controller: FRadioSelectGroupController(value: 1),
              items: const [
                FSelectGroupItem.radio(
                  value: 1,
                  label: Text('Radio 1'),
                  semanticLabel: 'Radio 1',
                ),
                FSelectGroupItem.radio(
                  value: 2,
                  label: Text('Radio 2'),
                  semanticLabel: 'Radio 2',
                ),
                FSelectGroupItem.radio(
                  value: 3,
                  label: Text('Radio 3'),
                  semanticLabel: 'Radio 3',
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/$themeName/radio.png'));
      });

      testWidgets('$themeName with radio error', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              forceErrorText: 'Some error message.',
              controller: FRadioSelectGroupController(value: 1),
              items: const [
                FSelectGroupItem.radio(
                  value: 1,
                  label: Text('Radio 1'),
                  semanticLabel: 'Radio 1',
                ),
                FSelectGroupItem.radio(
                  value: 2,
                  label: Text('Radio 2'),
                  semanticLabel: 'Radio 2',
                ),
                FSelectGroupItem.radio(
                  value: 3,
                  label: Text('Radio 3'),
                  semanticLabel: 'Radio 3',
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/$themeName/radio-error.png'));
      });
    }
  });
}
