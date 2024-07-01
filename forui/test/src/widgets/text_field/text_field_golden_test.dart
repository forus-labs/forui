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
    for (final (theme, theme_, _) in TestScaffold.themes) {
      for (final (focused, focused_) in [('focused', true), ('unfocused', false)]) {
        for (final (text, text_) in [('text', 'short text'), ('no-text', null)]) {
          testWidgets('default - $theme - $focused - $text', (tester) async {
            final controller = text_ == null ? null : TextEditingController(text: text_);
            await tester.pumpWidget(
              MaterialApp(
                home: TestScaffold(
                  data: theme_,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FTextField(
                      controller: controller,
                      autofocus: focused_,
                      label: const Text('My Label'),
                      hint: 'hint',
                      help: const Text('Some help text.'),
                    ),
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/default-$theme-$focused-$text.png'),
            );
          });

          testWidgets('error - $theme - $focused - $text', (tester) async {
            final controller = text_ == null ? null : TextEditingController(text: text_);
            await tester.pumpWidget(
              MaterialApp(
                home: TestScaffold(
                  data: theme_,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FTextField(
                      controller: controller,
                      autofocus: focused_,
                      label: const Text('My Label'),
                      hint: 'hint',
                      error: const Text('An error has occurred.'),
                    ),
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/error-$theme-$focused-$text.png'),
            );
          });

          testWidgets('email - $theme - $focused - $text', (tester) async {
            final controller = text_ == null ? null : TextEditingController(text: text_);
            await tester.pumpWidget(
              MaterialApp(
                home: TestScaffold(
                  data: theme_,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FTextField.email(
                      controller: controller,
                      autofocus: focused_,
                      hint: 'janedoe@foruslabs.com',
                    ),
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/email-$theme-$focused-$text.png'),
            );
          });

          testWidgets('password - $theme - $focused - $text', (tester) async {
            final controller = text_ == null ? null : TextEditingController(text: text_);
            await tester.pumpWidget(
              MaterialApp(
                home: TestScaffold(
                  data: theme_,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FTextField.password(
                      controller: controller,
                      autofocus: focused_,
                      hint: 'password',
                    ),
                  ),
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/password-$theme-$focused-$text.png'),
            );
          });
        }

        for (final (text, text_) in [('text', _longText), ('no-text', null)]) {
          testWidgets('multiline - $theme - $focused - $text', (tester) async {
            final controller = text_ == null ? null : TextEditingController(text: text_);
            await tester.pumpWidget(
              MaterialApp(
                home: TestScaffold(
                  data: theme_,
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
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text_field/multiline-$theme-$focused-$text.png'),
            );
          });
        }
      }
    }
  });
}
