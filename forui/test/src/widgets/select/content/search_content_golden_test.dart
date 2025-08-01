import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  for (final theme in TestScaffold.themes) {
    testWidgets('no results', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(key: key, format: (s) => s, filter: (_) => [], contentBuilder: (_, _) => []),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/search_content/no_results.png'),
      );
    });

    testWidgets('selected result', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(
            key: key,
            format: (s) => s,
            filter: (_) => [],
            contentBuilder: (_, _) => [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('B'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/search_content/selected-result.png'),
      );
    });

    testWidgets('sync', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(
            key: key,
            format: (s) => s,
            filter: (_) => [],
            contentBuilder: (_, _) => [FSelectItem('A', 'A')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/search_content/sync.png'));
    });

    testWidgets('async', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(
            key: key,
            format: (s) => s,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
            contentBuilder: (_, _) => [FSelectItem('A', 'A')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/search_content/async.png'));
    });

    testWidgets('async error with error builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(
            key: key,
            format: (s) => s,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 5));
              throw ArgumentError();
            },
            contentBuilder: (_, _) => [FSelectItem('A', 'A')],
            searchErrorBuilder: (_, error, trace) => Container(color: Colors.red, height: 10, width: 10),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/search_content/async_error_with_error_builder.png'),
      );

      await tester.pumpAndSettle();
    });

    testWidgets('async error with no error builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(
            key: key,
            format: (s) => s,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 5));
              throw ArgumentError();
            },
            contentBuilder: (_, data) => [for (final v in data.values) FSelectItem(v, v)],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/search_content/async_error.png'),
      );

      await tester.pumpAndSettle();
    });

    testWidgets('async loading', (tester) async {
      final completer = Completer<void>();

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.search(
            key: key,
            format: (s) => s,
            filter: (_) async {
              await completer.future;
              return [];
            },
            contentBuilder: (_, _) => [FSelectItem('A', 'A')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/search_content/async_loading.png'),
      );

      completer.complete();
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  }
}
