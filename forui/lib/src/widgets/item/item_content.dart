import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/render_item_content.dart';

part 'item_content.design.dart';

@internal
class ItemContent extends StatelessWidget {
  final FItemContentStyle style;
  final EdgeInsetsGeometry margin;
  final double top;
  final double bottom;
  final Set<WidgetState> states;
  final FWidgetStateMap<Color>? dividerColor;
  final double? dividerWidth;
  final FItemDivider dividerType;
  final Widget? prefix;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffix;

  const ItemContent({
    required this.style,
    required this.margin,
    required this.bottom,
    required this.top,
    required this.states,
    required this.dividerColor,
    required this.dividerWidth,
    required this.dividerType,
    required this.title,
    required this.prefix,
    required this.subtitle,
    required this.details,
    required this.suffix,
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
      Padding(
        padding: EdgeInsetsDirectional.only(end: style.middleSpacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: style.titleSpacing,
          children: [
            DefaultTextStyle.merge(
              style: style.titleTextStyle.resolve(states),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              overflow: TextOverflow.ellipsis,
              child: title,
            ),
            if (subtitle case final subtitle?)
              DefaultTextStyle.merge(
                style: style.subtitleTextStyle.resolve(states),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                overflow: TextOverflow.ellipsis,
                child: subtitle,
              ),
          ],
        ),
      ),
      if (details case final details?)
        DefaultTextStyle.merge(
          style: style.detailsTextStyle.resolve(states),
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          overflow: TextOverflow.ellipsis,
          child: details,
        )
      else
        const SizedBox(),
      if (suffix case final suffixIcon?)
        Padding(
          padding: EdgeInsetsDirectional.only(start: style.suffixIconSpacing),
          child: IconTheme(data: style.suffixIconStyle.resolve(states), child: suffixIcon),
        )
      else
        const SizedBox(),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DoubleProperty('top', top))
      ..add(DoubleProperty('bottom', bottom))
      ..add(IterableProperty('states', states))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('dividerType', dividerType));
  }
}

/// An [FItem] content's style.
class FItemContentStyle with Diagnosticable, _$FItemContentStyleFunctions {
  /// The content's padding. Defaults to `const EdgeInsetsDirectional.only(start: 11, top: 7.5, bottom: 7.5, end: 6)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The prefix icon style.
  @override
  final FWidgetStateMap<IconThemeData> prefixIconStyle;

  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override
  final double prefixIconSpacing;

  /// The title's text style.
  @override
  final FWidgetStateMap<TextStyle> titleTextStyle;

  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [titleSpacing] is negative.
  @override
  final double titleSpacing;

  /// The subtitle's text style.
  @override
  final FWidgetStateMap<TextStyle> subtitleTextStyle;

  /// The minimum horizontal spacing between the title, subtitle, combined, and the details. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [middleSpacing] is negative.
  @override
  final double middleSpacing;

  /// The details text style.
  @override
  final FWidgetStateMap<TextStyle> detailsTextStyle;

  /// The suffix icon style.
  @override
  final FWidgetStateMap<IconThemeData> suffixIconStyle;

  /// The horizontal spacing between the details and suffix icon. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [suffixIconSpacing] is negative.
  @override
  final double suffixIconSpacing;

  /// Creates a [FItemContentStyle].
  FItemContentStyle({
    required this.prefixIconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.detailsTextStyle,
    required this.suffixIconStyle,
    this.padding = const EdgeInsetsDirectional.only(start: 11, top: 7.5, bottom: 7.5, end: 6),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 3,
    this.middleSpacing = 4,
    this.suffixIconSpacing = 5,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing ($prefixIconSpacing) must be >= 0'),
       assert(0 <= titleSpacing, 'titleSpacing ($titleSpacing) must be >= 0'),
       assert(0 <= middleSpacing, 'middleSpacing ($middleSpacing) must be >= 0'),
       assert(0 <= suffixIconSpacing, 'suffixIconSpacing ($suffixIconSpacing) must be >= 0');

  /// Creates a [FItemContentStyle] that inherits its properties.
  FItemContentStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        prefixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
          WidgetState.any: IconThemeData(color: colors.primary, size: 15),
        }),
        titleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.sm,
        }),
        subtitleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
        }),
        detailsTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
        }),
        suffixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 15),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 15),
        }),
      );
}
