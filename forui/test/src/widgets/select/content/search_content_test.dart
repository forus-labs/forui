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

  group('SearchContent', () {
    testWidgets('didUpdateWidget does not dispose external controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.search(
            key: key,
            searchFieldProperties: FSelectSearchFieldProperties(controller: textController),
            filter: (_) => [],
            contentBuilder: (_, _) => [],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(textController.hasListeners, true);

      await tester.pumpWidget(
        TestScaffold.app(child: FSelect<String>.search(key: key, filter: (_) => [], contentBuilder: (_, _) => [])),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(textController.hasListeners, false);
      expect(textController.dispose, returnsNormally);
    });

    testWidgets('dispose() does not dispose external controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.search(
            key: key,
            searchFieldProperties: FSelectSearchFieldProperties(controller: textController),
            filter: (_) => [],
            contentBuilder: (_, _) => [],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(textController.hasListeners, true);

      await tester.pumpWidget(const SizedBox());

      expect(textController.hasListeners, false);
      expect(textController.dispose, returnsNormally);
    });

    testWidgets('keyboard navigation', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.search(
            key: key,
            controller: controller,
            searchFieldProperties: FSelectSearchFieldProperties(controller: textController),
            filter:
                (query) =>
                    query.isEmpty
                        ? fruits
                        : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase())),
            contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem.text(fruit)],
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
  });

  tearDown(() {
    controller.dispose();
  });
}
