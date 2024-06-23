import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

class UnderTest extends StatelessWidget {
  final Axis direction;
  final bool raw;

  const UnderTest({required this.direction, required this.raw, super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      FButton(label: 'Continue', onPress: () {}),
      FButton(style: FButtonStyle.outline, label: 'Cancel', onPress: () {
        Navigator.of(context).pop();
      }),
    ];

    if (raw) {
      return FDialog(
        direction: direction,
        rawTitle: const Text('Are you absolutely sure?'),
        rawBody: const Text('This action cannot be undone. This will permanently delete your account and remove your data from our servers.'),
        actions: actions,
      );

    } else {
      return FDialog(
        direction: direction,
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
      ..add(EnumProperty('alignment', direction))
      ..add(DiagnosticsProperty('raw', raw));
  }
}


void main() {
  group('FDialog', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      for (final direction in Axis.values) {
        testWidgets('$name with $direction text FDialogContent', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: TestScaffold(
                data: theme,
                background: background,
                child: UnderTest(direction: direction, raw: false),
              ),
            ),
          );

          await expectLater(
            find.byType(UnderTest),
            matchesGoldenFile('dialog/$name-$direction-text-dialog-content.png'),
          );
        });

        testWidgets('$name with $direction raw FDialogContent', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: TestScaffold(
                data: theme,
                background: background,
                child: UnderTest(direction: direction, raw: true),
              ),
            ),
          );

          await expectLater(
            find.byType(UnderTest),
            matchesGoldenFile('dialog/$name-$direction-raw-dialog-content.png'),
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
