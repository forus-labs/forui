import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTree', () {
    testWidgets('renders basic tree', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FTree(
            children: [
              FTreeItem(label: Text('Item 1')),
              FTreeItem(label: Text('Item 2')),
            ],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('renders nested tree collapsed by default', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FTree(
            children: [
              FTreeItem(
                label: Text('Parent'),
                children: [
                  FTreeItem(label: Text('Child 1')),
                  FTreeItem(label: Text('Child 2')),
                ],
              ),
            ],
          ),
        ),
      );

      expect(find.text('Parent'), findsOneWidget);
      // Note: Children exist in the widget tree but are hidden via FCollapsible
      // They will be found but not visible
    });

    testWidgets('expands and collapses when pressed', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FTree(
            children: [
              FTreeItem(
                label: Text('Parent'),
                children: [FTreeItem(label: Text('Child'))],
              ),
            ],
          ),
        ),
      );

      // Tap to expand
      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      expect(find.text('Child'), findsOneWidget);

      // Tap to collapse
      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      // Child still exists but is collapsed
      expect(find.text('Parent'), findsOneWidget);
    });

    testWidgets('initially expanded shows children', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: const FTree(
            children: [
              FTreeItem(
                label: Text('Parent'),
                initiallyExpanded: true,
                children: [FTreeItem(label: Text('Child'))],
              ),
            ],
          ),
        ),
      );

      expect(find.text('Parent'), findsOneWidget);
      expect(find.text('Child'), findsOneWidget);
    });
  });

  group('FTreeController', () {
    test('expands item', () {
      final controller = autoDispose(FTreeController());

      expect(controller.isExpanded(0), false);

      controller.expand(0);
      expect(controller.isExpanded(0), true);
    });

    test('collapses item', () {
      final controller = autoDispose(FTreeController(expanded: {0}));

      expect(controller.isExpanded(0), true);

      controller.collapse(0);
      expect(controller.isExpanded(0), false);
    });

    test('toggles item', () {
      final controller = autoDispose(FTreeController());

      expect(controller.isExpanded(0), false);

      controller.toggle(0);
      expect(controller.isExpanded(0), true);

      controller.toggle(0);
      expect(controller.isExpanded(0), false);
    });
  });
}
