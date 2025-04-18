import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_group.dart';
import 'package:forui/src/widgets/tile/tile_render_object.dart';

part 'tile_content.style.dart';

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
    final FTileData(style: tileStyle, :states) = tile;

    final group = extractTileGroup(FTileGroupData.maybeOf(context));

    final FTileStyle(:contentStyle, :dividerStyle) = tileStyle;
    final (dividerType) = switch (tile.last) {
      false => tile.divider,
      true when group.index == group.length - 1 => FTileDivider.none,
      true => group.divider,
    };

    return TileRenderObject(
      style: contentStyle,
      divider: dividerType,
      first: tile.index == 0 && group.index == 0,
      last: tile.last && group.index == group.length - 1,
      // We use the left side of the border to draw the focused outline.
      side: states.contains(WidgetState.focused) ? tileStyle.border.resolve(states).left : null,
      children: [
        if (prefixIcon case final prefix?)
          Padding(
            padding:
                ltr
                    ? EdgeInsets.only(right: contentStyle.prefixIconSpacing)
                    : EdgeInsets.only(left: contentStyle.prefixIconSpacing),
            child: IconTheme(data: contentStyle.prefixIconStyle.resolve(states), child: prefix),
          )
        else
          const SizedBox(),
        Padding(
          padding:
              ltr
                  ? EdgeInsets.only(right: contentStyle.middleSpacing)
                  : EdgeInsets.only(left: contentStyle.middleSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: contentStyle.titleTextStyle.resolve(states),
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
                    style: contentStyle.subtitleTextStyle.resolve(states),
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
            style: contentStyle.detailsTextStyle.resolve(states),
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
            padding:
                ltr
                    ? EdgeInsets.only(left: contentStyle.suffixIconSpacing)
                    : EdgeInsets.only(right: contentStyle.suffixIconSpacing),
            child: IconTheme(data: contentStyle.suffixIconStyle.resolve(states), child: suffixIcon),
          )
        else
          const SizedBox(),
        if (dividerType != FTileDivider.none) FDivider(style: dividerStyle.resolve(states)) else const SizedBox(),
      ],
    );
  }
}

/// A [FTile] content's style.
final class FTileContentStyle with Diagnosticable, _$FTileContentStyleFunctions {
  /// The content's padding. Defaults to `EdgeInsetsDirectional.only(15, 13, 10, 13)`.
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

  /// Creates a [FTileContentStyle].
  FTileContentStyle({
    required this.prefixIconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.detailsTextStyle,
    required this.suffixIconStyle,
    this.padding = const EdgeInsetsDirectional.fromSTEB(15, 13, 10, 13),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 3,
    this.middleSpacing = 4,
    this.suffixIconSpacing = 5,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing must be non-negative.'),
       assert(0 <= titleSpacing, 'titleSpacing must be non-negative.'),
       assert(0 <= middleSpacing, 'middleSpacing must be non-negative.'),
       assert(0 <= suffixIconSpacing, 'suffixIconSpacing must be non-negative.');

  /// Creates a [FTileContentStyle] that inherits its properties.
  FTileContentStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        prefixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 18),
          WidgetState.any: IconThemeData(color: colors.primary, size: 18),
        }),
        titleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.base,
        }),
        subtitleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
        }),
        detailsTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.base.copyWith(color: colors.mutedForeground),
        }),
        suffixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 18),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 18),
        }),
      );
}
