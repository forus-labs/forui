import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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
  late ScrollController scrollController;

  setUp(() {
    scrollController = ScrollController();
  });

  tearDown(() {
    scrollController.dispose();
  });

  for (final theme in TestScaffold.themes) {
    group('FSelectSection', () {
      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              children: [.section(label: const Text('Lorem'), items: letters)],
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
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              children: [
                .richSection(
                  label: const Text('Lorem'),
                  enabled: false,
                  children: [
                    const .item(title: Text('A'), value: 'A'),
                    const .item(title: Text('B'), value: 'B'),
                    const .item(title: Text('C'), value: 'C', enabled: true),
                  ],
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
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              children: [.section(label: const Text('Lorem'), items: letters)],
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
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              children: [
                .item(
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
            alignment: .topCenter,
            child: FSelect<String>(items: letters, key: key, contentScrollController: scrollController),
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
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              control: const .managed(initial: 'A'),
              children: [.item(title: Text(letters.keys.first), value: letters.keys.first, enabled: false)],
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
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              children: [.item(title: Text(letters.keys.first), value: letters.keys.first, enabled: false)],
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
            alignment: .topCenter,
            child: FSelect<String>(items: const {'A': 'A'}, key: key),
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
        debugDefaultTargetPlatformOverride = .iOS;

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: .topCenter,
            child: FSelect<String>(items: const {'A': 'A'}, key: key),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture(kind: .touch);
        await gesture.down(tester.getCenter(find.text('A')));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/press.png'));

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('raw', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: .topCenter,
            child: FSelect<String>.rich(
              key: key,
              format: (s) => s,
              children: [.raw(value: 'v', prefix: const Icon(FIcons.circle), child: const Text('Title'))],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/item/raw.png'));
      });
    });
  }
}
