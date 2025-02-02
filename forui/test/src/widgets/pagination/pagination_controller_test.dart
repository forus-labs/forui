import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('FPaginationController', () {
    test('value', () {
      final controller = FPaginationController(length: 10, initialPage: 8)..value = 5;
      expect(controller.value, 5);
    });

    test('next', () {
      final controller = FPaginationController(length: 10, initialPage: 9)..next();
      expect(controller.value, 10);
      controller.next();
      expect(controller.value, 10);
    });

    test('previous', () {
      final controller = FPaginationController(length: 10, initialPage: 2)..previous();
      expect(controller.value, 1);
      controller.previous();
      expect(controller.value, 1);
    });

    test('value', () {
      final controller = FPaginationController(length: 10, initialPage: 8)..value = 5;
      expect(controller.value, 5);
    });

    group('calculateRange(...)', () {
      for (final (currentPage, expected) in [
        (1, (1, 5)),
        (2, (1, 5)),
        (3, (1, 5)),
        (4, (1, 5)),
        (5, (4, 6)),
        (6, (5, 7)),
        (7, (6, 10)),
        (8, (6, 10)),
        (9, (6, 10)),
        (10, (6, 10)),
      ]) {
        test('with sibling length 1', () {
          final controller = FPaginationController(length: 10)..value = currentPage;
          expect(controller.calculateRange(), expected);
        });
      }

      for (final (currentPage, expected) in [
        (1, (1, 7)),
        (2, (1, 7)),
        (3, (1, 7)),
        (4, (1, 7)),
        (5, (1, 7)),
        (6, (4, 8)),
        (7, (5, 9)),
        (8, (6, 10)),
        (9, (7, 11)),
        (10, (8, 12)),
        (11, (9, 13)),
        (12, (10, 14)),
        (13, (11, 15)),
        (14, (12, 16)),
        (15, (13, 17)),
        (16, (14, 20)),
        (17, (14, 20)),
        (18, (14, 20)),
        (19, (14, 20)),
        (20, (14, 20)),
      ]) {
        test('with sibling length 2', () {
          final controller = FPaginationController(siblingLength: 2, length: 20)..value = currentPage;
          expect(controller.calculateRange(), expected);
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
      test('minPagesDisplayedAtEnds', () {
        final controller = FPaginationController(
          length: length,
          siblingLength: siblingLength,
        );
        expect(controller.minPagesDisplayedAtEnds, expected);
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
      test('minPagesDisplayedAtEnds with showFirstLastPages set to false', () {
        final controller =
            FPaginationController(length: length, siblingLength: siblingLength, showFirstLastPages: false);
        expect(controller.minPagesDisplayedAtEnds, expected);
      });
    }
  });
}
