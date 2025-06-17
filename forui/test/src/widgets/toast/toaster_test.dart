import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget small(
  String text, [
  String? button,
  FToastAlignment alignment = FToastAlignment.bottomRight,
  Duration? duration = const Duration(seconds: 5),
]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () => showRawFToast(
      alignment: alignment,
      context: context,
      duration: duration,
      builder: (_, _) => Container(
        width: 250,
        height: 143,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.blue),
        child: Text(text),
      ),
    ),
    child: Text(button ?? text),
  ),
);

Widget button([
  FToastAlignment alignment = FToastAlignment.bottomRight,
  List<AxisDirection>? swipeToDismiss,
  Duration? duration = const Duration(seconds: 5),
]) => Builder(
  builder: (context) => FButton(
    intrinsicWidth: true,
    onPress: () {
      for (var i = 1; i <= 3; i++) {
        showRawFToast(
          alignment: alignment,
          swipeToDismiss: swipeToDismiss,
          context: context,
          duration: duration,
          builder: (_, _) => Container(
            width: 250,
            height: 143,
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8), color: Colors.blue),
            child: Text('$i'),
          ),
        );
      }
    },
    child: const Text('button'),
  ),
);

void main() {
  for (final behavior in FToasterExpandBehavior.values) {
    group('$behavior', () {
      testWidgets('auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));

        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.text('1'), findsOne);
      });

      testWidgets('does not auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: behavior),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [small('1', null, FToastAlignment.bottomRight, null)],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));

        await tester.pumpAndSettle(const Duration(seconds: 10));

        expect(find.text('1'), findsExactly(2));
      });

      testWidgets('hover stops auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1')]),
              ),
            ),
          ),
        );

        await tester.tap(find.text('1'));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsExactly(2));

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('1').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await tester.pumpAndSettle(const Duration(seconds: 10));

        expect(find.text('1'), findsExactly(2));
      });

      testWidgets('press stops auto-close', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FToaster(
              style: FThemes.zinc.light.toasterStyle.copyWith(expandBehavior: behavior),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), small('3')]),
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
        expect(find.text('3'), findsExactly(2));

        await tester.tap(find.text('3').last);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle(const Duration(seconds: 10));

        expect(find.text('1'), findsExactly(2));
        expect(find.text('2'), findsExactly(2));
        expect(find.text('3'), findsExactly(2));
      });
    });
  }

  testWidgets('hover over non-first toast prevents auto-dismiss', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FToaster(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [button()]),
          ),
        ),
      ),
    );

    await tester.tap(find.text('button'));
    await tester.pumpAndSettle();

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('3')));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await gesture.moveTo(tester.getCenter(find.text('2')));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('1'), findsOne);
    expect(find.text('2'), findsOne);
    expect(find.text('3'), findsOne);
  });

  group('swipe to dismiss', () {
    const offsets = [
      Offset(-200, 0), // left
      Offset(200, 0), // right
      Offset(0, -100), // up
      Offset(0, 100), // down
    ];

    for (final (direction, offset) in [
      (AxisDirection.left, const Offset(-200, 0)),
      (AxisDirection.right, const Offset(200, 0)),
      (AxisDirection.up, const Offset(0, -100)),
      (AxisDirection.down, const Offset(0, 100)),
    ]) {
      group('$direction', () {
        testWidgets('dismiss', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: FToaster(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      button(FToastAlignment.bottomCenter, [direction]),
                    ],
                  ),
                ),
              ),
            ),
          );

          await tester.tap(find.text('button'));
          await tester.pumpAndSettle();

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('3')));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
          await tester.pumpAndSettle();

          expect(find.text('1'), findsOne);
          expect(find.text('2'), findsNothing);
          expect(find.text('3'), findsOne);
        });

        testWidgets('same direction does not dismiss', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: FToaster(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      button(FToastAlignment.bottomCenter, [direction]),
                    ],
                  ),
                ),
              ),
            ),
          );

          await tester.tap(find.text('button'));
          await tester.pumpAndSettle();

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('3')));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await tester.timedDrag(find.text('2'), offset * 0.5, const Duration(seconds: 1));
          await tester.pumpAndSettle();

          expect(find.text('1'), findsOne);
          expect(find.text('2'), findsOne);
          expect(find.text('3'), findsOne);
        });

        testWidgets('disabled does not dismiss', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              child: FToaster(
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [button(FToastAlignment.bottomCenter, [])]),
                ),
              ),
            ),
          );

          await tester.tap(find.text('button'));
          await tester.pumpAndSettle();

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('3')));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
          await tester.pumpAndSettle();

          expect(find.text('1'), findsOne);
          expect(find.text('2'), findsOne);
          expect(find.text('3'), findsOne);
        });

        for (final offset in offsets.whereNot((o) => o == offset)) {
          testWidgets('$offset - different direction - does not dismiss', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                child: FToaster(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        button(FToastAlignment.bottomCenter, [direction]),
                      ],
                    ),
                  ),
                ),
              ),
            );

            await tester.tap(find.text('button'));
            await tester.pumpAndSettle();

            final gesture = await tester.createPointerGesture();
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.text('3')));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            await tester.timedDrag(find.text('2'), offset, const Duration(seconds: 1));
            await tester.pumpAndSettle();

            expect(find.text('1'), findsOne);
            expect(find.text('2'), findsOne);
            expect(find.text('3'), findsOne);
          });
        }
      });
    }
  });
}
