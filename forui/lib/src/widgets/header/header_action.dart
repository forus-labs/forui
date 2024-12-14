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

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Defaults to false.
  ///
  /// Ideally, there is only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  ///
  /// If one is not supplied, then one will be automatically allocated, owned, and managed by this widget. The widget
  /// will be focusable even if a [focusNode] is not supplied. If supplied, the given `focusNode` will be hosted by this
  /// widget, but not owned. See [FocusNode] for more information on what being hosted and/or owned implies.
  ///
  /// Supplying a focus node is sometimes useful if an ancestor to this widget wants to control when this widget has the
  /// focus. The owner will be responsible for calling [FocusNode.dispose] on the focus node when it is done with it,
  /// but this widget will attach/detach and reparent the node when needed.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

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
    this.style,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onLongPress,
    super.key,
  });

  /// Creates a [FHeaderAction] with `FAssets.icons.arrowLeft`.
  factory FHeaderAction.back({
    required VoidCallback? onPress,
    FHeaderActionStyle? style,
    String? semanticLabel,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) =>
      FHeaderAction(
        icon: FIcon(FAssets.icons.arrowLeft),
        onPress: onPress,
        style: style,
        semanticLabel: semanticLabel,
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        key: key,
      );

  /// Creates a [FHeaderAction] with `FAssets.icons.x`.
  factory FHeaderAction.x({
    required VoidCallback? onPress,
    FHeaderActionStyle? style,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    Key? key,
  }) =>
      FHeaderAction(
        icon: FIcon(FAssets.icons.x),
        onPress: onPress,
        style: style,
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FHeaderData.of(context).actionStyle;
    final enabled = onPress != null || onLongPress != null;

    return FTappable.animated(
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      focusedOutlineStyle: style.focusedOutlineStyle,
      semanticLabel: semanticLabel,
      onPress: onPress,
      onLongPress: onLongPress,
      child: FIconStyleData(
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
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
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

  /// The outline style when this action is focused.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FHeaderActionStyle].
  FHeaderActionStyle({
    required this.enabledColor,
    required this.disabledColor,
    required this.size,
    required this.focusedOutlineStyle,
  });

  /// Creates a [FHeaderActionStyle] that inherits its properties from the given [FColorScheme].
  FHeaderActionStyle.inherit({required FColorScheme colorScheme, required FStyle style, required this.size})
      : enabledColor = colorScheme.foreground,
        disabledColor = colorScheme.disable(colorScheme.foreground),
        focusedOutlineStyle = style.focusedOutlineStyle;

  /// Returns a copy of this [FHeaderActionStyle] with the given properties replaced.
  @useResult
  FHeaderActionStyle copyWith({
    Color? enabledColor,
    Color? disabledColor,
    double? size,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) =>
      FHeaderActionStyle(
        enabledColor: enabledColor ?? this.enabledColor,
        disabledColor: disabledColor ?? this.disabledColor,
        size: size ?? this.size,
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('enabledColor', enabledColor))
      ..add(ColorProperty('disabledColor', disabledColor))
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FHeaderActionStyle &&
          runtimeType == other.runtimeType &&
          enabledColor == other.enabledColor &&
          disabledColor == other.disabledColor &&
          size == other.size &&
          focusedOutlineStyle == other.focusedOutlineStyle;

  @override
  int get hashCode => enabledColor.hashCode ^ disabledColor.hashCode ^ size.hashCode ^ focusedOutlineStyle.hashCode;
}
