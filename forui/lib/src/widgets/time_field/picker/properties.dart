import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class FTimeFieldPickerProperties with Diagnosticable {
  final AlignmentGeometry anchor;
  final AlignmentGeometry inputAnchor;
  final FPortalSpacing spacing;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  final Offset offset;
  final FHidePopoverRegion hideOnTapOutside;
  final int hourInterval;
  final int minuteInterval;

  const FTimeFieldPickerProperties({
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
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
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
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
          shift == other.shift &&
          offset == other.offset &&
          hideOnTapOutside == other.hideOnTapOutside &&
          hourInterval == other.hourInterval &&
          minuteInterval == other.minuteInterval;

  @override
  int get hashCode =>
      anchor.hashCode ^
      inputAnchor.hashCode ^
      spacing.hashCode ^
      shift.hashCode ^
      offset.hashCode ^
      hideOnTapOutside.hashCode ^
      hourInterval.hashCode ^
      minuteInterval.hashCode;
}
