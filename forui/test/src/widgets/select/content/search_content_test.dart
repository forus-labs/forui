// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const fruits = [
  'Apple',
  'Banana',
  'Blueberry',
  'Grapes',
  'Lemon',
  'Mango',
  'Kiwi',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Plum',
  'Raspberry',
  'Strawberry',
  'Watermelon',
];

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late TextEditingController textController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    textController = TextEditingController();
  });

  tearDown(() {
    controller.dispose();
  });

  testWidgets('keyboard navigation', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<String>.searchBuilder(
          control: .managed(controller: controller), key: key,
          format: (s) => s,
          searchFieldProperties: FSelectSearchFieldProperties(control: .managed(controller: textController)),
          filter: (query) =>
              query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase())),
          contentBuilder: (context, _, fruits) => [
            for (final fruit in fruits) FSelectItem(title: Text(fruit), value: fruit),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(FTextField).last, 'Ba');
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(controller.value, 'Banana');
  });

  group('search field control', () {
    group('lifted', () {
      testWidgets('value updates filter', (tester) async {
        var value = TextEditingValue.empty;

        await tester.pumpWidget(
          TestScaffold.app(
            child: StatefulBuilder(
              builder: (context, setState) => FSelect<String>.search(
                key: key,
                searchFieldProperties: FSelectSearchFieldProperties(
                  control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
                ),
                filter: (query) =>
                    query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase())),
                items: {for (final fruit in fruits) fruit: fruit},
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(FTextField).last, 'Ba');
        await tester.pumpAndSettle();

        expect(value.text, 'Ba');
        expect(find.text('Banana'), findsOneWidget);
        expect(find.text('Apple'), findsNothing);
      });

      testWidgets('showing popover does not cause error', (tester) async {
        var value = TextEditingValue.empty;

        await tester.pumpWidget(
          TestScaffold.app(
            child: StatefulBuilder(
              builder: (context, setState) => FSelect<String>.search(
                key: key,
                searchFieldProperties: FSelectSearchFieldProperties(
                  control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
                ),
                filter: (query) => fruits,
                items: {for (final fruit in fruits) fruit: fruit},
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        expect(tester.takeException(), null);
      });
    });

    group('managed', () {
      testWidgets('onChange callback called', (tester) async {
        TextEditingValue? changedValue;

        await tester.pumpWidget(
          TestScaffold.app(
            child: FSelect<String>.search(
              key: key,
              searchFieldProperties: FSelectSearchFieldProperties(
                onChange: (v) => changedValue = v,
              ),
              filter: (query) => fruits,
              items: {for (final fruit in fruits) fruit: fruit},
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(FTextField).last, 'test');
        await tester.pumpAndSettle();

        expect(changedValue?.text, 'test');
      });
    });
  });
}
