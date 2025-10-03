import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const title =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna '
    'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FHeader(
          style: TestScaffold.blueScreen.headerStyles.rootStyle,
          title: const Text('Title'),
          suffixes: [
            FHeaderAction.back(onPress: () {}),
            const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
          ],
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with FRootHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader(
            title: const Text(title),
            suffixes: [
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
              FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}.png'));
    });

    testWidgets('${theme.name} glassmorphic', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  FHeader(
                    style: theme.data.headerStyles.rootStyle.copyWith(
                      backgroundFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      decoration: BoxDecoration(color: theme.data.colors.background.withValues(alpha: 0.5)),
                    ),
                    title: const Text('Title'),
                    suffixes: [
                      FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
                      FHeaderAction.x(onPress: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}-glassmorphic.png'));
    });

    testWidgets('${theme.name} larger title', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: Builder(
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(color: context.theme.colors.primary)),
                  child: FHeader(
                    title: Text('Title', style: context.theme.typography.xl3),
                    suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}-larger-title.png'));
    });

    testWidgets('${theme.name} smaller title', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: Builder(
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(color: context.theme.colors.primary)),
                  child: FHeader(
                    title: Text('Title', style: context.theme.typography.xs),
                    suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}-smaller-title.png'));
    });

    testWidgets('${theme.name} with focused FRootHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader(
            title: const Text(title),
            suffixes: [
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
              FHeaderAction(autofocus: true, icon: const Icon(FIcons.plus), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}-focused.png'));
    });

    testWidgets('${theme.name} with RTL FRootHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          textDirection: TextDirection.rtl,
          child: const FHeader(
            title: Text(title),
            suffixes: [
              FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
              FHeaderAction(icon: Icon(FIcons.plus), onPress: null),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}-rtl.png'));
    });
  }
}
