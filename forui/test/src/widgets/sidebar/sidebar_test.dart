import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('focus', () {
    testWidgets('shift focus outside', (tester) async {
      final first = autoDispose(FocusNode());
      final second = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FSidebar(
                  children: [FSidebarItem(focusNode: first, label: const Text('Item 1'), onPress: () {})],
                ),
              ),
              FTextField(focusNode: second),
            ],
          ),
        ),
      );

      first.requestFocus();
      await tester.pumpAndSettle();

      expect(first.hasFocus, true);
      expect(second.hasFocus, false);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      expect(first.hasFocus, false);
      expect(second.hasFocus, true);
    });

    testWidgets('does not shift focus outside', (tester) async {
      final first = autoDispose(FocusNode());
      final second = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FSidebar(
                  traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
                  children: [FSidebarItem(focusNode: first, label: const Text('Item 1'), onPress: () {})],
                ),
              ),
              FTextField(focusNode: second),
            ],
          ),
        ),
      );

      first.requestFocus();
      await tester.pumpAndSettle();

      expect(first.hasFocus, true);
      expect(second.hasFocus, false);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      expect(first.hasFocus, true);
      expect(second.hasFocus, false);
    });
  });

  group('state', () {
    testWidgets('update focusNode', (tester) async {
      final first = autoDispose(FocusScopeNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSidebar(
            focusNode: first,
            children: [FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {})],
          ),
        ),
      );

      expect(first.context, isNotNull);

      final second = autoDispose(FocusScopeNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSidebar(
            focusNode: second,
            children: [FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {})],
          ),
        ),
      );

      expect(first.context, isNotNull);
      expect(second.context, isNotNull);
    });

    testWidgets('dispose focusNode', (tester) async {
      final node = autoDispose(FocusScopeNode());
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSidebar(
            focusNode: node,
            children: [FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {})],
          ),
        ),
      );

      expect(node.context, isNotNull);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(node.context, isNotNull);
    });
  });
}
