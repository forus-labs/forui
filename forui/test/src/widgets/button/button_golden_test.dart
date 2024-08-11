@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';
import '../../test_scaffold.dart';

void main() {
  group('FButton', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$name enabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  label: const Text('Button'),
                  style: variant,
                  prefix: FButtonIcon(icon: FAssets.icons.circlePlay),
                  suffix: FButtonIcon(icon: FAssets.icons.circleStop),
                  onPress: () {},
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
                'button/$name-$variant-enabled-content-button.png'),
          );
        });

        testWidgets('$name disabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  label: const Text('Button'),
                  style: variant,
                  prefix: FButtonIcon(icon: FAssets.icons.circlePlay),
                  suffix: FButtonIcon(icon: FAssets.icons.circleStop),
                  onPress: null,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
                'button/$name-$variant-disabled-content-button.png'),
          );
        });

        testWidgets('$name with enabled raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.raw(
                  style: variant,
                  onPress: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blueAccent,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name-$variant-enabled-raw-button.png'),
          );
        });

        testWidgets('$name disabled with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.raw(
                  style: variant,
                  onPress: null,
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blueAccent,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name-$variant-disabled-raw-button.png'),
          );
        });

        testWidgets('$name with enabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.icon(
                  onPress: () {},
                  style: variant,
                  child: FButtonIcon(
                    icon: FAssets.icons.chevronRight,
                  ),

                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/$name-$variant-icon-enabled-button.png',
            ),
          );
        });

        testWidgets('$name with disabled icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.icon(
                  onPress: null,
                  style: variant,
                  child: FButtonIcon(
                    icon: FAssets.icons.chevronRight,
                  ),

                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/$name-$variant-icon-disabled-button.png',
            ),
          );
        });
      }
    }
  });
}

//flutter test --update-goldens /Users/somyemahajan/Projects/forui/forui/test/src/widgets/button/button_golden_test.dart
