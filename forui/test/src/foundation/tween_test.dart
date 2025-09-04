import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/tween.dart';

void main() {
  group('FImmutableTween', () {
    group('transform', () {
      test('returns begin value when t=0.0', () {
        const tween = FImmutableTween(begin: 10.0, end: 20.0);
        
        expect(tween.transform(0.0), 10.0);
      });

      test('returns end value when t=1.0', () {
        const tween = FImmutableTween(begin: 10.0, end: 20.0);
        
        expect(tween.transform(1.0), 20.0);
      });

      test('interpolates correctly for intermediate values', () {
        const tween = FImmutableTween(begin: 0.0, end: 100.0);
        
        expect(tween.transform(0.5), 50.0);
        expect(tween.transform(0.25), 25.0);
        expect(tween.transform(0.75), 75.0);
      });
    });

    group('lerp', () {
      test('performs linear interpolation', () {
        const tween = FImmutableTween(begin: 0.0, end: 100.0);
        
        expect(tween.lerp(0.0), 0.0);
        expect(tween.lerp(0.25), 25.0);
        expect(tween.lerp(0.5), 50.0);
        expect(tween.lerp(0.75), 75.0);
        expect(tween.lerp(1.0), 100.0);
      });

      test('throws FlutterError for incompatible types', () {
        const tween = FImmutableTween(begin: 'hello', end: 'world');
        
        expect(
          () => tween.lerp(0.5),
          throwsA(isA<FlutterError>()),
        );
      });
    });
  });
}
