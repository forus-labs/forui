part of 'header.dart';

/// Represents a [FHeader]'s action.
class FHeaderAction extends StatelessWidget {
  /// The icon;
  final SvgAsset icon;

  /// The callback.
  ///
  /// If null, the action is disabled.
  final VoidCallback? onPress;

  /// The style.
  final FHeaderActionStyle? style;

  /// Creates a [FHeaderAction].
  const FHeaderAction({required this.icon, required this.onPress, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.headerStyle.action;

    return Padding(
      padding: style.padding,
      child: MouseRegion(
        cursor: onPress == null ? MouseCursor.defer : SystemMouseCursors.click,
        child: FTappable(
          onTap: onPress,
          child: icon(
            height: style.iconSize,
            colorFilter: ColorFilter.mode(onPress == null ? style.disabledIcon : style.enabledIcon, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// [FHeaderAction]'s style.
class FHeaderActionStyle with Diagnosticable {
  /// The icon's size. Defaults to 30.
  final double iconSize;

  /// The icon's color when this button is enabled. Defaults to [FColorScheme.foreground].
  final Color enabledIcon;

  /// The icon's color when this button is disabled. Defaults to a slightly translucent [FColorScheme.foreground].
  final Color disabledIcon;

  /// The padding. Defaults to `EdgeInsets.only(left: 10)`.
  final EdgeInsets padding;

  /// Creates a [FHeaderActionStyle].
  FHeaderActionStyle({
    required this.iconSize,
    required this.enabledIcon,
    required this.disabledIcon,
    required this.padding,
  });

  /// Creates a [FHeaderActionStyle] that inherits its properties from the given [FColorScheme].
  FHeaderActionStyle.inherit({required FColorScheme colorScheme})
      : iconSize = 30,
        padding = const EdgeInsets.only(left: 10),
        enabledIcon = colorScheme.foreground,
        disabledIcon = colorScheme.foreground.withOpacity(0.5);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('iconSize', iconSize, defaultValue: 30))
      ..add(ColorProperty('enabledIcon', enabledIcon))
      ..add(ColorProperty('disabledIcon', disabledIcon))
      ..add(DiagnosticsProperty('padding', padding, defaultValue: const EdgeInsets.only(left: 10)));
  }
}
