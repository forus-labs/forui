import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FDeterminateProgress(style: TestScaffold.blueScreen.determinateProgressStyle, value: 0.4),
      ),
    );

    await expectBlueScreen();
  });

  for (final (:data, :name) in TestScaffold.themes) {
    testWidgets('forward - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpFrames(
        sheet.record(TestScaffold.app(theme: data, child: const FDeterminateProgress(value: 0.5))),
        const Duration(milliseconds: 1100),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/determinate/forward-$name.png'));
    });

    testWidgets('backward - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpWidget(
        sheet.record(
          TestScaffold.app(
            theme: data,
            child: const FDeterminateProgress(value: 0.7, key: ValueKey('test')),
          ),
          recording: false,
        ),
      );
      await tester.pumpAndSettle();
      await tester.pumpFrames(
        sheet.record(
          TestScaffold.app(
            theme: data,
            child: const FDeterminateProgress(value: 0.2, key: ValueKey('test')),
          ),
        ),
        const Duration(milliseconds: 1100),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/determinate/backward-$name.png'));
    });
  }
}
