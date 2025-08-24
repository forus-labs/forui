import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedData extends InheritedWidget {
  static InheritedData of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedData>('$FSlider', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }

  final FSliderStyle style;
  final FLayout layout;
  final List<FSliderMark> marks;
  final double? trackMainAxisExtent;
  final double? trackHitRegionCrossExtent;
  final Widget Function(FTooltipController controller, double value) tooltipBuilder;
  final String Function(FSliderSelection) semanticFormatterCallback;
  final String Function(double) semanticValueFormatterCallback;
  final bool enabled;

  const InheritedData({
    required this.style,
    required this.layout,
    required this.marks,
    required this.trackMainAxisExtent,
    required this.trackHitRegionCrossExtent,
    required this.tooltipBuilder,
    required this.semanticFormatterCallback,
    required this.semanticValueFormatterCallback,
    required this.enabled,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedData old) =>
      style != old.style ||
      layout != old.layout ||
      !marks.equals(marks) ||
      trackMainAxisExtent != old.trackMainAxisExtent ||
      trackHitRegionCrossExtent != old.trackHitRegionCrossExtent ||
      tooltipBuilder != old.tooltipBuilder ||
      semanticFormatterCallback != old.semanticFormatterCallback ||
      semanticValueFormatterCallback != old.semanticValueFormatterCallback ||
      enabled != old.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(DoubleProperty('trackMainAxisExtent', trackMainAxisExtent))
      ..add(DoubleProperty('trackHitRegionCrossExtent', trackHitRegionCrossExtent))
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticValueFormatterCallback))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}
