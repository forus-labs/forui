import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'tag.style.dart';

/// A tag in a [FMultiSelect].
class FMultiSelectTag extends StatelessWidget {
  /// The style.
  final FMultiSelectTagStyle Function(FMultiSelectTagStyle)? style;

  /// The label.
  final Widget label;

  /// The callback when the tag is pressed.
  final VoidCallback? onPress;

  // TODO: Add more fields

  /// Creates a [FMultiSelectTag].
  const FMultiSelectTag({required this.label, this.onPress, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.multiSelectStyle.tagStyle) ?? context.theme.multiSelectStyle.tagStyle;
    return FTappable(
      style: style.tappableStyle,
      onPress: onPress,
      builder: (context, states, child) => DecoratedBox(
        decoration: style.decoration.resolve(states),
        child: Padding(
          padding: style.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: style.spacing,
            children: [
              DefaultTextStyle(style: style.labelTextStyle.resolve(states), child: label),
              IconTheme(data: style.iconStyle.resolve(states), child: const Icon(FIcons.x)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('style', style))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

/// A [FMultiSelectTag]'s style.
class FMultiSelectTagStyle with Diagnosticable, _$FMultiSelectTagStyleFunctions {
  /// The decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<Decoration> decoration;

  /// The padding. Defaults to `EdgeInsets.symmetric(vertical: 4, horizontal: 8)`.
  ///
  /// The vertical padding should typically be the same as the [FMultiSelectFieldStyle.hintPadding].
  @override
  final EdgeInsets padding;

  /// The spacing between the label and the icon. Defaults to 4.
  @override
  final double spacing;

  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<TextStyle> labelTextStyle;

  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FMultiSelectTagStyle].
  FMultiSelectTagStyle({
    required this.decoration,
    required this.labelTextStyle,
    required this.iconStyle,
    required this.tappableStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    this.spacing = 4,
  });

  /// Creates a [FMultiSelectTagStyle] that inherits its properties.
  FMultiSelectTagStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: FWidgetStateMap({
          WidgetState.disabled: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colors.disable(colors.secondary),
          ),
          WidgetState.hovered | WidgetState.pressed: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colors.hover(colors.secondary),
          ),
          WidgetState.any: BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
        }),
        labelTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.secondaryForeground)),
          WidgetState.any: typography.sm.copyWith(color: colors.secondaryForeground),
        }),
        iconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 15),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 15),
        }),
        tappableStyle: style.tappableStyle.copyWith(bounceTween: FTappableStyle.noBounceTween),
      );
}
