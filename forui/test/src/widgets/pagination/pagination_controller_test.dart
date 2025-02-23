import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FPaginationController', () {
    test('value', () {
      final controller = FPaginationController(length: 10, page: 8)..value = 5;
      expect(controller.value, 5);
    });

    test('next', () {
      final controller = FPaginationController(length: 10, page: 9)..next();
      expect(controller.value, 10);

      controller.next();
      expect(controller.value, 10);
    });

    test('previous', () {
      final controller = FPaginationController(length: 10, page: 2)..previous();
      expect(controller.value, 1);

      controller.previous();
      expect(controller.value, 1);
    });

    group('calculateSiblingRange(...)', () {
      for (final (currentPage, expected) in [
        (0, (0, 4)),
        (1, (0, 4)),
        (2, (0, 4)),
        (3, (0, 4)),
        (4, (3, 5)),
        (5, (4, 6)),
        (6, (5, 9)),
        (7, (5, 9)),
        (8, (5, 9)),
        (9, (5, 9)),
      ]) {
        test('siblings = 1', () {
          final controller = FPaginationController(length: 10)..value = currentPage;
          expect(controller.calculateSiblingRange(), expected);
        });
      }

      for (final (currentPage, expected) in [
        (0, (0, 2)),
        (1, (0, 2)),
        (2, (0, 2)),
        (3, (3, 3)),
        (4, (4, 4)),
        (5, (5, 5)),
        (6, (6, 6)),
        (7, (7, 9)),
        (8, (7, 9)),
        (9, (7, 9)),
      ]) {
        test('siblings = 0', () {
          final controller = FPaginationController(siblings: 0, length: 10)..value = currentPage;
          expect(controller.calculateSiblingRange(), expected);
        });
      }
    });

    for (final (length, siblingLength, expected) in [
      (6, 1, 6),
      (7, 1, 7),
      (8, 1, 3),
      (9, 2, 9),
      (10, 2, 10),
      (11, 2, 4),
      (12, 3, 12),
      (13, 3, 13),
      (14, 3, 5),
    ]) {
      test('minPagesDisplayedAtEdges', () {
        final controller = FPaginationController(length: length, siblings: siblingLength);
        expect(controller.minPagesDisplayedAtEdges, expected);
      });
    }

    for (final (length, siblingLength, expected) in [
      (6, 1, 6),
      (7, 1, 2),
      (9, 2, 9),
      (10, 2, 3),
      (12, 3, 12),
      (13, 3, 4),
    ]) {
      test('minPagesDisplayedAtEnds with showEdges set to false', () {
        final controller = FPaginationController(length: length, siblings: siblingLength, showEdges: false);
        expect(controller.minPagesDisplayedAtEdges, expected);
      });
    }
  });
}
