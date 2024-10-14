import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A divider.
///
/// Dividers visually separate content.
///
/// See:
/// * https://forui.dev/docs/divider for working examples.
/// * [FDividerStyle] for customizing a divider's appearance.
final class FDivider extends StatelessWidget {
  /// The divider's style. Defaults to the appropriate style in [FThemeData.dividerStyles].
  final FDividerStyle? style;

  /// The axis. Defaults to horizontal.
  final Axis axis;

  /// Creates a [FDivider].
  const FDivider({this.style, this.axis = Axis.horizontal, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ??
        switch (axis) {
          Axis.horizontal => context.theme.dividerStyles.horizontalStyle,
          Axis.vertical => context.theme.dividerStyles.verticalStyle,
        };

    return Container(
      margin: style.padding,
      color: style.color,
      height: axis == Axis.horizontal ? style.width : null,
      width: axis == Axis.horizontal ? null : style.width,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('axis', axis));
  }
}

/// The [FDivider] styles.
final class FDividerStyles with Diagnosticable {
  /// The horizontal divider's style.
  final FDividerStyle horizontalStyle;

  /// The vertical divider's style.
  final FDividerStyle verticalStyle;

  /// Creates a [FDividerStyles].
  FDividerStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [style].
  FDividerStyles.inherit({required FColorScheme colorScheme, required FStyle style})
      : this(
          horizontalStyle: FDividerStyle.inherit(
            colorScheme: colorScheme,
            style: style,
            padding: FDividerStyle.defaultPadding.horizontalStyle,
          ),
          verticalStyle: FDividerStyle.inherit(
            colorScheme: colorScheme,
            style: style,
            padding: FDividerStyle.defaultPadding.verticalStyle,
          ),
        );

  /// Returns a copy of this [FDividerStyles] with the given properties replaced.
  @useResult
  FDividerStyles copyWith({FDividerStyle? horizontalStyle, FDividerStyle? verticalStyle}) => FDividerStyles(
        horizontalStyle: horizontalStyle ?? this.horizontalStyle,
        verticalStyle: verticalStyle ?? this.verticalStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDividerStyles &&
          runtimeType == other.runtimeType &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle;

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// [FDivider]'s style.
///
/// The [padding] property can be used to indent the start and end of the separating line.
final class FDividerStyle with Diagnosticable {
  /// The default padding for horizontal and vertical dividers.
  static const defaultPadding = (
    horizontalStyle: EdgeInsets.symmetric(vertical: 20),
    verticalStyle: EdgeInsets.symmetric(horizontal: 20),
  );

  /// The color of the separating line.
  final Color color;

  /// The padding surrounding the separating line. Defaults to the appropriate padding in [defaultPadding].
  ///
  /// This property can be used to indent the start and end of the separating line.
  final EdgeInsetsGeometry padding;

  /// The width (thickness) of the separating line. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `width` <= 0.0
  /// * `width` is Nan
  final double width;

  /// Creates a [FDividerStyle].
  FDividerStyle({required this.color, required this.padding, this.width = 1})
      : assert(0 < width, 'The width is $width, but it should be in the range "0 < width".');

  /// Creates a [FDividerStyle] that inherits its properties from [colorScheme], [style], and [padding].
  FDividerStyle.inherit({
    required FColorScheme colorScheme,
    required FStyle style,
    required EdgeInsetsGeometry padding,
  }) : this(
          color: colorScheme.secondary,
          padding: padding,
          width: style.borderWidth,
        );

  /// Returns a copy of this [FDividerStyle] with the given properties replaced.
  @useResult
  FDividerStyle copyWith({Color? color, EdgeInsetsGeometry? padding, double? width}) => FDividerStyle(
        color: color ?? this.color,
        padding: padding ?? this.padding,
        width: width ?? this.width,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDividerStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          padding == other.padding &&
          width == other.width;

  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ width.hashCode;
}
