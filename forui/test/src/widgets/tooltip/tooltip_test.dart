import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTooltip', () {
    group('mobile', () {
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
      });

      testWidgets('long-press shows tooltip', (tester) async {
        const duration = Duration(milliseconds: 1000);

        await tester.pumpWidget(
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              pressExitDuration: duration,
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

      testWidgets('long-press and re-long-press shows resets hoverEnterDuration', (tester) async {
        const duration = Duration(milliseconds: 1000);

        await tester.pumpWidget(
          TestScaffold(
            data: FThemes.zinc.light,
            child: FTooltip(
              pressExitDuration: duration,
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

    group('desktop', () {
      testWidgets('manual does nothing', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.linux;

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

      testWidgets('hover shows tooltip', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.linux;

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

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('hover enter and re-enter resets hoverEnterDuration', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.linux;

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

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('hover exit and re-exit resets hoverExitDuration', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.linux;

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

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('tap hides tooltip even if child is GestureDetector', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.linux;

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

        debugDefaultTargetPlatformOverride = null;
      });
    });
  });
}
