
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

class _Controller extends FAccordionController {
  int listeners = 0;

  _Controller();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    listeners++;
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    listeners--;
  }
}

void main() {
  const key = Key('accordion');

  group('initState', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: controller),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('lifted', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .lifted(expanded: (_) => false, onChange: (_, _) {}),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );
    });
  });

  group('didUpdateWidget', () {
    testWidgets('external to lifted', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: controller),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(controller.listeners, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .lifted(expanded: (_) => false, onChange: (_, _) {}),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(controller.listeners, 0);
    });

    testWidgets('lifted to external', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .lifted(expanded: (_) => false, onChange: (_, _) {}),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: controller),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('external A to external B', (tester) async {
      final first = autoDispose(_Controller());
      final second = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: first),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(first.listeners, 1);
      expect(second.listeners, 0);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: second),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(first.listeners, 0);
      expect(second.listeners, 1);
    });

    testWidgets('internal to external', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: const FAccordion(
            key: key,
            children: [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: controller),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('external to internal', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: controller),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: const FAccordion(
            key: key,
            children: [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(controller.listeners, 0);
    });

    testWidgets('lifted A to lifted B', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .lifted(expanded: (_) => false, onChange: (_, _) {}),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      expect(find.text('Content').hitTestable(), findsNothing);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .lifted(expanded: (_) => true, onChange: (_, _) {}),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('Content').hitTestable(), findsOneWidget);
    });
  });

  group('dispose', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .managed(controller: controller),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());

      expect(controller.listeners, 0);
    });

    testWidgets('managed with internal controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: const FAccordion(
            key: key,
            children: [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('lifted', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FAccordion(
            key: key,
            control: .lifted(expanded: (_) => false, onChange: (_, _) {}),
            children: const [FAccordionItem(title: Text('Title'), child: Text('Content'))],
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());
    });
  });

  group('managed', () {
    testWidgets('onChange receives expanded set', (tester) async {
      Set<int>? lastExpanded;

      await tester.pumpWidget(
        TestScaffold(
          child: FAccordion(
            control: .managed(onChange: (expanded) => lastExpanded = expanded),
            children: const [FAccordionItem(title: Text('Item'), child: Text('Content'))],
          ),
        ),
      );

      await tester.tap(find.text('Item'));
      await tester.pumpAndSettle();

      expect(lastExpanded, {0});

      await tester.tap(find.text('Item'));
      await tester.pumpAndSettle();

      expect(lastExpanded, <int>{});
    });
  });
}
