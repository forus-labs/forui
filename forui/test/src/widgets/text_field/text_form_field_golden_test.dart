import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const _longText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure '
    'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non '
    'proident, sunt in culpa qui officia deserunt mollit anim id est laborum ';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FTextFormField(
          style: TestScaffold.blueScreen.textFieldStyle,
          label: const Text('My Label'),
          hint: 'hint',
          description: const Text('Some help text.'),
          forceErrorText: 'Error',
        ),
      ),
    );

    await expectBlueScreen(find.byType(MaterialApp));
  });

  for (final theme in TestScaffold.themes) {
    for (final (focused, focused_) in [('focused', true), ('unfocused', false)]) {
      for (final text in ['short text', null]) {
        testWidgets('default - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextFormField(
                control: .managed(initial: text == null ? null : TextEditingValue(text: text)),
                autofocus: focused_,
                label: const Text('My Label'),
                hint: 'hint',
                description: const Text('Some help text.'),
              ),
            ),
          );

          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('text-form-field/${theme.name}/default-$focused${text == null ? '-no-text' : ''}.png'),
          );
        });

        testWidgets('error - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextFormField(
                control: .managed(initial: text == null ? null : TextEditingValue(text: text)),
                autofocus: focused_,
                label: const Text('My Label'),
                hint: 'hint',
                forceErrorText: 'An error has occurred.',
              ),
            ),
          );

          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('text-form-field/${theme.name}/error-$focused${text == null ? '-no-text' : ''}.png'),
          );
        });

        testWidgets('email - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextFormField.email(
                control: .managed(initial: text == null ? null : TextEditingValue(text: text)),
                autofocus: focused_,
                hint: 'janedoe@duobase.io',
              ),
            ),
          );

          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('text-form-field/${theme.name}/email-$focused${text == null ? '-no-text' : ''}.png'),
          );
        });

        testWidgets('password - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextFormField.password(
                control: .managed(initial: text == null ? null : TextEditingValue(text: text)),
                autofocus: focused_,
                hint: 'password',
              ),
            ),
          );

          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('text-form-field/${theme.name}/password-$focused${text == null ? '-no-text' : ''}.png'),
          );
        });

        testWidgets('password - unobscured - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (
          tester,
        ) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextFormField.password(
                control: .managed(initial: text == null ? null : TextEditingValue(text: text)),
                obscureTextControl: const .managed(initial: false),
                autofocus: focused_,
                hint: 'password',
              ),
            ),
          );

          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'text-form-field/${theme.name}/password-unobscured-$focused${text == null ? '-no-text' : ''}.png',
            ),
          );
        });
      }

      for (final (text) in [_longText, null]) {
        testWidgets('multiline - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextFormField.multiline(
                control: .managed(initial: text == null ? null : TextEditingValue(text: text)),
                autofocus: focused_,
                label: const Text('My Label'),
                hint: 'hint',
              ),
            ),
          );

          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('text-form-field/${theme.name}/multiline-$focused${text == null ? '-no-text' : ''}.png'),
          );
        });
      }
    }

    testWidgets('counter text', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTextFormField(
            label: const Text('My Label'),
            counterBuilder: (context, current, max, focused) => Text('$current of $max'),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('text-form-field/${theme.name}/counter.png'));
    });

    testWidgets('iOS selection handles - ${theme.name}', (tester) async {
      debugDefaultTargetPlatformOverride = .iOS;

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: const FTextFormField(
            control: .managed(initial: TextEditingValue(text: 'text')),
          ),
        ),
      );

      await tester.tap(find.byType(FTextFormField));
      await tester.tap(find.byType(FTextFormField));
      await tester.tap(find.byType(FTextFormField));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('text-form-field/${theme.name}/ios-selection-handle.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });

    group('clearable', () {
      testWidgets('clear icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FTextFormField(clearable: (_) => true),
          ),
        );

        final gesture = await tester.createPointerGesture();

        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.bySemanticsLabel('Clear')));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('text-form-field/${theme.name}/clear-icon.png'));
      });

      testWidgets('clear & suffix icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FTextFormField(suffixBuilder: (_, _, _) => const Icon(FIcons.alarmClock), clearable: (_) => true),
          ),
        );

        final gesture = await tester.createPointerGesture();

        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.bySemanticsLabel('Clear')));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('text-form-field/${theme.name}/clear-suffix-icon.png'),
        );
      });

      testWidgets('custom clear icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FTextFormField(
              clearable: (_) => true,
              clearIconBuilder: (_, _, clear) => FButton.icon(onPress: clear, child: const Icon(FIcons.trash)),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();

        await tester.pump();
        await gesture.moveTo(tester.getCenter(find.byType(FButton)));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('text-form-field/${theme.name}/custom-clear-icon.png'),
        );
      });
    });
  }
}
