import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

class _Controller extends ValueNotifier<bool> {
  int listeners = 0;

  // ignore: avoid_positional_boolean_parameters
  _Controller(super._value);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    listeners++;
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    listeners--;
  }
}

void main() {
  const key = Key('field');

  group('initState', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller(true));

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: controller))),
      );

      // 2 listeners: _handleOnChange + ValueListenableBuilder
      expect(controller.listeners, 2);
    });
  });

  group('didUpdateWidget', () {
    testWidgets('external to lifted', (tester) async {
      final controller = autoDispose(_Controller(true));

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: controller))),
      );

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .lifted(value: true, onChange: (_) {}))),
      );

      expect(controller.listeners, 0);
    });

    testWidgets('external A to external B', (tester) async {
      final first = autoDispose(_Controller(true));
      final second = autoDispose(_Controller(false));

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: first))),
      );

      // 2 listeners: _handleOnChange + ValueListenableBuilder
      expect(first.listeners, 2);
      expect(second.listeners, 0);

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: second))),
      );

      expect(first.listeners, 0);
      expect(second.listeners, 2);
    });

    testWidgets('internal to external', (tester) async {
      final controller = autoDispose(_Controller(true));

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key)),
      );

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: controller))),
      );

      expect(controller.listeners, 2);
    });

    testWidgets('external to internal', (tester) async {
      final controller = autoDispose(_Controller(true));

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: controller))),
      );

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key)),
      );

      expect(controller.listeners, 0);
    });
  });

  group('dispose', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller(true));

      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .managed(controller: controller))),
      );

      await tester.pumpWidget(const SizedBox());

      expect(controller.listeners, 0);
    });

    testWidgets('managed with internal controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key)),
      );

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('lifted', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(child: FTextField.password(key: key, obscureTextControl: .lifted(value: true, onChange: (_) {}))),
      );

      await tester.pumpWidget(const SizedBox());
    });
  });
}
