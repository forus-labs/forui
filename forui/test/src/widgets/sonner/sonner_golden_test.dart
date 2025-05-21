import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget small(String text, [FSonnerAlignment alignment = FSonnerAlignment.bottomRight]) => Builder(
  builder:
      (context) => FButton(
        intrinsicWidth: true,
        onPress:
            () => showFToast(
              alignment: alignment,
              context: context,
              builder:
                  (_, _) => Container(
                    width: 250,
                    height: 143,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: Text(text),
                  ),
            ),
        child: Text(text),
      ),
);

Widget big(String text, [FSonnerAlignment alignment = FSonnerAlignment.bottomRight]) => Builder(
  builder:
      (context) => FButton(
        intrinsicWidth: true,
        onPress:
            () => showFToast(
              alignment: alignment,
              context: context,
              builder:
                  (_, _) => Container(
                    width: 312,
                    height: 201,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red,
                    ),
                    child: Text(text),
                  ),
            ),
        child: Text(text),
      ),
);

Widget closeable(String text, [FSonnerAlignment alignment = FSonnerAlignment.bottomRight]) => Builder(
  builder:
      (context) => FButton(
        intrinsicWidth: true,
        onPress:
            () => showFToast(
              alignment: alignment,
              context: context,
              builder:
                  (_, entry) => GestureDetector(
                    onTap: () => entry.dismiss(),
                    child: Container(
                      width: 312,
                      height: 201,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red,
                      ),
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
        child: FSonner(
          style: TestScaffold.blueScreen.sonnerStyle,
          child: Builder(
            builder:
                (context) => FButton(
                  style: TestScaffold.blueScreen.buttonStyles.primary,
                  onPress:
                      () => showFToast(
                        context: context,
                        builder:
                            (_, _) =>
                                Container(color: TestScaffold.blueScreen.colors.foreground, width: 100, height: 100),
                      ),
                  child: const Text('blue'),
                ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('blue'));
    await tester.pumpAndSettle();

    await expectBlueScreen(find.byType(TestScaffold));
  });

  for (final alignment in FSonnerAlignment.values) {
    group('collapsed - $alignment', () {
      testWidgets('simple', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FSonner(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/collapsed/simple-$alignment.png'));
      });

      testWidgets('big middle', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FSonner(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/collapsed/big-middle-$alignment.png'));
      });

      testWidgets('big front', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FSonner(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/collapsed/big-front-$alignment.png'));
      });
    });

    group('expanded - $alignment', () {
      testWidgets('simple', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FSonner(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/expanded/simple-$alignment.png'));
      });

      testWidgets('big middle', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FSonner(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/expanded/big-middle-$alignment.png'));
      });

      testWidgets('big front', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FSonner(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/expanded/big-front-$alignment.png'));
      });
    });
  }

  testWidgets('limit to max', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSonner(
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

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/limit.png'));
  });

  testWidgets('close', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSonner(
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

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/close.png'));
  });

  group('gestures', () {
    testWidgets('hover & press', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSonner(
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')])),
          ),
        ),
      );

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('3').last));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.text('3').last, kind: PointerDeviceKind.mouse);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/hover-press.png'));
    });

    testWidgets('press', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSonner(
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')])),
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
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/press-expands.png'));

      await tester.tap(find.text('3').last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/press-collapses.png'));
    });

    testWidgets('expand disabled - hover', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSonner(
            style: FThemes.zinc.light.sonnerStyle.copyWith(expandable: false),
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')])),
          ),
        ),
      );

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('3').last));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/expanded-disabled-hovered.png'));
    });

    testWidgets('expand disabled - pressed', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSonner(
            style: FThemes.zinc.light.sonnerStyle.copyWith(expandable: false),
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), big('3')])),
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sonner/expanded-disabled-pressed.png'));
    });
  });
}
