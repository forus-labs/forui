import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FRadioSelectGroupController', () {
    test('should initialize with a single value', () {
      final controller = FRadioSelectGroupController(value: 1);

      expect(controller.values, equals({1}));
    });

    test('should initialize with an empty set when no value is provided', () {
      final controller = FRadioSelectGroupController<int>();

      expect(controller.values, isEmpty);
    });

    test('should change selection when a new value is selected', () {
      final controller = FRadioSelectGroupController<int>()..onChange(1, true);

      expect(controller.values, equals({1}));
    });

    test('should not change selection when the same value is selected', () {
      final controller = FRadioSelectGroupController(value: 1)..onChange(1, true);

      expect(controller.values, equals({1}));
    });

    test('should not change selection when trying to deselect', () {
      final controller = FRadioSelectGroupController(value: 1)..onChange(1, false);

      expect(controller.values, equals({1}));
    });

    test('contains(...)', () {
      final controller = FRadioSelectGroupController(value: 1);

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isFalse);

      controller.onChange(2, true);

      expect(controller.contains(1), isFalse);
      expect(controller.contains(2), isTrue);
    });

    test('ensure notifyListeners() is called', () {
      bool notified = false;

      FRadioSelectGroupController<int>()
        ..addListener(() => notified = true)
        ..onChange(1, true);

      expect(notified, isTrue);
    });
  });

  group('FMultiSelectGroupController', () {
    test('should initialize with given values', () {
      final controller = FMultiSelectGroupController(values: {1, 2, 3});

      expect(controller.values, equals({1, 2, 3}));
    });

    test('should add a value when selected', () {
      final controller = FMultiSelectGroupController<int>()..onChange(1, true);

      expect(controller.values, equals({1}));
    });

    test('should remove a value when deselected', () {
      final controller = FMultiSelectGroupController(values: {1, 2})..onChange(1, false);

      expect(controller.values, equals({2}));
    });

    test('should not add a value when max limit is reached', () {
      final controller = FMultiSelectGroupController(max: 2, values: {1, 2})..onChange(3, true);

      expect(controller.values, equals({1, 2}));
    });

    test('should not remove a value when min limit is reached', () {
      final controller = FMultiSelectGroupController(min: 2, values: {1, 2})..onChange(1, false);

      expect(controller.values, equals({1, 2}));
    });

    test('contains(...)', () {
      final controller = FMultiSelectGroupController(values: {1});

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isFalse);

      controller.onChange(2, true);

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isTrue);

      controller.onChange(1, false);

      expect(controller.contains(1), isFalse);
      expect(controller.contains(2), isTrue);
    });

    test('ensure notifyListeners() is called', () {
      bool notified = false;

      FMultiSelectGroupController<int>()
        ..addListener(() => notified = true)
        ..onChange(1, true);

      expect(notified, isTrue);
    });
  });
}
