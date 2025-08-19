// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  tearDown(() {
    controller.dispose();
  });

  testWidgets('focus changes when pressed on mobile', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FSelect<String>(key: key, items: letters),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
    
    expect(Focus.of(tester.element(find.text('A'))).hasFocus, true);

    await tester.press(find.text('C'));
    await tester.pumpAndSettle();

    expect(Focus.of(tester.element(find.text('A'))).hasFocus, false);
    expect(Focus.of(tester.element(find.text('C'))).hasFocus, true);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('scrolls to item at the end of very long list', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<int>(
          items: {for (var i = 0; i < 20; i++) i.toString(): i},
          key: key,
          contentScrollController: scrollController,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    await tester.pumpAndSettle();

    await tester.tap(find.text('19'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(find.text('19'), findsNWidgets(2));
  });

  testWidgets('didUpdateWidget does not dispose external controller', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<String>(items: letters, key: key, contentScrollController: scrollController),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(scrollController.hasListeners, true);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<String>(items: letters, key: key),
      ),
    );

    expect(scrollController.dispose, returnsNormally);
  });

  testWidgets('dispose() does not dispose external controller', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<String>(items: letters, key: key, contentScrollController: scrollController),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(scrollController.hasListeners, true);

    await tester.pumpWidget(const SizedBox());

    expect(scrollController.hasListeners, false);
    expect(scrollController.dispose, returnsNormally);
  });
}
