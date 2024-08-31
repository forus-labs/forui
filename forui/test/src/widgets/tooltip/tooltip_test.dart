import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTooltip', () {
    testWidgets('manual does nothing', (tester) async {
      final controller = FTooltipController(vsync: const TestVSync());

      await tester.pumpWidget(
        TestScaffold(
          data: FThemes.zinc.light,
          child: FTooltip.manual(
            controller: controller,
            tipBuilder: (context, style, _) => const Text('tip'),
            child: FButton(
              onPress: () {},
              label: const Text('button'),
            ),
          ),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FButton)));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('tip'), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });

    group('long press', () {
      testWidgets('shows tooltip', (tester) async {
        const duration = Duration(milliseconds: 1000);

        await tester.pumpWidget(
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              longPressExitDuration: duration,
              tipBuilder: (context, style, _) => const Text('tip'),
              child: FButton(
                onPress: () {},
                label: const Text('button'),
              ),
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
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              longPressExitDuration: duration,
              tipBuilder: (context, style, _) => const Text('tip'),
              child: FButton(
                onPress: () {},
                label: const Text('button'),
              ),
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
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              tipBuilder: (context, style, _) => const Text('tip'),
              child: FButton(
                onPress: () {},
                label: const Text('button'),
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
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
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              hoverEnterDuration: const Duration(seconds: 1),
              tipBuilder: (context, style, _) => const Text('tip'),
              child: FButton(
                onPress: () {},
                label: const Text('button'),
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
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
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              hoverEnterDuration: Duration.zero,
              hoverExitDuration: const Duration(seconds: 1),
              tipBuilder: (context, style, _) => const Text('tip'),
              child: FButton(
                onPress: () {},
                label: const Text('button'),
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
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
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              tipBuilder: (context, style, _) => const Text('tip'),
              child: FButton(
                onPress: () {},
                label: const Text('button'),
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('tip'), findsOneWidget);

        await tester.tapAt(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        expect(find.text('tip'), findsNothing);
      });
    });
  });
}
