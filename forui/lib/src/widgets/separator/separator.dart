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
    final style = this.style ?? (vertical ? context.theme.verticalSeparatorStyle : context.theme.separatorStyle);
    return Padding(
      padding: style.padding,
      child: vertical ?
        SizedBox(
          width: style.thickness,
          child: ColoredBox(
            color: style.color,
          ),
        ) :
        SizedBox(
          height: style.thickness,
          child: ColoredBox(
            color: style.color,
          ),
        ),
    );
  }

}

/// [FSeparator]'s style.
final class FSeparatorStyle with Diagnosticable {

  /// The default padding for horizontal and vertical separators.
  static const defaultPadding = (
    horizontal: EdgeInsets.only(top: 20, bottom: 20),
    vertical: EdgeInsets.only(left: 20, right: 20),
  );

  /// The color of the separating line. Defaults to [FColorScheme.secondary].
  final Color color;

  /// The padding surrounding the separating line.
  final EdgeInsetsGeometry padding;

  /// The thickness of the separating line. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `thickness` <= 0.0
  /// * `thickness` is Nan
  final double thickness;

  /// Creates a [FSeparatorStyle].
  FSeparatorStyle({required this.color, required this.padding, this.thickness = 1}):
    assert(0 < thickness, 'The thickness is $thickness, but it should be in the range "0 < thickness".');

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme].
  FSeparatorStyle.inherit({required FColorScheme colorScheme, required EdgeInsetsGeometry padding}):
    this(color: colorScheme.secondary, padding: padding);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSeparatorStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          padding == other.padding &&
          thickness == other.thickness;

  @override
  int get hashCode => color.hashCode ^ padding.hashCode ^ thickness.hashCode;

}
