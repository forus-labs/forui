import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('onStateChange & onHoverChange callback called', (tester) async {
    Set<WidgetState>? states;
    bool? hovered;
    await tester.pumpWidget(
      TestScaffold(
        child: FButton(
          onStateChange: (v) => states = v,
          onHoverChange: (v) => hovered = v,
          onPress: () {},
          child: const Text('Button'),
        ),
      ),
    );

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('Button')));
    await tester.pumpAndSettle();

    expect(states, {WidgetState.hovered});
    expect(hovered, true);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(states, <WidgetState>{});
    expect(hovered, false);
  });
}
