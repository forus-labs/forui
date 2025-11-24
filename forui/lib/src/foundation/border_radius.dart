import 'dart:math';

import 'package:flutter/painting.dart';

/// A [BorderRadius] that lerps between 0 and a radius when a rectangle is smaller than `radius * 3`.
class FLerpBorderRadius extends BorderRadius {
  final double _min;

  /// Creates a [FLerpBorderRadius].
  const FLerpBorderRadius.all(super.radius, {required double min}) : _min = min, super.all();

  /// Creates a [FLerpBorderRadius].
  FLerpBorderRadius.circular(super.radius) : _min = radius * 3, super.circular();

  @override
  RRect toRRect(Rect rect) {
    final dimension = min(rect.width, rect.height);
    if (_min <= dimension) {
      return super.toRRect(rect);
    }

    final t = 1 - dimension / _min;
    return .fromRectAndCorners(
      rect,
      topLeft: .elliptical(topLeft.x * t, topLeft.y * t),
      topRight: .elliptical(topRight.x * t, topRight.y * t),
      bottomLeft: .elliptical(bottomLeft.x * t, bottomLeft.y * t),
      bottomRight: .elliptical(bottomRight.x * t, bottomRight.y * t),
    );
  }
}
