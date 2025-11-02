import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A date picker calendar popover's properties.
class FDateFieldCalendarProperties with Diagnosticable {
  /// The alignment point on the calendar popover. Defaults to [Alignment.topLeft].
  final AlignmentGeometry anchor;

  /// The alignment point on the input field. Defaults to [Alignment.bottomLeft].
  final AlignmentGeometry inputAnchor;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow overflow;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.hideRegion}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  ///
  /// Setting [hideRegion] to [FPopoverHideRegion.anywhere] may result in the calendar disappearing and reappearing
  /// when pressing and holding the input field, due to the popover being hidden and then immediately shown again.
  final FPopoverHideRegion hideRegion;

  /// {@macro forui.widgets.FPopover.onTapHide}
  ///
  /// This is only called if [hideRegion] is set to [FPopoverHideRegion.anywhere] or [FPopoverHideRegion.excludeChild].
  final VoidCallback? onTapHide;

  /// Customizes the appearance of calendar days.
  final ValueWidgetBuilder<FCalendarDayData> dayBuilder;

  /// The earliest selectable date, doesn't affect validation.
  final DateTime? start;

  /// The latest selectable date, doesn't affect validation.
  final DateTime? end;

  /// The date considered as "today".
  final DateTime? today;

  /// The initial view type (month/year).
  final FCalendarPickerType initialType;

  /// True if the calendar popover should be automatically hidden after a date is selected. Defaults to true.
  final bool autoHide;

  /// Creates calendar properties for a date picker.
  const FDateFieldCalendarProperties({
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.start,
    this.end,
    this.today,
    this.initialType = FCalendarPickerType.day,
    this.autoHide = true,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('inputAnchor', inputAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(DiagnosticsProperty('start', start))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('today', today))
      ..add(EnumProperty('initialType', initialType))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDateFieldCalendarProperties &&
          runtimeType == other.runtimeType &&
          anchor == other.anchor &&
          inputAnchor == other.inputAnchor &&
          spacing == other.spacing &&
          overflow == other.overflow &&
          offset == other.offset &&
          hideRegion == other.hideRegion &&
          onTapHide == other.onTapHide &&
          dayBuilder == other.dayBuilder &&
          start == other.start &&
          end == other.end &&
          today == other.today &&
          initialType == other.initialType &&
          autoHide == other.autoHide;

  @override
  int get hashCode =>
      anchor.hashCode ^
      inputAnchor.hashCode ^
      spacing.hashCode ^
      overflow.hashCode ^
      offset.hashCode ^
      hideRegion.hashCode ^
      onTapHide.hashCode ^
      dayBuilder.hashCode ^
      start.hashCode ^
      end.hashCode ^
      today.hashCode ^
      initialType.hashCode ^
      autoHide.hashCode;
}
