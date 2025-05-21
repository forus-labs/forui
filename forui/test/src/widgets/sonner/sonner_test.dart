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

void main() {
  testWidgets('auto-close', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSonner(
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), small('3')])),
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

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('1'), findsOne);
    expect(find.text('2'), findsOne);
    expect(find.text('3'), findsOne);
  });

  testWidgets('hover expand stops auto-close', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSonner(
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), small('3')])),
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

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('3').last));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(find.text('1'), findsExactly(2));
    expect(find.text('2'), findsExactly(2));
    expect(find.text('3'), findsExactly(2));
  });

  testWidgets('press expand stops auto-close', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSonner(
          child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [small('1'), small('2'), small('3')])),
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
}
