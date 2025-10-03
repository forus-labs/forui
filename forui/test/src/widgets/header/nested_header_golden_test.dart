import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FHeader.nested(
          style: TestScaffold.blueScreen.headerStyles.nestedStyle,
          title: const Text('Title'),
          prefixes: [
            FHeaderAction.back(onPress: () {}),
            const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
          ],
          suffixes: [
            FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
            FHeaderAction.x(onPress: () {}),
          ],
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with FNestedHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader.nested(
            title: const Text('Title'),
            prefixes: [
              FHeaderAction.back(onPress: () {}),
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
            ],
            suffixes: [
              FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
              FHeaderAction.x(onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}.png'));
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
                  FHeader.nested(
                    style: theme.data.headerStyles.nestedStyle.copyWith(
                      backgroundFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      decoration: BoxDecoration(color: theme.data.colors.background.withValues(alpha: 0.5)),
                    ),
                    title: const Text('Title'),
                    prefixes: [
                      FHeaderAction.back(onPress: () {}),
                      const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
                    ],
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-glassmorphic.png'));
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
                  child: FHeader.nested(
                    title: Text('Title', style: context.theme.typography.xl3),
                    prefixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                    suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-larger-title.png'));
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
                  child: FHeader.nested(
                    title: Text('Title', style: context.theme.typography.xs),
                    prefixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                    suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-smaller-title.png'));
    });

    testWidgets('${theme.name} with no FNestedHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FHeader.nested(title: Text('Title')),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-no-actions.png'));
    });

    testWidgets('${theme.name} with focused FNestedHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FHeader.nested(
            title: const Text('Title'),
            prefixes: [
              FHeaderAction.back(onPress: () {}),
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
            ],
            suffixes: [
              FHeaderAction(autofocus: true, icon: const Icon(FIcons.plus), onPress: () {}),
              FHeaderAction.x(onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-focused.png'));
    });

    testWidgets('${theme.name} with RTL FNestedHeader actions', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          textDirection: TextDirection.rtl,
          child: FHeader.nested(
            title: const Text('Title'),
            prefixes: [
              FHeaderAction.back(onPress: () {}),
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
            ],
            suffixes: [
              FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
              FHeaderAction.x(onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}-rtl.png'));
    });

    testWidgets('${theme.name} with prefix + title aligned start + no suffix', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader.nested(
            titleAlignment: Alignment.centerLeft,
            title: const Text('Title'),
            prefixes: [FHeaderAction.back(onPress: () {})],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('header/nested/${theme.name}-prefix-start-no-suffix.png'),
      );
    });

    testWidgets('${theme.name} with prefix + title aligned end + no suffix', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader.nested(
            titleAlignment: Alignment.centerRight,
            title: const Text('Title'),
            prefixes: [FHeaderAction.back(onPress: () {})],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('header/nested/${theme.name}-prefix-end-no-suffix.png'),
      );
    });

    testWidgets('${theme.name} with no prefix + title aligned start + suffix', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader.nested(
            titleAlignment: Alignment.centerLeft,
            title: const Text('Title'),
            suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('header/nested/${theme.name}-no-prefix-start-suffix.png'),
      );
    });

    testWidgets('${theme.name} with no prefix + title aligned end + suffix', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FHeader.nested(
            titleAlignment: Alignment.centerRight,
            title: const Text('Title'),
            suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {})],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('header/nested/${theme.name}-no-prefix-end-suffix.png'),
      );
    });

    testWidgets('${theme.name} with no prefix + title aligned start + no suffix', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FHeader.nested(titleAlignment: Alignment.centerLeft, title: Text('Title')),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('header/nested/${theme.name}-no-prefix-start-no-suffix.png'),
      );
    });

    testWidgets('${theme.name} with no prefix + title aligned end + no suffix', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FHeader.nested(titleAlignment: Alignment.centerRight, title: Text('Title')),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('header/nested/${theme.name}-no-prefix-end-no-suffix.png'),
      );
    });
  }
}
