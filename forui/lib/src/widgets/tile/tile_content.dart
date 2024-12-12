import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_group.dart';
import 'package:forui/src/widgets/tile/tile_render_object.dart';
import 'package:meta/meta.dart';

@internal
class FTileContent extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;

  const FTileContent({
    required this.title,
    required this.prefixIcon,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ltr = Directionality.maybeOf(context) == TextDirection.ltr;

    final tile = FTileData.maybeOf(context)!;
    final FTileData(style: tileStyle, :enabled, :hovered, :focused, :index, :last) = tile;

    final group = extractTileGroup(FTileGroupData.maybeOf(context));

    final FTileStyle(:contentStyle, :dividerStyle, :focusedDividerStyle) = tileStyle;
    final style = switch ((enabled, hovered)) {
      (true, true) => contentStyle.enabledHoveredStyle,
      (true, false) => contentStyle.enabledStyle,
      (false, _) => contentStyle.disabledStyle,
    };
    final divider = switch ((focused, last)) {
      (true, false) => FTileDivider.full,
      (true, true) when group.index != group.length - 1 => FTileDivider.full,
      (false, false) => tile.divider,
      (false, true) when group.index != group.length - 1 => group.divider,
      _ => FTileDivider.none,
    };

    return TileRenderObject(
      style: contentStyle,
      divider: divider,
      children: [
        if (prefixIcon case final prefixIcon?)
          Padding(
            padding: ltr
                ? EdgeInsets.only(right: contentStyle.prefixIconSpacing)
                : EdgeInsets.only(left: contentStyle.prefixIconSpacing),
            child: FIconStyleData(
              style: style.prefixIconStyle,
              child: prefixIcon,
            ),
          )
        else
          const SizedBox(),
        Padding(
          padding: ltr
              ? EdgeInsets.only(right: contentStyle.middleSpacing)
              : EdgeInsets.only(left: contentStyle.middleSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: style.titleTextStyle,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                overflow: TextOverflow.ellipsis,
                child: title,
              ),
              if (subtitle case final subtitle?)
                Padding(
                  padding: EdgeInsets.only(top: contentStyle.titleSpacing),
                  child: DefaultTextStyle.merge(
                    style: style.subtitleTextStyle,
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    overflow: TextOverflow.ellipsis,
                    child: subtitle,
                  ),
                ),
            ],
          ),
        ),
        if (details case final details?)
          DefaultTextStyle.merge(
            style: style.detailsTextStyle,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
            overflow: TextOverflow.ellipsis,
            child: details,
          )
        else
          const SizedBox(),
        if (suffixIcon case final suffixIcon?)
          Padding(
            padding: ltr
                ? EdgeInsets.only(left: contentStyle.suffixIconSpacing)
                : EdgeInsets.only(right: contentStyle.suffixIconSpacing),
            child: FIconStyleData(
              style: style.suffixIconStyle,
              child: suffixIcon,
            ),
          )
        else
          const SizedBox(),
        switch ((focused, divider)) {
          (_, FTileDivider.none) => const SizedBox(),
          (true, _) => FDivider(style: focusedDividerStyle),
          (false, _) => FDivider(style: dividerStyle),
        },
      ],
    );
  }
}

/// A [FTile] content's style.
final class FTileContentStyle with Diagnosticable {
  /// The content's padding. Defaults to `EdgeInsets.only(left: 15, top: 13, right: 10, bottom: 13)`.
  final EdgeInsets padding;

  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  final double prefixIconSpacing;

  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [titleSpacing] is negative.
  final double titleSpacing;

  /// The minimum horizontal spacing between the title, subtitle, combined, and the details. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [middleSpacing] is negative.
  final double middleSpacing;

  /// The horizontal spacing between the details and suffix icon. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [suffixIconSpacing] is negative.
  final double suffixIconSpacing;

  /// The content's enabled style.
  final FTileContentStateStyle enabledStyle;

  /// The content's enabled hovered style.
  final FTileContentStateStyle enabledHoveredStyle;

  /// The content's disabled style.
  final FTileContentStateStyle disabledStyle;

  /// Creates a [FTileContentStyle].
  FTileContentStyle({
    required this.enabledStyle,
    required this.enabledHoveredStyle,
    required this.disabledStyle,
    this.padding = const EdgeInsets.only(left: 15, top: 13, right: 10, bottom: 13),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 3,
    this.middleSpacing = 4,
    this.suffixIconSpacing = 5,
  })  : assert(0 <= prefixIconSpacing, 'prefixIconSpacing must be non-negative.'),
        assert(0 <= titleSpacing, 'titleSpacing must be non-negative.'),
        assert(0 <= middleSpacing, 'middleSpacing must be non-negative.'),
        assert(0 <= suffixIconSpacing, 'suffixIconSpacing must be non-negative.');

