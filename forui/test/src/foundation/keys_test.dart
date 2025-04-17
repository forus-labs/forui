// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/keys.dart';

void main() {
  group('ListKey', () {
    test('equality', () {
      const key1 = ListKey([1, 2, 3]);
      const key2 = ListKey([1, 2, 3]);
      const key3 = ListKey([3, 2, 1]);
      const key4 = ListKey(['a', 'b', 'c']);

      expect(key1 == key2, true);
      expect(key1 == key3, false);
      expect(key1 == key4, false);
      expect(key1 == 'not a key', false);
    });

    test('identical objects are equal', () {
      const key = ListKey([1, 2, 3]);
      expect(key == key, true);
    });

    test('hashCode is consistent', () {
      const key1 = ListKey([1, 2, 3]);
      const key2 = ListKey([1, 2, 3]);

      expect(key1.hashCode, key2.hashCode);
    });
  });

  group('SetKey', () {
    test('equality', () {
      const key1 = SetKey({1, 2, 3});
      const key2 = SetKey({1, 2, 3});
      const key3 = SetKey({3, 4, 5});
      const key4 = SetKey({1, 2, 3, 4});
      const key5 = SetKey({'a', 'b', 'c'});

      expect(key1 == key2, true);
      expect(key1 == key3, false);
      expect(key1 == key4, false);
      expect(key1 == key5, false);
      expect(key1 == 'not a key', false);
    });

    test('order does not matter', () {
      const key1 = SetKey({1, 2, 3});
      const key2 = SetKey({3, 2, 1});

      expect(key1 == key2, true);
    });

    test('identical objects are equal', () {
      const key = SetKey({1, 2, 3});
      expect(key == key, true);
    });

    test('hashCode is consistent', () {
      const key1 = SetKey({1, 2, 3});
      const key2 = SetKey({3, 1, 2});

      expect(key1.hashCode, key2.hashCode);
    });
  });
}
