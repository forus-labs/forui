import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

class UnderTest extends StatelessWidget {
  final FDialogAlignment alignment;
  final bool raw;

  const UnderTest({required this.alignment, required this.raw, super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      FButton(labelText: 'Continue', onPress: () {}),
      FButton(design: FButtonVariant.outlined, labelText: 'Cancel', onPress: () {
        Navigator.of(context).pop();
      }),
    ];

    if (raw) {
      return FDialog(
        alignment: alignment,
        rawTitle: const Text('Are you absolutely sure?'),
        rawBody: const Text('This action cannot be undone. This will permanently delete your account and remove your data from our servers.'),
        actions: actions,
      );

    } else {
      return FDialog(
        alignment: alignment,
        title: 'Are you absolutely sure?',
        body: 'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
        actions: actions,
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('alignment', alignment))
      ..add(DiagnosticsProperty('raw', raw));
  }
}


void main() {
  group('FDialog', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      for (final alignment in [FDialogAlignment.horizontal, FDialogAlignment.vertical]) {
        testWidgets('$name with $alignment text FDialogContent', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: TestScaffold(
                data: theme,
                background: background,
                child: UnderTest(alignment: alignment, raw: false),
              ),
            ),
          );

          await expectLater(
            find.byType(UnderTest),
            matchesGoldenFile('dialog/$name-$alignment-text-dialog-content.png'),
          );
        });

        testWidgets('$name with $alignment raw FDialogContent', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: TestScaffold(
                data: theme,
                background: background,
                child: UnderTest(alignment: alignment, raw: true),
              ),
            ),
          );

          await expectLater(
            find.byType(UnderTest),
            matchesGoldenFile('dialog/$name-$alignment-raw-dialog-content.png'),
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
