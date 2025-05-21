import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O'];

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  for (final theme in TestScaffold.themes) {
    group('FSelectSection', () {
      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem.text(letter)],
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/section/default.png'));
      });

      testWidgets('disabled section', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  enabled: false,
                  children: [FSelectItem.text('A'), FSelectItem.text('B'), FSelectItem.text('C', enabled: true)],
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/section/disabled.png'));
      });

      testWidgets('hover over title does nothing', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem.text(letter)],
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);

        await gesture.moveTo(tester.getCenter(find.text('Lorem')));
        await tester.pump();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/section/hovered.png'));
      });
    });

    group('FSelectItem - ${theme.name}', () {
      testWidgets('selects item & ensure visible', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              controller: controller,
              contentScrollController: scrollController,
              children: [for (final letter in letters) FSelectItem.text(letter)],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        await tester.pumpAndSettle();

        await tester.tap(find.text('O'));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/selects-item.png'));
      });

      testWidgets('does not select disabled item', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              controller: controller..value = 'A',
              children: [FSelectItem.text(letters.first, enabled: false)],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select/${theme.name}/item/disabled-selected-item.png'),
        );
      });

      testWidgets('disabled and selected item', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(key: key, children: [FSelectItem.text(letters.first, enabled: false)]),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await tester.tap(find.text('A'));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/disabled-item.png'));
      });

      testWidgets('hover effect', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(key: key, children: [FSelectItem.text(letters.first)]),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);

        await gesture.moveTo(tester.getCenter(find.text('A')));
        await tester.pump();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/hover.png'));
      });

      testWidgets('press effect on mobile', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(key: key, children: [FSelectItem.text(letters.first)]),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createGesture();
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);

        await gesture.down(tester.getCenter(find.text('A')));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/press.png'));

        debugDefaultTargetPlatformOverride = null;
      });
    });
  }

  tearDown(() {
    scrollController.dispose();
    controller.dispose();
  });
}
