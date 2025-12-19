import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFResizableController', (tester) async {
    late FResizableController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFResizableController();
            return Center(
              child: FResizable(
                axis: .vertical,
                control: .managed(controller: controller),
                children: [
                  FResizableRegion(
                    initialExtent: 100,
                    minExtent: 50,
                    builder: (context, snapshot, child) => const Align(child: Text('A')),
                    child: Container(),
                  ),
                  FResizableRegion(
                    initialExtent: 100,
                    minExtent: 50,
                    builder: (context, snapshot, child) => const Align(child: Text('B')),
                    child: Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.drag(find.text('A'), const Offset(0, 10));
    await tester.pumpAndSettle();
  });

  testWidgets('useFCascadeResizableController', (tester) async {
    late FResizableController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFCascadeResizableController();
            return Center(
              child: FResizable(
                axis: .vertical,
                control: .managed(controller: controller),
                children: [
                  FResizableRegion(
                    initialExtent: 100,
                    minExtent: 50,
                    builder: (context, snapshot, child) => const Align(child: Text('A')),
                    child: Container(),
                  ),
                  FResizableRegion(
                    initialExtent: 100,
                    minExtent: 50,
                    builder: (context, snapshot, child) => const Align(child: Text('B')),
                    child: Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.drag(find.text('A'), const Offset(0, 10));
    await tester.pumpAndSettle();
  });
}
