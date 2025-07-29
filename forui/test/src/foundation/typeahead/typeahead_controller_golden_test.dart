import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FTypeaheadController controller;

  setUp(() {
    controller = FTypeaheadController(
      textStyles: (context) => (
        const TextStyle(color: Colors.black),
        const TextStyle(color: Colors.blue),
        const TextStyle(color: Colors.grey),
      ),
      text: 'hello',
      suggestions: const ['hello world', 'hello there'],
    );
  });

  tearDown(() => controller.dispose());

  testWidgets('no completion', (tester) async {
    controller.text = 'hi';

    await tester.pumpWidget(
      TestScaffold(
        child: Builder(
          builder: (context) => Text.rich(controller.buildTextSpan(context: context, withComposing: false)),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('typeahead_controller/no_completion.png'));
  });

  testWidgets('no completion', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: Builder(
          builder: (context) => Text.rich(controller.buildTextSpan(context: context, withComposing: false)),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('typeahead_controller/completion.png'));
  });

  testWidgets('with composing range', (tester) async {
    controller.value = const TextEditingValue(text: 'hello', composing: TextRange(start: 1, end: 3));

    await tester.pumpWidget(
      TestScaffold(
        child: Builder(
          builder: (context) {
            final span = controller.buildTextSpan(context: context, withComposing: true);
            return Text.rich(span);
          },
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('typeahead_controller/composing.png'));
  });
}
