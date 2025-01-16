import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFAccordionController', (tester) async {
    late FDatePickerController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFDatePickerController();
          return FDatePicker(
            controller: controller,
          );
        }),
      ),
    );

    unawaited(controller.calendar.show());

    await tester.pumpAndSettle();
  });
}
