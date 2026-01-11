import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localizations_en.dart';
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

  late FMultiValueNotifier<String> controller;

  setUp(() {
    controller = FMultiValueNotifier<String>();
  });

  tearDown(() => controller.dispose());

  group('lifted', () {
    testWidgets('FMultiSelect', (tester) async {
      Set<String> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FMultiSelect<String>(
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
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, {'A'});

      await tester.tapAt(.zero);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A').last);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, <String>{});
    });

    testWidgets('FMultiSelect.rich', (tester) async {
      Set<String> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FMultiSelect<String>.rich(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              format: Text.new,
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
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, {'A'});

      await tester.tapAt(.zero);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A').last);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, <String>{});
    });

    testWidgets('FMultiSelect.search', (tester) async {
      Set<String> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FMultiSelect<String>.search(
              letters,
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, {'A'});

      await tester.tapAt(.zero);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A').last);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, <String>{});
    });

    testWidgets('FMultiSelect.searchBuilder', (tester) async {
      Set<String> value = {};

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FMultiSelect<String>.searchBuilder(
              key: key,
              control: .lifted(value: value, onChange: (v) => setState(() => value = v)),
              format: Text.new,
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
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, {'A'});

      await tester.tapAt(.zero);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A').last);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(value, <String>{});
    });
  });

  group('managed', () {
    testWidgets('onChange called', (tester) async {
      Set<String>? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>(
            key: key,
            control: .managed(controller: controller, onChange: (value) => changedValue = value),
            items: letters,
          ),
        ),
      );

      controller.value = {'A'};
      await tester.pump();

      expect(changedValue, {'A'});
    });
  });

  testWidgets('custom format', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FMultiSelect<String>.rich(
          control: .managed(controller: controller),
          key: key,
          format: (value) => Text('$value!'),
          children: [
            .item(title: const Text('A'), value: 'A'),
            .item(title: const Text('B'), value: 'B'),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('A'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('A!'), findsOne);
    expect(controller.value, {'A'});
  });

  group('disabled', () {
    testWidgets('field', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect(enabled: false, items: letters, clearable: true, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A'), findsNothing);
    });

    testWidgets('clear icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FMultiSelect(
            control: const .managed(initial: {'A'}),
            enabled: false,
            items: letters,
            clearable: true,
            key: key,
          ),
        ),
      );

      expect(find.bySemanticsLabel(FLocalizationsEnSg().textFieldClearButtonSemanticsLabel), findsNothing);
    });

    testWidgets('tag', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect(
            control: const .managed(initial: {'A'}),
            enabled: false,
            items: letters,
            key: key,
          ),
        ),
      );

      await tester.tap(find.text('A'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('A'), findsOne);
    });
  });

  testWidgets('tag clears itself', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FMultiSelect<String>.rich(
          control: .managed(controller: controller),
          key: key,
          format: (value) => Text('$value!'),
          children: [
            .item(title: const Text('A'), value: 'A'),
            .item(title: const Text('B'), value: 'B'),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('A'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('A!'), findsOne);
    expect(find.byIcon(FIcons.check), findsNWidgets(1));
    expect(controller.value, {'A'});

    await tester.tap(find.text('A!'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('A!'), findsNothing);
    expect(find.byIcon(FIcons.check), findsNothing);
    expect(controller.value, <String>{});
  });

  testWidgets('clear button clears everything', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FMultiSelect<String>.rich(
          control: .managed(controller: controller),
          key: key,
          format: (value) => Text('$value!'),
          clearable: true,
          children: const [
            FSelectItem(title: Text('A'), value: 'A'),
            FSelectItem(title: Text('B'), value: 'B'),
          ],
        ),
      ),
    );

    expect(find.byIcon(FIcons.x), findsNothing);

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    controller.value = {'A', 'B'};
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('A!'), findsOne);
    expect(find.text('B!'), findsOne);

    await tester.tap(find.byIcon(FIcons.x).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('A!'), findsNothing);
    expect(find.text('B!'), findsNothing);
    expect(controller.value, <String>{});
  });

  testWidgets('keyboard navigation', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FMultiSelect<String>(
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

    expect(controller.value, {'B'});
  });

  group('focus', () {
    testWidgets('external focus is not disposed', (tester) async {
      final focus = autoDispose(FocusNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<String>(items: const {'A': 'A', 'B': 'B'}, key: key, focusNode: focus),
        ),
      );

      expect(tester.takeException(), null);
    });

    testWidgets('tap on field should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
          child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
          child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
          child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, key: key, focusNode: focus),
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
