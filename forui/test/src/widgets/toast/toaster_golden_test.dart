import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget small(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, _) => Container(
        width: 250,
        height: 143,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.blue),
        child: Text(text),
      ),
    ),
    child: Text(text),
  ),
);

Widget big(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, _) => Container(
        width: 312,
        height: 201,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.red),
        child: Text(text),
      ),
    ),
    child: Text(text),
  ),
);

Widget closeable(String text, [FToastAlignment alignment = FToastAlignment.bottomRight]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      builder: (_, entry) => GestureDetector(
        onTap: () => entry.dismiss(),
        child: Container(
          width: 312,
          height: 201,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.red),
          child: const Text('close'),
        ),
      ),
    ),
    child: Text(text),
  ),
);

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FToaster(
          style: TestScaffold.blueScreen.toasterStyle,
          child: Builder(
            builder: (context) => FButton(
              style: TestScaffold.blueScreen.buttonStyles.primary,
              onPress: () => showRawFToast(
                context: context,
                builder: (_, _) => Container(color: TestScaffold.blueScreen.colors.foreground, width: 100, height: 100),
              ),
              child: const Text('blue'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('blue'));
    await tester.pumpAndSettle();

    await expectBlueScreen();
  });

  for (final alignment in FToastAlignment.values) {
    group('collapsed - $alignment', () {
      testWidgets('simple', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', alignment), small('2', alignment), small('3', alignment)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/collapsed/simple-$alignment.png'));
      });

      testWidgets('big middle', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', alignment), big('2', alignment), small('3', alignment)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/collapsed/big-middle-$alignment.png'));
      });

      testWidgets('big front', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', alignment), small('2', alignment), big('3', alignment)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/collapsed/big-front-$alignment.png'));
      });
    });

    group('expanded - $alignment', () {
      testWidgets('simple', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', alignment), small('2', alignment), small('3', alignment)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/expanded/simple-$alignment.png'));
      });

      testWidgets('big middle', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', alignment), big('2', alignment), small('3', alignment)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/expanded/big-middle-$alignment.png'));
      });

      testWidgets('big front', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', alignment), small('2', alignment), big('3', alignment)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/expanded/big-front-$alignment.png'));
      });
    });
  }

  testWidgets('limit to max', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FToaster(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3'), small('4')]),
          ),
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('4'));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/limit.png'));
  });

  testWidgets('close', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FToaster(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), closeable('3')]),
          ),
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsExactly(2));
    expect(find.text('2'), findsExactly(2));
    expect(find.text('close'), findsOne);

    await tester.tap(find.text('close'));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/close.png'));
  });

  group('gestures', () {
    group('always', () {
      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: FToasterExpandBehavior.always),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/always.png'));
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: FToasterExpandBehavior.always),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('3').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/always-hovered.png'));
      });

      testWidgets('pressed', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: FToasterExpandBehavior.disabled),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/always-pressed.png'));
      });
    });

    group('hover or press', () {
      testWidgets('hover & press', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('3').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await tester.tap(find.text('3').last, kind: PointerDeviceKind.mouse);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/hover-press.png'));
      });

      testWidgets('press', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/press-expands.png'));

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/press-collapses.png'));
      });
    });

    group('disabled', () {
      testWidgets('expand disabled - hover', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: FToasterExpandBehavior.disabled),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('3').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/disabled-hovered.png'));
      });

      testWidgets('expand disabled - pressed', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: FToasterExpandBehavior.disabled),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('2'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('toast/disabled-pressed.png'));
      });
    });
  });
}
