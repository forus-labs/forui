import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTextField.password', () {
    testWidgets('password toggle changes from unobscured to obscured state', (tester) async {
      final controller = autoDispose(ValueNotifier(false));

      await tester.pumpWidget(TestScaffold.app(child: FTextField.password(obscureTextController: controller)));

      await tester.pumpAndSettle();

      // Initial state: password is unobscured, eye-off icon shows 'Hide password' label
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeClosed), findsOneWidget);
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, false);

      // Change to obscured programmatically
      controller.value = true;
      await tester.pumpAndSettle();

      // Should now be obscured, eye icon shows 'Show password' label
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeClosed), findsNothing);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, true);
    });

    testWidgets('pressing toggle button when password is visible hides it', (tester) async {
      final obscure = autoDispose(ValueNotifier<bool>(false)); // Start unobscured

      await tester.pumpWidget(TestScaffold.app(child: FTextField.password(obscureTextController: obscure)));

      await tester.pumpAndSettle();

      // Initial state: password is visible, hide button is available
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeClosed), findsOneWidget);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, false);

      // Tap the hide button
      await tester.tap(find.bySemanticsLabel('Hide password'));
      await tester.pump(const Duration(milliseconds: 300)); // Wait for FTappable timer

      // Password should now be hidden
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeClosed), findsNothing);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, true);
    });

    testWidgets('multiple password fields share same obscure state', (tester) async {
      final obscure = autoDispose(ValueNotifier(true));

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FTextField.password(obscureTextController: obscure),
              FTextField.password(obscureTextController: obscure, suffixBuilder: null, label: const Text('Confirm')),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Both fields start obscured
      final editableTexts = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
      expect(editableTexts.length, 2);
      expect(editableTexts[0].obscureText, true);
      expect(editableTexts[1].obscureText, true);

      // Only one toggle button should exist (the confirm field has no suffix)
      expect(find.byType(FButton), findsOneWidget);

      // Change visibility programmatically
      obscure.value = false;
      await tester.pumpAndSettle();

      // Both fields should now be unobscured
      final editableTextsAfter = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
      expect(editableTextsAfter[0].obscureText, false);
      expect(editableTextsAfter[1].obscureText, false);

      // Change back to obscured
      obscure.value = true;
      await tester.pumpAndSettle();

      // Both fields should be obscured again
      final editableTextsFinal = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
      expect(editableTextsFinal[0].obscureText, true);
      expect(editableTextsFinal[1].obscureText, true);
    });

    testWidgets('password field with default obscure notifier starts obscured and toggles correctly', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: FTextField.password()));

      await tester.pumpAndSettle();

      // Initial state: password should be obscured by default
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, true);

      // Tap the toggle button to show password
      await tester.tap(find.bySemanticsLabel('Show password'));
      await tester.pump(const Duration(milliseconds: 300));

      // Password should now be visible
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeClosed), findsOneWidget);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, false);

      // Tap again to hide password
      await tester.tap(find.bySemanticsLabel('Hide password'));
      await tester.pump(const Duration(milliseconds: 300));

      // Back to obscured state
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);

      final editableTextFinal = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextFinal.obscureText, true);
    });
  });
}
