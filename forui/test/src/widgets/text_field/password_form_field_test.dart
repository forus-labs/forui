import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hide', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(child: FTextFormField.password(obscureTextController: autoDispose(ValueNotifier(false)))),
    );

    expect(find.bySemanticsLabel('Hide password'), findsOne);
    expect(find.byIcon(FIcons.eyeClosed), findsOne);

    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, false);

    await tester.tap(find.byIcon(FIcons.eyeClosed));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.bySemanticsLabel('Show password'), findsOne);
    expect(find.byIcon(FIcons.eye), findsOne);
    expect(find.bySemanticsLabel('Hide password'), findsNothing);
    expect(find.byIcon(FIcons.eyeClosed), findsNothing);

    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, true);
  });

  testWidgets('multiple fields', (tester) async {
    final controller = autoDispose(ValueNotifier(true));

    await tester.pumpWidget(
      TestScaffold.app(
        child: Column(
          children: [
            FTextFormField.password(obscureTextController: controller),
            FTextFormField.password(obscureTextController: controller, suffixBuilder: null),
          ],
        ),
      ),
    );

    var fields = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
    expect(fields[0].obscureText, true);
    expect(fields[1].obscureText, true);

    expect(find.byIcon(FIcons.eye), findsOneWidget);

    controller.value = false;
    await tester.pumpAndSettle();

    fields = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
    expect(fields[0].obscureText, false);
    expect(fields[1].obscureText, false);
  });

  testWidgets('custom suffix disables toggle', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTextFormField.password(suffixBuilder: (_, _, _, _) => const Icon(Icons.lock)),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Show password'), findsNothing);
    expect(find.bySemanticsLabel('Hide password'), findsNothing);
    expect(find.byIcon(FIcons.eye), findsNothing);
    expect(find.byIcon(FIcons.eyeClosed), findsNothing);
    expect(find.byIcon(Icons.lock), findsOneWidget);

    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, true);
  });

  testWidgets('reset preserves obscured state', (tester) async {
    final key = GlobalKey<FormState>();
    final obscure = autoDispose(ValueNotifier<bool>(false));

    await tester.pumpWidget(
      TestScaffold.app(
        child: Form(
          key: key,
          child: FTextFormField.password(obscureTextController: obscure, initialText: 'initial'),
        ),
      ),
    );

    var field = tester.widget<EditableText>(find.byType(EditableText));
    expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
    expect(field.obscureText, false);
    expect(field.controller.text, 'initial');

    await tester.enterText(find.byType(EditableText), 'changed');
    await tester.tap(find.bySemanticsLabel('Hide password'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    field = tester.widget<EditableText>(find.byType(EditableText));
    expect(find.bySemanticsLabel('Show password'), findsOneWidget);
    expect(field.obscureText, true);
    expect(field.controller.text, 'changed');

    key.currentState!.reset();
    await tester.pumpAndSettle();

    field = tester.widget<EditableText>(find.byType(EditableText));
    expect(find.bySemanticsLabel('Show password'), findsOneWidget);
    expect(field.obscureText, true);
    expect(field.controller.text, 'initial');
  });
}
