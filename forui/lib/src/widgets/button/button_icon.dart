part of 'button.dart';

/// Represents an icon that is used in a [FButton].
class FButtonIcon extends StatelessWidget {
  /// The icon.
  final SvgAsset icon;

  /// Creates a [FButtonIcon].
  const FButtonIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final (:style, :enabled) = FButton._of(context);

    return icon(
      height: 20,
      colorFilter: ColorFilter.mode(enabled ? style.icon.enabled : style.icon.disabled, BlendMode.srcIn),
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
  final Color enabled;

  /// The icon's color when this button is disabled.
  final Color disabled;

  /// The icon's height. Defaults to 20.
  final double height;

  /// Creates a [FButtonIconStyle].
  FButtonIconStyle({
    required this.enabled,
    required this.disabled,
    required this.height,
  });

  /// Creates a [FButtonIconStyle] that inherits its properties from the given [foreground] and [disabledForeground].
  FButtonIconStyle.inherit({
    required Color foreground,
    required Color disabledForeground,
  })  : enabled = foreground,
        disabled = disabledForeground,
        height = 20;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('enabled', enabled))
      ..add(ColorProperty('disabled', disabled))
      ..add(DoubleProperty('height', height));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconStyle &&
          runtimeType == other.runtimeType &&
          enabled == other.enabled &&
          disabled == other.disabled &&
          height == other.height;

  @override
  int get hashCode => enabled.hashCode ^ disabled.hashCode ^ height.hashCode;
}
