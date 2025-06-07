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
        child: FBottomNavigationBar(
          children: [
            FBottomNavigationBarItem(
              icon: const Icon(FIcons.house),
              label: const Text('Home'),
              onStateChange: (v) => states = v,
              onHoverChange: (v) => hovered = v,
            ),
          ],
        ),
      ),
    );

    final gesture = await tester.createPointerGesture();
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('Home')));
    await tester.pumpAndSettle();

    expect(states, {WidgetState.hovered});
    expect(hovered, true);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(states, <WidgetState>{});
    expect(hovered, false);
  });
}
