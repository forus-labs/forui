import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FFont', () {
    final font = FFont(
      family: 'Roboto',
      sizeScalar: 2,
      letterSpacingScalar: 3,
      wordSpacingScalar: 4,
      heightScalar: 5,
    );

    group('constructor', () {
      test('no arguments', () {
        final font = FFont();
        expect(font.family, 'packages/forui/Inter');
        expect(font.sizeScalar, 1);
        expect(font.letterSpacingScalar, 1);
        expect(font.wordSpacingScalar, 1);
        expect(font.heightScalar, 1);
      });

      test('blank font family', () => expect(() => FFont(family: ''), throwsAssertionError));

      test('sizeScalar is 0', () => expect(() => FFont(sizeScalar: 0), throwsAssertionError));

      test('sizeScalar is NaN', () => expect(() => FFont(sizeScalar: double.nan), throwsAssertionError));

      test('letterSpacingScalar is 0', () => expect(() => FFont(letterSpacingScalar: 0), throwsAssertionError));

      test('letterSpacingScalar is NaN', () => expect(() => FFont(letterSpacingScalar: double.nan), throwsAssertionError));

      test('wordSpacingScalar is 0', () => expect(() => FFont(wordSpacingScalar: 0), throwsAssertionError));

      test('wordSpacingScalar is NaN', () => expect(() => FFont(wordSpacingScalar: double.nan), throwsAssertionError));

      test('heightScalar is 0', () => expect(() => FFont(heightScalar: 0), throwsAssertionError));

      test('heightScalar is NaN', () => expect(() => FFont(heightScalar: double.nan), throwsAssertionError));
    });

    group('copyWith(...)', () {
      test('no arguments', () {
        font.copyWith();

        expect(font.family, 'Roboto');
        expect(font.sizeScalar, 2);
        expect(font.letterSpacingScalar, 3);
        expect(font.wordSpacingScalar, 4);
        expect(font.heightScalar, 5);
      });

      test('all arguments', () {
        final font = FFont().copyWith(
          family: 'Roboto',
          sizeScalar: 2,
          letterSpacingScalar: 3,
          wordSpacingScalar: 4,
          heightScalar: 5,
        );

        expect(font.family, 'Roboto');
        expect(font.sizeScalar, 2);
        expect(font.letterSpacingScalar, 3);
        expect(font.wordSpacingScalar, 4);
        expect(font.heightScalar, 5);
      });
    });

    group('toTextStyle(...)', () {
      test('no arguments', () {
        final style = font.toTextStyle();

        expect(style.fontFamily, 'Roboto');
        expect(style.fontSize, null);
        expect(style.letterSpacing, null);
        expect(style.wordSpacing, null);
        expect(style.height, null);
      });

      test('scaled arguments', () {
        final style = font.toTextStyle(
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
        final style = font.toTextStyle(
          color: const Color(0xFF000000),
        );

        expect(style.color, const Color(0xFF000000));
      });
    });

    test('debugFillProperties', () {
      final font = FFont(
        family: 'Roboto',
        sizeScalar: 2,
        letterSpacingScalar: 3,
        wordSpacingScalar: 4,
        heightScalar: 5,
      );

      final builder = DiagnosticPropertiesBuilder();
      font.debugFillProperties(builder);

      expect(builder.properties.map((p) => p.toString()), [
        StringProperty('family', 'Roboto'),
        DoubleProperty('sizeScalar', 2),
        DoubleProperty('letterSpacingScalar', 3),
        DoubleProperty('wordSpacingScalar', 4),
        DoubleProperty('heightScalar', 5),
      ].map((p) => p.toString()));
    });

    group('equality and hashcode', () {
      test('equal', () {
        final copy = font.copyWith();
        expect(copy, font);
        expect(copy.hashCode, font.hashCode);
      });

      test('not equal', () {
        final copy = font.copyWith(family: 'Else');
        expect(copy, isNot(font));
        expect(copy.hashCode, isNot(font.hashCode));
      });
    });
  });

  group('FontTextStyle', () {
    final font = FFont(
      family: 'Roboto',
      sizeScalar: 2,
      letterSpacingScalar: 3,
      wordSpacingScalar: 4,
      heightScalar: 5,
    );

    test('withFont(...)', () {
      final style = const TextStyle(
        color: Colors.blueAccent,
        fontFamily: 'default-font',
        fontSize: 7,
        letterSpacing: 11,
        wordSpacing: 13,
        height: 17,
      ).withFont(font);

      expect(style.color, Colors.blueAccent);
      expect(style.fontFamily, 'Roboto');
      expect(style.fontSize, 14);
      expect(style.letterSpacing, 33);
      expect(style.wordSpacing, 52);
      expect(style.height, 85);
    });
  });
}
