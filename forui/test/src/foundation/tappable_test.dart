import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import '../test_scaffold.dart';

void main() {
  group('FTappable', () {
    testWidgets('focused', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FTappable(
            focusNode: focusNode,
            builder: (_, value, __) => Text('$value'),
          ),
        ),
      );
      expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(find.text((focused: true, hovered: false).toString()), findsOneWidget);
    });

    testWidgets('hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FTappable(
            builder: (_, value, __) => Text('$value'),
          ),
        ),
      );
      expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FTappable)));
      await tester.pumpAndSettle();

      expect(find.text((focused: false, hovered: true).toString()), findsOneWidget);

      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);
    });

    testWidgets('long pressed', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FTappable(
            builder: (_, value, __) => Text('$value'),
          ),
        ),
      );
      expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);

      await tester.longPress(find.byType(FTappable));
      expect(find.text((focused: false, hovered: true).toString()), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text((focused: false, hovered: false).toString()), findsOneWidget);
    });
  });
}
