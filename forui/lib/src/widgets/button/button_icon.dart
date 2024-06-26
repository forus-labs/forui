part of 'button.dart';

/// A [FButton]'s icon.
class FButtonIcon extends StatelessWidget {
  /// The icon.
  final SvgAsset icon;

  /// Creates a [FButtonIcon] from the given SVG [icon].
  const FButtonIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final (style: FButtonCustomStyle(:icon), :enabled) = FButton._of(context);

    return this.icon(
      height: icon.height,
      colorFilter: ColorFilter.mode(enabled ? icon.enabledColor : icon.disabledColor, BlendMode.srcIn),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('icon', icon));
  }
}

/// [FButtonIcon]'s style.
final class FButtonIconStyle with Diagnosticable {
  /// The icon's color when this button is enabled.
  final Color enabledColor;

  /// The icon's color when this button is disabled.
  final Color disabledColor;

  /// The icon's height. Defaults to 20.
  final double height;

  /// Creates a [FButtonIconStyle].
  ///
  /// ## Contract:
  /// Throws [AssertionError] if:
  /// * `height` <= 0.0
  /// * `height` is Nan
  FButtonIconStyle({
    required this.enabledColor,
    required this.disabledColor,
    this.height = 20,
  }) : assert(0 < height, 'The height is $height, but it should be in the range "0 < height".');

  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FButtonIconStyle(
  ///   enabledColor: Colors.red,
  ///   disabledColor: Colors.black,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   disabledColor: Colors.blue,
  /// );
  ///
  /// print(copy.enabledColor); // Colors.blue
  /// print(copy.disabledColor); // Colors.black
  /// ```
  @useResult
  FButtonIconStyle copyWith({
    Color? enabledColor,
    Color? disabledColor,
    double? height,
  }) =>
      FButtonIconStyle(
        enabledColor: enabledColor ?? this.enabledColor,
        disabledColor: disabledColor ?? this.disabledColor,
        height: height ?? this.height,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('enabledColor', enabledColor))
      ..add(ColorProperty('disabledColor', disabledColor))
      ..add(DoubleProperty('height', height, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconStyle &&
          runtimeType == other.runtimeType &&
          enabledColor == other.enabledColor &&
          disabledColor == other.disabledColor &&
          height == other.height;

  @override
  int get hashCode => enabledColor.hashCode ^ disabledColor.hashCode ^ height.hashCode;
}
