// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

// Project imports:
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFRadioSelectGroupController', (tester) async {
    late FRadioSelectGroupController<int> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFRadioSelectGroupController();
          return FSelectGroup(
            controller: controller,
            items: const [
              FSelectGroupItem.radio(value: 0, label: Text('0')),
              FSelectGroupItem.radio(value: 1, label: Text('1')),
            ],
          );
        }),
      ),
    );

    await tester.tap(find.byType(FRadio).first);

    await tester.pumpAndSettle();
  });

  testWidgets('useFMultiSelectGroupController', (tester) async {
    late FMultiSelectGroupController<int> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFMultiSelectGroupController();
          return FSelectGroup(
            controller: controller,
            items: const [
              FSelectGroupItem.checkbox(value: 0, label: Text('0')),
              FSelectGroupItem.checkbox(value: 1, label: Text('1')),
            ],
          );
        }),
      ),
    );

    await tester.tap(find.byType(FCheckbox).first);

    await tester.pumpAndSettle();
  });
}
