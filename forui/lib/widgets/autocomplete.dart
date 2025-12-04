/// {@category Widgets}
///
/// An autocomplete provides a list of suggestions based on the user's input and shows typeahead text for the first match.
///
/// See https://forui.dev/docs/form/autocomplete for working examples.
library forui.widgets.autocomplete;

export '../src/widgets/autocomplete/autocomplete.dart';
export '../src/widgets/autocomplete/autocomplete_content.dart' hide Content, ContentData;
export '../src/widgets/autocomplete/autocomplete_control.dart' hide Lifted, Managed;
export '../src/widgets/autocomplete/autocomplete_controller.dart'
    hide InheritedAutocompleteController, InheritedAutocompleteStyle, LiftedAutocompleteController;
export '../src/widgets/autocomplete/autocomplete_item.dart';
