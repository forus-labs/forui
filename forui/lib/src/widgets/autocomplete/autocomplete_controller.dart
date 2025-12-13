import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete.dart';

part 'autocomplete_controller.control.dart';

/// A controller for managing autocomplete functionality in a text field.
class FAutocompleteController extends FTypeaheadController {
  /// Creates a [FAutocompleteController] with an optional initial text and suggestions.
  FAutocompleteController({super.text, super.suggestions})
    : super(
        textStyles: (context) {
          final InheritedAutocompleteStyle(:style, :states) = .of(context);
          return (
            style.fieldStyle.contentTextStyle.resolve(states),
            style.composingTextStyle.resolve(states),
            style.typeaheadTextStyle.resolve(states),
          );
        },
      );

  /// Creates a [FAutocompleteController] from a [TextEditingValue].
  FAutocompleteController.fromValue(super.value, {super.suggestions = const []})
    : super.fromValue(
        textStyles: (context) {
          final InheritedAutocompleteStyle(:style, :states) = .of(context);
          return (
            style.fieldStyle.contentTextStyle.resolve(states),
            style.composingTextStyle.resolve(states),
            style.typeaheadTextStyle.resolve(states),
          );
        },
      );
}

class _ProxyController extends FAutocompleteController {
  TextEditingValue? _unsynced;
  ValueChanged<TextEditingValue> _onChange;

  _ProxyController(super.value, this._onChange) : _unsynced = value, super.fromValue();

  void update(TextEditingValue newValue, ValueChanged<TextEditingValue> onChange) {
    _onChange = onChange;
    if (super.rawValue != newValue) {
      _unsynced = newValue;
      super.rawValue = newValue;
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      notifyListeners();
    }
  }

  @override
  set rawValue(TextEditingValue value) {
    _unsynced = value;
    if (super.value != value) {
      _onChange(value);
    }
  }
}

@internal
class InheritedAutocompleteController extends InheritedWidget {
  static InheritedAutocompleteController of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedAutocompleteController>('$FAutocomplete', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedAutocompleteController>()!;
  }

  final FPopoverController popover;
  final ValueChanged<String> onPress;
  final ValueChanged<String> onFocus;

  const InheritedAutocompleteController({
    required this.popover,
    required this.onPress,
    required this.onFocus,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedAutocompleteController old) => popover != old.popover || onPress != old.onPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popover', popover))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onFocus', onFocus));
  }
}

/// A [FAutocompleteControl] defines how a [FAutocomplete] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FAutocompleteControl with Diagnosticable, _$FAutocompleteControlMixin {
  /// Creates a [FAutocompleteControl].
  const factory FAutocompleteControl.managed({
    FAutocompleteController? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = FAutocompleteManagedControl;

  /// Creates a [FAutocompleteControl] for controlling an autocomplete using lifted state.
  const factory FAutocompleteControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onChange,
  }) = _Lifted;

  const FAutocompleteControl._();

  (FAutocompleteController, bool) _update(
    FAutocompleteControl old,
    FAutocompleteController controller,
    VoidCallback callback,
    FutureOr<Iterable<String>> Function(String) filter,
  );
}

/// A [FAutocompleteManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FAutocompleteManagedControl extends FAutocompleteControl with _$FAutocompleteManagedControlMixin {
  /// The controller.
  @override
  final FAutocompleteController? controller;

  /// The initial value. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final TextEditingValue? initial;

  /// Called when the value changes.
  @override
  final ValueChanged<TextEditingValue>? onChange;

  /// Creates a [FAutocompleteControl].
  const FAutocompleteManagedControl({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both a controller and initial.'),
      super._();

  @override
  FAutocompleteController createController(FutureOr<Iterable<String>> Function(String) _) =>
      controller ?? .fromValue(initial);
}

class _Lifted extends FAutocompleteControl with _$_LiftedMixin {
  @override
  final TextEditingValue value;
  @override
  final ValueChanged<TextEditingValue> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  FAutocompleteController createController(FutureOr<Iterable<String>> Function(String) _) =>
      _ProxyController(value, onChange);

  @override
  void _updateController(FAutocompleteController controller, FutureOr<Iterable<String>> Function(String) filter) {
    (controller as _ProxyController)
      ..update(value, onChange)
      ..loadSuggestions(filter(controller.text));
  }
}
