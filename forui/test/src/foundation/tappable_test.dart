import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/tappable.dart';
import '../test_scaffold.dart';

void main() {
  late FocusNode focusNode;

  setUp(() => focusNode = FocusNode());

  tearDown(() => focusNode.dispose());

  group('FTappable', () {
    for (final enabled in [true, false]) {
      testWidgets('focused - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(
              focusNode: focusNode,
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(find.text((focused: true, hovered: false, pressed: false).toString()), findsOneWidget);
      });

      testWidgets('hovered - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(child: FTappable(builder: (_, value, _) => Text('$value'), onPress: enabled ? () {} : null)),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(AnimatedTappable)));
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: enabled, pressed: false).toString()), findsOneWidget);

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
      });

      testWidgets('press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;

        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );

        await tester.tap(find.byType(AnimatedTappable));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(pressCount, enabled ? 1 : 0);
        expect(longPressCount, 0);
      });

      testWidgets('long press - $enabled', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        await tester.longPress(find.byType(AnimatedTappable));
        expect(find.text((focused: false, hovered: false, pressed: enabled).toString()), findsOneWidget);

        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        expect(pressCount, 0);
        expect(longPressCount, enabled ? 1 : 0);
      });

      testWidgets('press and hold - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        final key = GlobalKey<AnimatedTappableState>();

        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(key: key, builder: (_, value, _) => Text('$value'), onPress: enabled ? () {} : null),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
        expect(key.currentState!.animation.value, 1);

        final gesture = await tester.press(find.byType(AnimatedTappable));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(find.text((focused: false, hovered: false, pressed: enabled).toString()), findsOneWidget);
        expect(key.currentState!.animation.value, enabled ? 0.97 : 1.0);

        await gesture.up();
        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
        expect(key.currentState!.animation.value, 1);
      });

      testWidgets('shortcut', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;

        await tester.pumpWidget(
          TestScaffold(
            child: FTappable(
              autofocus: true,
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();

        expect(pressCount, enabled ? 1 : 0);
        expect(longPressCount, 0);
      });
    }

    testWidgets('resets hover and touch states when enabled state changes', (tester) async {
      late StateSetter setState;
      VoidCallback? onPress = () {};

      await tester.pumpWidget(
        TestScaffold(
          child: StatefulBuilder(
            builder: (context, setter) {
              setState = setter;
              return FTappable(builder: (_, value, _) => Text('$value'), onPress: onPress);
            },
          ),
        ),
      );

      expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(tester.getCenter(find.byType(AnimatedTappable)));
      await tester.pumpAndSettle();
      expect(find.text((focused: false, hovered: true, pressed: false).toString()), findsOneWidget);

      setState(() => onPress = null);
      await tester.pumpAndSettle();
      expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
    });
  });

  group('FTappable.static', () {
    for (final enabled in [true, false]) {
      testWidgets('focused - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(
              focusNode: focusNode,
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () {} : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        focusNode.requestFocus();
        await tester.pumpAndSettle();
        expect(find.text((focused: true, hovered: false, pressed: false).toString()), findsOneWidget);
      });

      testWidgets('hovered - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(builder: (_, value, _) => Text('$value'), onPress: enabled ? () {} : null),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FTappable)));
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: enabled, pressed: false).toString()), findsOneWidget);

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
      });

      testWidgets('press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;

        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );

        await tester.tap(find.byType(FTappable));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(pressCount, enabled ? 1 : 0);
        expect(longPressCount, 0);
      });

      testWidgets('long press', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        await tester.longPress(find.byType(FTappable));
        expect(find.text((focused: false, hovered: false, pressed: enabled).toString()), findsOneWidget);

        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        expect(pressCount, 0);
        expect(longPressCount, enabled ? 1 : 0);
      });

      testWidgets('press and hold - ${enabled ? 'enabled' : 'disabled'}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(builder: (_, value, _) => Text('$value'), onPress: enabled ? () {} : null),
          ),
        );
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

        final gesture = await tester.press(find.byType(FTappable));
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        expect(find.text((focused: false, hovered: false, pressed: enabled).toString()), findsOneWidget);

        await gesture.up();
        await tester.pumpAndSettle();
        expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
      });

      testWidgets('shortcut', (tester) async {
        var pressCount = 0;
        var longPressCount = 0;

        await tester.pumpWidget(
          TestScaffold(
            child: FTappable.static(
              autofocus: true,
              builder: (_, value, _) => Text('$value'),
              onPress: enabled ? () => pressCount++ : null,
              onLongPress: enabled ? () => longPressCount++ : null,
            ),
          ),
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.enter);
        await tester.pumpAndSettle();

        expect(pressCount, enabled ? 1 : 0);
        expect(longPressCount, 0);
      });
    }

    testWidgets('resets hover and touch states when enabled state changes', (tester) async {
      late StateSetter setState;
      VoidCallback? onPress = () {};

      await tester.pumpWidget(
        TestScaffold(
          child: StatefulBuilder(
            builder: (context, setter) {
              setState = setter;
              return FTappable.static(builder: (_, value, _) => Text('$value'), onPress: onPress);
            },
          ),
        ),
      );

      expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await gesture.moveTo(tester.getCenter(find.byType(FTappable)));
      await tester.pumpAndSettle();
      expect(find.text((focused: false, hovered: true, pressed: false).toString()), findsOneWidget);

      setState(() => onPress = null);
      await tester.pumpAndSettle();
      expect(find.text((focused: false, hovered: false, pressed: false).toString()), findsOneWidget);
    });
  });
}
