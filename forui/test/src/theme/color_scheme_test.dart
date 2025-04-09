import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FColorScheme', () {
    const scheme = FColors(
      brightness: Brightness.light,
      barrier: Color(0xFF03A9F4),
      background: Colors.black,
      foreground: Colors.black12,
      primary: Colors.black26,
      primaryForeground: Colors.black38,
      secondary: Colors.black45,
      secondaryForeground: Colors.black54,
      muted: Colors.black87,
      mutedForeground: Colors.blue,
      destructive: Colors.blueAccent,
      destructiveForeground: Colors.blueGrey,
      error: Colors.red,
      errorForeground: Colors.redAccent,
      border: Colors.lightBlue,
    );

    group('copyWith(...)', () {
      test('no arguments', () => expect(scheme.copyWith(), scheme));

      test('all arguments', () {
        final copy = scheme.copyWith(
          brightness: Brightness.dark,
          barrier: Colors.red,
          background: Colors.red,
          foreground: Colors.greenAccent,
          primary: Colors.yellow,
          primaryForeground: Colors.orange,
          secondary: Colors.purple,
          secondaryForeground: Colors.brown,
          muted: Colors.grey,
          mutedForeground: Colors.indigo,
          destructive: Colors.teal,
          destructiveForeground: Colors.pink,
          error: Colors.blueAccent,
          errorForeground: Colors.blueGrey,
          border: Colors.lime,
          disabledOpacity: 0.1,
          enabledHoveredOpacity: 0.2,
        );

        expect(copy.brightness, equals(Brightness.dark));
        expect(copy.barrier, equals(Colors.red));
        expect(copy.background, equals(Colors.red));
        expect(copy.foreground, equals(Colors.greenAccent));
        expect(copy.primary, equals(Colors.yellow));
        expect(copy.primaryForeground, equals(Colors.orange));
        expect(copy.secondary, equals(Colors.purple));
        expect(copy.secondaryForeground, equals(Colors.brown));
        expect(copy.muted, equals(Colors.grey));
        expect(copy.mutedForeground, equals(Colors.indigo));
        expect(copy.destructive, equals(Colors.teal));
        expect(copy.destructiveForeground, equals(Colors.pink));
        expect(copy.error, equals(Colors.blueAccent));
        expect(copy.errorForeground, equals(Colors.blueGrey));
        expect(copy.border, equals(Colors.lime));
        expect(copy.disabledOpacity, 0.1);
        expect(copy.enabledHoveredOpacity, 0.2);
      });
    });

    test('debugFillProperties(...)', () {
      final builder = DiagnosticPropertiesBuilder();
      scheme.debugFillProperties(builder);

      expect(
        builder.properties.map((p) => p.toString()),
        [
          EnumProperty('brightness', Brightness.light),
          ColorProperty('barrier', const Color(0xFF03A9F4)),
          ColorProperty('background', Colors.black),
          ColorProperty('foreground', Colors.black12),
          ColorProperty('primary', Colors.black26),
          ColorProperty('primaryForeground', Colors.black38),
          ColorProperty('secondary', Colors.black45),
          ColorProperty('secondaryForeground', Colors.black54),
          ColorProperty('muted', Colors.black87),
          ColorProperty('mutedForeground', Colors.blue),
          ColorProperty('destructive', Colors.blueAccent),
          ColorProperty('destructiveForeground', Colors.blueGrey),
          ColorProperty('error', Colors.red),
          ColorProperty('errorForeground', Colors.redAccent),
          ColorProperty('border', Colors.lightBlue),
          PercentProperty('enabledHoveredOpacity', 0.9),
          PercentProperty('disabledOpacity', 0.5),
        ].map((p) => p.toString()),
      );
    });

    group('equality and hashcode', () {
      test('equal', () {
        final copy = scheme.copyWith();
        expect(copy, scheme);
        expect(copy.hashCode, scheme.hashCode);
      });

      test('not equal', () {
        final copy = scheme.copyWith(background: Colors.red);
        expect(copy, isNot(scheme));
        expect(copy.hashCode, isNot(scheme.hashCode));
      });
    });
  });
}
