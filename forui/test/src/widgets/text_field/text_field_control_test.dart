import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/text_field/text_field_control.dart';

import '../../test_scaffold.dart';

class _Controller extends TextEditingController {
  int listeners = 0;

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
  const key = Key('control');

  Widget builder(BuildContext context, TextEditingController controller, Widget? child) => Text(controller.text);

  group('initState', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: controller),
            builder: builder,
          ),
        ),
      );

      expect(controller.listeners, 1);
    });
  });

  group('didUpdateWidget', () {
    testWidgets('external to lifted', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: controller),
            builder: builder,
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .lifted(value: .empty, onChange: (_) {}),
            builder: builder,
          ),
        ),
      );

      expect(controller.listeners, 0);
    });

    testWidgets('external A to external B', (tester) async {
      final first = autoDispose(_Controller());
      final second = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: first),
            builder: builder,
          ),
        ),
      );

      expect(first.listeners, 1);
      expect(second.listeners, 0);

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: second),
            builder: builder,
          ),
        ),
      );

      expect(first.listeners, 0);
      expect(second.listeners, 1);
    });

    testWidgets('internal to external', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(key: key, control: const .managed(), builder: builder),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: controller),
            builder: builder,
          ),
        ),
      );

      expect(controller.listeners, 1);
    });

    testWidgets('external to internal', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: controller),
            builder: builder,
          ),
        ),
      );

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(key: key, control: const .managed(), builder: builder),
        ),
      );

      expect(controller.listeners, 0);
    });
  });

  group('dispose', () {
    testWidgets('managed with external controller', (tester) async {
      final controller = autoDispose(_Controller());

      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .managed(controller: controller),
            builder: builder,
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());

      expect(controller.listeners, 0);
    });

    testWidgets('managed with internal controller', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(key: key, control: const .managed(), builder: builder),
        ),
      );

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('lifted', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: TextFieldControl(
            key: key,
            control: .lifted(value: .empty, onChange: (_) {}),
            builder: builder,
          ),
        ),
      );

      await tester.pumpWidget(const SizedBox());
    });
  });
}
