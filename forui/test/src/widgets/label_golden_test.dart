@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FLabel', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final state in FLabelState.values) {
        testWidgets('$name horizontal with ${state}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: SizedBox(
                width: 300,
                child: FLabel(
                  axis: Axis.horizontal,
                  label: Text('Email'),
                  description: Text('Enter your email address.'),
                  error: Text('Please enter a valid email address.'),
                  state: state,
                  child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.grey),
                    child: SizedBox(width: 16, height: 16),
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('label/$name-horizontal-${state}.png'),
          );
        });
      }

      for (final state in FLabelState.values) {
        testWidgets('$name vertical with ${state}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: FLabel(
                axis: Axis.vertical,
                label: Text('Email'),
                description: Text('Enter your email address.'),
                error: Text('Please enter a valid email address.'),
                state: state,
                child: DecoratedBox(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.grey),
                  child: SizedBox(width: 200, height: 30),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('label/$name-vertical-${state}.png'),
          );
        });
      }
    }
  });
}
