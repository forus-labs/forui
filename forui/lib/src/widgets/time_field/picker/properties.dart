import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class FTimeFieldPickerProperties with Diagnosticable {
  /// The alignment point on the picker popover. Defaults to [Alignment.topLeft].
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

  /// Callback that is called when the time picker is tapped to hide it.
  final VoidCallback? onTapHide;

  /// The interval between hours shown in the time picker. Defaults to 1.
  ///
  /// For example, setting this to 6 will show hours like 0, 6, 12, and 18.
  final int hourInterval;

  /// The interval between minutes shown in the time picker. Defaults to 1.
  ///
  /// For example, setting this to 15 will show minutes like 0, 15, 30, and 45.
  final int minuteInterval;

  const FTimeFieldPickerProperties({
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.hourInterval = 1,
    this.minuteInterval = 1,
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
      ..add(IntProperty('hourInterval', hourInterval))
      ..add(IntProperty('minuteInterval', minuteInterval));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTimeFieldPickerProperties &&
          runtimeType == other.runtimeType &&
          anchor == other.anchor &&
          inputAnchor == other.inputAnchor &&
          spacing == other.spacing &&
          overflow == other.overflow &&
          offset == other.offset &&
          hideRegion == other.hideRegion &&
          onTapHide == other.onTapHide &&
          hourInterval == other.hourInterval &&
          minuteInterval == other.minuteInterval;

  @override
  int get hashCode =>
      anchor.hashCode ^
      inputAnchor.hashCode ^
      spacing.hashCode ^
      overflow.hashCode ^
      offset.hashCode ^
      hideRegion.hashCode ^
      onTapHide.hashCode ^
      hourInterval.hashCode ^
      minuteInterval.hashCode;
}
