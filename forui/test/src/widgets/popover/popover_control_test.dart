import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

class _Controller extends FPopoverController {
  int listeners = 0;

  _Controller({required super.vsync});

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
  const key = Key('popover');

  group('initState', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('managed with internal controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );
    });

    testWidgets('lifted', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .lifted(shown: false, onChange: (_) {}),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );
    });
  });

  group('didUpdateWidget', () {
    testWidgets('external to lifted', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .lifted(shown: false, onChange: (_) {}),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 0);
    });

    testWidgets('external A to external B', (tester) async {
      final first = autoDispose(_Controller(vsync: tester));
      final second = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: first),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(first.listeners, 1);
      expect(second.listeners, 0);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: second),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(first.listeners, 0);
      expect(second.listeners, 1);
    });

    testWidgets('internal to external', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('external to internal', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 1);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 0);
    });

    testWidgets('lifted to external', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .lifted(shown: false, onChange: (_) {}),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('lifted to internal', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .lifted(shown: false, onChange: (_) {}),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );
    });
  });

  group('dispose', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(controller.listeners, 1);

      await tester.pumpWidget(const SizedBox());

      expect(controller.listeners, 0);
      expect(controller.disposed, false);
    });

    testWidgets('managed with internal controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('lifted', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .lifted(shown: false, onChange: (_) {}),
            popoverBuilder: (_, _) => const SizedBox(),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());
    });
  });

  group('managed onChange', () {
    testWidgets('onChange called on show and hide', (tester) async {
      final controller = autoDispose(_Controller(vsync: tester));
      final calls = <bool>[];

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            key: key,
            control: .managed(controller: controller, onChange: calls.add),
            popoverBuilder: (_, _) => const Text('Popover'),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      expect(calls, isEmpty);

      await controller.show();
      await tester.pumpAndSettle();
      expect(calls, [true]);

      await controller.hide();
      await tester.pumpAndSettle();
      expect(calls, [true, false]);
    });
  });
}
