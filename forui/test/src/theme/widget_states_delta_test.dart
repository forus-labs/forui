import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  test('added', () {
    final delta = FWidgetStatesDelta({.focused}, {.focused, .pressed});

    expect(delta.added, {WidgetState.pressed});
  });

  test('removed', () {
    final delta = FWidgetStatesDelta({.focused, .pressed}, {.focused});

    expect(delta.removed, {WidgetState.pressed});
  });

  group('equality', () {
    test('equals', () {
      final delta1 = FWidgetStatesDelta({.focused}, {.focused, .pressed});
      final delta2 = FWidgetStatesDelta({.focused}, {.focused, .pressed});

      expect(delta1.hashCode, delta2.hashCode);
      expect(delta1, delta2);
    });

    test('not equals', () {
      final delta1 = FWidgetStatesDelta({.focused}, {.focused, .pressed});
      final delta2 = FWidgetStatesDelta({.focused, .pressed}, {.focused});

      expect(delta1.hashCode, isNot(delta2.hashCode));
      expect(delta1, isNot(delta2));
    });
  });
}
