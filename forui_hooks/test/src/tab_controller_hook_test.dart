// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

// Project imports:
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFTabController', (tester) async {
    late FTabController controller;

    await tester.pumpWidget(
      HookBuilder(builder: (context) {
        controller = useFTabController(length: 2);
        return Container();
      }),
    );

    controller.animateTo(1);

    await tester.pumpAndSettle();
  });

  testWidgets('switch from uncontrolled to controlled throws', (tester) async {
    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFTabController(length: 1);
        return Container();
      },
    ));

    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFTabController(vsync: tester, length: 1);
        return Container();
      },
    ));

    expect(tester.takeException(), isStateError);
  });

  testWidgets('switch from controlled to uncontrolled throws', (tester) async {
    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFTabController(vsync: tester, length: 1);
        return Container();
      },
    ));

    await tester.pumpWidget(HookBuilder(
      builder: (context) {
        useFTabController(length: 1);
        return Container();
      },
    ));

    expect(tester.takeException(), isStateError);
  });
}
