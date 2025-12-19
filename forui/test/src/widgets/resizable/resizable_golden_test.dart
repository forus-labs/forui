import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FResizable', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FResizable(
            style: TestScaffold.blueScreen.resizableStyle,
            axis: .vertical,
            crossAxisExtent: 100,
            children: [
              FResizableRegion(
                initialExtent: 150,
                builder: (_, _, child) => child!,
                child: const Align(child: Text('')),
              ),
              FResizableRegion(
                initialExtent: 300,
                builder: (_, _, child) => child!,
                child: const Align(child: Text('')),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });

    for (final theme in TestScaffold.themes) {
      for (final axis in Axis.values) {
        for (final divider in FResizableDivider.values) {
          testWidgets('${theme.name} - $axis - $divider', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: .all(color: theme.data.colors.border),
                    borderRadius: .circular(8),
                  ),
                  child: FResizable(
                    axis: axis,
                    divider: divider,
                    crossAxisExtent: 100,
                    children: [
                      FResizableRegion(
                        initialExtent: 150,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('A')),
                      ),
                      FResizableRegion(
                        initialExtent: 300,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('B')),
                      ),
                    ],
                  ),
                ),
              ),
            );

            await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/${theme.name}/$axis-$divider.png'));
          });

          testWidgets('${theme.name} - $axis - $divider - focused', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: .all(color: theme.data.colors.border),
                    borderRadius: .circular(8),
                  ),
                  child: FResizable(
                    axis: axis,
                    divider: divider,
                    crossAxisExtent: 100,
                    children: [
                      FResizableRegion(
                        initialExtent: 150,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('A')),
                      ),
                      FResizableRegion(
                        initialExtent: 300,
                        builder: (_, _, child) => child!,
                        child: const Align(child: Text('B')),
                      ),
                    ],
                  ),
                ),
              ),
            );

            await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/${theme.name}/$axis-$divider.png'));
          });
        }
      }
    }

    for (final axis in Axis.values) {
      testWidgets('expanded - $axis', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FScaffold(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: .all(color: FThemes.zinc.light.colors.border),
                  borderRadius: .circular(8),
                ),
                child: FResizable(
                  axis: axis,
                  children: [
                    FResizableRegion(
                      initialExtent: 150,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('A')),
                    ),
                    FResizableRegion(
                      initialExtent: 300,
                      builder: (_, _, child) => child!,
                      child: const Align(child: Text('B')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/expanded-$axis.png'));
      });
    }
  });
}
