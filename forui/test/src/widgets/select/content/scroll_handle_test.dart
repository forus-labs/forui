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
  final localizations = FDefaultLocalizations();
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  tearDown(() {
    scrollController.dispose();
    controller.dispose();
  });

  testWidgets('hover scrolls up', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FSelect<String>(
          items: letters,
          key: key,
          controller: controller,
          contentScrollController: scrollController,
          contentScrollHandles: true,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    await tester.pumpAndSettle();

    final gesture = await tester.createPointerGesture();

    await gesture.moveTo(tester.getCenter(find.bySemanticsLabel(localizations.selectScrollUpSemanticsLabel)));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(scrollController.offset, 0);
  });

  testWidgets('hover scrolls down', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FSelect<String>(
          items: letters,
          key: key,
          controller: controller,
          contentScrollController: scrollController,
          contentScrollHandles: true,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    final gesture = await tester.createPointerGesture();

    await gesture.moveTo(tester.getCenter(find.bySemanticsLabel(localizations.selectScrollDownSemanticsLabel)));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(scrollController.offset, scrollController.position.maxScrollExtent);
  });

  testWidgets('un-hover stops scroll', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FSelect<String>(
          items: letters,
          key: key,
          controller: controller,
          contentScrollController: scrollController,
          contentScrollHandles: true,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    final gesture = await tester.createPointerGesture();

    await gesture.moveTo(tester.getCenter(find.bySemanticsLabel(localizations.selectScrollDownSemanticsLabel)));
    await tester.pump(const Duration(milliseconds: 200)); // Initial enter delay.
    await tester.pump(const Duration(milliseconds: 500));

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    expect(scrollController.offset, isNot(0));
    expect(scrollController.offset, isNot(scrollController.position.maxScrollExtent));
  });

  testWidgets('press and un-press scrolls until the end on mobile', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FSelect<String>(
          items: letters,
          key: key,
          controller: controller,
          contentScrollController: scrollController,
          contentScrollHandles: true,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.press(find.bySemanticsLabel(localizations.selectScrollDownSemanticsLabel));
    await tester.pump(const Duration(milliseconds: 200)); // Initial enter delay.
    await tester.pump(const Duration(milliseconds: 500));

    expect(scrollController.offset, isNot(0));
    expect(scrollController.offset, isNot(scrollController.position.maxScrollExtent));

    debugDefaultTargetPlatformOverride = null;
  });
}
