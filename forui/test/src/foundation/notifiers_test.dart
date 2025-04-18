// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  late int count;
  late int changeCount;

  setUp(() {
    count = 0;
    changeCount = 0;
  });

  group('FChangeNotifier', () {
    late FChangeNotifier notifier;

    setUp(() => notifier = FChangeNotifier());

    test('dispose() updates disposed field', () {
      expect(notifier.disposed, false);

      notifier.dispose();

      expect(notifier.disposed, true);
    });
  });

  group('FValueNotifier', () {
    late FValueNotifier<int> notifier;

    setUp(() => notifier = FValueNotifier<int>(0));

    testWidgets('hasListeners', (tester) async {
      expect(notifier.hasListeners, false);

      notifier.addValueListener((_) {});

      expect(notifier.hasListeners, true);
    });

    test('dispose() updates disposed field', () {
      expect(notifier.disposed, false);

      notifier.dispose();

      expect(notifier.disposed, true);
    });

    group('value listeners', () {
      test('callback that receives new value', () {
        int? lastValue;
        void listener(int value) => lastValue = value;

        notifier.addValueListener(listener);
        expect(lastValue, null);

        notifier.value = 42;
        expect(lastValue, 42);

        notifier.value = 100;
        expect(lastValue, 100);
      });

      test('removeValueListener stops value updates', () {
        int? lastValue;
        void listener(int value) => lastValue = value;

        notifier
          ..addValueListener(listener)
          ..value = 42;

        expect(lastValue, 42);

        notifier
          ..removeValueListener(listener)
          ..value = 100;

        expect(lastValue, 42);
      });

      test('removing non-existent listener does nothing', () {
        void listener(int value) {}

        expect(() => notifier.removeValueListener(listener), returnsNormally);
      });

      test('multiple listeners receive updates independently', () {
        int? listener1Value;
        int? listener2Value;
        void listener1(int value) => listener1Value = value;
        void listener2(int value) => listener2Value = value;

        notifier
          ..addValueListener(listener1)
          ..addValueListener(listener2)
          ..value = 42;

        expect(listener1Value, 42);
        expect(listener2Value, 42);

        notifier
          ..removeValueListener(listener1)
          ..value = 100;

        expect(listener1Value, 42);
        expect(listener2Value, 100);
      });
    });
  });

  group('FMultiValueNotifier - multi', () {
    test('contains(...)', () {
      final notifier = FMultiValueNotifier(values: {1});

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), false);

      notifier.update(2, add: true);

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), true);

      notifier.update(1, add: false);

      expect(notifier.contains(1), false);
      expect(notifier.contains(2), true);
    });

    test('should initialize with given values', () {
      final notifier =
          FMultiValueNotifier(values: {1, 2, 3})
            ..addListener(() => count++)
            ..addUpdateListener((_) => changeCount++);

      expect(notifier.value, equals({1, 2, 3}));
      expect(count, 0);
      expect(changeCount, 0);
    });

    test('should notify when added', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier<int>()
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed);

      final old = notifier.value;

      notifier.update(1, add: true);

      expect(notifier.value, {1});
      expect(notifier.value, isNot(old));
      expect(count, 1);
      expect(value, (1, true));
    });

    test('should remove a value when removed', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier(values: {1, 2})
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed);

      final old = notifier.value;

      notifier.update(1, add: false);

      expect(notifier.value, equals({2}));
      expect(notifier.value, isNot(old));
      expect(count, 1);
      expect(value, (1, false));
    });

    test('should not selected a value when max limit is reached', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier(max: 2, values: {1, 2})
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed)
            ..update(3, add: true);

      expect(notifier.value, equals({1, 2}));
      expect(count, 0);
      expect(value, null);
    });

    test('should not remove a value when min limit is reached', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier(min: 2, values: {1, 2})
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed)
            ..update(1, add: false);

      expect(notifier.value, equals({1, 2}));
      expect(count, 0);
      expect(value, null);
    });

    group('set value', () {
      test('should throw an error when more than 2 value is provided', () {
        final notifier = FMultiValueNotifier<int>(max: 2);

        expect(() => notifier.value = {1, 2, 3}, throwsArgumentError);
      });

      test('should throw an error when less than 2 value is provided', () {
        final notifier = FMultiValueNotifier<int>(min: 2);

        expect(() => notifier.value = {1}, throwsArgumentError);
      });

      test('should set the value', () {
        final notifier =
            FMultiValueNotifier<int>(min: 2, max: 2)
              ..addListener(() => count++)
              ..addUpdateListener((_) => changeCount++);

        final old = notifier.value;
        notifier.value = {1, 2};

        expect(notifier.value, equals({1, 2}));
        expect(notifier.value, isNot(old));
        expect(count, 1);
        expect(changeCount, 0);
      });
    });
  });

  group('FMultiValueNotifier - radio', () {
    test('contains(...)', () {
      final notifier = FMultiValueNotifier.radio(value: 1);

      expect(notifier.contains(1), true);
      expect(notifier.contains(2), false);

      notifier.update(2, add: true);

      expect(notifier.contains(1), false);
      expect(notifier.contains(2), true);
    });

    test('should initialize with a single value', () {
      final notifier =
          FMultiValueNotifier.radio(value: 1)
            ..addListener(() => count++)
            ..addUpdateListener((_) => changeCount++);

      expect(notifier.value, {1});
      expect(count, 0);
    });

    test('should initialize with an empty set when no value is provided', () {
      final notifier =
          FMultiValueNotifier<int>.radio()
            ..addListener(() => count++)
            ..addUpdateListener((_) => changeCount++);

      expect(notifier.value, isEmpty);
      expect(count, 0);
      expect(changeCount, 0);
    });

    test('should change value when a new value is added', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier<int>.radio()
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed);

      final old = notifier.value;
      notifier.update(1, add: true);

      expect(notifier.value, {1});
      expect(notifier.value, isNot(old));
      expect(count, 1);
      expect(value, (1, true));
    });

    test('should not change value when the same value is added', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier.radio(value: 1)
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed)
            ..update(1, add: true);

      expect(notifier.value, equals({1}));
      expect(value, null);
      expect(count, 0);
    });

    test('should not change value when trying to remove', () {
      (int, bool)? value;
      final notifier =
          FMultiValueNotifier.radio(value: 1)
            ..addListener(() => count++)
            ..addUpdateListener((changed) => value = changed)
            ..update(1, add: false);

      expect(notifier.value, equals({1}));
      expect(value, null);
      expect(count, 0);
    });

    group('set value', () {
      test('should throw an error when more than one value is provided', () {
        final notifier = FMultiValueNotifier.radio();

        expect(() => notifier.value = {1, 2}, throwsArgumentError);
      });

      test('should set the value when only one value is provided', () {
        final notifier =
            FMultiValueNotifier.radio()
              ..addListener(() => count++)
              ..addUpdateListener((_) => changeCount++);

        final old = notifier.value;
        notifier.value = {1};

        expect(notifier.value, equals({1}));
        expect(notifier.value, isNot(old));
        expect(count, 1);
        expect(changeCount, 0);
      });
    });
  });
}
