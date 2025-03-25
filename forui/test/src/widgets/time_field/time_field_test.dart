// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/widgets/time_field/time_field.dart';

import '../../locale_scaffold.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, field) in [
    ('input only', (controller, focus) => FTimeField(controller: controller, focusNode: focus)),
    (
    'picker only',
        (controller, focus) => FTimeField.picker(controller: controller, focusNode: focus),
    ),
  ]) {
    group(name, () {
      testWidgets('update controller', (tester) async {
        final first = FTimeFieldController(vsync: tester);

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(first, null))));

        expect(first.disposed, false);

        final second = FTimeFieldController(vsync: tester);

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(second, null))));

        // We remove the internal update controllers to prevent interference with the assertion.
        first.removeValueListener(first.update);
        second.removeValueListener(second.update);

        expect(first.popover.hasListeners, false);
        expect(first.disposed, false);
        expect(second.disposed, false);
      });

      testWidgets('dispose controller', (tester) async {
        final controller = FTimeFieldController(vsync: tester);

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(controller, null))));

        expect(controller.hasListeners, true);
        expect(controller.disposed, false);

        await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
        await tester.pumpAndSettle();

        // We remove the internal update controllers to prevent interference with the assertion.
        controller.removeValueListener(controller.update);

        expect(controller.popover.hasListeners, false);
        expect(controller.disposed, false);
      });

      testWidgets('update focus', (tester) async {
        final first = FocusNode();

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));

        expect(first.hasListeners, true);

        final second = FocusNode();

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, second))));

        expect(first.hasListeners, false);
        expect(second.hasListeners, true);
      });

      testWidgets('dispose focus', (tester) async {
        final first = FocusNode();

        await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));
        expect(first.hasListeners, true);

        await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
        expect(first.hasListeners, false);
      });
    });
  }
}
