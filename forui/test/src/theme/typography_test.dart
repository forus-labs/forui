import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FTypography', () {
    FTypography typography = const FTypography();

    setUp(() {
      typography = const FTypography(
        defaultFontFamily: 'Roboto',
        xs: TextStyle(fontSize: 1),
        sm: TextStyle(fontSize: 2),
        base: TextStyle(fontSize: 3),
        lg: TextStyle(fontSize: 4),
        xl: TextStyle(fontSize: 5),
        xl2: TextStyle(fontSize: 6),
        xl3: TextStyle(fontSize: 7),
        xl4: TextStyle(fontSize: 8),
        xl5: TextStyle(fontSize: 9),
        xl6: TextStyle(fontSize: 10),
        xl7: TextStyle(fontSize: 11),
        xl8: TextStyle(fontSize: 12),
      );
    });

    group('constructor', () {
      test('no arguments', () {
        const typography = FTypography();

        expect(typography.defaultFontFamily, 'packages/forui/Inter');
        expect(typography.xs, const TextStyle(fontSize: 12, height: 1));
        expect(typography.sm, const TextStyle(fontSize: 14, height: 1.25));
        expect(typography.base, const TextStyle(fontSize: 16, height: 1.5));
        expect(typography.lg, const TextStyle(fontSize: 18, height: 1.75));
        expect(typography.xl, const TextStyle(fontSize: 20, height: 1.75));
        expect(typography.xl2, const TextStyle(fontSize: 22, height: 2));
        expect(typography.xl3, const TextStyle(fontSize: 30, height: 2.25));
        expect(typography.xl4, const TextStyle(fontSize: 36, height: 2.5));
        expect(typography.xl5, const TextStyle(fontSize: 48, height: 1));
        expect(typography.xl6, const TextStyle(fontSize: 60, height: 1));
        expect(typography.xl7, const TextStyle(fontSize: 72, height: 1));
        expect(typography.xl8, const TextStyle(fontSize: 96, height: 1));
      });

      test('blank font family', () => expect(() => FTypography(defaultFontFamily: ''), throwsAssertionError));
    });

    group('inherit constructor', () {
      const colors = FColors(
        brightness: Brightness.light,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        barrier: Colors.black12,
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

      test('no arguments', () {
        typography = FTypography.inherit(colors: colors);

        expect(typography.defaultFontFamily, 'packages/forui/Inter');
        expect(
          typography.xs,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 12, height: 1),
        );
        expect(
          typography.sm,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 14, height: 1.25),
        );
        expect(
          typography.base,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 16, height: 1.5),
        );
        expect(
          typography.lg,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 18, height: 1.75),
        );
        expect(
          typography.xl,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 20, height: 1.75),
        );
        expect(
          typography.xl2,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 22, height: 2),
        );
        expect(
          typography.xl3,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 30, height: 2.25),
        );
        expect(
          typography.xl4,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 36, height: 2.5),
        );
        expect(
          typography.xl5,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 48, height: 1),
        );
        expect(
          typography.xl6,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 60, height: 1),
        );
        expect(
          typography.xl7,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 72, height: 1),
        );
        expect(
          typography.xl8,
          TextStyle(color: colors.foreground, fontFamily: typography.defaultFontFamily, fontSize: 96, height: 1),
        );
      });

      test(
        'blank font family',
        () => expect(() => FTypography.inherit(colors: colors, defaultFontFamily: ''), throwsAssertionError),
      );
    });

    group('scale(...)', () {
      test('no arguments', () {
        typography = typography.scale();

        expect(typography.defaultFontFamily, 'Roboto');
        expect(typography.xs, const TextStyle(fontSize: 1));
        expect(typography.sm, const TextStyle(fontSize: 2));
        expect(typography.base, const TextStyle(fontSize: 3));
        expect(typography.lg, const TextStyle(fontSize: 4));
        expect(typography.xl, const TextStyle(fontSize: 5));
        expect(typography.xl2, const TextStyle(fontSize: 6));
        expect(typography.xl3, const TextStyle(fontSize: 7));
        expect(typography.xl4, const TextStyle(fontSize: 8));
        expect(typography.xl5, const TextStyle(fontSize: 9));
        expect(typography.xl6, const TextStyle(fontSize: 10));
        expect(typography.xl7, const TextStyle(fontSize: 11));
        expect(typography.xl8, const TextStyle(fontSize: 12));
      });

      test('all arguments', () {
        typography = typography.scale(sizeScalar: 10);

        expect(typography.defaultFontFamily, 'Roboto');
        expect(typography.xs, const TextStyle(fontSize: 10));
        expect(typography.sm, const TextStyle(fontSize: 20));
        expect(typography.base, const TextStyle(fontSize: 30));
        expect(typography.lg, const TextStyle(fontSize: 40));
        expect(typography.xl, const TextStyle(fontSize: 50));
        expect(typography.xl2, const TextStyle(fontSize: 60));
        expect(typography.xl3, const TextStyle(fontSize: 70));
        expect(typography.xl4, const TextStyle(fontSize: 80));
        expect(typography.xl5, const TextStyle(fontSize: 90));
        expect(typography.xl6, const TextStyle(fontSize: 100));
        expect(typography.xl7, const TextStyle(fontSize: 110));
        expect(typography.xl8, const TextStyle(fontSize: 120));
      });
    });

    group('copyWith(...)', () {
      test('no arguments', () {
        typography = const FTypography(defaultFontFamily: 'Roboto');
        typography = typography.copyWith();

        expect(typography.defaultFontFamily, 'Roboto');
        expect(typography.xs, const TextStyle(fontSize: 12, height: 1));
        expect(typography.sm, const TextStyle(fontSize: 14, height: 1.25));
        expect(typography.base, const TextStyle(fontSize: 16, height: 1.5));
        expect(typography.lg, const TextStyle(fontSize: 18, height: 1.75));
        expect(typography.xl, const TextStyle(fontSize: 20, height: 1.75));
        expect(typography.xl2, const TextStyle(fontSize: 22, height: 2));
        expect(typography.xl3, const TextStyle(fontSize: 30, height: 2.25));
        expect(typography.xl4, const TextStyle(fontSize: 36, height: 2.5));
        expect(typography.xl5, const TextStyle(fontSize: 48, height: 1));
        expect(typography.xl6, const TextStyle(fontSize: 60, height: 1));
        expect(typography.xl7, const TextStyle(fontSize: 72, height: 1));
        expect(typography.xl8, const TextStyle(fontSize: 96, height: 1));
      });

      test('all arguments', () {
        final typography = const FTypography().copyWith(
          xs: const TextStyle(fontSize: 1),
          sm: const TextStyle(fontSize: 2),
          base: const TextStyle(fontSize: 3),
          lg: const TextStyle(fontSize: 4),
          xl: const TextStyle(fontSize: 5),
          xl2: const TextStyle(fontSize: 6),
          xl3: const TextStyle(fontSize: 7),
          xl4: const TextStyle(fontSize: 8),
          xl5: const TextStyle(fontSize: 9),
          xl6: const TextStyle(fontSize: 10),
          xl7: const TextStyle(fontSize: 11),
          xl8: const TextStyle(fontSize: 12),
        );

        expect(typography.defaultFontFamily, 'packages/forui/Inter');
        expect(typography.xs, const TextStyle(fontSize: 1));
        expect(typography.sm, const TextStyle(fontSize: 2));
        expect(typography.base, const TextStyle(fontSize: 3));
        expect(typography.lg, const TextStyle(fontSize: 4));
        expect(typography.xl, const TextStyle(fontSize: 5));
        expect(typography.xl2, const TextStyle(fontSize: 6));
        expect(typography.xl3, const TextStyle(fontSize: 7));
        expect(typography.xl4, const TextStyle(fontSize: 8));
        expect(typography.xl5, const TextStyle(fontSize: 9));
        expect(typography.xl6, const TextStyle(fontSize: 10));
        expect(typography.xl7, const TextStyle(fontSize: 11));
        expect(typography.xl8, const TextStyle(fontSize: 12));
      });
    });

    test('debugFillProperties', () {
      final builder = DiagnosticPropertiesBuilder();
      typography.debugFillProperties(builder);

      expect(
        builder.properties.map((p) => p.toString()),
        [
          StringProperty('defaultFontFamily', 'Roboto'),
          DiagnosticsProperty('xs', const TextStyle(fontSize: 1)),
          DiagnosticsProperty('sm', const TextStyle(fontSize: 2)),
          DiagnosticsProperty('base', const TextStyle(fontSize: 3)),
          DiagnosticsProperty('lg', const TextStyle(fontSize: 4)),
          DiagnosticsProperty('xl', const TextStyle(fontSize: 5)),
          DiagnosticsProperty('xl2', const TextStyle(fontSize: 6)),
          DiagnosticsProperty('xl3', const TextStyle(fontSize: 7)),
          DiagnosticsProperty('xl4', const TextStyle(fontSize: 8)),
          DiagnosticsProperty('xl5', const TextStyle(fontSize: 9)),
          DiagnosticsProperty('xl6', const TextStyle(fontSize: 10)),
          DiagnosticsProperty('xl7', const TextStyle(fontSize: 11)),
          DiagnosticsProperty('xl8', const TextStyle(fontSize: 12)),
        ].map((p) => p.toString()),
      );
    });

    group('equality and hashcode', () {
      test('equal', () {
        final copy = typography.copyWith();
        expect(copy, typography);
        expect(copy.hashCode, typography.hashCode);
      });

      test('not equal', () {
        final copy = typography.copyWith(xs: const TextStyle(fontSize: 100));
        expect(copy, isNot(typography));
        expect(copy.hashCode, isNot(typography.hashCode));
      });
    });

    group('lerp(...)', () {
      const typographyB = FTypography(
        defaultFontFamily: 'Arial',
        xs: TextStyle(fontSize: 10, height: 1.5, color: Colors.red),
        sm: TextStyle(fontSize: 12, height: 1.75, color: Colors.green),
        base: TextStyle(fontSize: 14, height: 2.0, color: Colors.blue),
        lg: TextStyle(fontSize: 16, height: 2.25, color: Colors.yellow),
        xl: TextStyle(fontSize: 18, height: 2.5, color: Colors.orange),
        xl2: TextStyle(fontSize: 20, height: 2.75, color: Colors.purple),
        xl3: TextStyle(fontSize: 22, height: 3.0, color: Colors.pink),
        xl4: TextStyle(fontSize: 24, height: 3.25, color: Colors.brown),
        xl5: TextStyle(fontSize: 26, height: 3.5, color: Colors.grey),
        xl6: TextStyle(fontSize: 28, height: 3.75, color: Colors.teal),
        xl7: TextStyle(fontSize: 30, height: 4.0, color: Colors.indigo),
        xl8: TextStyle(fontSize: 32, height: 4.25, color: Colors.lime),
      );

      test('identical objects', () {
        final result = FTypography.lerp(typography, typography, 0.5);
        expect(result, typography);
      });

      test('interpolation at t=0', () {
        final result = FTypography.lerp(typography, typographyB, 0.0);
        expect(result.defaultFontFamily, typography.defaultFontFamily);
        expect(result.xs, typography.xs);
        expect(result.sm, typography.sm);
        expect(result.base, typography.base);
      });

      test('interpolation at t=1', () {
        final result = FTypography.lerp(typography, typographyB, 1.0);
        expect(result.defaultFontFamily, typographyB.defaultFontFamily);
        expect(result.xs, typographyB.xs);
        expect(result.sm, typographyB.sm);
        expect(result.base, typographyB.base);
      });

      test('interpolation at t=0.5', () {
        final result = FTypography.lerp(typography, typographyB, 0.5);
        expect(result.defaultFontFamily, typography.defaultFontFamily); // threshold-based
        expect(result.xs, TextStyle.lerp(typography.xs, typographyB.xs, 0.5));
        expect(result.sm, TextStyle.lerp(typography.sm, typographyB.sm, 0.5));
        expect(result.base, TextStyle.lerp(typography.base, typographyB.base, 0.5));
        expect(result.lg, TextStyle.lerp(typography.lg, typographyB.lg, 0.5));
        expect(result.xl, TextStyle.lerp(typography.xl, typographyB.xl, 0.5));
        expect(result.xl2, TextStyle.lerp(typography.xl2, typographyB.xl2, 0.5));
        expect(result.xl3, TextStyle.lerp(typography.xl3, typographyB.xl3, 0.5));
        expect(result.xl4, TextStyle.lerp(typography.xl4, typographyB.xl4, 0.5));
        expect(result.xl5, TextStyle.lerp(typography.xl5, typographyB.xl5, 0.5));
        expect(result.xl6, TextStyle.lerp(typography.xl6, typographyB.xl6, 0.5));
        expect(result.xl7, TextStyle.lerp(typography.xl7, typographyB.xl7, 0.5));
        expect(result.xl8, TextStyle.lerp(typography.xl8, typographyB.xl8, 0.5));
      });
    });
  });
}
