
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

Widget small(
  String text, [
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
    child: Text(text),
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
                  children: [small('1', FToastAlignment.bottomRight, null)],
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
}
