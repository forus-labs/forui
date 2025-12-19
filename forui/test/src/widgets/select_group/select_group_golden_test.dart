import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('checkbox', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelectGroup(
            style: TestScaffold.blueScreen.selectGroupStyle,
            label: const Text('Select Group'),
            description: const Text('Select Group Description'),
            control: const .managed(initial: {1}),
            children: [
              .checkbox(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
              .radio(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with checkbox', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              control: const .managed(initial: {1}),
              children: [
                .checkbox(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
                .checkbox(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
                .checkbox(value: 3, label: const Text('Checkbox 3'), semanticsLabel: 'Checkbox 3'),
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
              control: const .managed(initial: {1}),
              children: [
                .checkbox(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
                .checkbox(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
                .checkbox(value: 3, label: const Text('Checkbox 3'), semanticsLabel: 'Checkbox 3'),
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

  group('radio', () {
    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with radio', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectGroup(
              label: const Text('Select Group'),
              description: const Text('Select Group Description'),
              control: const .managedRadio(initial: 1),
              children: [
                .radio(value: 1, label: const Text('Radio 1'), semanticsLabel: 'Radio 1'),
                .radio(value: 2, label: const Text('Radio 2'), semanticsLabel: 'Radio 2'),
                .radio(value: 3, label: const Text('Radio 3'), semanticsLabel: 'Radio 3'),
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
              control: const .managedRadio(initial: 1),
              children: [
                .radio(value: 1, label: const Text('Radio 1'), semanticsLabel: 'Radio 1'),
                .radio(value: 2, label: const Text('Radio 2'), semanticsLabel: 'Radio 2'),
                .radio(value: 3, label: const Text('Radio 3'), semanticsLabel: 'Radio 3'),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/radio-error.png'));
      });
    }
  });
}
