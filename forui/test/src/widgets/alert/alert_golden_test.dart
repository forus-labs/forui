@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/alert/alert.dart';
import '../../test_scaffold.dart';

void main() {
  group('FAlert', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$name with default icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FAlert(
                  title: const Text('Alert Title'),
                  subtitle: const Text('Alert description with extra text'),
                  style: variant,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('alert/$name-$variant-with-default-icon.png'),
          );
        });

        testWidgets('$name without user icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FAlert(
                  icon: FAlertIcon(icon: FAssets.icons.badgeAlert),
                  title: const Text('Alert Title'),
                  subtitle: const Text('Alert description with extra text'),
                  style: variant,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('alert/$name-$variant-without-user-icon.png'),
          );
        });
      }
    }
  });
}
