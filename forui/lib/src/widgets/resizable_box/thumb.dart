import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class Thumb extends StatelessWidget {
  final FResizableThumbStyle style;

  const Thumb({required this.style, super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: style.padding,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: style.color,
            borderRadius: style.borderRadius,
          ),
          child: SizedBox(
            height: style.height,
            width: style.width,
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// The resizable thumbs' style.
class FResizableThumbStyle with Diagnosticable {
  /// The padding. Defaults to `EdgeInsets.all(7)`.
  final EdgeInsetsGeometry padding;

  /// The icon's color. Defaults to [Colors.white30].
  final Color color;

  /// The height.
  ///
  /// Defaults to:
  /// * 4.7 when vertically resizable
  /// * 29 when horizontally resizable
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [height] <= 0
  /// * [height] is [double.nan]
  final double height;

  /// The width.
  ///
  /// Defaults to:
  /// * 29 when vertically resizable
  /// * 4.7 when horizontally resizable
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [width] <= 0
  /// * [width] is [double.nan]
  final double width;

  /// The thumb's border radius.
  final BorderRadius borderRadius;

  /// Creates a [FResizableThumbStyle].
  const FResizableThumbStyle({
    required this.height,
    required this.width,
    required this.borderRadius,
    this.padding = const EdgeInsets.all(7),
    this.color = Colors.white30,
  })  : assert(0 < width, 'Height should be positive, but is $height.'),
        assert(0 < height, 'Width should be positive, but is $width.');

  /// Creates a [FResizableThumbStyle] that for a `FResizable` that is horizontally resizable.
  const FResizableThumbStyle.horizontal({
    this.padding = const EdgeInsets.all(7),
    this.color = Colors.white30,
    this.height = 29,
    this.width = 4.7,
    this.borderRadius = const BorderRadius.vertical(
      top: Radius.circular(5),
      bottom: Radius.circular(5),
    ),
  })  : assert(0 < width, 'Height should be positive, but is $height.'),
        assert(0 < height, 'Width should be positive, but is $width.');

  /// Creates a [FResizableThumbStyle] that for a `FResizable` that is vertically resizable.
  const FResizableThumbStyle.vertical({
    this.padding = const EdgeInsets.all(7),
    this.color = Colors.white30,
    this.height = 4.7,
    this.width = 29,
    this.borderRadius = const BorderRadius.horizontal(
      left: Radius.circular(5),
      right: Radius.circular(5),
    ),
  })  : assert(0 < width, 'Height should be positive, but is $height.'),
        assert(0 < height, 'Width should be positive, but is $width.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('borderRadius', borderRadius));
  }
}
