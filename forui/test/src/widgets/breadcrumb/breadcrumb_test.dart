import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('lifted', () {
    testWidgets('FBreadcrumbItem.collapsed', (tester) async {
      var shown = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FBreadcrumb(
              children: [
                FBreadcrumbItem.collapsed(
                  popoverControl: .lifted(shown: shown, onChange: (v) => setState(() => shown = v)),
                  menu: [
                    .group(
                      children: [.item(onPress: () {}, title: const Text('Item'))],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(FIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(shown, true);
    });

    testWidgets('FBreadcrumbItem.collapsedTiles', (tester) async {
      var shown = false;

      await tester.pumpWidget(
        TestScaffold.app(
          child: StatefulBuilder(
            builder: (context, setState) => FBreadcrumb(
              children: [
                FBreadcrumbItem.collapsedTiles(
                  popoverControl: .lifted(shown: shown, onChange: (v) => setState(() => shown = v)),
                  menu: [
                    FTileGroup(
                      children: [.tile(onPress: () {}, title: const Text('Item'))],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(FIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(shown, true);
    });
  });

  group('managed', () {
    testWidgets('FBreadcrumbItem.collapsed onChange callback', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsed(
                popoverControl: .managed(onChange: (value) => changedValue = value),
                menu: [
                  FItemGroup(
                    children: [FItem(onPress: () {}, title: const Text('Item'))],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(FIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(changedValue, true);
    });

    testWidgets('FBreadcrumbItem.collapsedTiles onChange callback', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsedTiles(
                popoverControl: .managed(onChange: (value) => changedValue = value),
                menu: [
                  FTileGroup(
                    children: [FTile(onPress: () {}, title: const Text('Item'))],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(FIcons.ellipsis));
      await tester.pumpAndSettle();

      expect(changedValue, true);
    });
  });
}
