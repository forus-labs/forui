import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;

  setUp(() {
    controller = FSelectController<String>();
  });

  tearDown(() => controller.dispose());

  group('lifted', () {
    testWidgets('FSelect', (tester) async {
      String? value;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelect<String>(
              key: key,
              control: .lifted(
                value: value,
                onChange: (v) => setState(() {
                  value = v;
                }),
              ),
              items: letters,
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(value, 'A');

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('FSelect.rich', (tester) async {
      String? value;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelect<String>.rich(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              format: (v) => v,
              children: [
                .item(title: const Text('A'), value: 'A'),
                .item(title: const Text('B'), value: 'B'),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(value, 'A');

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('FSelect.search', (tester) async {
      String? value;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelect<String>.search(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              items: letters,
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(value, 'A');

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('FSelect.searchBuilder', (tester) async {
      String? value;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelect<String>.searchBuilder(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              format: (v) => v,
              filter: (query) => letters.keys.where((k) => k.toLowerCase().contains(query.toLowerCase())),
              contentBuilder: (context, query, items) => [
                for (final item in items) .item(title: Text(item), value: item),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(value, 'A');

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('showing popover does not cause error', (tester) async {
      String? value;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FSelect<String>(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              items: letters,
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), null);

      await tester.pumpWidget(const SizedBox());
    });
  });

  group('managed', () {
    testWidgets('onChange called', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            items: letters,
          ),
        ),
      );

      controller.value = 'A';
      await tester.pump();

      expect(changedValue, 'A');
    });
  });

  group('form', () {
    testWidgets('set initial value using initialValue', (tester) async {
      final key = GlobalKey<FormState>();

      String? initial;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FSelect<String>.rich(
              control: const .managed(initial: 'A'),
              format: (value) => '$value!',
              onSaved: (value) => initial = value,
              children: [
                .item(title: const Text('A'), value: 'A'),
                .item(title: const Text('B'), value: 'B'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('A!'), findsOneWidget);

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial, 'A');
    });

    testWidgets('controller provided', (tester) async {
      final key = GlobalKey<FormState>();

      String? initial;
      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FSelect<String>.rich(
              control: const .managed(initial: 'A'),
              format: (value) => '$value!',
              onSaved: (value) => initial = value,
              children: [
                .item(title: const Text('A'), value: 'A'),
                .item(title: const Text('B'), value: 'B'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('A!'), findsOneWidget);

      key.currentState!.save();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(initial, 'A');
    });
  });

  group('FSelect', () {
    testWidgets('custom format', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.rich(
            control: .managed(controller: controller),
            key: key,
            format: (value) => '$value!',
            children: [
              .item(title: const Text('A'), value: 'A'),
              .item(title: const Text('B'), value: 'B'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle();

      expect(find.text('A!'), findsOne);
      expect(controller.value, 'A');
    });

    testWidgets('keyboard navigation', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            control: .managed(controller: controller),
            items: const {'A': 'A', 'B': 'B'},
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      expect(controller.value, 'B');
    });
  });

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(items: const {'A': 'A', 'B': 'B'}, key: key, focusNode: focus),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('refocus after selection', (tester) async {
      final focus = autoDispose(FocusNode());
      const itemKey = ValueKey('item');

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            focusNode: focus,
            children: [
              .item(title: const Text('A'), value: 'A', key: itemKey),
              .item(title: const Text('B'), value: 'B'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(itemKey));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('tap on text-field should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('escape should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.escape);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('tap outside unfocuses on Android/iOS', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);
    });

    testWidgets('tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = .macOS;

      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
