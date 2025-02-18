import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFTimePickerController', (tester) async {
    late FTimePickerController controller;

    await tester.pumpWidget(
      HookBuilder(
        builder: (context) {
          controller = useFTimePickerController(initial: const FTime(12, 30));
          return Container();
        },
      ),
    );

    expect(controller.value, const FTime(12, 30));
  });
}
