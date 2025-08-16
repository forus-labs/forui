import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

@internal
class InheritedStates extends InheritedWidget {
  static InheritedStates of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedStates>('$FSlider', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedStates>()!;
  }

  final Set<WidgetState> states;

  const InheritedStates({required this.states, required super.child, super.key});

  @override
  bool updateShouldNotify(InheritedStates old) => !setEquals(states, states);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('states', states));
  }
}
