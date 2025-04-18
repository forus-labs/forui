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
            children: [
              FCheckbox.grouped(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
              FRadio.grouped(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
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
              children: [
                FCheckbox.grouped(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
                FCheckbox.grouped(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
                FCheckbox.grouped(value: 3, label: const Text('Checkbox 3'), semanticsLabel: 'Checkbox 3'),
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
              children: [
                FCheckbox.grouped(value: 1, label: const Text('Checkbox 1'), semanticsLabel: 'Checkbox 1'),
                FCheckbox.grouped(value: 2, label: const Text('Checkbox 2'), semanticsLabel: 'Checkbox 2'),
                FCheckbox.grouped(value: 3, label: const Text('Checkbox 3'), semanticsLabel: 'Checkbox 3'),
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
              children: [
                FRadio.grouped(value: 1, label: const Text('Radio 1'), semanticsLabel: 'Radio 1'),
                FRadio.grouped(value: 2, label: const Text('Radio 2'), semanticsLabel: 'Radio 2'),
                FRadio.grouped(value: 3, label: const Text('Radio 3'), semanticsLabel: 'Radio 3'),
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
              children: [
                FRadio.grouped(value: 1, label: const Text('Radio 1'), semanticsLabel: 'Radio 1'),
                FRadio.grouped(value: 2, label: const Text('Radio 2'), semanticsLabel: 'Radio 2'),
                FRadio.grouped(value: 3, label: const Text('Radio 3'), semanticsLabel: 'Radio 3'),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-group/${theme.name}/radio-error.png'));
      });
    }
  });
}
