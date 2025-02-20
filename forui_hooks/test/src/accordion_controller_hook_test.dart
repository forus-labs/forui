import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFAccordionController', (tester) async {
    late FAccordionController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFAccordionController();
            return FAccordion(
              controller: controller,
              items: [
                FAccordionItem(title: const Text('Header 1'), child: const Text('Body 1')),
                FAccordionItem(title: const Text('Header 1'), child: const Text('Body 1')),
              ],
            );
          },
        ),
      ),
    );

    unawaited(controller.toggle(0));

    await tester.pumpAndSettle();
  });
}
