@Tags(['golden'])
library;

import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FLineCalendar', () {
    testWidgets('blue screen', (tester) async {
      final focus = FocusScopeNode();

      await tester.pumpWidget(
        TestScaffold.blue(
          child: Focus(
            focusNode: focus,
            child: FLineCalendar(
              style: TestScaffold.blueScreen.lineCalendarStyle,
              controller: FCalendarController.date(),
            ),
          ),
        ),
      );

      final nodes = focus.traversalDescendants.toList();
      nodes[nodes.length ~/ 2 - 1].requestFocus();
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} - default', (tester) async {
        final focus = FocusScopeNode();

        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Focus(
              focusNode: focus,
              child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
            ),
          ),
        );

        final nodes = focus.traversalDescendants.toList();
        nodes[nodes.length ~/ 2 - 1].requestFocus();
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/${theme.name}/default.png'));
      });

      testWidgets('${theme.name} - selected other date', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
          ),
        );

        await tester.tap(find.text('29').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/selected-other-date.png'),
        );
      });

      testWidgets('${theme.name} - selected today', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
          ),
        );

        // There are multiple matches for '28' due to `_SpeculativeLayout`.
        await tester.tap(find.text('28').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/selected-today.png'),
        );
      });

      testWidgets('${theme.name} - selected focused', (tester) async {
        final focus = FocusScopeNode();

        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Focus(
              focusNode: focus,
              child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
            ),
          ),
        );

        await tester.tap(find.text('28').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        final nodes = focus.traversalDescendants.toList();
        nodes[nodes.length ~/ 2].requestFocus();
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/selected-focused.png'),
        );
      });

      testWidgets('${theme.name} - selected hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
          ),
        );

        await tester.tap(find.text('28').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('28').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/selected-hovered.png'),
        );
      });

      testWidgets('${theme.name} - unselected hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('28').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/unselected-hovered.png'),
        );
      });
    }

    testWidgets('RTL locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          textDirection: TextDirection.rtl,
          child: FLineCalendar(controller: FCalendarController.date(), today: DateTime(2024, 11, 28)),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/rtl.png'));
    });

    testWidgets('align to start', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(
            controller: FCalendarController.date(),
            initialDateAlignment: AlignmentDirectional.bottomStart,
            today: DateTime(2024, 11, 28),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/align-start.png'));
    });

    testWidgets('align to end', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(
            controller: FCalendarController.date(),
            initialDateAlignment: AlignmentDirectional.bottomEnd,
            today: DateTime(2024, 11, 28),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/align-end.png'));
    });

    testWidgets('custom item builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FLineCalendar(
            controller: FCalendarController.date(),
            builder:
                (context, state, child) => Stack(
                  children: [
                    child!,
                    Positioned(top: 5, left: 5, child: Container(width: 3, height: 3, color: const Color(0xFF00FF00))),
                  ],
                ),
            today: DateTime(2024, 11, 28),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/builder.png'));
    });
  });
}
