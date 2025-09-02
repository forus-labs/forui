import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTextField.password', () {
    testWidgets('password toggle displays correct icons and semantic labels', (tester) async {
      final obscure = ValueNotifier<bool>(true);
      addTearDown(obscure.dispose);

      await tester.pumpWidget(TestScaffold.app(child: FTextField.password(obscureText: obscure)));

      await tester.pumpAndSettle();

      // Initial state: password is obscured, eye icon shows 'Show password' label
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);

      final editableText = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableText.obscureText, isTrue);

      // Change visibility programmatically
      obscure.value = false;
      await tester.pumpAndSettle();

      // Password should now be visible, eye-off icon shows 'Hide password' label
      expect(find.bySemanticsLabel('Hide password'), findsOneWidget);
      expect(find.byIcon(FIcons.eyeOff), findsOneWidget);
      expect(find.bySemanticsLabel('Show password'), findsNothing);
      expect(find.byIcon(FIcons.eye), findsNothing);

      final editableTextAfter = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextAfter.obscureText, isFalse);

      // Change back to obscured
      obscure.value = true;
      await tester.pumpAndSettle();

      // Back to initial state
      expect(find.bySemanticsLabel('Show password'), findsOneWidget);
      expect(find.byIcon(FIcons.eye), findsOneWidget);
      expect(find.bySemanticsLabel('Hide password'), findsNothing);
      expect(find.byIcon(FIcons.eyeOff), findsNothing);

      final editableTextFinal = tester.widget<EditableText>(find.byType(EditableText));
      expect(editableTextFinal.obscureText, isTrue);
    });

    testWidgets('multiple password fields share same obscure state', (tester) async {
      final obscure = ValueNotifier<bool>(true);
      addTearDown(obscure.dispose);

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FTextField.password(obscureText: obscure),
              FTextField.password(
                obscureText: obscure,
                suffixBuilder: null,
                label: const Text('Confirm'),
              ),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Both fields start obscured
      final editableTexts = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
      expect(editableTexts.length, 2);
      expect(editableTexts[0].obscureText, isTrue);
      expect(editableTexts[1].obscureText, isTrue);

      // Only one toggle button should exist (the confirm field has no suffix)
      expect(find.byType(FButton), findsOneWidget);

      // Change visibility programmatically
      obscure.value = false;
      await tester.pumpAndSettle();

      // Both fields should now be unobscured
      final editableTextsAfter = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
      expect(editableTextsAfter[0].obscureText, isFalse);
      expect(editableTextsAfter[1].obscureText, isFalse);

      // Change back to obscured
      obscure.value = true;
      await tester.pumpAndSettle();

      // Both fields should be obscured again
      final editableTextsFinal = tester.widgetList<EditableText>(find.byType(EditableText)).toList();
      expect(editableTextsFinal[0].obscureText, isTrue);
      expect(editableTextsFinal[1].obscureText, isTrue);
    });
  });
}
