import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker_wheel.dart';
import '../../test_scaffold.dart';

void main() {
  late FTimePickerController controller;

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FTimePicker(
          // The default opacity messes up the coloring.
          style: TestScaffold.blueScreen.timePickerStyle.copyWith(overAndUnderCenterOpacity: 1),
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    for (final (name, locale, hour24, hourInterval, minuteInterval, file) in [
      // Inter doesn't support most non-western digit languages.
      ('Eastern 12-hour', const Locale('ar'), false, 1, 1, 'eastern-12.png'),
      ('Eastern 24-hour', const Locale('ar'), true, 1, 1, 'eastern-24.png'),
      ('Eastern 12-hour interval', const Locale('ar'), false, 2, 5, 'eastern-12-interval.png'),
      ('Eastern 24-hour interval', const Locale('ar'), true, 2, 5, 'eastern-24-interval.png'),
      //
      ('Western 12-hour single digit', const Locale('en'), false, 1, 1, 'western-12-single-digit.png'),
      // AM/PM is not rendered, this is expected.
      ('Western 12-hour single digit', const Locale('zh', 'HK'), false, 1, 1, 'western-period-first.png'),
      ('Western 24-hour single digit', const Locale('en'), true, 1, 1, 'western-24-single-digit.png'),
      //
      ('Western 24-hour double digit', const Locale('hr'), true, 1, 1, 'western-24-double-digit.png'),
      //
      ('Western 12-hour interval', const Locale('en'), false, 2, 5, 'western-12-interval.png'),
      ('Western 24-hour interval', const Locale('en'), true, 2, 5, 'western-24-interval.png'),
    ]) {
      testWidgets('${theme.name} $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            locale: locale,
            child: SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(
                control: const .managed(initial: FTime(10, 30)),
                hour24: hour24,
                hourInterval: hourInterval,
                minuteInterval: minuteInterval,
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-picker/${theme.name}/$file'));
      });
    }
  }

  group('lifted', () {
    testWidgets('programmatically changed value', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(300, 300)));
      FTime value = const FTime(10, 30);

      await tester.pumpWidget(
        sheet.record(
          TestScaffold.app(
            locale: const Locale('en'),
            child: StatefulBuilder(
              builder: (_, setState) => SizedBox(
                width: 300,
                height: 300,
                child: FTimePicker(
                  control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
                ),
              ),
            ),
          ),
        ),
      );

      value = const FTime(14, 45);

      await tester.pumpFrames(
        sheet.record(
          TestScaffold.app(
            locale: const Locale('en'),
            child: StatefulBuilder(
              builder: (_, setState) => SizedBox(
                width: 300,
                height: 300,
                child: FTimePicker(
                  control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
                ),
              ),
            ),
          ),
        ),
        const Duration(milliseconds: 300),
      );

      await expectLater(sheet.collate(5), matchesGoldenFile('time-picker/lifted-value-change.png'));
    });

    testWidgets('drag back', (tester) async {
      final sheet = autoDispose(AnimationSheetBuilder(frameSize: const Size(300, 300)));

      final widget = sheet.record(
        TestScaffold.app(
          locale: const Locale('en'),
          child: SizedBox(
            width: 300,
            height: 300,
            child: FTimePicker(
              control: .lifted(time: const FTime(10, 30), onChange: (_) {}),
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.drag(find.byType(BuilderWheel).first, const Offset(0, -50));
      // This doesn't fully wait for animation to end but it's a good enough approximation.
      await tester.pumpFrames(widget, const Duration(milliseconds: 500));

      await expectLater(sheet.collate(5), matchesGoldenFile('time-picker/lifted-drag-back.png'));
    });

    testWidgets('change hour24 format', (tester) async {
      var value = const FTime(14, 30); // 2:30 PM

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (_, setState) => SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(
                control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
              ),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (_, setState) => SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(
                control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
                hour24: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(BuilderWheel).first, const Offset(0, -50));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-picker/lifted-hour24.png'));
    });

    testWidgets('change locale', (tester) async {
      var value = const FTime(22, 30); // 10:30 PM

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          child: StatefulBuilder(
            builder: (_, setState) => SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(
                control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
              ),
            ),
          ),
        ),
      );

      // Change to Korean locale (period-first format)
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('ko'),
          child: StatefulBuilder(
            builder: (_, setState) => SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(
                control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(BuilderWheel).first, const Offset(0, -50));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-picker/lifted-change-locale.png'));
    });
  });

  group('boundary', () {
    // We cannot use the time directly adjacent to the boundary. The simulated drag occurs too quickly and doesn't
    // emit a scroll notification that crosses said boundary.
    for (final locale in [const Locale('ar'), const Locale('en')]) {
      testWidgets('11am to 12pm - $locale', (tester) async {
        controller = autoDispose(FTimePickerController(time: const FTime(10)));

        await tester.pumpWidget(
          TestScaffold.app(
            locale: locale,
            child: SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(control: .managed(controller: controller)),
            ),
          ),
        );

        await tester.drag(find.byType(BuilderWheel).first, const Offset(0, -50));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('time-picker/boundary/${locale.toLanguageTag()}-11am-12pm.png'),
        );

        expect(controller.value, const FTime(12));
      });

      testWidgets('11pm to 12am - $locale', (tester) async {
        controller = autoDispose(FTimePickerController(time: const FTime(22)));

        await tester.pumpWidget(
          TestScaffold.app(
            locale: locale,
            child: SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(control: .managed(controller: controller)),
            ),
          ),
        );

        await tester.drag(find.byType(BuilderWheel).first, const Offset(0, -50));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('time-picker/boundary/${locale.toLanguageTag()}-11pm-12am.png'),
        );

        expect(controller.value, const FTime());
      });

      testWidgets('12pm to 11am - $locale', (tester) async {
        controller = autoDispose(FTimePickerController(time: const FTime(13)));

        await tester.pumpWidget(
          TestScaffold.app(
            locale: locale,
            child: SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(control: .managed(controller: controller)),
            ),
          ),
        );

        await tester.drag(find.byType(BuilderWheel).first, const Offset(0, 50));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('time-picker/boundary/${locale.toLanguageTag()}-12pm-11am.png'),
        );

        expect(controller.value, const FTime(11));
      });

      testWidgets('12am to 11pm - $locale', (tester) async {
        controller = autoDispose(FTimePickerController(time: const FTime(1)));

        await tester.pumpWidget(
          TestScaffold.app(
            locale: locale,
            child: SizedBox(
              width: 300,
              height: 300,
              child: FTimePicker(control: .managed(controller: controller)),
            ),
          ),
        );

        await tester.drag(find.byType(BuilderWheel).first, const Offset(0, 50));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('time-picker/boundary/${locale.toLanguageTag()}-12am-11pm.png'),
        );

        expect(controller.value, const FTime(23));
      });
    }
  });
}
