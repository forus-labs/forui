import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hit test', (tester) async {
    final controller = OverlayPortalController();
    var taps = 0;

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPortal(
          portalAnchor: .topRight,
          childAnchor: .bottomLeft,
          controller: controller,
          portalBuilder: (context, _) => Padding(
            padding: const .all(5),
            child: ColoredBox(
              color: Colors.red,
              child: SizedBox.square(
                dimension: 100,
                child: Align(
                  alignment: .bottomLeft,
                  child: SizedBox.square(dimension: 1, child: GestureDetector(onTap: () => taps++)),
                ),
              ),
            ),
          ),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(GestureDetector));

    expect(taps, 1);
  });
}
