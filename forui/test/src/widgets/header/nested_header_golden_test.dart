import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FNestedHeader', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FHeader.nested(
            style: TestScaffold.blueScreen.headerStyle.nestedStyle,
            title: const Text('Title'),
            prefixes: [
              FHeaderAction.back(onPress: () {}),
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
            ],
            suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}), FHeaderAction.x(onPress: () {})],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
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
              suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}), FHeaderAction.x(onPress: () {})],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/nested/${theme.name}.png'));
      });

      testWidgets('${theme.name} with no FNestedHeader actions', (tester) async {
        await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FHeader.nested(title: Text('Title'))));

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
              suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}), FHeaderAction.x(onPress: () {})],
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
  });
}
