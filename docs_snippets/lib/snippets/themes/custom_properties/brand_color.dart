import 'package:flutter/material.dart';

class BrandColor extends ThemeExtension<BrandColor> {
  final Color color;

  const BrandColor({required this.color});

  @override
  BrandColor copyWith({Color? color}) => BrandColor(color: color ?? this.color);

  @override
  BrandColor lerp(BrandColor? other, double t) {
    if (other is! BrandColor) {
      return this;
    }

    return BrandColor(color: Color.lerp(color, other.color, t)!);
  }
}
