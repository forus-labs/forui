import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'pagination_style.style.dart';

/// The [FPagination] styles.
final class FPaginationStyle with Diagnosticable, _$FPaginationStyleFunctions {
  /// The style for the [FPagination] when it is selected.
  @override
  final FPaginationStateStyle selected;

  /// The style for the [FPagination] when it is unselected.
  @override
  final FPaginationStateStyle unselected;

  /// The icon style.
  @override
  final IconThemeData iconStyle;

  /// The padding around each item. Defaults to EdgeInsets.symmetric(horizontal: 2)`.
  @override
  final EdgeInsets itemPadding;

  /// The constraints for the content. Defaults to `BoxConstraints(maxWidth: 40, minWidth: 40, maxHeight: 40, minHeight: 40)`.
  @override
  final BoxConstraints contentConstraints;

  /// The tappable's action style.
  @override
  final FTappableStyle actionTappableStyle;

  /// The tappable's page style.
  @override
  final FTappableStyle pageTappableStyle;

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.selected,
    required this.unselected,
    required this.iconStyle,
    required this.actionTappableStyle,
    required this.pageTappableStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2),
    this.contentConstraints = const BoxConstraints.tightFor(width: 40.0, height: 40.0),
  });

  /// Creates a [FPaginationStyle] that inherits its properties from [colorScheme], [typography], and [style].
  FPaginationStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        selected: FPaginationStateStyle(
          decoration: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.primary),
          hoveredDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.hover(colorScheme.primary),
          ),
          textStyle: typography.sm.copyWith(color: colorScheme.primaryForeground),
        ),

        unselected: FPaginationStateStyle(
          decoration: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.background),
          hoveredDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.border),
          textStyle: typography.sm.copyWith(color: colorScheme.primary),
        ),

        iconStyle: IconThemeData(color: colorScheme.primary, size: 18),
        actionTappableStyle: style.tappableStyle,
        pageTappableStyle: style.tappableStyle,
      );
}

/// A [FPagination] state's style.
final class FPaginationStateStyle with Diagnosticable, _$FPaginationStateStyleFunctions {
  /// The decoration applied to the pagination item.
  @override
  final BoxDecoration decoration;

  /// The decoration applied when the pagination item is hovered.
  @override
  final BoxDecoration hoveredDecoration;

  /// The text style.
  @override
  final TextStyle textStyle;

  /// Creates a [FPaginationStateStyle].
  FPaginationStateStyle({required this.decoration, required this.hoveredDecoration, required this.textStyle});
}
