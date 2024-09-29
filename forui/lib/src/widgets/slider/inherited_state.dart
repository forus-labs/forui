import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class InheritedState extends InheritedWidget {
  static InheritedState of(BuildContext context) {
    final InheritedState? result = context.dependOnInheritedWidgetOfExactType<InheritedState>();
    assert(result != null, 'No InheritedState found in context');
    return result!;
  }

  final FSliderStateStyle style;
  final FLabelState state;

  const InheritedState({
    required this.style,
    required this.state,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedState old) => style != old.style || state != old.state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('state', state));
  }
}
