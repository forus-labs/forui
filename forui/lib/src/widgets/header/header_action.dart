part of 'header.dart';

/// A [FHeader] action.
///
/// If the [onPress] and [onLongPress] callbacks are null, then this action will be disabled, it will not react to touch.
class FHeaderAction extends StatelessWidget {
  /// The style.
  final FHeaderActionStyle? style;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// The icon.
  ///
  /// [icon] is wrapped in [FIconStyle], and therefore works with [FIcon]s.
  final Widget icon;

  /// A callback for when the button is pressed.
  ///
  /// The action will be disabled if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the button is long pressed.
  ///
  /// The action will be disabled if both [onPress] and [onLongPress] are null.
  final VoidCallback? onLongPress;

  /// Creates a [FHeaderAction] from the given SVG [icon].
  const FHeaderAction({
    required this.icon,
    required this.onPress,
    this.onLongPress,
    this.style,
    this.semanticLabel,
    super.key,
  });

  /// Creates a [FHeaderAction] with [FAssets.icons.arrowLeft].
  factory FHeaderAction.back({
    required VoidCallback? onPress,
    FHeaderActionStyle? style,
    String? semanticLabel,
    Key? key,
  }) =>
      FHeaderAction(
        icon: FIcon(FAssets.icons.arrowLeft),
        onPress: onPress,
        style: style,
        semanticLabel: semanticLabel,
        key: key,
      );

  /// Creates a [FHeaderAction] with [FAssets.icons.x].
  factory FHeaderAction.x({
    required VoidCallback? onPress,
    FHeaderActionStyle? style,
    Key? key,
  }) =>
      FHeaderAction(
        icon: FIcon(FAssets.icons.x),
        onPress: onPress,
        style: style,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FHeaderData.of(context).actionStyle;
    final enabled = onPress != null || onLongPress != null;

    return FTappable.animated(
      semanticLabel: semanticLabel,
      onPress: onPress,
      onLongPress: onLongPress,
      child: FInheritedIconStyle(
        style: FIconStyle(
          color: enabled ? style.enabledColor : style.disabledColor,
          size: style.size,
        ),
        child: icon,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

/// [FHeaderAction]'s style.
final class FHeaderActionStyle with Diagnosticable {
  /// The icon's color when this action is enabled.
  final Color enabledColor;

  /// The icon's color when this action is disabled.
  final Color disabledColor;

  /// The icon's size.
  ///
  /// Defaults to:
  /// * 30 for [FHeader].
  /// * 25 for [FHeader.nested]
  final double size;

  /// Creates a [FHeaderActionStyle].
  FHeaderActionStyle({
    required this.enabledColor,
    required this.disabledColor,
    required this.size,
  });

  /// Creates a [FHeaderActionStyle] that inherits its properties from the given [FStateColorScheme].
  FHeaderActionStyle.inherit({required FStateColorScheme colorScheme, required this.size})
      : enabledColor = colorScheme.foreground,
        disabledColor = colorScheme.foreground.withOpacity(0.5);

  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  @useResult
  FHeaderActionStyle copyWith({
    Color? enabledColor,
    Color? disabledColor,
    double? size,
    EdgeInsets? padding,
  }) =>
      FHeaderActionStyle(
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
      ..add(DoubleProperty('size', size));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FHeaderActionStyle &&
          runtimeType == other.runtimeType &&
          enabledColor == other.enabledColor &&
          disabledColor == other.disabledColor &&
          size == other.size;

  @override
  int get hashCode => enabledColor.hashCode ^ disabledColor.hashCode ^ size.hashCode;
}
