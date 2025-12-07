import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'autocomplete_controller.control.dart';

/// A controller for managing autocomplete functionality in a text field.
class FAutocompleteController extends FTypeaheadController {
  /// The popover controller used to show all autocomplete suggestions.
  final FPopoverController popover;

  /// Creates a [FAutocompleteController] with an optional initial text and suggestions.
  FAutocompleteController({
    required TickerProvider vsync,
    super.text,
    super.suggestions,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : popover = FPopoverController(vsync: vsync, motion: popoverMotion),
       super(
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
  FAutocompleteController.fromValue(
    super.value, {
    required TickerProvider vsync,
    super.suggestions = const [],
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : popover = FPopoverController(vsync: vsync, motion: popoverMotion),
       super.fromValue(
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
  FAutocompleteController._(super.value, {required this.popover})
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

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}

class _Controller extends FAutocompleteController {
  late FPopoverController _popover;
  ValueChanged<TextEditingValue> _onValueChange;

  _Controller(
    super.value, {
    required TickerProvider vsync,
    required ValueChanged<TextEditingValue> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : _onValueChange = onValueChange,
       super._(
         popover: popoverShown != null && onPopoverChange != null
             ? LiftedPopoverController(popoverShown, onPopoverChange, vsync: vsync, motion: popoverMotion)
             : FPopoverController(vsync: vsync, motion: popoverMotion),
       ) {
    _popover = super.popover; // This prevents the creation of two popover controllers, with one being shadowed.
  }

  void update(
    TickerProvider vsync,
    TextEditingValue value,
    ValueChanged<TextEditingValue> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
  ) {
    if (super.value != value) {
      super.value = value;
    }

    _onValueChange = onValueChange;
    _popover = InternalPopoverController.updateNested(_popover, vsync, popoverShown, onPopoverChange);
  }

  @override
  set value(TextEditingValue value) {
    if (super.value != value) {
      _onValueChange(value);
    }
  }

  @override
  FPopoverController get popover => _popover;
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

/// Defines how [FAutocomplete]'s state is controlled.
sealed class FAutocompleteControl with Diagnosticable {
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

  const FAutocompleteControl._();

  FAutocompleteController _create(
    VoidCallback callback,
    TickerProvider vsync,
    FutureOr<Iterable<String>> Function(String) filter,
  );

  (FAutocompleteController, bool) _update(
    FAutocompleteControl old,
    FAutocompleteController controller,
    VoidCallback callback,
    TickerProvider vsync,
    FutureOr<Iterable<String>> Function(String) filter,
  );

  void _dispose(FAutocompleteController controller, VoidCallback callback);
}

@internal
class Lifted extends FAutocompleteControl with _$LiftedFunctions {
  @override
  final TextEditingValue value;
  @override
  final ValueChanged<TextEditingValue> onValueChange;
  @override
  final bool? popoverShown;
  @override
  final ValueChanged<bool>? onPopoverChange;

  const Lifted({required this.value, required this.onValueChange, this.popoverShown, this.onPopoverChange})
    : assert(
        (popoverShown == null) == (onPopoverChange == null),
        'popoverShown and onPopoverChange must both be provided or both be null.',
      ),
      super._();

  @override
  FAutocompleteController _create(
    VoidCallback callback,
    TickerProvider vsync,
    FutureOr<Iterable<String>> Function(String) _,
  ) => _Controller(
    value,
    vsync: vsync,
    onValueChange: onValueChange,
    popoverShown: popoverShown,
    onPopoverChange: onPopoverChange,
  )..addListener(callback);

  @override
  void _updateController(
    FAutocompleteController controller,
    TickerProvider vsync,
    FutureOr<Iterable<String>> Function(String) filter,
  ) {
    (controller as _Controller)
      ..update(vsync, value, onValueChange, popoverShown, onPopoverChange)
      ..loadSuggestions(filter(controller.text));
  }
}

@internal
class Managed extends FAutocompleteControl with _$ManagedFunctions {
  @override
  final FAutocompleteController? controller;
  @override
  final TextEditingValue? initial;
  @override
  final ValueChanged<TextEditingValue>? onChange;

  const Managed({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both a controller and initial.'),
      super._();

  @override
  FAutocompleteController _create(
    VoidCallback callback,
    TickerProvider vsync,
    FutureOr<Iterable<String>> Function(String) _,
  ) => (controller ?? .fromValue(initial, vsync: vsync))..addListener(callback);
}
