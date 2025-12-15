import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFSelectController', (tester) async {
    late FSelectController<String> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFSelectController();
            return FSelect.rich(
              control: .managed(controller: controller),
              format: (s) => s,
              children: const [],
            );
          },
        ),
      ),
    );

    expect(controller.value, null);
  });

  testWidgets('useFMultiValueNotifier', (tester) async {
    late FMultiValueNotifier<String> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFMultiValueNotifier();
            return FMultiSelect.rich(
              control: .managed(controller: controller),
              format: (v) => const SizedBox(),
              children: const [],
            );
          },
        ),
      ),
    );

    expect(controller.value, <String>{});
  });
}
