import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

// ignore_for_file: avoid_positional_boolean_parameters

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

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}

/// Internal controller for lifted state mode.
@internal
class LiftedAutocompleteController extends FAutocompleteController {
  FPopoverController _popover;
  ValueChanged<TextEditingValue> _onValueChange;

  LiftedAutocompleteController(
    super.value, {
    required super.vsync,
    required ValueChanged<TextEditingValue> onValueChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    super.popoverMotion,
  }) : _popover = popoverShown != null && onPopoverChange != null
           ? LiftedController(popoverShown, onPopoverChange, vsync: vsync)
           : FPopoverController(vsync: vsync),
       _onValueChange = onValueChange,
       super.fromValue();

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
    switch ((_popover, popoverShown != null)) {
      // Lifted -> Lifted
      case (final LiftedController lifted, true):
        lifted.update(popoverShown!, onPopoverChange!);

      // Lifted -> Internal
      case (LiftedController(), false):
        _popover.dispose();
        _popover = FPopoverController(vsync: vsync);

      // Internal -> Lifted
      case (_, true) when _popover is! LiftedController:
        _popover.dispose();
        _popover = LiftedController(popoverShown!, onPopoverChange!, vsync: vsync);
    }
  }

  @override
  set value(TextEditingValue value) {
    if (super.value != value) {
      _onValueChange(value);
    }
  }

  @override
  FPopoverController get popover => _popover;

  @override
  void dispose() {
    _popover.dispose();
    super.dispose();
  }
}

@internal
final class InheritedAutocompleteStyle extends InheritedWidget {
  @useResult
  static InheritedAutocompleteStyle of(BuildContext context) {
    assert(debugCheckHasAncestor<InheritedAutocompleteStyle>('FAutocomplete', context));
    return context.dependOnInheritedWidgetOfExactType<InheritedAutocompleteStyle>()!;
  }

  /// The autocomplete style.
  final FAutocompleteStyle style;

  /// The current widget states.
  final Set<WidgetState> states;

  const InheritedAutocompleteStyle({required this.style, required this.states, required super.child, super.key});

  @override
  bool updateShouldNotify(InheritedAutocompleteStyle old) => style != old.style || states != old.states;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('states', states));
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
