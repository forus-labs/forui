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

  testWidgets('update widget', (tester) async {
    final controller = FSelectController<int>();

    var firstChanges = 0;
    var firstSelections = 0;
    (int, bool)? firsSelection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          controller: controller,
          onChange: (_) => firstChanges++,
          onSelect: (value) {
            firstSelections++;
            firsSelection = value;
          },
          items: const [FSelectGroupItem.checkbox(value: 1, label: Text('1'))],
        ),
      ),
    );

    await tester.tap(find.text('1'));

    expect(firstChanges, 1);
    expect(firstSelections, 1);
    expect(firsSelection, (1, true));

    var secondChanges = 0;
    var secondSelections = 0;
    (int, bool)? secondSelection;

    await tester.pumpWidget(
      TestScaffold(
        child: FSelectGroup<int>(
          controller: controller,
          onChange: (_) => secondChanges++,
          onSelect: (value) {
            secondSelections++;
            secondSelection = value;
          },
          items: const [FSelectGroupItem.checkbox(value: 1, label: Text('1'))],
        ),
      ),
    );

    await tester.tap(find.text('1'));

    expect(firstChanges, 1);
    expect(firstSelections, 1);
    expect(firsSelection, (1, true));

    expect(secondChanges, 1);
    expect(secondSelections, 1);
    expect(secondSelection, (1, false));
  });
}
