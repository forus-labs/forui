import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFSelectController', (tester) async {
    late FMultiValueNotifier<int> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFMultiValueNotifier<int>();
            return FSelectGroup<int>(
              controller: controller,
              children: const [
                FSelectGroupItem.checkbox(value: 0, label: Text('0')),
                FSelectGroupItem.checkbox(value: 1, label: Text('1')),
              ],
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(FCheckbox).first);

    await tester.pumpAndSettle();
  });

  testWidgets('useFRadioSelectController', (tester) async {
    late FMultiValueNotifier<int> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            controller = useFRadioMultiValueNotifier<int>();
            return FSelectGroup<int>(
              controller: controller,
              children: const [
                FSelectGroupItem.radio(value: 0, label: Text('0')),
                FSelectGroupItem.radio(value: 1, label: Text('1')),
              ],
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(FRadio).first);

    await tester.pumpAndSettle();
  });
}
