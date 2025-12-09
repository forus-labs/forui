import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFTimeFieldController', (tester) async {
    late FTimeFieldController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFTimeFieldController();
            return FTimeField(control: .managed(controller: controller));
          },
        ),
      ),
    );

    unawaited(controller.popover.show());

    await tester.pumpAndSettle();
  });
}
