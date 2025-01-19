// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
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
}
