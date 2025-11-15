import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FColorScheme', () {
    const scheme = FColors(
      brightness: .light,
      systemOverlayStyle: .dark,
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
          brightness: .dark,
          systemOverlayStyle: .light,
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
          hoverLighten: 0.3,
          hoverDarken: 0.2,
          disabledOpacity: 0.1,
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
        expect(copy.hoverLighten, 0.3);
        expect(copy.hoverDarken, 0.2);
        expect(copy.disabledOpacity, 0.1);
      });
    });

    test('debugFillProperties(...)', () {
      final builder = DiagnosticPropertiesBuilder();
      scheme.debugFillProperties(builder);

      expect(
        builder.properties.map((p) => p.toString()),
        [
          EnumProperty('brightness', Brightness.light),
          DiagnosticsProperty('systemOverlayStyle', SystemUiOverlayStyle.dark),
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
          PercentProperty('hoverLighten', 0.075),
          PercentProperty('hoverDarken', 0.05),
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

    group('lerp(...)', () {
      const schemeB = FColors(
        brightness: .dark,
        systemOverlayStyle: .light,
        barrier: Colors.red,
        background: Colors.white,
        foreground: Colors.white70,
        primary: Colors.blue,
        primaryForeground: Colors.white,
        secondary: Colors.green,
        secondaryForeground: Colors.white60,
        muted: Colors.grey,
        mutedForeground: Colors.white54,
        destructive: Colors.orange,
        destructiveForeground: Colors.white38,
        error: Colors.yellow,
        errorForeground: Colors.white30,
        border: Colors.purple,
        hoverLighten: 0.1,
        hoverDarken: 0.08,
        disabledOpacity: 0.3,
      );

      test('interpolation at t=0', () {
        final result = FColors.lerp(scheme, schemeB, 0.0);
        expect(result.brightness, scheme.brightness);
        expect(result.systemOverlayStyle, scheme.systemOverlayStyle);
        expect(result.background, scheme.background);
        expect(result.foreground, scheme.foreground);
        expect(result.hoverLighten, scheme.hoverLighten);
        expect(result.hoverDarken, scheme.hoverDarken);
        expect(result.disabledOpacity, scheme.disabledOpacity);
      });

      test('interpolation at t=1', () {
        final result = FColors.lerp(scheme, schemeB, 1.0);
        expect(result.brightness, schemeB.brightness);
        expect(result.systemOverlayStyle, schemeB.systemOverlayStyle);
        expect(result.background, schemeB.background);
        expect(result.foreground, schemeB.foreground);
        expect(result.hoverLighten, schemeB.hoverLighten);
        expect(result.hoverDarken, schemeB.hoverDarken);
        expect(result.disabledOpacity, schemeB.disabledOpacity);
      });

      test('interpolation at t=0.5', () {
        final result = FColors.lerp(scheme, schemeB, 0.5);
        expect(result.brightness, schemeB.brightness); // threshold-based
        expect(result.systemOverlayStyle, schemeB.systemOverlayStyle); // threshold-based
        expect(result.background, Color.lerp(scheme.background, schemeB.background, 0.5));
        expect(result.foreground, Color.lerp(scheme.foreground, schemeB.foreground, 0.5));
        expect(result.hoverLighten, closeTo(0.0875, 0.001)); // (0.075 + 0.1) / 2
        expect(result.hoverDarken, closeTo(0.065, 0.001)); // (0.05 + 0.08) / 2
        expect(result.disabledOpacity, closeTo(0.4, 0.001)); // (0.5 + 0.3) / 2
      });
    });
  });
}
