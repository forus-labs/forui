import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(title: const Text('Bluetooth'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.tap(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 1);
    expect(longPress, 0);
  });

  testWidgets('disabled press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          enabled: false,
          title: const Text('Bluetooth'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.tap(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(title: const Text('Lorem'), onPress: () => press++, onLongPress: () => longPress++),
      ),
    );

    await tester.longPress(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 1);
  });

  testWidgets('disabled long press', (tester) async {
    var press = 0;
    var longPress = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          enabled: false,
          title: const Text('Lorem'),
          onPress: () => press++,
          onLongPress: () => longPress++,
        ),
      ),
    );

    await tester.longPress(find.byType(FTile));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(press, 0);
    expect(longPress, 0);
  });

  testWidgets('child hit test', (tester) async {
    var count = 0;
    await tester.pumpWidget(
      TestScaffold(
        child: FTile(
          title: const Text('Bluetooth'),
          details: FButton(onPress: () => count++, child: const Text('child')),
        ),
      ),
    );

    await tester.tap(find.text('child'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(count, 1);
  });
}
