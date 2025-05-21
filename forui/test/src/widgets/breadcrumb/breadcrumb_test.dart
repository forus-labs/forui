// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FBreadcrumb.collapsed', () {
    testWidgets('update controller', (tester) async {
      final first = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsed(
                popoverController: first,
                menu: [
                  FTileGroup(
                    children: [
                      FTile(title: const Text('Documentation'), onPress: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);

      final second = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsed(
                popoverController: second,
                menu: [
                  FTileGroup(
                    children: [
                      FTile(title: const Text('Documentation'), onPress: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);
      expect(second.hasListeners, false);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FBreadcrumb(
            children: [
              FBreadcrumbItem.collapsed(
                popoverController: controller,
                menu: [
                  FTileGroup(
                    children: [
                      FTile(title: const Text('Documentation'), onPress: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);
    });
  });
}
