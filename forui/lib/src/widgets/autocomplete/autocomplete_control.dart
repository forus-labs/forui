import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

/// Defines how [FAutocomplete]'s state is controlled.
sealed class FAutocompleteControl {
  /// Creates lifted state control.
  ///
  /// Text is always lifted.
  /// Content visibility is optionally lifted - if [popoverShown] is provided, [onPopoverChange] must also be provided.
  ///
  /// ## Contract
  /// Throws [AssertionError] if only one of [popoverShown]/[onPopoverChange] is provided.
  const factory FAutocompleteControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
  }) = Lifted;

  /// Creates managed control using an [FAutocompleteController].
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  const factory FAutocompleteControl.managed({
    FAutocompleteController? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = Managed;
}

@internal
class Lifted with Diagnosticable implements FAutocompleteControl {
  final TextEditingValue value;
  final ValueChanged<TextEditingValue> onValueChange;
  final bool? popoverShown;
  final ValueChanged<bool>? onPopoverChange;

  const Lifted({required this.value, required this.onValueChange, this.popoverShown, this.onPopoverChange})
    : assert(
        (popoverShown == null) == (onPopoverChange == null),
        'contentShown and onContentChange must both be provided or both be null.',
      );

  // Generated all of these.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(ObjectFlagProperty.has('onValueChange', onValueChange))
      ..add(FlagProperty('contentShown', value: popoverShown, ifTrue: 'shown'))
      ..add(ObjectFlagProperty.has('onContentChange', onPopoverChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lifted &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          onValueChange == other.onValueChange &&
          popoverShown == other.popoverShown &&
          onPopoverChange == other.onPopoverChange;

  @override
  int get hashCode => Object.hash(value, onValueChange, popoverShown, onPopoverChange);
}

@internal
class Managed with Diagnosticable implements FAutocompleteControl {
  final FAutocompleteController? controller;
  final TextEditingValue? initial;
  final ValueChanged<TextEditingValue>? onChange;

  const Managed({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both a controller and initial.');

  // Generated all of these.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('initial', initial))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange;

  @override
  int get hashCode => Object.hash(controller, initial, onChange);
}
