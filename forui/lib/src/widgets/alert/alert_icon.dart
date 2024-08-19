import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/alert/alert.dart';
import 'package:meta/meta.dart';

/// A [FAlert]'s icon.
class FAlertIcon extends StatelessWidget {
  /// The icon.
  final SvgAsset icon;

  /// Creates a [FAlertIcon] from the given SVG [icon].
  const FAlertIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final FAlertCustomStyle(:icon) = InheritedData.of(context);

    return this.icon(
      height: icon.size,
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

  /// The icon's size. Defaults to 20.
  final double size;

  /// Creates a [FButtonIconStyle].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `height` <= 0.0
  /// * `height` is Nan
  FAlertIconStyle({
    required this.color,
    this.size = 20,
  }) : assert(0 < size, 'The dimension is $size, but it should be positive.');

  /// Returns a copy of this [FAlertIconStyle] with the given properties replaced.
  @useResult
  FAlertIconStyle copyWith({
    Color? color,
    double? size,
  }) =>
      FAlertIconStyle(
        color: color ?? this.color,
        size: size ?? this.size,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('size', size, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconStyle &&
          runtimeType == other.runtimeType &&
          color == other.enabledColor &&
          size == other.size;

  @override
  int get hashCode => color.hashCode ^ size.hashCode;
}
