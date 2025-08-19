import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  test('added', () {
    final delta = FWidgetStatesDelta({WidgetState.focused}, {WidgetState.focused, WidgetState.pressed});

    expect(delta.added, {WidgetState.pressed});
  });

  test('removed', () {
    final delta = FWidgetStatesDelta({WidgetState.focused, WidgetState.pressed}, {WidgetState.focused});

    expect(delta.removed, {WidgetState.pressed});
  });

  group('equality', () {
    test('equals', () {
      final delta1 = FWidgetStatesDelta({WidgetState.focused}, {WidgetState.focused, WidgetState.pressed});
      final delta2 = FWidgetStatesDelta({WidgetState.focused}, {WidgetState.focused, WidgetState.pressed});

      expect(delta1.hashCode, delta2.hashCode);
      expect(delta1, delta2);
    });

    test('not equals', () {
      final delta1 = FWidgetStatesDelta({WidgetState.focused}, {WidgetState.focused, WidgetState.pressed});
      final delta2 = FWidgetStatesDelta({WidgetState.focused, WidgetState.pressed}, {WidgetState.focused});

      expect(delta1.hashCode, isNot(delta2));
      expect(delta1, isNot(delta2));
    });
  });
}
