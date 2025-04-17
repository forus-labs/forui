import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FWidgetStateMap', () {
    group('resolve(...)', () {
      test('resolves matching', () {
        const map = FWidgetStateMap<Color>({WidgetState.hovered: Colors.green, WidgetState.pressed: Colors.blue});

        expect(map.resolve({WidgetState.pressed}), Colors.blue);
      });

      test('resolves first matching', () {
        const map = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue, WidgetState.hovered: Colors.green});

        expect(map.resolve({WidgetState.pressed, WidgetState.hovered}), Colors.blue);
      });

      test('throws ArgumentError when no matches and T', () {
        const map = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue});

        expect(() => map.resolve({WidgetState.hovered}), throwsArgumentError);
      });

      test('null when no matches and T?', () {
        const map = FWidgetStateMap<Color?>({WidgetState.pressed: Colors.blue});

        expect(map.resolve({WidgetState.hovered}), null);
      });
    });

    group('maybeResolve(...)', () {
      test('value when matches', () {
        const map = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue});

        expect(map.maybeResolve({WidgetState.pressed}), Colors.blue);
      });

      test('null when no matches', () {
        const map = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue});

        expect(map.maybeResolve({WidgetState.hovered}), null);
      });
    });

    test('map(...)', () {
      const original = FWidgetStateMap({WidgetState.pressed: 1, WidgetState.hovered: 2});

      final mapped = original.map((scale) => Colors.blue.withRed(scale));

      expect(mapped.resolve({WidgetState.pressed, WidgetState.hovered}), Colors.blue.withRed(1));
      expect(mapped.resolve({WidgetState.hovered}), Colors.blue.withRed(2));
    });

    test('replaceFirstWhere(...)', () {
      const original = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue, WidgetState.hovered: Colors.green});

      final modified = original.replaceFirstWhere({
        WidgetState.pressed,
        WidgetState.hovered,
      }, (color) => color.withRed(1));

      expect(modified.resolve({WidgetState.pressed}), Colors.blue.withRed(1));
      expect(modified.resolve({WidgetState.hovered}), Colors.green);
    });

    test('replaceLastWhere(...)', () {
      const original = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue, WidgetState.hovered: Colors.green});

      final modified = original.replaceLastWhere({
        WidgetState.pressed,
        WidgetState.hovered,
      }, (color) => color.withRed(1));

      expect(modified.resolve({WidgetState.pressed}), Colors.blue);
      expect(modified.resolve({WidgetState.hovered}), Colors.green.withRed(1));
    });

    test('replaceAllWhere(...)', () {
      const original = FWidgetStateMap<Color>({
        WidgetState.pressed: Colors.blue,
        WidgetState.hovered: Colors.green,
        WidgetState.focused: Colors.yellow,
      });

      final modified = original.replaceAllWhere({
        WidgetState.pressed,
        WidgetState.hovered,
      }, (color) => color.withRed(1));

      expect(modified.resolve({WidgetState.pressed}), Colors.blue.withRed(1));
      expect(modified.resolve({WidgetState.hovered}), Colors.green.withRed(1));
      expect(modified.resolve({WidgetState.focused}), Colors.yellow);
    });
  });
}
