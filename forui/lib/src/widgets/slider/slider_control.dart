import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

/// A slider's tooltip controllers.
class FSliderTooltipControls with Diagnosticable {
  /// The tooltip controller for the min thumb.
  final FTooltipControl min;

  /// The tooltip controller for the max thumb.
  final FTooltipControl max;

  /// Whether tooltips are enabled. Defaults to true.
  final bool enabled;

  /// Creates a [FSliderTooltipControls] with the given tooltip controllers.
  const FSliderTooltipControls({this.min = const .managed(), this.max = const .managed()}) : enabled = true;

  /// Creates a [FSliderTooltipControls] with both tooltips disabled.
  const FSliderTooltipControls.disabled() : min = const .managed(), max = const .managed(), enabled = false;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('min', min))
      ..add(DiagnosticsProperty('max', max))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}