  /// Creates a [FTileContentStyle] that inherits from the given [colorScheme] and [typography].
  FTileContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          enabledStyle: FTileContentStateStyle(
            prefixIconStyle: FIconStyle(color: colorScheme.primary, size: 18),
            titleTextStyle: typography.base,
            subtitleTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
            detailsTextStyle: typography.base.copyWith(color: colorScheme.mutedForeground),
            suffixIconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
          ),
          enabledHoveredStyle: FTileContentStateStyle(
            prefixIconStyle: FIconStyle(color: colorScheme.primary, size: 18),
            titleTextStyle: typography.base,
            subtitleTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
            detailsTextStyle: typography.base.copyWith(color: colorScheme.mutedForeground),
            suffixIconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
          ),
          disabledStyle: FTileContentStateStyle(
            prefixIconStyle: FIconStyle(color: colorScheme.disable(colorScheme.primary), size: 18),
            titleTextStyle: typography.base.copyWith(color: colorScheme.disable(colorScheme.primary)),
            subtitleTextStyle: typography.xs.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
            detailsTextStyle: typography.base.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
            suffixIconStyle: FIconStyle(color: colorScheme.disable(colorScheme.mutedForeground), size: 18),
          ),
        );

  /// Returns a copy of this [FTileContentStyle] with the given fields replaced with the new values.
  @useResult
  FTileContentStyle copyWith({
    EdgeInsets? padding,
    double? prefixIconSpacing,
    double? titleSpacing,
    double? suffixIconSpacing,
    FTileContentStateStyle? enabledStyle,
    FTileContentStateStyle? enabledHoveredStyle,
    FTileContentStateStyle? disabledStyle,
  }) =>
      FTileContentStyle(
        padding: padding ?? this.padding,
        prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
        titleSpacing: titleSpacing ?? this.titleSpacing,
        suffixIconSpacing: suffixIconSpacing ?? this.suffixIconSpacing,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        enabledHoveredStyle: enabledHoveredStyle ?? this.enabledHoveredStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing))
      ..add(DoubleProperty('titleSpacing', titleSpacing))
      ..add(DoubleProperty('middleSpacing', middleSpacing))
      ..add(DoubleProperty('suffixIconSpacing', suffixIconSpacing))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('enabledHoveredStyle', enabledHoveredStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTileContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          prefixIconSpacing == other.prefixIconSpacing &&
          titleSpacing == other.titleSpacing &&
          middleSpacing == other.middleSpacing &&
          suffixIconSpacing == other.suffixIconSpacing &&
          enabledStyle == other.enabledStyle &&
          enabledHoveredStyle == other.enabledHoveredStyle &&
          disabledStyle == other.disabledStyle;

  @override
  int get hashCode =>
      padding.hashCode ^
      prefixIconSpacing.hashCode ^
      titleSpacing.hashCode ^
      middleSpacing.hashCode ^
      suffixIconSpacing.hashCode ^
      enabledStyle.hashCode ^
      enabledHoveredStyle.hashCode ^
      disabledStyle.hashCode;
}

/// A [FTile] content's state style.
final class FTileContentStateStyle with Diagnosticable {
  /// The prefix icon's style.
  final FIconStyle prefixIconStyle;

  /// The title's text style.
  final TextStyle titleTextStyle;

  /// The subtitle's text style.
  final TextStyle subtitleTextStyle;

  /// The detail's text style.
  final TextStyle detailsTextStyle;

  /// The suffix icon's style.
  final FIconStyle suffixIconStyle;

  /// Creates a [FTileContentStateStyle].
  const FTileContentStateStyle({
    required this.prefixIconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.detailsTextStyle,
    required this.suffixIconStyle,
  });

  /// Returns a [FTileContentStateStyle] with the given properties replaced.
  @useResult
  FTileContentStateStyle copyWith({
    FIconStyle? prefixIconStyle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    TextStyle? detailsTextStyle,
    FIconStyle? suffixIconStyle,
  }) =>
      FTileContentStateStyle(
        prefixIconStyle: prefixIconStyle ?? this.prefixIconStyle,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        detailsTextStyle: detailsTextStyle ?? this.detailsTextStyle,
        suffixIconStyle: suffixIconStyle ?? this.suffixIconStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle))
      ..add(DiagnosticsProperty('detailsTextStyle', detailsTextStyle))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTileContentStateStyle &&
          runtimeType == other.runtimeType &&
          prefixIconStyle == other.prefixIconStyle &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle &&
          detailsTextStyle == other.detailsTextStyle &&
          suffixIconStyle == other.suffixIconStyle;

  @override
  int get hashCode =>
      prefixIconStyle.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode ^
      detailsTextStyle.hashCode ^
      suffixIconStyle.hashCode;
}
