import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/accordion/accordion_controller.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hit test', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      TestScaffold(
        child: FAccordion(
          children: [
            FAccordionItem(
              title: const Text('Title'),
              initiallyExpanded: true,
              child: SizedBox.square(
                dimension: 1,
                child: GestureDetector(onTap: () => taps++, child: const Text('button')),
              ),
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('button'), warnIfMissed: false);
    expect(taps, 0);

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('button'));
    expect(taps, 1);
  });

  testWidgets('old controller is not disposed', (tester) async {
    final first = autoDispose(FAccordionController());
    await tester.pumpWidget(
      TestScaffold.app(
        child: FAccordion(
          control: .managed(controller: first),
          children: const [FAccordionItem(title: Text('Title'), child: Text('button'))],
        ),
      ),
    );

    final second = autoDispose(FAccordionController());
    await tester.pumpWidget(
      TestScaffold.app(
        child: FAccordion(
          control: .managed(controller: second),
          children: const [FAccordionItem(title: Text('Title'), child: Text('button'))],
        ),
      ),
    );

    expect(first.disposed, false);
    expect(second.disposed, false);
  });

  testWidgets('separators', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: const FAccordion(
          children: [
            SizedBox(height: 100),
            FAccordionItem(
              title: Text('Title'),
              initiallyExpanded: true,
              child: SizedBox.square(dimension: 1, child: Text('button')),
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();

    expect(find.text('button'), findsOneWidget);
  });

  testWidgets('disposed item removes controller from map', (tester) async {
    final controller = autoDispose(FAccordionController());

    await tester.pumpWidget(
      TestScaffold.app(
        child: FAccordion(
          control: .managed(controller: controller),
          children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
        ),
      ),
    );

    expect(controller.controllers.length, 1);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FAccordion(
          control: .managed(controller: controller),
          children: const [],
        ),
      ),
    );

    expect(controller.controllers.length, 0);
  });

  testWidgets('replaced item does not remove new controller', (tester) async {
    final controller = autoDispose(FAccordionController());

    await tester.pumpWidget(
      TestScaffold.app(
        child: FAccordion(
          control: .managed(controller: controller),
          children: const [FAccordionItem(key: Key('a'), title: Text('Title A'), child: Text('Content A'))],
        ),
      ),
    );

    expect(controller.controllers.length, 1);

    await tester.pumpWidget(
      TestScaffold.app(
        child: FAccordion(
          control: .managed(controller: controller),
          children: const [FAccordionItem(key: Key('b'), title: Text('Title B'), child: Text('Content B'))],
        ),
      ),
    );

    // New item at same index should still have its controller registered
    expect(controller.controllers.length, 1);
    expect(find.text('Title B'), findsOneWidget);
  });

  testWidgets('lifted', (tester) async {
    final expanded = <int>{};
    var lastIndex = -1;
    var lastExpanded = false;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (_, setState) => TestScaffold(
          child: FAccordion(
            control: .lifted(
              expanded: expanded.contains,
              onChange: (index, isExpanded) => setState(() {
                lastIndex = index;
                lastExpanded = isExpanded;
                lastExpanded ? expanded.add(index) : expanded.remove(index);
              }),
            ),
            children: const [
              FAccordionItem(title: Text('Title 0'), child: Text('Content 0')),
              FAccordionItem(title: Text('Title 1'), child: Text('Content 1')),
            ],
          ),
        ),
      ),
    );

    expect(expanded, isEmpty);

    // Expand first item
    await tester.tap(find.text('Title 0'));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(lastIndex, 0);
    expect(lastExpanded, true);
    expect(expanded, {0});

    // Collapse first item
    await tester.tap(find.text('Title 0'));
    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    expect(lastIndex, 0);
    expect(lastExpanded, false);
    expect(expanded, <int>{});

    // Expand first item
    await tester.tap(find.text('Title 0'));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(lastIndex, 0);
    expect(lastExpanded, true);
    expect(expanded, {0});
  });

  testWidgets('managed onChange is called', (tester) async {
    Set<int>? lastExpanded;

    await tester.pumpWidget(
      TestScaffold(
        child: FAccordion(
          control: .managed(onChange: (expanded) => lastExpanded = expanded),
          children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
        ),
      ),
    );

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();

    expect(lastExpanded, {0});

    await tester.tap(find.text('Title'));
    await tester.pumpAndSettle();

    expect(lastExpanded, <int>{});
  });
}
