import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

@internal
class InheritedStates extends InheritedWidget {
  static InheritedStates of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<InheritedStates>();
    assert(result != null, 'No InheritedStates found in context');
    return result!;
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
