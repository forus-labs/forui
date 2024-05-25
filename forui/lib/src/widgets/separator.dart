import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A separator visually separates content.
final class FSeparator extends StatelessWidget {

  /// The style.
  final FSeparatorStyle? style;

  /// Whether this separator should be horizontal or vertical. Defaults to horizontal (false).
  final bool vertical;

  /// Creates a [FSeparator].
  const FSeparator({this.style, this.vertical = false, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? (vertical ? context.theme.separatorStyles.vertical : context.theme.separatorStyles.horizontal);
    return Padding(
      padding: style.padding,
      child: vertical ?
        SizedBox(
          width: style.width,
          height: double.infinity,
          child: ColoredBox(
            color: style.color,
          ),
        ) :
        SizedBox(
          width: double.infinity,
          height: style.width,
          child: ColoredBox(
            color: style.color,
          ),
        ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('vertical', vertical))
      ..add(DiagnosticsProperty<FSeparatorStyle?>('style', style));
  }

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

  /// The padding surrounding the separating line.
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
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding))
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
