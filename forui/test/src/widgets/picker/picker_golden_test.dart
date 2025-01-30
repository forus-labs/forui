@Tags(['golden'])
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

const months = [
  Text('January'),
  Text('February'),
  Text('March'),
  Text('April'),
  Text('May'),
  Text('June'),
  Text('July'),
  Text('August'),
  Text('September'),
  Text('October'),
  Text('November'),
  Text('December'),
];

void main() {
  group('FPicker', () {
    late FPickerController controller;

    setUp(() => controller = FPickerController(initialIndexes: [1, 5]));

    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FPicker(
            // The default opacity messes up the coloring.
            style: TestScaffold.blueScreen.pickerStyle.copyWith(overAndUnderCenterOpacity: 1),
            children: [
              const FPickerWheel(
                flex: 3,
                loop: true,
                children: months,
              ),
              FPickerWheel.builder(
                flex: 3,
                builder: (context, index) => Text('Item $index'),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} default', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPicker(
              controller: controller,
              children: [
                const FPickerWheel(
                  flex: 3,
                  loop: true,
                  children: months,
                ),
                FPickerWheel.builder(
                  builder: (context, index) => Text('Item $index'),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/${theme.name}/default.png'));
      });

      testWidgets('${theme.name} with separator', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPicker(
              controller: controller,
              children: [
                const FPickerWheel(
                  flex: 3,
                  loop: true,
                  children: months,
                ),
                const Text(':'),
                FPickerWheel.builder(
                  builder: (context, index) => Text('Item $index'),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/${theme.name}/with-separator.png'));
      });

      testWidgets('${theme.name} non-looping', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPicker(
              controller: controller,
              children: const [
                FPickerWheel(
                  flex: 3,
                  children: months,
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/${theme.name}/non-looping.png'));
      });

      testWidgets('${theme.name} focused', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPicker(
              controller: controller,
              children: [
                const FPickerWheel(
                  autofocus: true,
                  flex: 3,
                  loop: true,
                  children: months,
                ),
                const Text(':'),
                FPickerWheel.builder(
                  builder: (context, index) => Text('Item $index'),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/${theme.name}/focused.png'));
      });
    }

    testWidgets('touch dragged', (tester) async {
      const key = ValueKey('1st');

      await tester.pumpWidget(
        TestScaffold(
          child: FPicker(
            controller: controller,
            children: [
              const FPickerWheel(
                flex: 3,
                key: key,
                children: months,
              ),
              const Text(':'),
              FPickerWheel.builder(
                builder: (context, index) => Text('Item $index'),
              ),
            ],
          ),
        ),
      );

      await tester.drag(find.byKey(key), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(controller.value, [4, 5]);
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/touch-dragged.png'));
    });

    testWidgets('desktop dragged', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      const key = ValueKey('1st');

      await tester.pumpWidget(
        TestScaffold(
          child: FPicker(
            controller: controller,
            children: [
              const FPickerWheel(
                flex: 3,
                key: key,
                children: months,
              ),
              const Text(':'),
              FPickerWheel.builder(
                builder: (context, index) => Text('Item $index'),
              ),
            ],
          ),
        ),
      );

      await tester.drag(find.byKey(key), const Offset(0, -100));
      await tester.pumpAndSettle();

      expect(controller.value, [4, 5]);
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/desktop-dragged.png'));

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('arrow key', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      const key = ValueKey('1st');

      await tester.pumpWidget(
        TestScaffold(
          child: FPicker(
            controller: controller,
            children: [
              const FPickerWheel(
                autofocus: true,
                flex: 3,
                key: key,
                children: months,
              ),
              const Text(':'),
              FPickerWheel.builder(
                builder: (context, index) => Text('Item $index'),
              ),
            ],
          ),
        ),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();

      expect(controller.value, [2, 5]);
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/arrow-key.png'));

      debugDefaultTargetPlatformOverride = null;
    });

    tearDown(() => controller.dispose());
  });
}
