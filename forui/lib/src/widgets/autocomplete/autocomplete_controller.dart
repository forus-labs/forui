import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:meta/meta.dart';

/// A controller for managing the state of an autocomplete input field.
class FAutocompleteController extends TextEditingController {
  /// The popover controller used to manage the autocomplete suggestions.
  final FPopoverController popover;

  String _suggestion;

  /// Creates a [FAutocompleteController] with an optional initial text.
  FAutocompleteController({required TickerProvider vsync, super.text})
    : popover = FPopoverController(vsync: vsync),
      _suggestion = '';

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, bool? withComposing}) {
    final InheritedAutocompleteStyle(:style, :states) = InheritedAutocompleteStyle.of(context);
    return TextSpan(
      children: [
        TextSpan(text: text, style: style.fieldStyle.contentTextStyle.resolve(states)),
        TextSpan(text: _suggestion, style: style.typeaheadTextStyle.resolve(states)),
      ],
    );
  }

  /// Returns the current suggested remaining text.
  String get suggestion => _suggestion;

  /// Sets the suggested remaining text.
  set suggestion(String value) {
    if (_suggestion != value) {
      _suggestion = value;
      notifyListeners();
    }
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

  const InheritedAutocompleteController({
    required this.popover,
    required this.onPress,
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
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}
