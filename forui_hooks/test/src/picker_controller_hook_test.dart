import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFPickerController', (tester) async {
    late FPickerController controller;

    await tester.pumpWidget(
      HookBuilder(builder: (context) {
        controller = useFPickerController(initialIndexes: [1, 2, 3]);
        return Container();
      }),
    );

    expect(controller.value, [1, 2, 3]);
  });
}
