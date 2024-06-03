import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A separator that visually separates content.
final class FSeparator extends StatelessWidget {

  /// The style. Defaults to the appropriate style in [FThemeData.separatorStyles] if null.
  final FSeparatorStyle? style;

  /// True if this separator is vertical. Defaults to false (horizontal).
  final bool vertical;

  /// Creates a [FSeparator].
  const FSeparator({this.style, this.vertical = false, super.key});

  @override
  Widget build(BuildContext context) {
    final FSeparatorStyle(:padding, :width, :color) = style ?? (vertical ? context.theme.separatorStyles.vertical : context.theme.separatorStyles.horizontal);
    return Padding(
      padding: padding,
      child: vertical ?
        SizedBox(
          width: width,
          height: double.infinity,
          child: ColoredBox(
            color: color,
          ),
        ) :
        SizedBox(
          width: double.infinity,
          height: width,
          child: ColoredBox(
            color: color,
          ),
        ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('vertical', value: vertical, defaultValue: false))
      ..add(DiagnosticsProperty('style', style));
  }

}

/// The [FSeparator] styles.
final class FSeparatorStyles with Diagnosticable {

  /// The horizontal separator style.
  final FSeparatorStyle horizontal;

  /// The vertical separator style.
  final FSeparatorStyle vertical;

  /// Creates a [FSeparatorStyles].
  FSeparatorStyles({required this.horizontal, required this.vertical});

  /// Creates a [FSeparatorStyles] that inherits its properties from [colorScheme].
  FSeparatorStyles.inherit({required FColorScheme colorScheme, required FStyle style}):
    horizontal = FSeparatorStyle.inherit(
      colorScheme: colorScheme,
      style: style,
      padding: FSeparatorStyle.defaultPadding.horizontal,
    ),
    vertical = FSeparatorStyle.inherit(
      colorScheme: colorScheme,
      style: style,
      padding: FSeparatorStyle.defaultPadding.vertical
    );

  /// Creates a copy of this [FSeparatorStyles] with the given properties replaced.
  FSeparatorStyles copyWith({FSeparatorStyle? horizontal, FSeparatorStyle? vertical}) => FSeparatorStyles(
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
      other is FSeparatorStyles &&
          runtimeType == other.runtimeType &&
          horizontal == other.horizontal &&
          vertical == other.vertical;

  @override
  int get hashCode => horizontal.hashCode ^ vertical.hashCode;

}

/// [FSeparator]'s style.
final class FSeparatorStyle with Diagnosticable {

  /// The default padding for horizontal and vertical separators.
  static const defaultPadding = (
    horizontal: EdgeInsets.symmetric(vertical: 20),
    vertical: EdgeInsets.symmetric(horizontal: 20),
  );

  /// The color of the separating line. Defaults to [FColorScheme.secondary].
  final Color color;

  /// The padding surrounding the separating line. Defaults to the appropriate padding in [defaultPadding].
  final EdgeInsetsGeometry padding;

  /// The width of the separating line. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `width` <= 0.0
  /// * `width` is Nan
  final double width;

  /// Creates a [FSeparatorStyle].
  FSeparatorStyle({required this.color, required this.padding, this.width = 1}):
    assert(0 < width, 'The width is $width, but it should be in the range "0 < width".');

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme].
  FSeparatorStyle.inherit({required FColorScheme colorScheme, required FStyle style, required EdgeInsetsGeometry padding}):
    this(color: colorScheme.secondary, padding: padding, width: style.borderWidth);

  /// Creates a copy of this [FSeparatorStyle] with the given properties replaced.
  FSeparatorStyle copyWith({Color? color, EdgeInsetsGeometry? padding, double? width}) => FSeparatorStyle(
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
      other is FSeparatorStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          padding == other.padding &&
          width == other.width;

  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ width.hashCode;

}
