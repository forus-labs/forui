import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('blue screen', () {
    testWidgets('enabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FItem(
            style: TestScaffold.blueScreen.itemStyle,
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('Duobase (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FItem(
            style: TestScaffold.blueScreen.itemStyle,
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('Duobase (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FItem)));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FItem(
            style: TestScaffold.blueScreen.itemStyle,
            enabled: false,
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('Duobase (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('enabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FItem(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/enabled-${theme.name}.png'));
    });

    testWidgets('hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FItem(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FItem)));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/hovered-${theme.name}.png'));
    });

    testWidgets('pressed', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FItem(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await tester.longPress(find.byType(FItem));
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/pressed-${theme.name}.png'));

      await tester.pumpAndSettle();

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('RTL', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          textDirection: TextDirection.rtl,
          child: FItem(
            autofocus: true,
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/rtl-${theme.name}.png'));
    });

    testWidgets('focused', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FItem(
            autofocus: true,
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/focused-${theme.name}.png'));
    });

    testWidgets('disabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FItem(
            enabled: false,
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/disabled-${theme.name}.png'));
    });
  }

  testWidgets('does not hover', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(
          prefix: const Icon(FIcons.bluetooth),
          title: const Text('Bluetooth'),
          details: const Text('FL (5G)'),
          suffix: const Icon(FIcons.chevronRight),
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byType(FItem)));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/unhoverable.png'));
  });

  group('FItem', () {
    testWidgets('utilize all space', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 225),
            child: FItem(
              prefix: const Icon(FIcons.bluetooth),
              title: const Text('Bluetooth'),
              details: const Text('FL (5G)'),
              suffix: const Icon(FIcons.chevronRight),
              onPress: () {},
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/utilize-all-space.png'));
    });

    testWidgets('minimal', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItem(title: const Text('Bluetooth'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/minimal.png'));
    });

    testWidgets('no subtitle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItem(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/no-subtitle.png'));
    });

    testWidgets('no suffix icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItem(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            details: const Text('FL (5G)'),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/no-suffix.png'));
    });

    testWidgets('prioritize title', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const .all(8.0),
              child: FItem(
                prefix: const Icon(FIcons.bluetooth),
                title: const Text('L                               ong'),
                details: const Text('FL (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/prioritize-title.png'));
    });

    testWidgets('prioritize subtitle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const .all(8.0),
              child: FItem(
                prefix: const Icon(FIcons.bluetooth),
                title: const Text('Title'),
                subtitle: const Text('L                                     ong'),
                details: const Text('FL (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/prioritize-subtitle.png'));
    });

    testWidgets('prioritize details', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const .all(8.0),
              child: FItem(
                prefix: const Icon(FIcons.bluetooth),
                title: const Text('Title'),
                subtitle: const Text('L                                     ong'),
                details: const FSwitch(),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/item/prioritize-details.png'));
    });
  });

  group('FItem.raw', () {
    testWidgets('minimal', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItem.raw(child: const Text('Bluetooth'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/raw/minimal.png'));
    });

    testWidgets('all', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItem.raw(prefix: const Icon(FIcons.bluetooth), child: const Text('Bluetooth'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/raw/all.png'));
    });

    testWidgets('expanded child', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItem.raw(prefix: const Icon(FIcons.bluetooth), child: const FTextField()),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/raw/expanded.png'));
    });
  });
}
