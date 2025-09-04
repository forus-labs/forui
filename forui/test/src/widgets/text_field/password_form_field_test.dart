import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTextFormField.password', () {
    testWidgets('password toggle displays correct icons and semantic labels', (tester) async {
      final obscure = autoDispose(ValueNotifier<bool>(true));

      await tester.pumpWidget(TestScaffold.app(child: FTextFormField.password(obscureText: obscure)));

      await tester.pumpAndSettle();

      // Initial state: password is obscured, eye icon shows 'Show password' label
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, true);

      // Change visibility programmatically
      obscure.value = false;
      await tester.pumpAndSettle();

      // Password should now be visible, eye-off icon shows 'Hide password' label
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeOff), findsOneWidget);
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, false);
    });

    testWidgets('password form field toggle changes from unobscured to obscured state', (tester) async {
      final obscure = autoDispose(ValueNotifier<bool>(false)); // Start unobscured

      await tester.pumpWidget(TestScaffold.app(child: FTextFormField.password(obscureText: obscure)));

      await tester.pumpAndSettle();

      // Initial state: password is unobscured, eye-off icon shows 'Hide password' label
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeOff), findsOneWidget);
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, false);

      // Change to obscured programmatically
      obscure.value = true;
      await tester.pumpAndSettle();

      // Should now be obscured, eye icon shows 'Show password' label
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, true);
    });

    testWidgets('pressing toggle button when password form field is visible hides it', (tester) async {
      final obscure = autoDispose(ValueNotifier<bool>(false)); // Start unobscured

      await tester.pumpWidget(TestScaffold.app(child: FTextFormField.password(obscureText: obscure)));

      await tester.pumpAndSettle();

      // Initial state: password is visible, hide button is available
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeOff), findsOneWidget);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, false);

      // Tap the hide button
      await tester.tap(find.bySemanticsLabel('Hide password'));
      await tester.pump(const Duration(milliseconds: 300)); // Wait for FTappable timer

      // Password should now be hidden
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, true);
    });

    testWidgets('multiple password form fields share same obscure state', (tester) async {
      final obscure = autoDispose(ValueNotifier<bool>(true));

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FTextFormField.password(obscureText: obscure),
              FTextFormField.password(obscureText: obscure, suffixBuilder: null, label: const Text('Confirm')),
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

    testWidgets('password form field with default obscure notifier starts obscured and toggles correctly', (
      tester,
    ) async {
      await tester.pumpWidget(TestScaffold.app(child: FTextFormField.password()));

      await tester.pumpAndSettle();

      // Initial state: password should be obscured by default
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, true);

      // Tap the toggle button to show password
      await tester.tap(find.bySemanticsLabel('Show password'));
      await tester.pump(const Duration(milliseconds: 300)); // Wait for FTappable timer

      // Password should now be visible
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeOff), findsOneWidget);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, false);

      // Tap again to hide password
      await tester.tap(find.bySemanticsLabel('Hide password'));
      await tester.pump(const Duration(milliseconds: 300)); // Wait for FTappable timer

      // Back to obscured state
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);

      final editableTextFinal = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextFinal.obscureText, true);
    });

    testWidgets('password form field integrates with Form validation', (tester) async {
      final formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: formKey,
            child: FTextFormField.password(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              onSaved: (value) {
                savedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Test empty validation
      final isValid1 = formKey.currentState!.validate();
      expect(isValid1, false);
      await tester.pumpAndSettle();
      expect(find.text('Password is required'), findsOneWidget);

      // Enter short password
      await tester.enterText(find.byType(EditableText), 'short');
      final isValid2 = formKey.currentState!.validate();
      expect(isValid2, false);
      await tester.pumpAndSettle();
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);

      // Enter valid password
      await tester.enterText(find.byType(EditableText), 'validpassword');
      final isValid3 = formKey.currentState!.validate();
      expect(isValid3, true);
      await tester.pumpAndSettle();
      expect(find.text('Password is required'), findsNothing);
      expect(find.text('Password must be at least 6 characters'), findsNothing);

      // Test save functionality
      formKey.currentState!.save();
      expect(savedValue, 'validpassword');
    });

    testWidgets('password form field preserves obscure state during validation', (tester) async {
      final obscure = autoDispose(ValueNotifier<bool>(false)); // Start visible

      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: formKey,
            child: FTextFormField.password(
              obscureText: obscure,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify password starts visible
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, false);

      // Trigger validation error
      formKey.currentState!.validate();
      await tester.pumpAndSettle();
      expect(find.text('Password is required'), findsOneWidget);

      // Verify obscure state is preserved
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, false);

      // Toggle visibility while error is showing
      await tester.tap(find.bySemanticsLabel('Hide password'));
      await tester.pump(const Duration(milliseconds: 300));

      // Verify toggle worked and error is still showing
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      final editableTextFinal = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextFinal.obscureText, true);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('password form field with custom suffix builder disables default toggle', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FTextFormField.password(suffixBuilder: (context, style, states) => const Icon(Icons.lock)),
        ),
      );

      await tester.pumpAndSettle();

      // Should not find the default toggle button
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);

      // Should find the custom suffix
      expect(find.byIcon(Icons.lock), findsOneWidget);

      // Password should remain obscured since no toggle is available
      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, true);
    });

    testWidgets('password form field with null suffix builder removes toggle entirely', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: FTextFormField.password(suffixBuilder: null)));

      await tester.pumpAndSettle();

      // Should not find any suffix
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);
      expect(find.byType(FButton), findsNothing);

      // Password should remain obscured
      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, true);
    });

    testWidgets('password form field reset functionality preserves toggle state', (tester) async {
      final formKey = GlobalKey<FormState>();
      final obscure = autoDispose(ValueNotifier<bool>(false)); // Start visible

      await tester.pumpWidget(
        TestScaffold.app(
          child: Form(
            key: formKey,
            child: FTextFormField.password(obscureText: obscure, initialText: 'initial'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify initial state
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      final editableText1 = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText1.obscureText, false);
      expect(editableText1.controller.text, 'initial');

      // Change text and toggle visibility
      await tester.enterText(find.byType(EditableText), 'changed');
      await tester.tap(find.bySemanticsLabel('Hide password'));
      await tester.pump(const Duration(milliseconds: 300));

      // Verify changes
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      final editableText2 = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText2.obscureText, true);
      expect(editableText2.controller.text, 'changed');

      // Reset form
      formKey.currentState!.reset();
      await tester.pumpAndSettle();

      // Verify text is reset but toggle state is preserved
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      final editableText3 = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText3.obscureText, true);
      expect(editableText3.controller.text, 'initial');
    });
  });
}
