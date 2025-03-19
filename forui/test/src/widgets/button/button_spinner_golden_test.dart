@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';
import '../../test_scaffold.dart';

void main() {
  group('Circular progress indicator', () {
    for (final theme in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('${theme.name} with enabled circular progress', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                prefix: const FProgress.circularIcon(),
                label: const Text('Loading'),
                onPress: () {},
                style: variant,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/${theme.name}/$variant/circular-progress-enabled-button.png'),
          );
        });

        testWidgets('${theme.name} with disabled circular progress', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FButton(
                prefix: const FProgress.circularIcon(),
                label: const Text('Loading'),
                onPress: null,
                style: variant,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/${theme.name}/$variant/circular-progress-disabled-button.png'),
          );
        });
      }
    }
  });
}
