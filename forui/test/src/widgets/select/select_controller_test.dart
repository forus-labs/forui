import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  late int count;
  late int changeCount;

  setUp(() {
    count = 0;
    changeCount = 0;
  });

  group('FSelectController - multi', () {
    test('contains(...)', () {
      final notifier = FSelectController(values: {1});

      expect(notifier.contains(1), isTrue);
      expect(notifier.contains(2), isFalse);

      notifier.update(2, selected: true);

      expect(notifier.contains(1), isTrue);
      expect(notifier.contains(2), isTrue);

      notifier.update(1, selected: false);

      expect(notifier.contains(1), isFalse);
      expect(notifier.contains(2), isTrue);
    });

    test('should initialize with given values', () {
      final notifier =
      FSelectController(values: {1, 2, 3})
        ..addListener(() => count++)
        ..addSelectListener((_) => changeCount++);

      expect(notifier.value, equals({1, 2, 3}));
      expect(count, 0);
      expect(changeCount, 0);
    });

    test('should selected a value when added', () {
      (int, bool)? value;
      final notifier =
      FSelectController<int>()
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(1, selected: true);

      expect(notifier.value, {1});
      expect(count, 1);
      expect(value, (1, true));
    });

    test('should remove a value when removed', () {
      (int, bool)? value;
      final notifier =
      FSelectController(values: {1, 2})
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(1, selected: false);

      expect(notifier.value, equals({2}));
      expect(count, 1);
      expect(value, (1, false));
    });

    test('should not selected a value when max limit is reached', () {
      (int, bool)? value;
      final notifier =
      FSelectController(max: 2, values: {1, 2})
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(3, selected: true);

      expect(notifier.value, equals({1, 2}));
      expect(count, 0);
      expect(value, null);
    });

    test('should not remove a value when min limit is reached', () {
      (int, bool)? value;
      final notifier =
      FSelectController(min: 2, values: {1, 2})
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(1, selected: false);

      expect(notifier.value, equals({1, 2}));
      expect(count, 0);
      expect(value, null);
    });

    group('set value', () {
      test('should throw an error when more than 2 value is provided', () {
        final notifier = FSelectController<int>(max: 2);

        expect(() => notifier.value = {1, 2, 3}, throwsArgumentError);
      });

      test('should throw an error when less than 2 value is provided', () {
        final notifier = FSelectController<int>(min: 2);

        expect(() => notifier.value = {1}, throwsArgumentError);
      });

      test('should set the value', () {
        final notifier = FSelectController<int>(min: 2, max: 2)
          ..addListener(() => count++)
          ..addSelectListener((_) => changeCount++)
          ..value = {1, 2};

        expect(notifier.value, equals({1, 2}));
        expect(count, 1);
        expect(changeCount, 0);
      });
    });
  });

  group('FSelectController - radio', () {
    test('contains(...)', () {
      final notifier = FSelectController.radio(value: 1);

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), false);

      notifier.update(2, selected: true);

      expect(notifier.contains(1), false);
      expect(notifier.contains(2), true);
    });

    test('should initialize with a single value', () {
      final notifier =
      FSelectController.radio(value: 1)
        ..addListener(() => count++)
        ..addSelectListener((_) => changeCount++);

      expect(notifier.value, {1});
      expect(count, 0);
    });

    test('should initialize with an empty set when no value is provided', () {
      final notifier =
      FSelectController<int>.radio()
        ..addListener(() => count++)
        ..addSelectListener((_) => changeCount++);

      expect(notifier.value, isEmpty);
      expect(count, 0);
      expect(changeCount, 0);
    });

    test('should change value when a new value is added', () {
      (int, bool)? value;
      final notifier =
      FSelectController<int>.radio()
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(1, selected: true);

      expect(notifier.value, {1});
      expect(count, 1);
      expect(value, (1, true));
    });

    test('should not change value when the same value is added', () {
      (int, bool)? value;
      final notifier =
      FSelectController.radio(value: 1)
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(1, selected: true);

      expect(notifier.value, equals({1}));
      expect(value, null);
      expect(count, 0);
    });

    test('should not change value when trying to remove', () {
      (int, bool)? value;
      final notifier =
      FSelectController.radio(value: 1)
        ..addListener(() => count++)
        ..addSelectListener((changed) => value = changed)
        ..update(1, selected: false);

      expect(notifier.value, equals({1}));
      expect(value, null);
      expect(count, 0);
    });

    group('set value', () {
      test('should throw an error when more than one value is provided', () {
        final notifier = FSelectController.radio();

        expect(() => notifier.value = {1, 2}, throwsArgumentError);
      });

      test('should set the value when only one value is provided', () {
        final notifier =
        FSelectController.radio()
          ..addListener(() => count++)
          ..addSelectListener((_) => changeCount++)
          ..value = {1};

        expect(notifier.value, equals({1}));
        expect(count, 1);
        expect(changeCount, 0);
      });
    });
  });
}
