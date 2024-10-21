import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/inkwell.dart';
import '../test_scaffold.dart';

void main() {
  group('FInkWell', () {
    for (final enabled in [true, false]) {
      testWidgets('focused - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell(
              focusNode: focusNode,
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(find.text((focused: true, hovered: false).toString()), findsOneWidget);
      });

      testWidgets('hovered - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell(
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FInkWell)));
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: enabled).toString()), findsOneWidget);

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);
      });

      testWidgets('press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;

        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell(
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );

        await tester.tap(find.byType(FInkWell));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(pressCount, enabled ? 1 : 0);
        expect(longPressCount, 0);
      });

      testWidgets('long press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell(
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        await tester.longPress(find.byType(FInkWell));
        expect(find.text((focused: false, hovered: enabled).toString()), findsOneWidget);

        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        expect(pressCount, 0);
        expect(longPressCount, enabled ? 1 : 0);
      });
    }
  });

  group('AnimatedInkWell', () {
    for (final enabled in [true, false]) {
      testWidgets('focused - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        final focusNode = FocusNode();

        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell.animated(
              focusNode: focusNode,
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(find.text((focused: true, hovered: false).toString()), findsOneWidget);
      });

      testWidgets('hovered - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell.animated(
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(AnimatedInkWell)));
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: enabled).toString()), findsOneWidget);

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);
      });

      testWidgets('press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;

        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell.animated(
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );

        await tester.tap(find.byType(AnimatedInkWell));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(pressCount, enabled ? 1 : 0);
        expect(longPressCount, 0);
      });

      testWidgets('long press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell.animated(
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        await tester.longPress(find.byType(AnimatedInkWell));
        expect(find.text((focused: false, hovered: enabled).toString()), findsOneWidget);

        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

        expect(pressCount, 0);
        expect(longPressCount, enabled ? 1 : 0);
      });

      testWidgets('press and hold - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        final key = GlobalKey<AnimatedInkWellState>();

        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FInkWell.animated(
              key: key,
              builder: (_, value, __) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);
        expect(key.currentState!.animation.value, 1);

        final gesture = await tester.press(find.byType(AnimatedInkWell));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(find.text((focused: false, hovered: enabled).toString()), findsOneWidget);
        expect(key.currentState!.animation.value, enabled ? 0.97 : 1.0);

        await gesture.up();
        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);
        expect(key.currentState!.animation.value, 1);
      });
    }
  });
}
