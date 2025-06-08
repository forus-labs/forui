// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

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
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  tearDown(() {
    controller.dispose();
  });

  testWidgets('didUpdateWidget does not dispose external controller', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<String>.fromMap(letters, key: key, contentScrollController: scrollController),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(scrollController.hasListeners, true);

    await tester.pumpWidget(TestScaffold.app(child: FSelect<String>.fromMap(letters, key: key)));

    expect(scrollController.dispose, returnsNormally);
  });

  testWidgets('dispose() does not dispose external controller', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FSelect<String>.fromMap(letters, key: key, contentScrollController: scrollController),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(scrollController.hasListeners, true);

    await tester.pumpWidget(const SizedBox());

    expect(scrollController.hasListeners, false);
    expect(scrollController.dispose, returnsNormally);
  });
}
