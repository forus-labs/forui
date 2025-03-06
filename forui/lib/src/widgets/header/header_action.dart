part of 'header.dart';

/// A [FHeader] action.
///
/// If the [onPress] and [onLongPress] callbacks are null, then this action will be disabled, it will not react to touch.
class FHeaderAction extends StatelessWidget {
  /// The style.
  final FHeaderActionStyle? style;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticLabel;

  /// The icon.
  ///
  /// [icon] is wrapped in [FIconStyle], and therefore works with [FIcon]s.
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
  }) => FHeaderAction(
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
  }) => FHeaderAction(
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

    return FTappable.animated(
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      focusedOutlineStyle: style.focusedOutlineStyle,
      semanticLabel: semanticLabel,
      onPress: onPress,
      onLongPress: onLongPress,
      builder:
          (_, states, _) =>
              FIconStyleData(style: FIconStyle(color: style.color.resolve(states), size: style.size), child: icon),
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
final class FHeaderActionStyle with Diagnosticable, _$FHeaderActionStyleFunctions {
  /// The icon's color.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  @override
  final FWidgetStateMap<Color> color;

  /// The icon's size.
  ///
  /// Defaults to:
  /// * 30 for [FHeader].
  /// * 25 for [FHeader.nested]
  @override
  final double size;

  /// The outline style when this action is focused.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FHeaderActionStyle].
  FHeaderActionStyle({required this.color, required this.size, required this.focusedOutlineStyle});

  /// Creates a [FHeaderActionStyle] that inherits its properties from the given [FColorScheme].
  FHeaderActionStyle.inherit({required FColorScheme colorScheme, required FStyle style, required this.size})
    : color = FWidgetStateMap({
        WidgetState.disabled: colorScheme.disable(colorScheme.foreground),
        ~WidgetState.disabled: colorScheme.foreground,
      }),
      focusedOutlineStyle = style.focusedOutlineStyle;
}
