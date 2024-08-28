@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPortal', () {
    testWidgets('hidden', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FPortal(
            controller: controller,
            follower: (context) => const ColoredBox(
              color: Colors.red,
              child: SizedBox.square(
                dimension: 100,
              ),
            ),
            child: const ColoredBox(
              color: Colors.yellow,
              child: SizedBox.square(
                dimension: 100,
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/hidden.png'));
    });

    testWidgets('shown', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FPortal(
            controller: controller,
            follower: (context) => const Padding(
              padding: EdgeInsets.all(5),
              child: ColoredBox(
                color: Colors.red,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
            child: const ColoredBox(
              color: Colors.yellow,
              child: SizedBox.square(
                dimension: 50,
              ),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(MaterialApp), matchesGoldenFile('portal/shown.png'));
    });
  });
}
