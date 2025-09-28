import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(title: const Text('Bluetooth'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.tap(find.byType(FItem));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 1);
    expect(longPress, 0);
  });

  testWidgets('disabled press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(
          enabled: false,
          title: const Text('Bluetooth'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.tap(find.byType(FItem));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(title: const Text('Lorem'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.longPress(find.byType(FItem));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 1);
  });

  testWidgets('disabled long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(
          enabled: false,
          title: const Text('Lorem'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.longPress(find.byType(FItem));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('disabled when no press callbacks given', (tester) async {
    FWidgetStatesDelta? delta;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(title: const Text('item'), onStateChange: (s) => delta = s),
      ),
    );

    final gesture = await tester.createPointerGesture();

    await gesture.moveTo(tester.getCenter(find.byType(FItem)));
    await tester.pumpAndSettle();

    expect(delta, null);
  });

  testWidgets('enabled when secondary press given', (tester) async {
    FWidgetStatesDelta? delta;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(title: const Text('item'), onSecondaryPress: () {}, onStateChange: (s) => delta = s),
      ),
    );

    final gesture = await tester.createPointerGesture();

    await gesture.moveTo(tester.getCenter(find.byType(FItem)));
    await tester.pumpAndSettle();

    expect(delta, FWidgetStatesDelta({}, {WidgetState.hovered}));
  });

  testWidgets('enabled when secondary long press given', (tester) async {
    FWidgetStatesDelta? delta;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(title: const Text('item'), onSecondaryLongPress: () {}, onStateChange: (s) => delta = s),
      ),
    );

    final gesture = await tester.createPointerGesture();

    await gesture.moveTo(tester.getCenter(find.byType(FItem)));
    await tester.pumpAndSettle();

    expect(delta, FWidgetStatesDelta({}, {WidgetState.hovered}));
  });

  testWidgets('child hit test', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(
          title: const Text('Bluetooth'),
          details: FButton(onPress: () => count++, child: const Text('child')),
        ),
      ),
    );

    await tester.tap(find.text('child'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(count, 1);
  });

  testWidgets('focus does not cause inner gesture detector to be ignored', (tester) async {
    var outer = 0;
    var inner = 0;
    final focusNode = autoDispose(FocusNode());
    await tester.pumpWidget(
      TestScaffold(
        child: FItem(
          focusNode: focusNode,
          title: const Text('Bluetooth'),
          onPress: () => outer++,
          suffix: FButton.icon(onPress: () => inner++, child: const Icon(FIcons.pencil)),
        ),
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.byIcon(FIcons.pencil));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(inner, 1);
    expect(outer, 0);
  });
}
