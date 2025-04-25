import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('onChange & onHoverChange callback called', (tester) async {
    Set<WidgetState>? states;
    bool? hovered;
    await tester.pumpWidget(
      TestScaffold(
        child: FHeader.nested(
          title: const Text('Title'),
          prefixes: [
            FHeaderAction.back(onHoverChange: (v) => hovered = v, onChange: (v) => states = v, onPress: () {}),
          ],
        ),
      ),
    );

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byType(FHeaderAction)));
    await tester.pumpAndSettle();

    expect(states, {WidgetState.hovered});
    expect(hovered, true);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(states, <WidgetState>{});
    expect(hovered, false);
  });
}
