import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

class UnderTest extends StatelessWidget {
  final Axis direction;

  const UnderTest({
    required this.direction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      FButton(
        label: const Text('Continue'),
        onPress: () {},
      ),
      FButton(
        style: FButtonStyle.outline,
        label: const Text('Cancel'),
        onPress: () {
          Navigator.of(context).pop();
        },
      ),
    ];

    return FDialog(
      direction: direction,
      title: const Text('Are you absolutely sure?'),
      body: const Text(
        'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
      ),
      actions: actions,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('alignment', direction));
  }
}

void main() {
  group('FDialog', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FDialog(
            style: TestScaffold.blueScreen.dialogStyle,
            direction: Axis.horizontal,
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: const [],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final direction in Axis.values) {
        testWidgets('$name with $direction FDialogContent', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: TestScaffold(
                data: theme,
                background: background,
                child: UnderTest(direction: direction),
              ),
            ),
          );

          await expectLater(
            find.byType(UnderTest),
            matchesGoldenFile('dialog/$name-$direction-content-dialog.png'),
          );
        });
      }

      testWidgets('$name with raw content', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FDialog.raw(
                  builder: (context, style) => const SizedBox(
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(FDialog),
          matchesGoldenFile('dialog/$name-raw-content-dialog.png'),
        );
      });
    }
  });
}
