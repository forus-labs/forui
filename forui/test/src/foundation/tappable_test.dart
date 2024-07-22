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
          data: FThemes.zinc.light,
          child: FTappable(
            focusNode: focusNode,
            builder: (_, value, __) => Text('${value.focused}'),
          ),
        ),
      );
      expect(find.text('false'), findsOneWidget);

      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FTappable(
            builder: (_, value, __) => Text('${value.hovered}'),
          ),
        ),
      );
      expect(find.text('false'), findsOneWidget);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FTappable)));
      await tester.pumpAndSettle();

      expect(find.text('true'), findsOneWidget);

      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('false'), findsOneWidget);
    });
  });
}
