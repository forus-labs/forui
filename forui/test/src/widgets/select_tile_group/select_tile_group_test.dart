import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSelectTileGroup', () {
    testWidgets('press select tile with prefix check icon', (tester) async {
      final controller = FRadioSelectGroupController<int>();

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FSelectTileGroup(
            controller: controller,
            children: [
              FSelectTile(
                title: const Text('1'),
                value: 1,
              ),
              FSelectTile(
                title: const Text('2'),
                value: 2,
              ),
            ],
          ),
        ),
      );
      expect(controller.values, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.values, {2});
    });

    testWidgets('press select tile with suffix check icon', (tester) async {
      final controller = FRadioSelectGroupController<int>();

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FSelectTileGroup(
            controller: controller,
            children: [
              FSelectTile.suffix(
                title: const Text('1'),
                value: 1,
              ),
              FSelectTile.suffix(
                title: const Text('2'),
                value: 2,
              ),
            ],
          ),
        ),
      );
      expect(controller.values, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.values, {2});
    });

    testWidgets('press already selected tile', (tester) async {
      final controller = FRadioSelectGroupController<int>(value: 2);

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FSelectTileGroup(
            controller: controller,
            children: [
              FSelectTile.suffix(
                title: const Text('1'),
                value: 1,
              ),
              FSelectTile.suffix(
                title: const Text('2'),
                value: 2,
              ),
            ],
          ),
        ),
      );
      expect(controller.values, {2});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.values, {2});
    });

    testWidgets('press nested select tile', (tester) async {
      final controller = FRadioSelectGroupController<int>();

      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: FTileGroup.merge(
            children: [
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('A'),
                  ),
                  FTile(
                    title: const Text('B'),
                  ),
                ],
              ),
              FSelectTileGroup(
                controller: controller,
                children: [
                  FSelectTile(
                    title: const Text('1'),
                    value: 1,
                  ),
                  FSelectTile(
                    title: const Text('2'),
                    value: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      expect(controller.values, <int>{});

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      expect(controller.values, {2});
    });
  });
}
