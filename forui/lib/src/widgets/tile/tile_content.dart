import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:meta/meta.dart';

@internal
class FTileContent extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;
  final String? semanticLabel;
  final bool enabled;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;

  const FTileContent({
    required this.title,
    required this.prefixIcon,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
    required this.semanticLabel,
    required this.enabled,
    required this.onPress,
    required this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FTileData(:style, :index, :length, :divider) = FTileData.maybeOf(context)!;
    final contentStyle = style.contentStyle;
    Widget content(FTileContentStateStyle style, BoxDecoration decoration) => switch (divider) {
          FTileDivider.full || FTileDivider.none => _Content(
              style: style,
              decoration: decoration,
              prefixIcon: prefixIcon,
              title: title,
              subtitle: subtitle,
              details: details,
              suffixIcon: suffixIcon,
            ),
          FTileDivider.title => _TitleAlignedContent(
              style: style,
              prefixIcon: prefixIcon,
              title: title,
              subtitle: subtitle,
              details: details,
              suffixIcon: suffixIcon,
            ),
        };

    if (enabled && onPress != null || onLongPress != null) {
      return FTappable(
        behavior: HitTestBehavior.translucent,
        semanticLabel: semanticLabel,
        onPress: onPress,
        onLongPress: onLongPress,
        shortPressDelay: Duration.zero,
        builder: (_, state, __) => switch (state.hovered || state.shortPressed) {
          true => content(contentStyle.enabledHoveredStyle, style.enabledHoverDecoration),
          false => content(contentStyle.enabledStyle, style.enabledDecoration),
        },
      );
    } else {
      return Semantics(
        container: true,
        label: semanticLabel,
        child: switch (enabled) {
          true => content(contentStyle.enabledStyle, style.enabledDecoration),
          false => content(contentStyle.disabledStyle, style.disabledDecoration),
        },
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

class _Content extends StatelessWidget {
  final FTileContentStateStyle style;
  final BoxDecoration decoration;
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;

  const _Content({
    required this.style,
    required this.decoration,
    required this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final FTileData(style: tileStyle, :index, :length, :divider) = FTileData.maybeOf(context)!;
    final FTileStyle(:contentStyle, :dividerStyle) = tileStyle;
    assert(divider != FTileDivider.title, 'FTileDivider.title is not supported in _Content.');

    Widget tile = Padding(
      padding: contentStyle.padding,
      child: Row(
        children: [
          if (prefixIcon case final prefixIcon?)
            Padding(
              padding: EdgeInsets.only(right: contentStyle.prefixIconSpacing),
              child: FIconStyleData(
                style: style.prefixIconStyle,
                child: prefixIcon,
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle.merge(
                style: style.titleTextStyle,
                overflow: TextOverflow.ellipsis,
                child: title,
              ),
              if (subtitle case final subtitle?)
                Padding(
                  padding: EdgeInsets.only(top: contentStyle.titleSpacing),
                  child: DefaultTextStyle.merge(
                    style: style.subtitleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    child: subtitle,
                  ),
                ),
            ],
          ),
          const Spacer(),
          if (details case final details?)
            DefaultTextStyle.merge(
              style: style.detailsTextStyle,
              overflow: TextOverflow.ellipsis,
              child: details,
            ),
          if (suffixIcon case final suffixIcon?)
            Padding(
              padding: EdgeInsets.only(left: contentStyle.suffixIconSpacing),
              child: FIconStyleData(
                style: style.suffixIconStyle,
                child: suffixIcon,
              ),
            ),
        ],
      ),
    );

    if (divider == FTileDivider.full && index < length - 1) {
      tile = Column(
        mainAxisSize: MainAxisSize.min,
        children: [tile, FDivider(style: dividerStyle)],
      );
    } else if (length == 1) {
      tile = DecoratedBox(
        decoration: decoration,
        child: tile,
      );
    }

    return tile;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('decoration', decoration));
  }
}

class _TitleAlignedContent extends StatelessWidget {
  final FTileContentStateStyle style;
  final Widget? prefixIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffixIcon;

  const _TitleAlignedContent({
    required this.style,
    required this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final FTileData(style: tileStyle, :index, :length, :divider) = FTileData.maybeOf(context)!;
    final FTileStyle(:contentStyle, :dividerStyle) = tileStyle;
    assert(divider == FTileDivider.title, 'Only FTileDivider.title is supported in _TitleAlignedContent.');

    return Row(
      children: [
        if (prefixIcon case final prefixIcon?)
          Padding(
            padding: contentStyle.padding.copyWith(right: contentStyle.prefixIconSpacing),
            child: FIconStyleData(
              style: style.prefixIconStyle,
              child: prefixIcon,
            ),
          )
        else
          SizedBox(width: contentStyle.padding.left),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: contentStyle.padding.copyWith(left: 0),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        merge(
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
                              overflow: TextOverflow.ellipsis,
                              child: subtitle,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (details case final details?)
                      DefaultTextStyle.merge(
                        style: style.detailsTextStyle,
                        overflow: TextOverflow.ellipsis,
                        child: details,
                      ),
                    if (suffixIcon case final suffixIcon?)
                      Padding(
                        padding: EdgeInsets.only(left: contentStyle.suffixIconSpacing),
                        child: FIconStyleData(
                          style: style.suffixIconStyle,
                          child: suffixIcon,
                        ),
                      ),
                  ],
                ),
              ),
              if (index < length - 1) FDivider(style: dividerStyle),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTile] content's style.
final class FTileContentStyle with Diagnosticable {
  /// The content's padding. Defaults to `EdgeInsets.only(left: 15, top: 8, right: 10, bottom: 8)`.
  final EdgeInsets padding;

  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  final double prefixIconSpacing;

  /// The vertical spacing between the title and the subtitle. Defaults to 5.
  final double titleSpacing;

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
    this.padding = const EdgeInsets.only(left: 15, top: 8, right: 10, bottom: 8),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 5,
    this.suffixIconSpacing = 10,
  });

  /// Creates a [FTileContentStyle] that inherits from the given [colorScheme] and [typography].
  FTileContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          enabledStyle: FTileContentStateStyle(
            prefixIconStyle: FIconStyle(color: colorScheme.primary, size: 18),
            titleTextStyle: typography.base,
            subtitleTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
            detailsTextStyle: typography.base.copyWith(color: colorScheme.mutedForeground),
            suffixIconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
          ),
          enabledHoveredStyle: FTileContentStateStyle(
            prefixIconStyle: FIconStyle(color: colorScheme.primary, size: 18),
            titleTextStyle: typography.base,
            subtitleTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
            detailsTextStyle: typography.base.copyWith(color: colorScheme.mutedForeground),
            suffixIconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 18),
          ),
          disabledStyle: FTileContentStateStyle(
            prefixIconStyle: FIconStyle(color: colorScheme.disable(colorScheme.primary), size: 18),
            titleTextStyle: typography.base.copyWith(color: colorScheme.disable(colorScheme.primary)),
            subtitleTextStyle: typography.sm.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
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
          suffixIconSpacing == other.suffixIconSpacing &&
          enabledStyle == other.enabledStyle &&
          enabledHoveredStyle == other.enabledHoveredStyle &&
          disabledStyle == other.disabledStyle;

  @override
  int get hashCode =>
      padding.hashCode ^
      prefixIconSpacing.hashCode ^
      titleSpacing.hashCode ^
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
