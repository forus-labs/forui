import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
final class InheritedData extends InheritedWidget {
  static InheritedData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context');
    return result!;
  }

  final FSliderStyle style;
  final Layout layout;
  final List<FSliderMark> marks;
  final Widget Function(FTooltipStyle, double) tooltipBuilder;
  final String Function(FSliderSelection) semanticFormatterCallback;
  final String Function(double) semanticValueFormatterCallback;
  final bool enabled;

  const InheritedData({
    required this.style,
    required this.layout,
    required this.marks,
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
      ..add(ObjectFlagProperty.has('tooltipBuilder', tooltipBuilder))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticValueFormatterCallback))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}
