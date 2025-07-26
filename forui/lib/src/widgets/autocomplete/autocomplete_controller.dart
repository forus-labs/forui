import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:meta/meta.dart';

/// A controller for managing the state of an autocomplete input field.
class FAutocompleteController extends FTypeaheadController {
  /// The popover controller used to manage the autocomplete suggestions.
  final FPopoverController popover;

  /// Creates a [FAutocompleteController] with an optional initial text.
  FAutocompleteController({required TickerProvider vsync, super.text, super.completion})
    : popover = FPopoverController(vsync: vsync),
      super(styles: (context) {
        final InheritedAutocompleteStyle(:style, :states) = InheritedAutocompleteStyle.of(context);
        return (style.fieldStyle.contentTextStyle.resolve(states), style.typeaheadTextStyle.resolve(states));
      });

  @override
  void dispose() {
    popover.dispose();
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
