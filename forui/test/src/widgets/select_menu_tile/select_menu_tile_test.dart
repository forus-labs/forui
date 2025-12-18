import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const key = Key('key');

void main() {
  group('lifted', () {
    testWidgets('FSelectMenuTile', (tester) async {
      Set<int> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelectMenuTile<int>(
              selectControl: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              title: const Text('Title'),
              menu: const [
                .tile(title: Text('1'), value: 1),
                .tile(title: Text('2'), value: 2),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(value, {1});
    });

    testWidgets('FSelectMenuTile.builder', (tester) async {
      Set<int> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelectMenuTile<int>.builder(
              selectControl: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              title: const Text('Title'),
              count: 2,
              menuBuilder: (context, index) => .tile(title: Text('${index + 1}'), value: index + 1),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(value, {1});
    });

    testWidgets('FSelectMenuTile.fromMap', (tester) async {
      Set<int> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelectMenuTile<int>.fromMap(
              const {'1': 1, '2': 2},
              selectControl: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              title: const Text('Title'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(value, {1});
    });
  });

  testWidgets('managed onChange called', (tester) async {
    final controller = autoDispose(FMultiValueNotifier<int>());
    Set<int>? changedValue;

    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile<int>(
          selectControl: .managed(controller: controller, onChange: (value) => changedValue = value),
          title: const Text('Title'),
          menu: const [
            .tile(title: Text('1'), value: 1),
            .tile(title: Text('2'), value: 2),
          ],
        ),
      ),
    );

    controller.value = {1, 2};
    await tester.pump();

    expect(changedValue, {1, 2});
  });

  testWidgets('leaky inherited FItemData does not affect popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTileGroup(
          children: [
            FSelectMenuTile(
              key: key,
              prefix: const Icon(FIcons.calendar),
              label: const Text('Label'),
              description: const Text('Description'),
              title: const Text('Repeat'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('None'),
              menu: const [
                .tile(title: Text('Item 1'), value: 1),
                .tile(title: Text('Item 2'), value: 2),
              ],
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
  });

  testWidgets('tap on tile opens menu', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile(
          prefix: const Icon(FIcons.calendar),
          label: const Text('Label'),
          description: const Text('Description'),
          title: const Text('Repeat'),
          subtitle: const Text('Fee, Fo, Fum'),
          details: const Text('None'),
          menu: const [
            .tile(title: Text('Item 1'), value: 1),
            .tile(title: Text('Item 2'), value: 2),
          ],
        ),
      ),
    );

    expect(find.text('Item 1'), findsNothing);
    expect(find.text('Item 2'), findsNothing);

    await tester.tap(find.byType(FSelectMenuTile<int>));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);
  });

  testWidgets('selecting item in menu does not close it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile(
          autoHide: false,
          prefix: const Icon(FIcons.calendar),
          label: const Text('Label'),
          description: const Text('Description'),
          title: const Text('Repeat'),
          subtitle: const Text('Fee, Fo, Fum'),
          details: const Text('None'),
          menu: const [
            .tile(title: Text('Item 1'), value: 1),
            .tile(title: Text('Item 2'), value: 2),
          ],
        ),
      ),
    );
    await tester.tap(find.byType(FSelectMenuTile<int>));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);

    await tester.tap(find.text('Item 1'));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);
  });

  testWidgets('selecting item in menu closes it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelectMenuTile(
          prefix: const Icon(FIcons.calendar),
          label: const Text('Label'),
          description: const Text('Description'),
          title: const Text('Repeat'),
          subtitle: const Text('Fee, Fo, Fum'),
          details: const Text('None'),
          menu: const [
            .tile(title: Text('Item 1'), value: 1),
            .tile(title: Text('Item 2'), value: 2),
          ],
        ),
      ),
    );
    await tester.tap(find.byType(FSelectMenuTile<int>));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOne);
    expect(find.text('Item 2'), findsOne);

    await tester.tap(find.text('Item 1'));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsNothing);
    expect(find.text('Item 2'), findsNothing);
  });
}
