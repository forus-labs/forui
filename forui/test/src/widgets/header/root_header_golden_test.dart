import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const title =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

void main() {
  group('FRootHeader', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FHeader(
            style: TestScaffold.blueScreen.headerStyle.rootStyle,
            title: const Text('Title'),
            actions: [
              FHeaderAction.back(onPress: () {}),
              const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with FRootHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FHeader(
              title: const Text(title),
              actions: [
                const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
                FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}.png'));
      });

      testWidgets('${theme.name} with focused FRootHeader actions', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FHeader(
              title: const Text(title),
              actions: [
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
            child: FHeader(
              title: const Text(title),
              actions: [
                const FHeaderAction(icon: Icon(FIcons.alarmClock), onPress: null),
                FHeaderAction(icon: const Icon(FIcons.plus), onPress: () {}),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('header/root/${theme.name}-rtl.png'));
      });
    }
  });
}
