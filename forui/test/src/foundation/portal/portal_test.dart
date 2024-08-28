@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPortal', () {
    testWidgets('hit test', (tester) async {
      final controller = OverlayPortalController();
      var taps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: FPortal(
              followerAnchor: Alignment.topRight,
              childAnchor: Alignment.bottomLeft,
              controller: controller,
              follower: (context) => Padding(
                padding: const EdgeInsets.all(5),
                child: ColoredBox(
                  color: Colors.red,
                  child: SizedBox.square(
                    dimension: 100,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox.square(
                        dimension: 1,
                        child: GestureDetector(
                          onTap: () => taps++,
                        ),
                      ),
                    ),
                  ),
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
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(GestureDetector));

      expect(taps, 1);
    });
  });
}
