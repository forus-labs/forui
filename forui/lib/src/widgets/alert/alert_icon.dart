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
      height: icon.dimension,
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

  /// The icon's dimension. Defaults to 20.
  final double dimension;

  /// Creates a [FButtonIconStyle].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `height` <= 0.0
  /// * `height` is Nan
  FAlertIconStyle({
    required this.color,
    this.dimension = 20,
  }) : assert(0 < dimension, 'The dimension is $dimension, but it should be positive.');

  /// Returns a copy of this [FAlertIconStyle] with the given properties replaced.
  @useResult
  FAlertIconStyle copyWith({
    Color? color,
    double? dimension,
  }) =>
      FAlertIconStyle(
        color: color ?? this.color,
        dimension: dimension ?? this.dimension,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('dimension', dimension, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconStyle &&
          runtimeType == other.runtimeType &&
          color == other.enabledColor &&
          dimension == other.height;

  @override
  int get hashCode => color.hashCode ^ dimension.hashCode;
}
