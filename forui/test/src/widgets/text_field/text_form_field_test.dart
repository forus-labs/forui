import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('form', () {
    for (final (type, field) in [
      (
        'normal',
        (text, controller, saved) => FTextFormField(initialText: text, controller: controller, onSaved: saved),
      ),
      (
        'email',
        (text, controller, saved) => FTextFormField.email(initialText: text, controller: controller, onSaved: saved),
      ),
      (
        'password',
        (text, controller, saved) => FTextFormField.password(initialText: text, controller: controller, onSaved: saved),
      ),
      (
        'multiline',
        (text, controller, saved) =>
            FTextFormField.multiline(initialText: text, controller: controller, onSaved: saved),
      ),
    ]) {
      testWidgets('$type - set initial text using initialText', (tester) async {
        final key = GlobalKey<FormState>();

        String? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(key: key, child: field('initial', null, (value) => initial = value)),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, 'initial');
      });

      testWidgets('$type - controller provided', (tester) async {
        final key = GlobalKey<FormState>();

        String? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: field(null, autoDispose(TextEditingController(text: 'initial')), (value) => initial = value),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, 'initial');
      });
    }
  });

  group('onChange', () {
    testWidgets('reset', (tester) async {
      final key = GlobalKey<FormState>();
      final controller = autoDispose(TextEditingController(text: 'initial'));
      int count = 0;

      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: key,
            child: FTextFormField(controller: controller, onChange: (value) => count++),
          ),
        ),
      );

      controller.text = 'other';

      key.currentState!.reset();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(count, 2);
    });
  });
}
