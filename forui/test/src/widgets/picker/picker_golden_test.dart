import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  late FPickerController controller;

  setUp(() => controller = FPickerController(indexes: [1, 5]));

  tearDown(() => controller.dispose());

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FPicker(
          // The default opacity messes up the coloring.
          style: TestScaffold.blueScreen.pickerStyle.copyWith(overAndUnderCenterOpacity: 1),
          children: [
            const FPickerWheel(flex: 3, loop: true, children: months),
            FPickerWheel.builder(flex: 3, builder: (context, index) => Text('Item $index')),
          ],
        ),
      ),
    );

    await expectBlueScreen();
  });

  group('lifted', () {
    testWidgets('animates programmatically changed value', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(400, 300)));

      await tester.pumpWidget(
        sheet.record(
          TestScaffold(
            child: StatefulBuilder(
              builder: (_, setState) => FPicker(
                control: .lifted(indexes: [1], onChange: (v) {}),
                children: const [FPickerWheel(flex: 3, children: months)],
              ),
            ),
          ),
        ),
      );

      var value = [8];

      await tester.pumpFrames(
        sheet.record(
          TestScaffold(
            child: StatefulBuilder(
              builder: (_, setState) => FPicker(
                control: .lifted(indexes: value, onChange: (v) => setState(() => value = v)),
                children: const [FPickerWheel(children: months)],
              ),
            ),
          ),
        ),
        const Duration(milliseconds: 300),
      );

      await expectLater(sheet.collate(5), matchesGoldenFile('picker/lifted-value-change-animation.png'));
    });

    testWidgets('animates drag back', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(300, 300)));

      final widget = sheet.record(
        TestScaffold(
          child: FPicker(
            control: .lifted(indexes: [1], onChange: (_) {}),
            children: const [FPickerWheel(flex: 3, children: months)],
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.drag(find.byType(FPicker), const Offset(0, -50));
      // This doesn't fully wait for animation to end but it's a good enough approximation.
      await tester.pumpFrames(widget, const Duration(milliseconds: 500));

      await expectLater(sheet.collate(5), matchesGoldenFile('picker/lifted-drag-back-animation.png'));
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} default', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FPicker(
            control: const .managed(initial: [1, 5]),
            children: [
              const FPickerWheel(flex: 3, loop: true, children: months),
              FPickerWheel.builder(builder: (context, index) => Text('Item $index')),
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
            control: const .managed(initial: [1, 5]),
            children: [
              const FPickerWheel(flex: 3, loop: true, children: months),
              const Text(':'),
              FPickerWheel.builder(builder: (context, index) => Text('Item $index')),
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
          child: const FPicker(
            control: .managed(initial: [1]),
            children: [FPickerWheel(flex: 3, children: months)],
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
            control: const .managed(initial: [1, 5]),
            children: [
              const FPickerWheel(autofocus: true, flex: 3, loop: true, children: months),
              const Text(':'),
              FPickerWheel.builder(builder: (context, index) => Text('Item $index')),
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
          control: .managed(controller: controller),
          children: [
            const FPickerWheel(flex: 3, key: key, children: months),
            const Text(':'),
            FPickerWheel.builder(builder: (context, index) => Text('Item $index')),
          ],
        ),
      ),
    );

    await tester.drag(find.byKey(key), const Offset(0, -100));
    await tester.pumpAndSettle();

    expect(controller.value, [5, 5]);
    await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/touch-dragged.png'));
  });

  testWidgets('desktop dragged', (tester) async {
    debugDefaultTargetPlatformOverride = .macOS;
    const key = ValueKey('1st');

    await tester.pumpWidget(
      TestScaffold(
        child: FPicker(
          control: .managed(controller: controller),
          children: [
            const FPickerWheel(flex: 3, key: key, children: months),
            const Text(':'),
            FPickerWheel.builder(builder: (context, index) => Text('Item $index')),
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
    debugDefaultTargetPlatformOverride = .macOS;
    const key = ValueKey('1st');

    await tester.pumpWidget(
      TestScaffold(
        child: FPicker(
          control: .managed(controller: controller),
          children: [
            const FPickerWheel(autofocus: true, flex: 3, key: key, children: months),
            const Text(':'),
            FPickerWheel.builder(builder: (context, index) => Text('Item $index')),
          ],
        ),
      ),
    );

    await tester.sendKeyEvent(.arrowDown);
    await tester.pumpAndSettle();

    expect(controller.value, [2, 5]);
    await expectLater(find.byType(TestScaffold), matchesGoldenFile('picker/arrow-key.png'));

    debugDefaultTargetPlatformOverride = null;
  });
}
