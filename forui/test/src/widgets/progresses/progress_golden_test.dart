import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(TestScaffold.blue(child: FProgress(style: TestScaffold.blueScreen.progressStyle)));

    await expectBlueScreen();
  });

  for (final (:data, :name) in TestScaffold.themes) {
    testWidgets('FProgress - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpFrames(
        sheet.record(TestScaffold.app(theme: data, child: const FProgress())),
        const Duration(milliseconds: 1660),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/progress/$name.png'));
    });
  }
}
