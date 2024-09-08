import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FRadioSelectGroupController', () {
    test('should initialize with a single value', () {
      bool notified = false;

      final controller = FRadioSelectGroupController(value: 1)..addListener(() => notified = true);

      expect(controller.values, equals({1}));
      expect(notified, isFalse);
    });

    test('should initialize with an empty set when no value is provided', () {
      bool notified = false;

      final controller = FRadioSelectGroupController<int>()..addListener(() => notified = true);

      expect(controller.values, isEmpty);
      expect(notified, isFalse);
    });

    test('should change selection when a new value is selected', () {
      bool notified = false;

      final controller = FRadioSelectGroupController<int>()
        ..addListener(() => notified = true)
        ..select(1, true);

      expect(controller.values, equals({1}));
      expect(notified, isTrue);
    });

    test('should not change selection when the same value is selected', () {
      bool notified = false;

      final controller = FRadioSelectGroupController(value: 1)
        ..addListener(() => notified = true)
        ..select(1, true);

      expect(controller.values, equals({1}));
      expect(notified, isFalse);
    });

    test('should not change selection when trying to deselect', () {
      bool notified = false;

      final controller = FRadioSelectGroupController(value: 1)
        ..addListener(() => notified = true)
        ..select(1, false);

      expect(controller.values, equals({1}));
      expect(notified, isFalse);
    });

    test('contains(...)', () {
      final controller = FRadioSelectGroupController(value: 1);

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isFalse);

      controller.select(2, true);

      expect(controller.contains(1), isFalse);
      expect(controller.contains(2), isTrue);
    });
  });

  group('FMultiSelectGroupController', () {
    test('should initialize with given values', () {
      bool notified = false;

      final controller = FMultiSelectGroupController(values: {1, 2, 3})..addListener(() => notified = true);

      expect(controller.values, equals({1, 2, 3}));
      expect(notified, isFalse);
    });

    test('should add a value when selected', () {
      bool notified = false;

      final controller = FMultiSelectGroupController<int>()
        ..addListener(() => notified = true)
        ..select(1, true);

      expect(controller.values, equals({1}));
      expect(notified, isTrue);
    });

    test('should remove a value when deselected', () {
      bool notified = false;

      final controller = FMultiSelectGroupController(values: {1, 2})
        ..addListener(() => notified = true)
        ..select(1, false);

      expect(controller.values, equals({2}));
      expect(notified, isTrue);
    });

    test('should not add a value when max limit is reached', () {
      bool notified = false;

      final controller = FMultiSelectGroupController(max: 2, values: {1, 2})
        ..addListener(() => notified = true)
        ..select(3, true);

      expect(controller.values, equals({1, 2}));
      expect(notified, isFalse);
    });

    test('should not remove a value when min limit is reached', () {
      bool notified = false;

      final controller = FMultiSelectGroupController(min: 2, values: {1, 2})
        ..addListener(() => notified = true)
        ..select(1, false);

      expect(controller.values, equals({1, 2}));
      expect(notified, isFalse);
    });

    test('contains(...)', () {
      final controller = FMultiSelectGroupController(values: {1});

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isFalse);

      controller.select(2, true);

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isTrue);

      controller.select(1, false);

      expect(controller.contains(1), isFalse);
      expect(controller.contains(2), isTrue);
    });
  });
}
