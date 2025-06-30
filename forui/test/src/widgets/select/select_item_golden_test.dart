import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

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
    scrollController.dispose();
    controller.dispose();
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
              format: (s) => s,
              children: [FSelectSection.fromMap(label: const Text('Lorem'), items: letters)],
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
              format: (s) => s,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  enabled: false,
                  children: [FSelectItem('A', 'A'), FSelectItem('B', 'B'), FSelectItem('C', 'C', enabled: true)],
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
              format: (s) => s,
              children: [FSelectSection.fromMap(label: const Text('Lorem'), items: letters)],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();

        await gesture.moveTo(tester.getCenter(find.text('Lorem')));
        await tester.pump();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/section/hovered.png'));
      });
    });

    group('FSelectItem - ${theme.name}', () {
      testWidgets('has everything', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              format: (s) => s,
              children: [
                FSelectItem.from(
                  value: 'v',
                  prefix: const Icon(FIcons.circle),
                  title: const Text('Title'),
                  subtitle: const Text('subtitle'),
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/everything.png'));
      });

      testWidgets('selects item & ensure visible', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>.fromMap(
              letters,
              key: key,
              controller: controller,
              contentScrollController: scrollController,
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
              format: (s) => s,
              controller: controller..value = 'A',
              children: [FSelectItem(letters.keys.first, letters.keys.first, enabled: false)],
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
            child: FSelect<String>(
              key: key,
              format: (s) => s,
              children: [FSelectItem(letters.keys.first, letters.keys.first, enabled: false)],
            ),
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
            child: FSelect<String>.fromMap(const {'A': 'A'}, key: key),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();

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
            child: FSelect<String>.fromMap(const {'A': 'A'}, key: key),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture(kind: PointerDeviceKind.touch);
        await gesture.down(tester.getCenter(find.text('A')));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/press.png'));

        debugDefaultTargetPlatformOverride = null;
      });
    });
  }
}
