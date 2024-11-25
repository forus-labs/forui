import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFPopoverController', (tester) async {
    late FPopoverController controller;

    await tester.pumpWidget(
      HookBuilder(builder: (context) {
        controller = useFPopoverController();
        return Container();
      }),
    );

    unawaited(controller.show());

    await tester.pumpAndSettle();
  });

  testWidgets('switch from uncontrolled to controlled throws', (tester) async {
    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFPopoverController();
        return Container();
      },
    ));

    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFPopoverController(vsync: tester);
        return Container();
      },
    ));

    expect(tester.takeException(), isStateError);
  });

  testWidgets('switch from controlled to uncontrolled throws', (tester) async {
    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFPopoverController(vsync: tester);
        return Container();
      },
    ));

    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFPopoverController();
        return Container();
      },
    ));

    expect(tester.takeException(), isStateError);
  });
}