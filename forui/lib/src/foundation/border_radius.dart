import 'dart:math' as math;

import 'package:flutter/painting.dart';

/// A [BorderRadius] that lerps between 0 and a radius when a rectangle is smaller than `radius * 3`.
class FLerpBorderRadius extends BorderRadius {
  final double _min;

  /// Creates a [FLerpBorderRadius].
  FLerpBorderRadius.circular(super.radius) : _min = radius * 3, super.circular();

  @override
  RRect toRRect(Rect rect) {
    final dimension = math.min(rect.width, rect.height);
    if (_min <= dimension) {
      return super.toRRect(rect);
    }

    final t = dimension / _min;
    return RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.lerp(null, topLeft, t)!,
      topRight: Radius.lerp(null, topRight, t)!,
      bottomLeft: Radius.lerp(null, bottomLeft, t)!,
      bottomRight: Radius.lerp(null, bottomRight, t)!,
    );
  }
}
