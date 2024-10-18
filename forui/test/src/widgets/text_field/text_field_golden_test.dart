@Tags(['golden'])
library;

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
  group('FTextField', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FTextField(
                style: TestScaffold.blueScreen.textFieldStyle,
                label: const Text('My Label'),
                hint: 'hint',
                description: const Text('Some help text.'),
                forceErrorText: 'Error',
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(MaterialApp), isBlueScreen);
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final (focused, focused_) in [('focused', true), ('unfocused', false)]) {
        for (final text in ['short text', null]) {
          testWidgets('default - $name - $focused - ${text == null ? 'no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FTextField(
                    controller: controller,
                    autofocus: focused_,
                    label: const Text('My Label'),
                    hint: 'hint',
                    description: const Text('Some help text.'),
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/$name/default-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });

          testWidgets('error - $name - $focused - ${text == null ? 'no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FTextField(
                    controller: controller,
                    autofocus: focused_,
                    label: const Text('My Label'),
                    hint: 'hint',
                    forceErrorText: 'An error has occurred.',
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/$name/error-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });

          testWidgets('email - $name - $focused - ${text == null ? 'no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FTextField.email(
                    controller: controller,
                    autofocus: focused_,
                    hint: 'janedoe@foruslabs.com',
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/$name/email-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });

          testWidgets('password - $name - $focused - ${text == null ? 'no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FTextField.password(
                    controller: controller,
                    autofocus: focused_,
                    hint: 'password',
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/$name/password-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });
        }

        for (final (text) in [_longText, null]) {
          testWidgets('multiline - $name - $focused - ${text == null ? 'no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FTextField.multiline(
                    controller: controller,
                    autofocus: focused_,
                    label: const Text('My Label'),
                    hint: 'hint',
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/$name/multiline-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });
        }
      }
    }
  });
}
