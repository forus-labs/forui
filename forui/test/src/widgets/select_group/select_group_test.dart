import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  testWidgets('callbacks called', (tester) async {
    var changes = 0;
    var selections = 0;
    (int, bool)? selection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          controller: FSelectController(),
          onChange: (_) => changes++,
          onSelect: (value) {
            selections++;
            selection = value;
          },
          items: const [
            FSelectGroupItem.radio(value: 1, label: Text('1')),
            FSelectGroupItem.radio(value: 2, label: Text('2')),
            FSelectGroupItem.radio(value: 3, label: Text('3')),
          ],
        ),
      ),
    );

    await tester.tap(find.text('2'));

    expect(changes, 1);
    expect(selections, 1);
    expect(selection, (2, true));
  });
}
