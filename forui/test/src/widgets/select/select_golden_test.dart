@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  for (final theme in TestScaffold.themes) {
    group('FSelect', () {
      testWidgets('auto-hide disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(key: key, autoHide: false, children: [FSelectItem.text('A'), FSelectItem.text('B')]),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await tester.tap(find.text('B'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/auto-hide-disabled.png'));
      });
    });

    group('FSelect.new', () {
      testWidgets('empty', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: const FSelect<String>(key: key, children: []),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/empty.png'));
      });
    });
  }
}
