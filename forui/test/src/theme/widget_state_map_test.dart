import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FWidgetStateMap', () {
    group('lerp', () {
      test('lerpBoxDecoration(...)', () {
        const a = FWidgetStateMap<BoxDecoration>({
          WidgetState.pressed: BoxDecoration(color: Colors.red),
          WidgetState.hovered: BoxDecoration(color: Colors.green),
        });

        const b = FWidgetStateMap<BoxDecoration>({
          WidgetState.pressed: BoxDecoration(color: Colors.blue),
          WidgetState.focused: BoxDecoration(color: Colors.yellow),
        });

        final result = FWidgetStateMap.lerpBoxDecoration(a, b, 0.5);

        expect(
          result.resolve({WidgetState.pressed}),
          BoxDecoration.lerp(const BoxDecoration(color: Colors.red), const BoxDecoration(color: Colors.blue), 0.5),
        );
        expect(
          result.resolve({WidgetState.hovered}),
          BoxDecoration.lerp(const BoxDecoration(color: Colors.green), null, 0.5),
        );
        expect(
          result.resolve({WidgetState.focused}),
          BoxDecoration.lerp(null, const BoxDecoration(color: Colors.yellow), 0.5),
        );
      });

      test('lerpColor(...)', () {
        const a = FWidgetStateMap<Color>({WidgetState.pressed: Colors.red, WidgetState.hovered: Colors.green});

        const b = FWidgetStateMap<Color>({WidgetState.pressed: Colors.blue, WidgetState.focused: Colors.yellow});

        final result = FWidgetStateMap.lerpColor(a, b, 0.5);

        expect(result.resolve({WidgetState.pressed}), Color.lerp(Colors.red, Colors.blue, 0.5));
        expect(result.resolve({WidgetState.hovered}), Color.lerp(Colors.green, null, 0.5));
        expect(result.resolve({WidgetState.focused}), Color.lerp(null, Colors.yellow, 0.5));
      });

      test('lerpTextStyle(...)', () {
        const a = FWidgetStateMap<TextStyle>({
          WidgetState.pressed: TextStyle(fontSize: 16, color: Colors.red),
          WidgetState.hovered: TextStyle(fontSize: 14, color: Colors.green),
        });

        const b = FWidgetStateMap<TextStyle>({
          WidgetState.pressed: TextStyle(fontSize: 20, color: Colors.blue),
          WidgetState.focused: TextStyle(fontSize: 18, color: Colors.yellow),
        });

        final result = FWidgetStateMap.lerpTextStyle(a, b, 0.5);

        expect(
          result.resolve({WidgetState.pressed}),
          TextStyle.lerp(
            const TextStyle(fontSize: 16, color: Colors.red),
            const TextStyle(fontSize: 20, color: Colors.blue),
            0.5,
          ),
        );
        expect(
          result.resolve({WidgetState.hovered}),
          TextStyle.lerp(const TextStyle(fontSize: 14, color: Colors.green), null, 0.5),
        );
        expect(
          result.resolve({WidgetState.focused}),
          TextStyle.lerp(null, const TextStyle(fontSize: 18, color: Colors.yellow), 0.5),
        );
      });

      test('lerpWhere(...)', () {
        const a = FWidgetStateMap<double>({WidgetState.pressed: 1.0, WidgetState.hovered: 0.8});

        const b = FWidgetStateMap<double>({WidgetState.pressed: 0.5, WidgetState.focused: 0.9});

        final result = FWidgetStateMap.lerpWhere(a, b, 0.5, lerpDouble);

        expect(result.resolve({WidgetState.pressed}), 0.75);
        expect(result.resolve({WidgetState.hovered}), 0.4);
        expect(result.resolve({WidgetState.focused}), 0.45);
      });
    });

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
