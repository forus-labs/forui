import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPortal', () {
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
            portalBuilder:
                (context) => const Padding(
                  padding: EdgeInsets.all(5),
                  child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                ),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shown.png'));
    });

    testWidgets('shifted', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            controller: controller,
            offset: const Offset(100, 100),
            portalBuilder:
                (context) => const Padding(
                  padding: EdgeInsets.all(5),
                  child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                ),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      controller.show();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('portal/shifted.png'));
    });

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
                    portalBuilder:
                        (context) => const Padding(
                          padding: EdgeInsets.all(5),
                          child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                        ),
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
                    portalBuilder:
                        (context) => const Padding(
                          padding: EdgeInsets.all(5),
                          child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                        ),
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
                    portalBuilder:
                        (context) => const Padding(
                          padding: EdgeInsets.all(5),
                          child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                        ),
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
                    portalBuilder:
                        (context) => const Padding(
                          padding: EdgeInsets.all(5),
                          child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                        ),
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
                    portalBuilder:
                        (context) => const Padding(
                          padding: EdgeInsets.all(5),
                          child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                        ),
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

    testWidgets('portal repositions when expanded', (tester) async {
      final controller = OverlayPortalController();

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPortal(
            controller: controller,
            portalBuilder:
                (context) => const Padding(
                  padding: EdgeInsets.all(5),
                  child: ColoredBox(color: Colors.red, child: SizedBox.square(dimension: 100)),
                ),
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

    testWidgets('respect view padding', (tester) async {
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
