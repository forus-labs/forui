import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('linear', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FProgress(style: TestScaffold.blueScreen.progressStyles.linearProgressStyle, value: 0.5),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      for (final value in [0.0, 0.5, 1.0]) {
        testWidgets('${theme.name} - $value', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FProgress(value: value),
            ),
          );
          await tester.pumpAndSettle();

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('progress/linear/${theme.name}/$value.png'));
        });
      }

      testWidgets('${theme.name} - indefinite', (tester) async {
        await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FProgress()));
        await tester.pump(const Duration(milliseconds: 500));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('progress/linear/${theme.name}/indefinite.png'));
      });
    }

    testWidgets('update value double', (tester) async {
      await tester.pumpWidget(TestScaffold(child: const FProgress(value: 0.5)));
      await tester.pumpWidget(TestScaffold(child: const FProgress(value: 1)));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('progress/linear/update-value-double.png'));
    });

    testWidgets('update value to null', (tester) async {
      await tester.pumpWidget(TestScaffold(child: const FProgress(value: 1)));
      await tester.pumpWidget(TestScaffold(child: const FProgress()));
      await tester.pump(const Duration(milliseconds: 300));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('progress/linear/update-value-numer.png'));
    });
  });

  group('circular', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FProgress.circularIcon(style: TestScaffold.blueScreen.progressStyles.circularIconProgressStyle),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} - indefinite', (tester) async {
        await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FProgress.circularIcon()));
        await tester.pump(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('progress/circular/${theme.name}/indefinite.png'),
        );
      });
    }
  });
}
