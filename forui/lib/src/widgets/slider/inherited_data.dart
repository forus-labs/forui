import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

@internal
class InheritedData extends InheritedWidget {
  final FSliderController controller;
  final FSliderStyle style;
  final Layout layout;
  final List<FSliderMark> marks;
  final bool enabled;

  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context');
    return result!;
  }

  const InheritedData({
    required this.controller,
    required this.style,
    required this.layout,
    required this.marks,
    required this.enabled,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedData old) =>
      controller != old.controller ||
      style != old.style ||
      layout != old.layout ||
      marks.equals(marks) ||
      enabled != old.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}
