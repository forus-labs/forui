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
  });
}
