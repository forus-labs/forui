part of 'header.dart';

/// A [FHeader] action.
///
/// If the [onPress] and [onLongPress] callbacks are null, then this action will be disabled, it will not react to touch.
class FHeaderAction extends StatelessWidget {
  /// The style.
  final FHeaderActionStyle? style;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// The icon, wrapped in a [IconThemeData].
  final Widget icon;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onPress}
  final VoidCallback? onPress;

  /// {@macro forui.foundation.FTappable.onLongPress}
  final VoidCallback? onLongPress;

  /// Creates a [FHeaderAction] from the given SVG [icon].
  const FHeaderAction({
    required this.icon,
    required this.onPress,
    this.style,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onLongPress,
    super.key,
  });

  /// Creates a [FHeaderAction] with `FIcons.arrowLeft`.
  factory FHeaderAction.back({
    required VoidCallback? onPress,
    FHeaderActionStyle? style,
    String? semanticsLabel,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    VoidCallback? onLongPress,
    Key? key,
  }) => FHeaderAction(
    icon: const Icon(FIcons.arrowLeft),
    onPress: onPress,
    style: style,
    semanticsLabel: semanticsLabel,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    onLongPress: onLongPress,
    key: key,
  );

  /// Creates a [FHeaderAction] with `FIcons.x`.
  factory FHeaderAction.x({
    required VoidCallback? onPress,
    FHeaderActionStyle? style,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    VoidCallback? onLongPress,
    Key? key,
  }) => FHeaderAction(
    icon: const Icon(FIcons.x),
    onPress: onPress,
    style: style,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    onLongPress: onLongPress,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FHeaderData.of(context).actionStyle;
    final enabled = onPress != null || onLongPress != null;

    return FTappable(
      style: style.tappableStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      focusedOutlineStyle: style.focusedOutlineStyle,
      semanticsLabel: semanticsLabel,
      onPress: onPress,
      onLongPress: onLongPress,
      child: IconTheme(data: enabled ? style.enabledStyle : style.disabledStyle, child: icon),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

/// [FHeaderAction]'s style.
final class FHeaderActionStyle with Diagnosticable, _$FHeaderActionStyleFunctions {
  /// The icon's style when an action is enabled.
  @override
  final IconThemeData enabledStyle;

  /// The icon's style when an action is disabled.
  @override
  final IconThemeData disabledStyle;

  /// The outline style when this action is focused.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FHeaderActionStyle].
  FHeaderActionStyle({
    required this.enabledStyle,
    required this.disabledStyle,
    required this.focusedOutlineStyle,
    required this.tappableStyle,
  });

  /// Creates a [FHeaderActionStyle] that inherits its properties from the given [FColorScheme].
  FHeaderActionStyle.inherit({required FColorScheme color, required FStyle style, required double size})
    : enabledStyle = IconThemeData(color: color.foreground, size: size),
      disabledStyle = IconThemeData(color: color.disable(color.foreground), size: size),
      focusedOutlineStyle = style.focusedOutlineStyle,
      tappableStyle = style.tappableStyle;
}
