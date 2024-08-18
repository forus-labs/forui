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

  /// True if this divider is vertical. Defaults to false (horizontal).
  final bool vertical;

  /// Creates a [FDivider].
  const FDivider({this.style, this.vertical = false, super.key});

  @override
  Widget build(BuildContext context) {
    final style =
        this.style ?? (vertical ? context.theme.dividerStyles.vertical : context.theme.dividerStyles.horizontal);
    final (height, width) = vertical ? (null, style.width) : (style.width, null);

    return Container(
      margin: style.padding,
      color: style.color,
      height: height,
      width: width,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('vertical', value: vertical, defaultValue: false, ifTrue: 'vertical'))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// The [FDivider] styles.
final class FDividerStyles with Diagnosticable {
  /// The horizontal divider's style.
  final FDividerStyle horizontal;

  /// The vertical divider's style.
  final FDividerStyle vertical;

  /// Creates a [FDividerStyles].
  FDividerStyles({required this.horizontal, required this.vertical});

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [style].
  FDividerStyles.inherit({required FColorScheme colorScheme, required FStyle style})
      : horizontal = FDividerStyle.inherit(
          colorScheme: colorScheme,
          style: style,
          padding: FDividerStyle.defaultPadding.horizontal,
        ),
        vertical = FDividerStyle.inherit(
          colorScheme: colorScheme,
          style: style,
          padding: FDividerStyle.defaultPadding.vertical,
        );

  /// Returns a copy of this [FDividerStyles] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FDividerStyles(
  ///   horizontal: ...,
  ///   vertical: ...,
  /// );
  ///
  /// final copy = style.copyWith(vertical: ...);
  ///
  /// print(style.horizontal == copy.horizontal); // true
  /// print(style.vertical == copy.vertical); // false
  /// ```
  @useResult
  FDividerStyles copyWith({FDividerStyle? horizontal, FDividerStyle? vertical}) => FDividerStyles(
        horizontal: horizontal ?? this.horizontal,
        vertical: vertical ?? this.vertical,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontal', horizontal))
      ..add(DiagnosticsProperty('vertical', vertical));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDividerStyles &&
          runtimeType == other.runtimeType &&
          horizontal == other.horizontal &&
          vertical == other.vertical;

  @override
  int get hashCode => horizontal.hashCode ^ vertical.hashCode;
}

/// [FDivider]'s style.
final class FDividerStyle with Diagnosticable {
  /// The default padding for horizontal and vertical dividers.
  static const defaultPadding = (
    horizontal: EdgeInsets.symmetric(vertical: 20),
    vertical: EdgeInsets.symmetric(horizontal: 20),
  );

  /// The color of the separating line.
  final Color color;

  /// The padding surrounding the separating line. Defaults to the appropriate padding in [defaultPadding].
  final EdgeInsetsGeometry padding;

  /// The width of the separating line. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `thickness` <= 0.0
  /// * `thickness` is Nan
  final double width;

  /// Creates a [FDividerStyle].
  FDividerStyle({required this.color, required this.padding, this.width = 1})
      : assert(0 < width, 'The thickness is $width, but it should be in the range "0 < thickness".');

  /// Creates a [FDividerStyle] that inherits its properties from [colorScheme], [style], and [padding].
  FDividerStyle.inherit({
    required FColorScheme colorScheme,
    required FStyle style,
    required EdgeInsetsGeometry padding,
  }) : this(color: colorScheme.secondary, padding: padding, width: style.borderWidth);

  /// Returns a copy of this [FDividerStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FDividerStyle(
  ///   color: Colors.black,
  ///   width: 1,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(width: 2);
  ///
  /// print(copy.color); // black
  /// print(copy.width); // 2
  /// ```
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
