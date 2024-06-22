import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FTypography', () {
    const typography = FTypography(
      defaultFontFamily: 'Roboto',
      sizeScalar: 2,
      letterSpacingScalar: 3,
      wordSpacingScalar: 4,
      heightScalar: 5,
    );

    group('constructor', () {
      test('no arguments', () {
        const typography = FTypography();
        expect(typography.defaultFontFamily, 'packages/forui/Inter');
        expect(typography.sizeScalar, 1);
        expect(typography.letterSpacingScalar, 1);
        expect(typography.wordSpacingScalar, 1);
        expect(typography.heightScalar, 1);
      });

      test('blank font family', () => expect(() => FTypography(defaultFontFamily: ''), throwsAssertionError));

      test('sizeScalar is 0', () => expect(() => FTypography(sizeScalar: 0), throwsAssertionError));

      test('sizeScalar is NaN', () => expect(() => FTypography(sizeScalar: double.nan), throwsAssertionError));

      test('letterSpacingScalar is 0', () => expect(() => FTypography(letterSpacingScalar: 0), throwsAssertionError));

      test('letterSpacingScalar is NaN',
          () => expect(() => FTypography(letterSpacingScalar: double.nan), throwsAssertionError));

      test('wordSpacingScalar is 0', () => expect(() => FTypography(wordSpacingScalar: 0), throwsAssertionError));

      test('wordSpacingScalar is NaN', () => expect(() => FTypography(wordSpacingScalar: double.nan), throwsAssertionError));

      test('heightScalar is 0', () => expect(() => FTypography(heightScalar: 0), throwsAssertionError));

      test('heightScalar is NaN', () => expect(() => FTypography(heightScalar: double.nan), throwsAssertionError));
    });

    // TODO: scale function.

    group('copyWith(...)', () {
      test('no arguments', () {
        typography.copyWith();

        expect(typography.defaultFontFamily, 'Roboto');
        expect(typography.sizeScalar, 2);
        expect(typography.letterSpacingScalar, 3);
        expect(typography.wordSpacingScalar, 4);
        expect(typography.heightScalar, 5);
      });

      test('all arguments', () {
        final typography = const FTypography().copyWith(
          defaultFontFamily: 'Roboto',
          sizeScalar: 2,
          letterSpacingScalar: 3,
          wordSpacingScalar: 4,
          heightScalar: 5,
        );

        expect(typography.defaultFontFamily, 'Roboto');
        expect(typography.sizeScalar, 2);
        expect(typography.letterSpacingScalar, 3);
        expect(typography.wordSpacingScalar, 4);
        expect(typography.heightScalar, 5);
      });
    });

    group('toTextStyle(...)', () {
      test('no arguments', () {
        final style = typography.toTextStyle();

        expect(style.fontFamily, 'Roboto');
        expect(style.fontSize, null);
        expect(style.letterSpacing, null);
        expect(style.wordSpacing, null);
        expect(style.height, null);
      });

      test('scaled arguments', () {
        final style = typography.toTextStyle(
          fontSize: 7,
          letterSpacing: 11,
          wordSpacing: 13,
          height: 17,
        );

        expect(style.fontFamily, 'Roboto');
        expect(style.fontSize, 14);
        expect(style.letterSpacing, 33);
        expect(style.wordSpacing, 52);
        expect(style.height, 85);
      });

      test('other arguments', () {
        final style = typography.toTextStyle(
          color: const Color(0xFF000000),
        );

        expect(style.color, const Color(0xFF000000));
      });
    });

    test('debugFillProperties', () {
      const font = FTypography(
        defaultFontFamily: 'Roboto',
        sizeScalar: 2,
        letterSpacingScalar: 3,
        wordSpacingScalar: 4,
        heightScalar: 5,
        xs: 6,
        sm: 7,
        base: 8,
        lg: 9,
        xl: 10,
        xl2: 11,
        xl3: 12,
        xl4: 13,
        xl5: 14,
        xl6: 15,
        xl7: 16,
        xl8: 17,
      );

      final builder = DiagnosticPropertiesBuilder();
      font.debugFillProperties(builder);

      expect(
          builder.properties.map((p) => p.toString()),
          [
            StringProperty('family', 'Roboto'),
            DoubleProperty('sizeScalar', 2),
            DoubleProperty('letterSpacingScalar', 3),
            DoubleProperty('wordSpacingScalar', 4),
            DoubleProperty('heightScalar', 5),
            DoubleProperty('xs', 6),
            DoubleProperty('sm', 7),
            DoubleProperty('base', 8),
            DoubleProperty('lg', 9),
            DoubleProperty('xl', 10),
            DoubleProperty('xl2', 11),
            DoubleProperty('xl3', 12),
            DoubleProperty('xl4', 13),
            DoubleProperty('xl5', 14),
            DoubleProperty('xl6', 15),
            DoubleProperty('xl7', 16),
            DoubleProperty('xl8', 17),
          ].map((p) => p.toString()));
    });

    group('equality and hashcode', () {
      test('equal', () {
        final copy = typography.copyWith();
        expect(copy, typography);
        expect(copy.hashCode, typography.hashCode);
      });

      test('not equal', () {
        final copy = typography.copyWith(defaultFontFamily: 'Else');
        expect(copy, isNot(typography));
        expect(copy.hashCode, isNot(typography.hashCode));
      });
    });
  });

  group('FontTextStyle', () {
    const font = FTypography(
      defaultFontFamily: 'Roboto',
      sizeScalar: 2,
      letterSpacingScalar: 3,
      wordSpacingScalar: 4,
      heightScalar: 5,
    );

    test('scale(...)', () {
      final style = const TextStyle(
        color: Colors.blueAccent,
        fontFamily: 'default-font',
        fontSize: 7,
        letterSpacing: 11,
        wordSpacing: 13,
        height: 17,
      ).scale(font);

      expect(style.color, Colors.blueAccent);
      expect(style.fontFamily, 'default-font');
      expect(style.fontSize, 14);
      expect(style.letterSpacing, 33);
      expect(style.wordSpacing, 52);
      expect(style.height, 85);
    });
  });
}
