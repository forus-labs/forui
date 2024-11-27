import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// [FLineCalendar]'s style.
final class FLineCalendarStyle with Diagnosticable {
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  final EdgeInsets itemPadding;

  /// The calendar item's style.
  final FLineCalendarItemStyle itemStyle;

  /// Creates a [FLineCalendarStyle].
  FLineCalendarStyle({
    required this.itemStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 6.5),
  });

  /// Creates a [FLineCalendarStyle] that inherits its properties from [colorScheme] and [typography].
  FLineCalendarStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
    itemStyle: FLineCalendarItemStyle.inherit(
      colorScheme: colorScheme,
      typography: typography,
      style: style,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsets? itemPadding,
    FLineCalendarItemStyle? itemStyle,
  }) =>
      FLineCalendarStyle(
        itemPadding: itemPadding ?? this.itemPadding,
        itemStyle: itemStyle ?? this.itemStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FLineCalendarStyle &&
              runtimeType == other.runtimeType &&
              itemPadding == other.itemPadding &&
              itemStyle == other.itemStyle;

  @override
  int get hashCode => itemPadding.hashCode ^ itemStyle.hashCode;
}