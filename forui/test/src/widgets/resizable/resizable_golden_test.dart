@Tags(['golden'])
library;

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
            axis: Axis.vertical,
            crossAxisExtent: 100,
            children: [
              FResizableRegion(
                initialExtent: 150,
                builder: (_, __, child) => child!,
                child: const Align(
                  child: Text(''),
                ),
              ),
              FResizableRegion(
                initialExtent: 300,
                builder: (_, __, child) => child!,
                child: const Align(
                  child: Text(''),
                ),
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final axis in Axis.values) {
        for (final divider in FResizableDivider.values) {
          testWidgets('$name - $axis - $divider', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme,
                background: background,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.border,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FResizable(
                    axis: axis,
                    divider: divider,
                    crossAxisExtent: 100,
                    children: [
                      FResizableRegion(
                        initialExtent: 150,
                        builder: (_, __, child) => child!,
                        child: const Align(
                          child: Text('A'),
                        ),
                      ),
                      FResizableRegion(
                        initialExtent: 300,
                        builder: (_, __, child) => child!,
                        child: const Align(
                          child: Text('B'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            await expectLater(find.byType(FResizable), matchesGoldenFile('resizable/$name/$axis-$divider.png'));
          });
        }
      }
    }

    for (final axis in Axis.values) {
      testWidgets('expanded - $axis', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FScaffold(
              content: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: FThemes.zinc.light.colorScheme.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FResizable(
                  axis: axis,
                  children: [
                    FResizableRegion(
                      initialExtent: 150,
                      builder: (_, __, child) => child!,
                      child: const Align(
                        child: Text('A'),
                      ),
                    ),
                    FResizableRegion(
                      initialExtent: 300,
                      builder: (_, __, child) => child!,
                      child: const Align(
                        child: Text('B'),
                      ),
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
