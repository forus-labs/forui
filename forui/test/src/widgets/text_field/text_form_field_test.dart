import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('lifted', (tester) async {
    var value = const TextEditingValue(text: 'initial');
    TextEditingValue? received;

    Widget buildWidget() => TestScaffold.app(
      child: FTextFormField(
        control: .lifted(
          value: value,
          onChange: (v) => received = v,
        ),
      ),
    );

    await tester.pumpWidget(buildWidget());

    expect(find.text('initial'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'typed');
    await tester.pumpAndSettle();
    expect(received?.text, 'typed');

    value = const TextEditingValue(text: 'external');
    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();
    expect(find.text('external'), findsOneWidget);
  });

  group('form', () {
    for (final (type, field) in [
      (
        'normal',
        (text, controller, autovalidate, validator, saved) => FTextFormField(
          control: .managed(controller: controller, initial: text),
          autovalidateMode: autovalidate ?? .disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
      (
        'email',
        (text, controller, autovalidate, validator, saved) => FTextFormField.email(
          control: .managed(controller: controller, initial: text),
          autovalidateMode: autovalidate ?? .disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
      (
        'password',
        (text, controller, autovalidate, validator, saved) => FTextFormField.password(
          control: .managed(controller: controller, initial: text),
          autovalidateMode: autovalidate ?? .disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
      (
        'multiline',
        (text, controller, autovalidate, validator, saved) => FTextFormField.multiline(
          control: .managed(controller: controller, initial: text),
          autovalidateMode: autovalidate ?? .disabled,
          validator: validator,
          onSaved: saved,
        ),
      ),
    ]) {
      testWidgets('$type - set initial text using initial', (tester) async {
        final key = GlobalKey<FormState>();

        String? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            child: Form(
              key: key,
              child: field(const TextEditingValue(text: 'initial'), null, null, null, (value) => initial = value),
            ),
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
            child: FTextFormField(
              control: .managed(controller: controller, onChange: (value) => count++),
            ),
          ),
        ),
      );

      controller.text = 'other';

      key.currentState!.reset();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(count, 2);
    });
  });

  testWidgets('email - localized', (tester) async {
    await tester.pumpWidget(TestScaffold.app(locale: const Locale('zh'), child: const FTextFormField.email()));

    expect(find.text('电子邮件'), findsOneWidget);
  });

  testWidgets('password - localized', (tester) async {
    await tester.pumpWidget(TestScaffold.app(locale: const Locale('zh'), child: FTextFormField.password()));

    expect(find.text('密码'), findsOneWidget);
  });
}
