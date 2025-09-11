import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('form', () {
    for (final (type, field) in [
      (
        'normal',
        (text, controller, autovalidate, validator, saved) => FTextFormField(
          initialText: text,
          controller: controller,
          autovalidateMode: autovalidate ?? AutovalidateMode.disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
      (
        'email',
        (text, controller, autovalidate, validator, saved) => FTextFormField.email(
          initialText: text,
          controller: controller,
          autovalidateMode: autovalidate ?? AutovalidateMode.disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
      (
        'password',
        (text, controller, autovalidate, validator, saved) => FTextFormField.password(
          initialText: text,
          controller: controller,
          autovalidateMode: autovalidate ?? AutovalidateMode.disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
      (
        'multiline',
        (text, controller, autovalidate, validator, saved) => FTextFormField.multiline(
          initialText: text,
          controller: controller,
          autovalidateMode: autovalidate ?? AutovalidateMode.disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
    ]) {
      testWidgets('$type - set initial text using initialText', (tester) async {
        final key = GlobalKey<FormState>();

        String? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(key: key, child: field('initial', null, null, null, (value) => initial = value)),
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
              child: field(
                null,
                autoDispose(TextEditingController(text: 'initial')),
                null,
                null,
                (value) => initial = value,
              ),
            ),
          ),
        );

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, 'initial');
      });

      testWidgets('$type - with controller, validator called with correct value', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              child: field(
                null,
                autoDispose(TextEditingController(text: 'initial')),
                AutovalidateMode.always,
                (value) => value == 'some-value' ? null : 'Invalid value',
                null,
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(EditableText), 'other-value');
        await tester.pumpAndSettle();

        expect(find.text('Invalid value'), findsOneWidget);

        await tester.enterText(find.byType(EditableText), 'some-value');
        await tester.pumpAndSettle();

        expect(find.text('Invalid value'), findsNothing);
      });

      testWidgets('$type - without controller, validator called with correct value', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              child: field(
                null,
                null,
                AutovalidateMode.always,
                (value) => value == 'some-value' ? null : 'Invalid value',
                null,
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(EditableText), 'other-value');
        await tester.pumpAndSettle();

        expect(find.text('Invalid value'), findsOneWidget);

        await tester.enterText(find.byType(EditableText), 'some-value');
        await tester.pumpAndSettle();

        expect(find.text('Invalid value'), findsNothing);
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
