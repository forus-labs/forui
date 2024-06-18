@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FButton', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final variant in FButtonVariant.values) {
        testWidgets('$name enabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  labelText: 'Button',
                  design: variant,
                  onPress: () {},
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name-$variant-enabled-button-content.png'),
          );
        });

        testWidgets('$name disabled with FButtonContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  text: 'Button',
                  design: variant,
                  onPress: null,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name-$variant-disabled-button-content.png'),
          );
        });

        testWidgets('$name with enabled raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.raw(
                  design: variant,
                  onPress: () {},
                  builder: (_, style) => Padding(
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
            matchesGoldenFile('button/$name-$variant-enabled-raw-content.png'),
          );
        });

        testWidgets('$name disabled with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton.raw(
                  design: variant,
                  onPress: null,
                  builder: (_, style) => Padding(
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
            matchesGoldenFile('button/$name-$variant-disabled-raw-content.png'),
          );
        });
      }
    }
  });
}
