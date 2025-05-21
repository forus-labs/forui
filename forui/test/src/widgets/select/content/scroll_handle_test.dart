import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
];

void main() {
  final localizations = FDefaultLocalizations();
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  group('ScrollHandle', () {
    testWidgets('hover scrolls up', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            controller: controller,
            contentScrollController: scrollController,
            contentScrollHandles: true,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(
        tester.getCenter(
          find.bySemanticsLabel(localizations.selectScrollUpSemanticsLabel),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(scrollController.offset, 0);
    });

    testWidgets('hover scrolls down', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            controller: controller,
            contentScrollController: scrollController,
            contentScrollHandles: true,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(
        tester.getCenter(
          find.bySemanticsLabel(localizations.selectScrollDownSemanticsLabel),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 10));

      expect(
        scrollController.offset,
        scrollController.position.maxScrollExtent,
      );
    });

    testWidgets('un-hover stops scroll', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            controller: controller,
            contentScrollController: scrollController,
            contentScrollHandles: true,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(
        tester.getCenter(
          find.bySemanticsLabel(localizations.selectScrollDownSemanticsLabel),
        ),
      );
      await tester.pump(
        const Duration(milliseconds: 200),
      ); // Initial enter delay.
      await tester.pump(const Duration(milliseconds: 500));

      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      expect(scrollController.offset, isNot(0));
      expect(
        scrollController.offset,
        isNot(scrollController.position.maxScrollExtent),
      );
    });

    testWidgets('press and un-press scrolls until the end on mobile', (
      tester,
    ) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            controller: controller,
            contentScrollController: scrollController,
            contentScrollHandles: true,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.press(
        find.bySemanticsLabel(localizations.selectScrollDownSemanticsLabel),
      );
      await tester.pump(
        const Duration(milliseconds: 200),
      ); // Initial enter delay.
      await tester.pump(const Duration(milliseconds: 500));

      expect(scrollController.offset, isNot(0));
      expect(
        scrollController.offset,
        isNot(scrollController.position.maxScrollExtent),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  });

  tearDown(() {
    scrollController.dispose();
    controller.dispose();
  });
}
