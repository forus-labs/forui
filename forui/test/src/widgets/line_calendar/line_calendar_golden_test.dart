import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FocusScopeNode focus;

  setUp(() {
    focus = FocusScopeNode();
  });

  tearDown(() {
    focus.dispose();
  });

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: Focus(
          focusNode: focus,
          child: FLineCalendar(style: TestScaffold.blueScreen.lineCalendarStyle),
        ),
      ),
    );

    final nodes = focus.traversalDescendants.toList();
    nodes[nodes.length ~/ 2 - 1].requestFocus();
    await tester.pumpAndSettle();

    await expectBlueScreen();
  });

  group('lifted', () {
    testWidgets('selected', (tester) async {
      DateTime? value;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => TestScaffold.app(
            child: FLineCalendar(
              control: .lifted(date: value, onChange: (date) => setState(() => value = date)),
              today: DateTime(2024, 11, 28),
            ),
          ),
        ),
      );

      await tester.tap(find.text('29').last);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/lifted-selected.png'));
    });

    testWidgets('does not update without setState', (tester) async {
      DateTime? value;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => TestScaffold.app(
            child: FLineCalendar(
              control: .lifted(date: value, onChange: (_) {}),
              today: DateTime(2024, 11, 28),
            ),
          ),
        ),
      );

      await tester.tap(find.text('29').last);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/lifted-not-updated.png'));
    });
  });

  group('states', () {
    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} - default', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Focus(
              focusNode: focus,
              child: FLineCalendar(today: DateTime(2024, 11, 28)),
            ),
          ),
        );

        final nodes = focus.traversalDescendants.toList();
        nodes[nodes.length ~/ 2 - 1].requestFocus();
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/${theme.name}/default.png'));
      });

      testWidgets('${theme.name} - disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              control: .managed(selectable: (d) => d.day != 19),
              today: DateTime(2025, 12, 19),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/${theme.name}/disabled.png'));
      });

      testWidgets('${theme.name} - disabled focused', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Focus(
              focusNode: focus,
              child: FLineCalendar(
                control: .managed(selectable: (d) => d.day != 19),
                today: DateTime(2025, 12, 19),
              ),
            ),
          ),
        );

        final nodes = focus.traversalDescendants.toList();
        nodes[nodes.length ~/ 2].requestFocus();
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/disabled-focused.png'),
        );
      });

      testWidgets('${theme.name} - disabled selected', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              control: .managed(initial: DateTime(2025, 12, 19), selectable: (d) => d.day != 19),
              today: DateTime(2025, 12, 19),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/disabled-selected.png'),
        );
      });

      testWidgets('${theme.name} - disabled selected focused', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Focus(
              focusNode: focus,
              child: FLineCalendar(
                control: .managed(initial: DateTime(2025, 12, 19), selectable: (d) => d.day != 19),
                today: DateTime(2025, 12, 19),
              ),
            ),
          ),
        );

        final nodes = focus.traversalDescendants.toList();
        nodes[nodes.length ~/ 2].requestFocus();
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/disabled-selected-focused.png'),
        );
      });

      testWidgets('${theme.name} - selected other date', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(today: DateTime(2024, 11, 28)),
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
            child: FLineCalendar(today: DateTime(2024, 11, 28)),
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
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Focus(
              focusNode: focus,
              child: FLineCalendar(today: DateTime(2024, 11, 28)),
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
            child: FLineCalendar(today: DateTime(2024, 11, 28)),
          ),
        );

        await tester.tap(find.text('28').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        final gesture = await tester.createPointerGesture();
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
            child: FLineCalendar(today: DateTime(2024, 11, 28)),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('28').last));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line-calendar/${theme.name}/unselected-hovered.png'),
        );
      });

      testWidgets('${theme.name} - untogglable', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              control: .managed(initial: DateTime(2024, 11, 29)),
              today: DateTime(2024, 11, 28),
            ),
          ),
        );

        await tester.tap(find.text('29').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/${theme.name}/untoggleable.png'));
      });

      testWidgets('${theme.name} - toggleable', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              control: .managed(initial: DateTime(2024, 11, 29), toggleable: true),
              today: DateTime(2024, 11, 28),
            ),
          ),
        );

        await tester.tap(find.text('29').last);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/${theme.name}/toggleable.png'));
      });
    }
  });

  testWidgets('RTL locale', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        textDirection: .rtl,
        child: FLineCalendar(today: DateTime(2024, 11, 28)),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/rtl.png'));
  });

  testWidgets('align to start', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FLineCalendar(initialScrollAlignment: .bottomStart, today: DateTime(2024, 11, 28)),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/align-start.png'));
  });

  testWidgets('align to end', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FLineCalendar(initialScrollAlignment: .bottomEnd, today: DateTime(2024, 11, 28)),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('line-calendar/align-end.png'));
  });

  testWidgets('custom item builder', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FLineCalendar(
          builder: (context, state, child) => Stack(
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
}
