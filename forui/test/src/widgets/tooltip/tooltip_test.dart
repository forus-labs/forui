import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTooltip', () {
    testWidgets('does nothing', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            hover: false,
            longPress: false,
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsNothing);
    });

    group('long press', () {
      testWidgets('shows tooltip', (tester) async {
        const duration = Duration(milliseconds: 1000);

        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              longPressExitDuration: duration,
              tipBuilder: (context, _) => const Text('tip'),
              child: FButton(onPress: () {}, child: const Text('button')),
            ),
          ),
        );

        await tester.longPress(find.byType(FButton));
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsOneWidget);

        await tester.pumpAndSettle(kLongPressTimeout + kPressTimeout + duration);

        expect(find.text('tip'), findsNothing);
      });

      testWidgets('re-long-press shows resets longPressExitDuration', (tester) async {
        const duration = Duration(milliseconds: 1000);

        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              longPressExitDuration: duration,
              tipBuilder: (context, _) => const Text('tip'),
              child: FButton(onPress: () {}, child: const Text('button')),
            ),
          ),
        );

        await tester.longPress(find.byType(FButton));
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsOneWidget);
        await tester.pumpAndSettle(kLongPressTimeout + kPressTimeout + const Duration(milliseconds: 100));

        await tester.longPress(find.byType(FButton));
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsOneWidget);
        await tester.pumpAndSettle(kLongPressTimeout + kPressTimeout + const Duration(milliseconds: 1000));

        expect(find.text('tip'), findsNothing);
      });
    });

    group('hover', () {
      testWidgets('hover shows tooltip', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              tipBuilder: (context, _) => const Text('tip'),
              child: FButton(onPress: () {}, child: const Text('button')),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('tip'), findsOneWidget);

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsNothing);
      });

      testWidgets('hover enter and re-enter resets hoverEnterDuration', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              hoverEnterDuration: const Duration(seconds: 1),
              tipBuilder: (context, _) => const Text('tip'),
              child: FButton(onPress: () {}, child: const Text('button')),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsNothing);

        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('tip'), findsOneWidget);
      });

      testWidgets('hover exit and re-exit resets hoverExitDuration', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              hoverEnterDuration: Duration.zero,
              hoverExitDuration: const Duration(seconds: 1),
              tipBuilder: (context, _) => const Text('tip'),
              child: FButton(onPress: () {}, child: const Text('button')),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        await gesture.moveTo(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsOneWidget);

        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('tip'), findsNothing);
      });

      testWidgets('tap hides tooltip even if child is GestureDetector', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FTooltip(
              tipBuilder: (context, _) => const Text('tip'),
              child: FButton(onPress: () {}, child: const Text('button')),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('tip'), findsOneWidget);

        await tester.tapAt(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsNothing);
      });
    });

    testWidgets('old controller is not disposed', (tester) async {
      final first = autoDispose(FTooltipController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            controller: first,
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      final second = autoDispose(FTooltipController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            controller: first,
            tipBuilder: (context, _) => const Text('tip'),
            child: FButton(onPress: () {}, child: const Text('button')),
          ),
        ),
      );

      expect(first.disposed, false);
      expect(second.disposed, false);
    });
  });
}
