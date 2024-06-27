part of 'nested_header.dart';

/// A [FNestedHeader] action.
///
/// If the [onPress] and [onLongPress] callbacks are null, then this action will be disabled, it will not react to touch.
class FNestedHeaderAction extends StatelessWidget {
  /// The style.
  final FNestedHeaderActionStyle? style;

  /// The icon.
  final SvgAsset icon;

  /// A callback for when the button is pressed.
  ///
  /// The action will be disabled if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the button is long pressed.
  ///
  /// The action will be disabled if both [onPress] and [onLongPress] are null.
  final VoidCallback? onLongPress;

  /// Creates a [FNestedHeaderAction] from the given SVG [icon].
  const FNestedHeaderAction({
    required this.icon,
    required this.onPress,
    this.onLongPress,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.nestedHeaderStyle.actionStyle;
    final enabled = onPress != null || onLongPress != null;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
      child: FTappable(
        onTap: onPress,
        onLongPress: onLongPress,
        child: icon(
          height: style.size,
          colorFilter: ColorFilter.mode(onPress == null ? style.disabledColor : style.enabledColor, BlendMode.srcIn),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

/// [FNestedHeaderAction]'s style.
class FNestedHeaderActionStyle with Diagnosticable {
  /// The icon's color when this action is enabled.
  final Color enabledColor;

  /// The icon's color when this action is disabled.
  final Color disabledColor;

  /// The icon's size. Defaults to 20.
  final double size;

  /// Creates a [FNestedHeaderActionStyle].
  FNestedHeaderActionStyle({
    required this.enabledColor,
    required this.disabledColor,
    this.size = 25,
  });

  /// Creates a [FNestedHeaderActionStyle] that inherits its properties from the given [FColorScheme].
  FNestedHeaderActionStyle.inherit({required FColorScheme colorScheme})
      : enabledColor = colorScheme.foreground,
        disabledColor = colorScheme.foreground.withOpacity(0.5),
        size = 25;

  /// Returns a copy of this [FNestedHeaderActionStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FNestedHeaderActionStyle(
  ///   enabledColor: Colors.black,
  ///   disabledColor: Colors.white,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   disabledColor: Colors.blue,
  /// );
  ///
  /// print(copy.enabledColor); // black
  /// print(copy.disabledColor); // blue
  /// ```
  @useResult
  FNestedHeaderActionStyle copyWith({
    Color? enabledColor,
    Color? disabledColor,
    double? size,
    EdgeInsets? padding,
  }) =>
      FNestedHeaderActionStyle(
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
      ..add(DoubleProperty('size', size, defaultValue: 30));
  }
}
