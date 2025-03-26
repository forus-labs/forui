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
            controller: autoDispose(FMultiValueNotifier(values: {1})),
            items: const [
              FSelectGroupItem.checkbox(value: 1, label: Text('Checkbox 1'), semanticLabel: 'Checkbox 1'),
              FSelectGroupItem.radio(value: 2, label: Text('Checkbox 2'), semanticLabel: 'Checkbox 2'),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with checkbox', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              controller: autoDispose(FMultiValueNotifier(values: {1})),
              items: const [
                FSelectGroupItem.checkbox(value: 1, label: Text('Checkbox 1'), semanticLabel: 'Checkbox 1'),
                FSelectGroupItem.checkbox(value: 2, label: Text('Checkbox 2'), semanticLabel: 'Checkbox 2'),
                FSelectGroupItem.checkbox(value: 3, label: Text('Checkbox 3'), semanticLabel: 'Checkbox 3'),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/checkbox.png'));
      });

      testWidgets('${theme.name} with checkbox error', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              forceErrorText: 'Some error message.',
              controller: autoDispose(FMultiValueNotifier(values: {1})),
              items: const [
                FSelectGroupItem.checkbox(value: 1, label: Text('Checkbox 1'), semanticLabel: 'Checkbox 1'),
                FSelectGroupItem.checkbox(value: 2, label: Text('Checkbox 2'), semanticLabel: 'Checkbox 2'),
                FSelectGroupItem.checkbox(value: 3, label: Text('Checkbox 3'), semanticLabel: 'Checkbox 3'),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-group/${theme.name}/checkbox-error.png'),
        );
      });
    }
  });

  group('FRadio', () {
    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with radio', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              controller: autoDispose(FMultiValueNotifier.radio(value: 1)),
              items: const [
                FSelectGroupItem.radio(value: 1, label: Text('Radio 1'), semanticLabel: 'Radio 1'),
                FSelectGroupItem.radio(value: 2, label: Text('Radio 2'), semanticLabel: 'Radio 2'),
                FSelectGroupItem.radio(value: 3, label: Text('Radio 3'), semanticLabel: 'Radio 3'),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/radio.png'));
      });

      testWidgets('${theme.name} with radio error', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              forceErrorText: 'Some error message.',
              controller: autoDispose(FMultiValueNotifier.radio(value: 1)),
              items: const [
                FSelectGroupItem.radio(value: 1, label: Text('Radio 1'), semanticLabel: 'Radio 1'),
                FSelectGroupItem.radio(value: 2, label: Text('Radio 2'), semanticLabel: 'Radio 2'),
                FSelectGroupItem.radio(value: 3, label: Text('Radio 3'), semanticLabel: 'Radio 3'),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/radio-error.png'));
      });
    }
  });
}
