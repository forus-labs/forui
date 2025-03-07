import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class FTimeFieldPickerProperties with Diagnosticable {
  final AlignmentGeometry anchor;
  final AlignmentGeometry inputAnchor;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  final FHidePopoverRegion hideOnTapOutside;
  final bool directionPadding;
  final int hourInterval;
  final int minuteInterval;

  const FTimeFieldPickerProperties({
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
    this.hourInterval = 1,
    this.minuteInterval = 1,
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
          shift == other.shift &&
          hideOnTapOutside == other.hideOnTapOutside &&
          directionPadding == other.directionPadding &&
          hourInterval == other.hourInterval &&
          minuteInterval == other.minuteInterval;

  @override
  int get hashCode =>
      anchor.hashCode ^
      inputAnchor.hashCode ^
      shift.hashCode ^
      hideOnTapOutside.hashCode ^
      directionPadding.hashCode ^
      hourInterval.hashCode ^
      minuteInterval.hashCode;
}
