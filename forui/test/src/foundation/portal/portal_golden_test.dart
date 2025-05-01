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
          portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
          portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
          child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shown.png'));
  });

  group('constraints', () {
    testWidgets('fixed constraints', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            constraints: const FPortalConstraints.tightFor(width: 25, height: 25),
            controller: controller,
            portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
            portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
            portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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

  group('spacing, shifting & offset', () {
    testWidgets('spacing', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            controller: controller,
            spacing: const FPortalSpacing(5),
            portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/spacing.png'));
    });

    testWidgets('shifted', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FPortal(
              controller: controller,
              portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shifted.png'));
    });

    testWidgets('offset', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            offset: const Offset(50, 70),
            controller: controller,
            portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/offset.png'));
    });

    testWidgets('spacing & shifted', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FPortal(
              controller: controller,
              spacing: const FPortalSpacing(5),
              portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/spacing-shifted.png'));
    });

    testWidgets('shifted & offset', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FPortal(
              controller: controller,
              offset: const Offset(30, 0),
              portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
              child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shifted-offset.png'));
    });
  });

  group('rendering', () {
    testWidgets('shifted when wrapped inside repaint boundary', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FPortal(
                    controller: controller,
                    spacing: const FPortalSpacing(5),
                    portalBuilder:
                        (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shifted-inside-repaint-boundary.png'));
    });

    testWidgets('shifted when wrapped outside repaint boundary', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FPortal(
                    controller: controller,
                    spacing: const FPortalSpacing(5),
                    portalBuilder:
                        (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shifted-outside-repaint-boundary.png'));
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
                    spacing: const FPortalSpacing(5),
                    portalBuilder:
                        (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
            spacing: const FPortalSpacing(5),
            portalBuilder: (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
            builder:
                (context) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(viewPadding: const EdgeInsets.all(100)),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FPortal(
                      portalAnchor: Alignment.topLeft,
                      childAnchor: Alignment.bottomRight,
                      controller: controller,
                      portalBuilder:
                          (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
            builder:
                (context) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(viewPadding: const EdgeInsets.all(100)),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FPortal(
                      portalAnchor: Alignment.topLeft,
                      childAnchor: Alignment.bottomRight,
                      controller: controller,
                      viewInsets: const EdgeInsets.all(50),
                      portalBuilder:
                          (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
            builder:
                (context) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(viewPadding: const EdgeInsets.all(100)),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FPortal(
                      portalAnchor: Alignment.topLeft,
                      childAnchor: Alignment.bottomRight,
                      controller: controller,
                      viewInsets: EdgeInsets.zero,
                      portalBuilder:
                          (context) => const ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
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
