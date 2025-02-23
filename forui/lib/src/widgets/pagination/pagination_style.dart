import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'pagination_style.style.dart';

/// Defines the visual styles for different states of the [FPagination] widget.
final class FPaginationStateStyle with Diagnosticable, _$FPaginationStateStyleFunctions {
  /// The default decoration applied to the pagination item.
  @override
  final BoxDecoration decoration;

  /// The decoration applied when the pagination item is hovered.
  @override
  final BoxDecoration hoveredDecoration;

  /// The text style used for the pagination item.
  @override
  final TextStyle textStyle;

  /// Creates a [FPaginationStateStyle].
  FPaginationStateStyle({required this.decoration, required this.hoveredDecoration, required this.textStyle});
}

/// The [FPagination] styles.
final class FPaginationStyle with Diagnosticable, _$FPaginationStyleFunctions {
  /// The style configuration for a pagination item when it is in the selected state.
  @override
  final FPaginationStateStyle selected;

  /// The style configuration for a pagination item when it is in the unselected state.
  @override
  final FPaginationStateStyle unselected;

  /// The icon style.
  @override
  final FIconStyle iconStyle;

  /// The padding around each item. Defaults to EdgeInsets.symmetric(horizontal: 2)`.
  @override
  final EdgeInsets itemPadding;

  /// The constraints for the content. Defaults to `BoxConstraints(maxWidth: 40.0, minWidth: 40.0, maxHeight: 40, minHeight: 40.0)`.
  @override
  final BoxConstraints contentConstraints;

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.selected,
    required this.unselected,
    required this.iconStyle,

    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2),
    this.contentConstraints = const BoxConstraints(maxWidth: 40.0, minWidth: 40.0, maxHeight: 40.0, minHeight: 40.0),
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

        iconStyle: FIconStyle(color: colorScheme.primary, size: 18),
      );

  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  @override
  @useResult
  FPaginationStyle copyWith({
    FPaginationStateStyle? selected,
    FPaginationStateStyle? unselected,
    FIconStyle? iconStyle,
    EdgeInsets? itemPadding,
    BoxConstraints? contentConstraints,
  }) => FPaginationStyle(
    selected: selected ?? this.selected,
    unselected: unselected ?? this.unselected,
    iconStyle: iconStyle ?? this.iconStyle,
    itemPadding: itemPadding ?? this.itemPadding,
    contentConstraints: contentConstraints ?? this.contentConstraints,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('unselected', unselected))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('contentConstraints', contentConstraints));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPaginationStyle &&
          runtimeType == other.runtimeType &&
          selected == other.selected &&
          unselected == other.unselected &&
          iconStyle == other.iconStyle &&
          itemPadding == other.itemPadding &&
          contentConstraints == other.contentConstraints;

  @override
  int get hashCode =>
      selected.hashCode ^ unselected.hashCode ^ iconStyle.hashCode ^ itemPadding.hashCode ^ contentConstraints.hashCode;
}
