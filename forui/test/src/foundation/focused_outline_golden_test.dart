import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FFocusedOutline', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FFocusedOutline(
            style: TestScaffold.blueScreen.style.focusedOutlineStyle,
            focused: true,
            child: const SizedBox(width: 100, height: 100),
          ),
        ),
      );

      await expectBlueScreen();
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('focused', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FFocusedOutline(
              focused: true,
              child: Container(width: 100, height: 100, color: theme.data.colors.primary),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('focused-outline/${theme.name}/focused.png'));
      });

      testWidgets('unfocused', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FFocusedOutline(
              focused: false,
              child: Container(width: 100, height: 100, color: theme.data.colors.primary),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('focused-outline/${theme.name}/unfocused.png'));
      });
    }
  });
}
