import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/inkwell.dart';
import '../test_scaffold.dart';

void main() {
  group('FInkWell', () {
    testWidgets('focused', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FInkWell(
            focusNode: focusNode,
            builder: (_, value, __) => Text('$value'),
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
          child: FInkWell(
            builder: (_, value, __) => Text('$value'),
          ),
        ),
      );
      expect(find.text('false'), findsOneWidget);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FInkWell)));
      await tester.pumpAndSettle();

      expect(find.text('true'), findsOneWidget);

      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('semantics', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FInkWell(
            semanticLabel: 'My Label',
            selected: true,
            builder: (_, value, __) => Text('$value'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(FInkWell));
      expect(
        semantics,
        matchesSemantics(
          label: 'My Label',
          isButton: true,
          isSelected: true,
          isFocusable: true,
        ),
      );
    });
  });
}
