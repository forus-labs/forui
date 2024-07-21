part of 'alert.dart';

/// A [FAlert]'s icon.
class FAlertIcon extends StatelessWidget {
  /// The icon.
  final SvgAsset icon;

  /// Creates a [FAlertIcon] from the given SVG [icon].
  const FAlertIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final FAlertCustomStyle(:icon) = FAlert._of(context);

    return this.icon(
      height: icon.height,
      colorFilter: ColorFilter.mode(icon.color, BlendMode.srcIn),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('icon', icon));
  }
}

/// [FAlertIcon]'s style.
final class FAlertIconStyle with Diagnosticable {
  /// The icon's color.
  final Color color;

  /// The icon's height. Defaults to 20.
  final double height;

  /// Creates a [FButtonIconStyle].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `height` <= 0.0
  /// * `height` is Nan
  FAlertIconStyle({
    required this.color,
    this.height = 20,
  }) : assert(0 < height, 'The height is $height, but it should be in the range "0 < height".');

  /// Returns a copy of this [FAlertIconStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FAlertIconStyle(
  ///   height: 20,
  ///   color: Colors.red,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   color: Colors.blue,
  /// );
  ///
  /// print(copy.color); // Colors.blue
  /// print(copy.height); // 20
  /// ```
  @useResult
  FAlertIconStyle copyWith({
    Color? color,
    double? height,
  }) =>
      FAlertIconStyle(
        color: color ?? this.color,
        height: height ?? this.height,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('height', height, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconStyle &&
          runtimeType == other.runtimeType &&
          color == other.enabledColor &&
          height == other.height;

  @override
  int get hashCode => color.hashCode ^ height.hashCode;
}
