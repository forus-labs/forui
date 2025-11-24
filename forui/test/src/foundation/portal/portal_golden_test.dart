import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hidden', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPortal(
          controller: controller,
          barrier: Container(color: Colors.blue),
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/hidden.png'));
  });

  testWidgets('shown', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPortal(
          controller: controller,
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shown.png'));
  });

  testWidgets('shown with barrier', (tester) async {
    final controller = OverlayPortalController();

    await tester.pumpWidget(
      TestScaffold.app(
        child: FPortal(
          controller: controller,
          barrier: Container(color: Colors.blue),
          portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/barrier.png'));
  });

  group('constraints', () {
    testWidgets('fixed constraints', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            constraints: const .tightFor(width: 25, height: 25),
            controller: controller,
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: GestureDetector(
              onTap: controller.toggle,
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/fixed-constraints.png'));
    });

    testWidgets('auto-height constraints', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            constraints: const FAutoHeightPortalConstraints.tightFor(width: 100),
            controller: controller,
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: GestureDetector(
              onTap: controller.toggle,
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/auto-height-constraints.png'));
    });

    testWidgets('auto-width constraints', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            constraints: const FAutoWidthPortalConstraints.tightFor(height: 100),
            controller: controller,
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: GestureDetector(
              onTap: controller.toggle,
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/auto-width-constraints.png'));
    });
  });

  group('spacing, overflowed & offset', () {
    testWidgets('spacing', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            controller: controller,
            spacing: const .spacing(5),
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/spacing.png'));
    });

    testWidgets('overflowed', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPortal(
              controller: controller,
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/overflow.png'));
    });

    testWidgets('offset', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            offset: const Offset(50, 70),
            controller: controller,
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/offset.png'));
    });

    testWidgets('spacing & overflowed', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPortal(
              controller: controller,
              spacing: const .spacing(5),
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/spacing-overflowed.png'));
    });

    testWidgets('overflowed & offset', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: .bottomRight,
            child: FPortal(
              controller: controller,
              offset: const Offset(30, 0),
              portalBuilder: (context, _) =>
                  const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/overflowed-offset.png'));
    });
  });

  group('rendering', () {
    testWidgets('overflowed when wrapped inside repaint boundary', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: .end,
                children: [
                  FPortal(
                    controller: controller,
                    spacing: const .spacing(5),
                    portalBuilder: (context, _) =>
                        const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                    child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/overflowed-inside-repaint-boundary.png'));
    });

    testWidgets('overflowed when wrapped outside repaint boundary', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .end,
                children: [
                  FPortal(
                    controller: controller,
                    spacing: const .spacing(5),
                    portalBuilder: (context, _) =>
                        const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                    child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/overflowed-outside-repaint-boundary.png'));
    });

    testWidgets('does not show portal when child is unlinked/not visible', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: ListView(
            children: [
              const SizedBox(height: 1000),
              Row(
                children: [
                  FPortal(
                    controller: controller,
                    spacing: const .spacing(5),
                    portalBuilder: (context, _) =>
                        const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                    child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/unlinked.png'));
    });

    testWidgets('portal repositions when child expanded', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            controller: controller,
            spacing: const .spacing(5),
            portalBuilder: (context, _) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const Center(child: Expanding()),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Expanding));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/expanded.png'));
    });
  });

  group('viewInsets', () {
    testWidgets('view padding', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(viewPadding: const .all(100)),
              child: Align(
                alignment: .bottomRight,
                child: FPortal(
                  portalAnchor: .topLeft,
                  childAnchor: .bottomRight,
                  controller: controller,
                  portalBuilder: (context, _) =>
                      const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                  child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
                ),
              ),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/view-padding.png'));
    });

    testWidgets('view insets', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(viewPadding: const .all(100)),
              child: Align(
                alignment: .bottomRight,
                child: FPortal(
                  portalAnchor: .topLeft,
                  childAnchor: .bottomRight,
                  controller: controller,
                  viewInsets: const .all(50),
                  portalBuilder: (context, _) =>
                      const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                  child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
                ),
              ),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/view-insets.png'));
    });

    testWidgets('no view insets', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(viewPadding: const .all(100)),
              child: Align(
                alignment: .bottomRight,
                child: FPortal(
                  portalAnchor: .topLeft,
                  childAnchor: .bottomRight,
                  controller: controller,
                  viewInsets: .zero,
                  portalBuilder: (context, _) =>
                      const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                  child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
                ),
              ),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/no-view-insets.png'));
    });
  });
}

class Expanding extends StatefulWidget {
  const Expanding({super.key});

  @override
  State<Expanding> createState() => _ExpandingState();
}

class _ExpandingState extends State<Expanding> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => setState(() => _expanded = !_expanded),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      width: _expanded ? 200.0 : 50.0,
      height: _expanded ? 200.0 : 50.0,
      color: Colors.yellow,
    ),
  );
}
