import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A [FTile] content's style.
final class FTileContentStyle with Diagnosticable {
  /// The content's padding. Defaults to `EdgeInsets.only(left: 15, top: 8, right: 10, bottom: 8)`.
  final EdgeInsets padding;

  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  final double prefixIconSpacing;

  /// The vertical spacing between the title and the subtitle. Defaults to 4.
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
    this.padding = const EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 4,
    this.suffixIconSpacing = 5,
  });

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