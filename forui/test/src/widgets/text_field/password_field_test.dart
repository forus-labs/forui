import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('lifted', (tester) async {
    var value = const TextEditingValue(text: 'initial');
    TextEditingValue? received;

    Widget buildWidget() => TestScaffold.app(
      child: FTextField.password(
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

  testWidgets('hide', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(child: FTextField.password(obscureTextControl: .managed(controller: autoDispose(ValueNotifier(false))))),
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
            FTextField.password(obscureTextControl: .managed(controller: controller)),
            FTextField.password(obscureTextControl: .managed(controller: controller), suffixBuilder: null),
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

  group('obscureTextControl', () {
    testWidgets('lifted', (tester) async {
      var value = true;
      bool? received;

      Widget buildWidget() => TestScaffold.app(
        child: FTextField.password(
          obscureTextControl: .lifted(
            value: value,
            onChange: (v) => received = v,
          ),
        ),
      );

      await tester.pumpWidget(buildWidget());

      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, true);

      await tester.tap(find.byIcon(FIcons.eye));
      await tester.pumpAndSettle();
      expect(received, false);

      value = false;
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();
      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, false);
    });

    testWidgets('managed', (tester) async {
      final controller = autoDispose(ValueNotifier(false));

      await tester.pumpWidget(TestScaffold.app(child: FTextField.password(obscureTextControl: .managed(controller: controller))));

      expect(find.bySemanticsLabel('Hide password'), findsOne);
      expect(find.byIcon(FIcons.eyeClosed), findsOne);
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);

      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, false);

      controller.value = true;
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Show password'), findsOne);
      expect(find.byIcon(FIcons.eye), findsOne);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeClosed), findsNothing);

      expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, true);
    });
  });
}
