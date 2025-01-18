import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A date picker calendar popover's properties.
class FDatePickerCalendarProperties with Diagnosticable {
  /// The alignment point on the calendar popover. Defaults to [Alignment.topLeft]
  final Alignment anchor;

  /// The alignment point on the input field. Defaults to [Alignment.bottomLeft].
  final Alignment inputAnchor;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@macro forui.widgets.FPopover.hideOnTapOutside}
  final FHidePopoverRegion hideOnTapOutside;

  /// Whether to add padding based on the popover direction. Defaults
  final bool directionPadding;

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
  const FDatePickerCalendarProperties({
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
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
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
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
      other is FDatePickerCalendarProperties &&
          runtimeType == other.runtimeType &&
          anchor == other.anchor &&
          inputAnchor == other.inputAnchor &&
          shift == other.shift &&
          hideOnTapOutside == other.hideOnTapOutside &&
          directionPadding == other.directionPadding &&
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
      shift.hashCode ^
      hideOnTapOutside.hashCode ^
      directionPadding.hashCode ^
      dayBuilder.hashCode ^
      start.hashCode ^
      end.hashCode ^
      today.hashCode ^
      initialType.hashCode ^
      autoHide.hashCode;
}
