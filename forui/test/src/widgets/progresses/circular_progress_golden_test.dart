import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(child: FCircularProgress(style: TestScaffold.blueScreen.circularProgressStyle)),
    );

    await expectBlueScreen();
  });

  for (final (:data, :name) in TestScaffold.themes) {
    testWidgets('FCircularProgress - $name', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(100, 100)));

      await tester.pumpFrames(
        sheet.record(TestScaffold.app(theme: data, child: const FCircularProgress())),
        const Duration(milliseconds: 1000),
      );

      await expectLater(sheet.collate(10), matchesGoldenFile('progresses/circular/$name.png'));
    });
  }

  testWidgets('inherit style', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FInheritedCircularProgressStyle(
          style: FCircularProgressStyle(iconStyle: const IconThemeData(color: Colors.red, size: 40)),
          child: const FCircularProgress(),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('progresses/circular/inherit-style.png'));
  });
}
