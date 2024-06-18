import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

class UnderTest extends StatelessWidget {
  final FDialogAlignment alignment;

  const UnderTest({required this.alignment, super.key});

  @override
  Widget build(BuildContext context) => FDialog(
    alignment: alignment,
    titleText: 'Are you absolutely sure?',
    bodyText: 'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
    actions: [
      FButton(labelText: 'Continue', onPress: () {}),
      FButton(design: FButtonVariant.outlined, labelText: 'Cancel', onPress: () {
        Navigator.of(context).pop();
      }),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<FDialogAlignment>('alignment', alignment));
  }
}


void main() {
  group('FDialog', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      for (final alignment in [FDialogAlignment.horizontal, FDialogAlignment.vertical]) {
        testWidgets('$name with $alignment content', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: TestScaffold(
                data: theme,
                background: background,
                child: UnderTest(alignment: alignment),
              ),
            ),
          );

          await expectLater(
            find.byType(UnderTest),
            matchesGoldenFile('dialog/$name-$alignment-content.png'),
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
          matchesGoldenFile('dialog/$name-raw-content.png'),
        );
      });
    }
  });
}
