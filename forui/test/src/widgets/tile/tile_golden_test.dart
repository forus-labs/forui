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
          child: FTile(
            style: TestScaffold.blueScreen.tileStyle,
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
          child: FTile(
            style: TestScaffold.blueScreen.tileStyle,
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

      await gesture.moveTo(tester.getCenter(find.byType(FTile)));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FTile(
            style: TestScaffold.blueScreen.tileStyle,
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
          child: FTile(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/enabled-${theme.name}.png'));
    });

    testWidgets('hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTile(
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

      await gesture.moveTo(tester.getCenter(find.byType(FTile)));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/hovered-${theme.name}.png'));
    });

    testWidgets('pressed', (tester) async {
      debugDefaultTargetPlatformOverride = .iOS;

      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTile(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Lorem'),
            subtitle: const Text('Fee, Fo'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );

      await tester.longPress(find.byType(FTile));
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/pressed-${theme.name}.png'));

      await tester.pumpAndSettle();

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('RTL', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          textDirection: .rtl,
          child: FTile(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/rtl-${theme.name}.png'));
    });

    testWidgets('focused', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTile(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/focused-${theme.name}.png'));
    });

    testWidgets('disabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTile(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/disabled-${theme.name}.png'));
    });
  }

  testWidgets('does not hover', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          prefix: const Icon(FIcons.bluetooth),
          title: const Text('Bluetooth'),
          details: const Text('FL (5G)'),
          suffix: const Icon(FIcons.chevronRight),
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byType(FTile)));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/unhoverable.png'));
  });

  group('FTile', () {
    testWidgets('utilize all space', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 225),
            child: FTile(
              prefix: const Icon(FIcons.bluetooth),
              title: const Text('Bluetooth'),
              details: const Text('FL (5G)'),
              suffix: const Icon(FIcons.chevronRight),
              onPress: () {},
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/utilize-all-space.png'));
    });

    testWidgets('minimal', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTile(title: const Text('Bluetooth'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/minimal.png'));
    });

    testWidgets('no subtitle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTile(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            details: const Text('FL (5G)'),
            suffix: const Icon(FIcons.chevronRight),
            onPress: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/no-subtitle.png'));
    });

    testWidgets('no suffix icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTile(
            prefix: const Icon(FIcons.bluetooth),
            title: const Text('Bluetooth'),
            details: const Text('FL (5G)'),
            onPress: () {},
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/no-suffix.png'));
    });

    testWidgets('prioritize title', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const .all(8.0),
              child: FTile(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/prioritize-title.png'));
    });

    testWidgets('prioritize subtitle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const .all(8.0),
              child: FTile(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/prioritize-subtitle.png'));
    });

    testWidgets('prioritize details', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const .all(8.0),
              child: FTile(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/tile/prioritize-details.png'));
    });
  });

  group('FTile.raw', () {
    testWidgets('minimal', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTile.raw(child: const Text('Bluetooth'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/raw/minimal.png'));
    });

    testWidgets('all', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTile.raw(prefix: const Icon(FIcons.bluetooth), child: const Text('Bluetooth'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/raw/all.png'));
    });

    testWidgets('expanded child', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTile.raw(prefix: const Icon(FIcons.bluetooth), child: const FTextField()),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/raw/expanded.png'));
    });
  });
}
