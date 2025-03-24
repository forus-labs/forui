// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O'];

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  group('Content', () {
    testWidgets('didUpdateWidget does not dispose external controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            contentScrollController: scrollController,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(scrollController.hasListeners, true);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(key: key, children: [for (final letter in letters) FSelectItem.text(letter)]),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(scrollController.hasListeners, false);
      expect(scrollController.dispose, returnsNormally);
    });

    testWidgets('dispose() does not dispose external controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelect<String>(
            key: key,
            contentScrollController: scrollController,
            children: [for (final letter in letters) FSelectItem.text(letter)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(scrollController.hasListeners, true);

      await tester.pumpWidget(const SizedBox());

      expect(scrollController.hasListeners, false);
      expect(scrollController.dispose, returnsNormally);
    });
  });

  tearDown(() {
    controller.dispose();
  });
}
