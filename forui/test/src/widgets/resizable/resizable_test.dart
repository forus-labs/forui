// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart' hide VerticalDivider;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/divider.dart';
import '../../test_scaffold.dart';

void main() {
  final top = FResizableRegion(
    initialExtent: 30,
    minExtent: 20,
    builder: (context, snapshot, child) => const Align(child: Text('A')),
  );

  final bottom = FResizableRegion(
    initialExtent: 70,
    minExtent: 20,
    builder: (context, snapshot, child) => const Align(child: Text('B')),
  );

  setUp(() {
    FTouch.primary = false;
  });

  tearDown(() => FTouch.primary = null);

  for (final (index, constructor)
      in [
        () => FResizable(crossAxisExtent: 0, axis: Axis.vertical, children: [top, bottom]),
      ].indexed) {
    test('[$index] constructor throws error', () => expect(constructor, throwsAssertionError));
  }

  testWidgets('vertical drag downwards', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: Center(child: FResizable(crossAxisExtent: 50, axis: Axis.vertical, children: [top, bottom])),
      ),
    );

    await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, 100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizableRegion).first), const Size(50, 80));
    expect(tester.getSize(find.byType(FResizableRegion).last), const Size(50, 20));
  });

  testWidgets('vertical drag upwards', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: Center(child: FResizable(crossAxisExtent: 50, axis: Axis.vertical, children: [top, bottom])),
      ),
    );

    await tester.timedDrag(find.byType(VerticalDivider), const Offset(0, -100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizableRegion).first), const Size(50, 20));
    expect(tester.getSize(find.byType(FResizableRegion).last), const Size(50, 80));
  });

  testWidgets('horizontal drag right', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: Center(child: FResizable(crossAxisExtent: 50, axis: Axis.horizontal, children: [top, bottom])),
      ),
    );

    await tester.timedDrag(find.byType(HorizontalDivider), const Offset(100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizableRegion).first), const Size(80, 50));
    expect(tester.getSize(find.byType(FResizableRegion).last), const Size(20, 50));
  });

  testWidgets('horizontal drag left', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: Center(child: FResizable(crossAxisExtent: 50, axis: Axis.horizontal, children: [top, bottom])),
      ),
    );

    await tester.timedDrag(find.byType(HorizontalDivider), const Offset(-100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizableRegion).first), const Size(20, 50));
    expect(tester.getSize(find.byType(FResizableRegion).last), const Size(80, 50));
  });

  group('state', () {
    testWidgets('update controller', (tester) async {
      final first = autoDispose(FResizableController.cascade());
      await tester.pumpWidget(
        TestScaffold.app(
          child: Center(
            child: FResizable(controller: first, crossAxisExtent: 50, axis: Axis.horizontal, children: [top, bottom]),
          ),
        ),
      );

      expect(first.hasListeners, true);
      expect(first.disposed, false);

      final second = autoDispose(FResizableController.cascade());
      await tester.pumpWidget(
        TestScaffold.app(
          child: Center(
            child: FResizable(controller: second, crossAxisExtent: 50, axis: Axis.horizontal, children: [top, bottom]),
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);
      expect(second.hasListeners, true);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FResizableController.cascade());
      await tester.pumpWidget(
        TestScaffold.app(
          child: Center(
            child: FResizable(
              controller: controller,
              crossAxisExtent: 50,
              axis: Axis.horizontal,
              children: [top, bottom],
            ),
          ),
        ),
      );

      expect(controller.hasListeners, true);
      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);
    });
  });
}
