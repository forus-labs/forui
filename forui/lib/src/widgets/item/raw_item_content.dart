import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/render_item_content.dart';

part 'raw_item_content.design.dart';

@internal
class RawItemContent extends StatelessWidget {
  final FRawItemContentStyle style;
  final EdgeInsetsGeometry margin;

  final double top;
  final double bottom;
  final Set<WidgetState> states;
  final FWidgetStateMap<Color>? dividerColor;
  final double? dividerWidth;
  final FItemDivider dividerType;
  final Widget? prefix;
  final Widget child;

  const RawItemContent({
    required this.style,
    required this.margin,
    required this.bottom,
    required this.top,
    required this.states,
    required this.dividerColor,
    required this.dividerWidth,
    required this.dividerType,
    required this.prefix,
    required this.child,
    super.key,
  }) : assert(
         (dividerColor != null && dividerWidth != null) || dividerType == FItemDivider.none,
         'dividerColor and dividerWidth must be provided if dividerType is not FItemDivider.none. This is a bug unless '
         "you're creating your own custom item container.",
       );

  @override
  Widget build(BuildContext context) => ItemContentLayout(
    margin: margin,
    padding: style.padding,
    top: top,
    bottom: bottom,
    dividerColor: dividerColor?.resolve(states),
    dividerWidth: dividerWidth,
    dividerType: dividerType,
    children: [
      if (prefix case final prefix?)
        Padding(
          padding: EdgeInsetsDirectional.only(end: style.prefixIconSpacing),
          child: IconTheme(data: style.prefixIconStyle.resolve(states), child: prefix),
        )
      else
        const SizedBox(),
      DefaultTextStyle.merge(
        style: style.childTextStyle.resolve(states),
        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
        overflow: TextOverflow.ellipsis,
        child: child,
      ),
      const SizedBox(),
      const SizedBox(),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(IterableProperty('states', states))
      ..add(DoubleProperty('top', top))
      ..add(DoubleProperty('bottom', bottom))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('dividerType', dividerType));
  }
}

/// An [FItem] raw content's style.
class FRawItemContentStyle with Diagnosticable, _$FRawItemContentStyleFunctions {
  /// The content's padding. Defaults to `EdgeInsetsDirectional.only(15, 13, 10, 13)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The prefix icon style.
  @override
  final FWidgetStateMap<IconThemeData> prefixIconStyle;

  /// The horizontal spacing between the prefix icon and child. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override
  final double prefixIconSpacing;

  /// The child's text style.
  @override
  final FWidgetStateMap<TextStyle> childTextStyle;

  /// Creates a [FRawItemContentStyle].
  FRawItemContentStyle({
    required this.prefixIconStyle,
    required this.childTextStyle,
    this.padding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
    this.prefixIconSpacing = 10,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing ($prefixIconSpacing) must be >= 0');

  /// Creates a [FRawItemContentStyle] that inherits its properties.
  FRawItemContentStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        prefixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
          WidgetState.any: IconThemeData(color: colors.primary, size: 15),
        }),
        childTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.sm,
        }),
      );
}
