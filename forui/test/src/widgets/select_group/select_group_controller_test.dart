import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  late int count;

  setUp(() => count = 0);

  group('FRadioSelectGroupController', () {
    test('contains(...)', () {
      final controller = FRadioSelectGroupController(value: 1);

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isFalse);

      controller.update(2, selected: true);

      expect(controller.contains(1), isFalse);
      expect(controller.contains(2), isTrue);
    });

    test('should initialize with a single value', () {
      final controller = FRadioSelectGroupController(value: 1)..addListener(() => count++);

      expect(controller.value, equals({1}));
      expect(count, 0);
    });

    test('should initialize with an empty set when no value is provided', () {
      final controller = FRadioSelectGroupController<int>()..addListener(() => count++);

      expect(controller.value, isEmpty);
      expect(count, 0);
    });

    test('should change selection when a new value is selected', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FRadioSelectGroupController<int>(onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(1, selected: true);

      expect(controller.value, equals({1}));
      expect(lastValue, (1, true));
      expect(count, 1);
    });

    test('should not change selection when the same value is selected', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FRadioSelectGroupController(value: 1, onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(1, selected: true);

      expect(controller.value, equals({1}));
      expect(lastValue, null);
      expect(count, 0);
    });

    test('should not change selection when trying to deselect', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FRadioSelectGroupController(value: 1, onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(1, selected: false);

      expect(controller.value, equals({1}));
      expect(lastValue, null);
      expect(count, 0);
    });

    test('get value returns copy', () {
      final controller = FRadioSelectGroupController(value: 1);

      controller.value.add(2);

      expect(controller.value, equals({1}));
    });

    group('set value', () {
      test('should throw an error when more than one value is provided', () {
        final controller = FRadioSelectGroupController<int>();

        expect(() => controller.value = {1, 2}, throwsArgumentError);
      });

      test('should set the value when only one value is provided', () {
        final controller = FRadioSelectGroupController<int>()..value = {1};

        expect(controller.value, equals({1}));
      });
    });
  });

  group('FMultiSelectGroupController', () {
    test('contains(...)', () {
      final controller = FMultiSelectGroupController(values: {1});

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isFalse);

      controller.update(2, selected: true);

      expect(controller.contains(1), isTrue);
      expect(controller.contains(2), isTrue);

      controller.update(1, selected: false);

      expect(controller.contains(1), isFalse);
      expect(controller.contains(2), isTrue);
    });

    test('should initialize with given values', () {
      final controller = FMultiSelectGroupController(values: {1, 2, 3})..addListener(() => count++);

      expect(controller.value, equals({1, 2, 3}));
      expect(count, 0);
    });

    test('should add a value when selected', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FMultiSelectGroupController<int>(onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(1, selected: true);

      expect(controller.value, equals({1}));
      expect(lastValue, (1, true));
      expect(count, 1);
    });

    test('should remove a value when deselected', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FMultiSelectGroupController(values: {1, 2}, onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(1, selected: false);

      expect(controller.value, equals({2}));
      expect(lastValue, (1, false));
      expect(count, 1);
    });

    test('should not add a value when max limit is reached', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FMultiSelectGroupController(max: 2, values: {1, 2}, onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(3, selected: true);

      expect(controller.value, equals({1, 2}));
      expect(lastValue, null);
      expect(count, 0);
    });

    test('should not remove a value when min limit is reached', () {
      (int, bool)? lastValue;
      void onUpdate((int, bool) value) => lastValue = value;

      final controller = FMultiSelectGroupController(min: 2, values: {1, 2}, onUpdate: onUpdate)
        ..addListener(() => count++)
        ..update(1, selected: false);

      expect(controller.value, equals({1, 2}));
      expect(lastValue, null);
      expect(count, 0);
    });

    test('get value returns copy', () {
      final controller = FMultiSelectGroupController(values: {1});

      controller.value.add(2);

      expect(controller.value, equals({1}));
    });

    group('set value', () {
      test('should throw an error when more than 2 value is provided', () {
        final controller = FMultiSelectGroupController<int>(max: 2);

        expect(() => controller.value = {1, 2, 3}, throwsArgumentError);
      });

      test('should throw an error when less than 2 value is provided', () {
        final controller = FMultiSelectGroupController<int>(min: 2);

        expect(() => controller.value = {1}, throwsArgumentError);
      });

      test('should set the value', () {
        final controller = FMultiSelectGroupController<int>(min: 2, max: 2)..value = {1, 2};

        expect(controller.value, equals({1, 2}));
      });
    });
  });
}
