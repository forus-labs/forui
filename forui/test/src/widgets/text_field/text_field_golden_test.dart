import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
        TestScaffold.blue(
          child: FTextField(
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
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FTextField(
                  controller: controller,
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
              matchesGoldenFile('text-field/${theme.name}/default-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });

          testWidgets('error - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FTextField(
                  controller: controller,
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
              matchesGoldenFile('text-field/${theme.name}/error-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });

          testWidgets('email - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FTextField.email(controller: controller, autofocus: focused_, hint: 'janedoe@foruslabs.com'),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text-field/${theme.name}/email-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });

          testWidgets('password - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FTextField.password(controller: controller, autofocus: focused_, hint: 'password'),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text-field/${theme.name}/password-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });
        }

        for (final (text) in [_longText, null]) {
          testWidgets('multiline - ${theme.name} - $focused ${text == null ? '- no text' : ''}', (tester) async {
            final controller = text == null ? null : TextEditingController(text: text);
            await tester.pumpWidget(
              TestScaffold.app(
                theme: theme.data,
                child: FTextField.multiline(
                  controller: controller,
                  autofocus: focused_,
                  label: const Text('My Label'),
                  hint: 'hint',
                ),
              ),
            );

            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('text-field/${theme.name}/multiline-$focused${text == null ? '-no-text' : ''}.png'),
            );
          });
        }
      }

      testWidgets('counter text', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FTextField(
              label: const Text('My Label'),
              counterBuilder: (context, current, max, focused) => Text('$current of $max'),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('text-field/${theme.name}/counter.png'));
      });

      testWidgets('iOS selection handles - ${theme.name}', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        final controller = TextEditingController(text: 'text');

        await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FTextField(controller: controller)));

        await tester.tap(find.byType(FTextField));
        await tester.tap(find.byType(FTextField));
        await tester.tap(find.byType(FTextField));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('text-field/${theme.name}/ios-selection-handle.png'),
        );

        debugDefaultTargetPlatformOverride = null;
      });

      group('clearable', () {
        testWidgets('clear icon', (tester) async {
          await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FTextField(clearable: (_) => true)));

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);

          await tester.pump();
          await gesture.moveTo(tester.getCenter(find.bySemanticsLabel('Clear')));
          await tester.pumpAndSettle();

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('text-field/${theme.name}/clear-icon.png'));
        });

        testWidgets('clear & suffix icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FTextField(suffixBuilder: (_, _, _) => const Icon(FIcons.alarmClock), clearable: (_) => true),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);

          await tester.pump();
          await gesture.moveTo(tester.getCenter(find.bySemanticsLabel('Clear')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('text-field/${theme.name}/clear-suffix-icon.png'),
          );
        });
      });
    }
  });
}
