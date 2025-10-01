import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('showFDialog', () {
    testWidgets('tap on barrier does not dismiss dialog', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                barrierDismissible: false,
                context: context,
                builder: (context, _, animation) => FDialog(
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(style: FButtonStyle.outline(), onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.text('Are you absolutely sure?'), findsOneWidget);
    });

    testWidgets('tap on barrier dismisses dialog', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          child: Builder(
            builder: (context) => FButton(
              onPress: () => showFDialog(
                context: context,
                builder: (context, _, animation) => FDialog(
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: [
                    FButton(onPress: () {}, child: const Text('Continue')),
                    FButton(style: FButtonStyle.outline(), onPress: () {}, child: const Text('Cancel')),
                  ],
                ),
              ),
              child: const Text('button'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      expect(find.text('Are you absolutely sure?'), findsOneWidget);

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.text('Are you absolutely sure?'), findsNothing);
    });
  });

  group('FDialog', () {
    for (final direction in Axis.values) {
      testWidgets('$direction infinite sized child', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FDialog(
              direction: direction,
              title: const Text('Are you absolutely sure?'),
              body: SingleChildScrollView(
                child: Text.rich(
                  WidgetSpan(
                    child: Stack(
                      children: [Container(height: 200, width: double.infinity, color: Colors.red)],
                    ),
                  ),
                ),
              ),
              actions: [
                FButton(child: const Text('Continue'), onPress: () {}),
                FButton(style: FButtonStyle.outline(), child: const Text('Cancel'), onPress: () {}),
              ],
            ),
          ),
        );

        expect(tester.takeException(), null);
      });
    }

    testWidgets('scrollable body', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton(
              mainAxisSize: MainAxisSize.min,
              onPress: () => showFDialog(
                context: context,
                builder: (context, style, animation) => FDialog(
                  style: style,
                  animation: animation,
                  title: const Text('Are you absolutely sure?'),
                  body: SingleChildScrollView(child: Container(height: 5000)),
                  actions: [
                    FButton(style: FButtonStyle.outline(), child: const Text('Cancel'), onPress: () {}),
                    FButton(child: const Text('Continue'), onPress: () {}),
                  ],
                ),
              ),
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), null);
    });
  });
}
