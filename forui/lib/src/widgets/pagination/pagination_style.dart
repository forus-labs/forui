import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'pagination_style.style.dart';

/// The [FPagination] styles.
final class FPaginationStyle with Diagnosticable, _$FPaginationStyleFunctions  {
  /// The selected page [BoxDecoration].
  final BoxDecoration selectedDecoration;

  /// The unselected page [BoxDecoration].
  final BoxDecoration unselectedDecoration;

  /// The hovered page [BoxDecoration].
  final BoxDecoration hoveredDecoration;

  /// The hovered selected page [BoxDecoration].
  final BoxDecoration selectedHoveredDecoration;

  /// The unselected textStyle.
  final TextStyle unselectedTextStyle;

  /// The selected textStyle.
  final TextStyle selectedTextStyle;

  // final FPaginationStateStyle selected;
  // final FPaginationStateStyle unselected;

  /// The icon style.
  final FIconStyle iconStyle;

  /// The padding around each item. Defaults to EdgeInsets.symmetric(horizontal: 2)`.
  final EdgeInsets itemPadding;

  /// The constraints for the content. Defaults to `BoxConstraints(maxWidth: 40.0, minWidth: 40.0, maxHeight: 40, minHeight: 40.0)`.
  final BoxConstraints contentConstraints;

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.selectedDecoration,
    required this.unselectedDecoration,
    required this.hoveredDecoration,
    required this.selectedHoveredDecoration,
    required this.iconStyle,
    required this.unselectedTextStyle,
    required this.selectedTextStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2),
    this.contentConstraints = const BoxConstraints(maxWidth: 40.0, minWidth: 40.0, maxHeight: 40.0, minHeight: 40.0),
  });

  /// Creates a [FPaginationStyle] that inherits its properties from [colorScheme], [typography], and [style].
  FPaginationStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
    selectedDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: colorScheme.primary,
    ),
    unselectedDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: colorScheme.background,
    ),
    hoveredDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: colorScheme.border,
    ),
    selectedHoveredDecoration: BoxDecoration(
      borderRadius: style.borderRadius,
      color: colorScheme.hover(colorScheme.primary),
    ),
    unselectedTextStyle: typography.sm.copyWith(color: colorScheme.primary),
    selectedTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground),
    iconStyle: FIconStyle(color: colorScheme.primary, size: 18),
  );

  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  @useResult
  FPaginationStyle copyWith({
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
    BoxDecoration? hoveredDecoration,
    BoxDecoration? selectedHoveredDecoration,
    TextStyle? unselectedTextStyle,
    TextStyle? selectedTextStyle,
    FIconStyle? iconStyle,
    EdgeInsets? contentPadding,
    EdgeInsets? itemPadding,
    BoxConstraints? contentConstraints,
  }) =>
      FPaginationStyle(
        selectedDecoration: selectedDecoration ?? this.selectedDecoration,
        unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
        hoveredDecoration: hoveredDecoration ?? this.hoveredDecoration,
        selectedHoveredDecoration: selectedHoveredDecoration ?? this.selectedHoveredDecoration,
        unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        itemPadding: itemPadding ?? this.itemPadding,
        contentConstraints: contentConstraints ?? this.contentConstraints,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedDecoration', selectedDecoration))
      ..add(DiagnosticsProperty('unselectedDecoration', unselectedDecoration))
      ..add(DiagnosticsProperty('hoveredDecoration', hoveredDecoration))
      ..add(DiagnosticsProperty('selectedHoveredDecoration', selectedHoveredDecoration))
      ..add(DiagnosticsProperty('unselectedTextStyle', unselectedTextStyle))
      ..add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('contentConstraints', contentConstraints));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FPaginationStyle &&
              runtimeType == other.runtimeType &&
              selectedDecoration == other.selectedDecoration &&
              unselectedDecoration == other.unselectedDecoration &&
              hoveredDecoration == other.hoveredDecoration &&
              selectedHoveredDecoration == other.selectedHoveredDecoration &&
              unselectedTextStyle == other.unselectedTextStyle &&
              selectedTextStyle == other.selectedTextStyle &&
              iconStyle == other.iconStyle &&
              itemPadding == other.itemPadding &&
              contentConstraints == other.contentConstraints;

  @override
  int get hashCode =>
      selectedDecoration.hashCode ^
      unselectedDecoration.hashCode ^
      hoveredDecoration.hashCode ^
      selectedHoveredDecoration.hashCode ^
      unselectedTextStyle.hashCode ^
      selectedTextStyle.hashCode ^
      iconStyle.hashCode ^
      itemPadding.hashCode ^
      contentConstraints.hashCode;
}
