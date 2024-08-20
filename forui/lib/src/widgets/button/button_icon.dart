import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FButton]'s icon.
class FButtonIcon extends StatelessWidget {
  /// The icon.
  final SvgAsset icon;

  /// Creates a [FButtonIcon] from the given SVG [icon].
  const FButtonIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonCustomStyle(:icon), :enabled) = FButtonData.of(context);

    return this.icon(
      height: icon.size,
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

  /// The icon's size. Defaults to 20.
  final double size;

  /// Creates a [FButtonIconStyle].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `size` <= 0.0
  /// * `size` is Nan
  FButtonIconStyle({
    required this.enabledColor,
    required this.disabledColor,
    this.size = 20,
  }) : assert(0 < size, 'The size is $size, but it should be in the range "0 < size".');

  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  @useResult
  FButtonIconStyle copyWith({
    Color? enabledColor,
    Color? disabledColor,
    double? size,
  }) =>
      FButtonIconStyle(
        enabledColor: enabledColor ?? this.enabledColor,
        disabledColor: disabledColor ?? this.disabledColor,
        size: size ?? this.size,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('enabledColor', enabledColor))
      ..add(ColorProperty('disabledColor', disabledColor))
      ..add(DoubleProperty('size', size, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconStyle &&
          runtimeType == other.runtimeType &&
          enabledColor == other.enabledColor &&
          disabledColor == other.disabledColor &&
          size == other.size;

  @override
  int get hashCode => enabledColor.hashCode ^ disabledColor.hashCode ^ size.hashCode;
}
