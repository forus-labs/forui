import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('hide', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(child: FTextField.password(obscureTextController: autoDispose(ValueNotifier(false)))),
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
            FTextField.password(obscureTextController: controller),
            FTextField.password(obscureTextController: controller, suffixBuilder: null),
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

  group('obscureTextController', () {
    const key = Key('field');

    testWidgets('set value', (tester) async {
      final controller = autoDispose(ValueNotifier(false));

      await tester.pumpWidget(TestScaffold.app(child: FTextField.password(obscureTextController: controller)));

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

    testWidgets('old controller is not disposed', (tester) async {
      final first = autoDispose(FValueNotifier(false));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTextField.password(key: key, obscureTextController: first),
        ),
      );

      final second = autoDispose(FValueNotifier(true));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTextField.password(key: key, obscureTextController: first),
        ),
      );

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FValueNotifier(false));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTextField.password(key: key, obscureTextController: controller),
        ),
      );
      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));
      expect(controller.disposed, false);
    });
  });
}
