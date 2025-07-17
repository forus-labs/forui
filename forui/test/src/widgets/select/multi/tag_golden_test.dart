import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = {
  'Apple': 'Apple',
  'Banana': 'Banana',
  'Cherry': 'Cherry',
  'Dragonfruit': 'Dragonfruit',
  'Elderberry': 'Elderberry',
  'Fig': 'Fig',
  'Grape': 'Grape',
  'Honeydew': 'Honeydew',
  'Italian plum': 'Italian plum',
  'Jackfruit': 'Jackfruit',
  'Kiwi': 'Kiwi',
  'Lemon': 'Lemon',
  'Mango': 'Mango',
  'Nectarine': 'Nectarine',
  'Orange': 'Orange',
};

void main() {
  const key = ValueKey('select');

  group('blue screen', () {
    testWidgets('tag', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FMultiSelectTag(
            style: TestScaffold.blueScreen.multiSelectStyle.tagStyle,
            label: const Text('Tag'),
            key: key,
          ),
        ),
      );

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('tag', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FMultiSelectTag(label: const Text('Tag'), onPress: () {}, key: key),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/tag/${theme.name}/tag.png'));
    });

    testWidgets('focused', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FMultiSelectTag(focusNode: focus, label: const Text('Tag'), onPress: () {}, key: key),
        ),
      );

      focus.requestFocus();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/tag/${theme.name}/focused.png'));
    });
  }
}
