import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('onStateChange & onHoverChange callback called', (tester) async {
    FWidgetStatesDelta? delta;
    bool? hovered;
    await tester.pumpWidget(
      TestScaffold(
        child: FHeader.nested(
          title: const Text('Title'),
          prefixes: [
            FHeaderAction.back(onHoverChange: (v) => hovered = v, onStateChange: (v) => delta = v, onPress: () {}),
          ],
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.byType(FHeaderAction)));
    await tester.pumpAndSettle();

    expect(delta, FWidgetStatesDelta({}, {WidgetState.hovered}));
    expect(hovered, true);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(delta, FWidgetStatesDelta({WidgetState.hovered}, {}));
    expect(hovered, false);
  });
}
