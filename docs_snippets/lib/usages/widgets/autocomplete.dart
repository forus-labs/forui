// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

final autocomplete = FAutocomplete(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  hint: 'Hint',
  items: const ['Apple', 'Banana', 'Cherry'],
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  forceErrorText: null,
  onSaved: (value) {},
  onReset: () {},
  validator: (value) => null,
  autovalidateMode: .disabled,
  // {@endcategory}
  // {@category "Field"}
  builder: (context, style, states, child) => child,
  magnifierConfiguration: null,
  groupId: EditableText,
  keyboardType: null,
  textInputAction: null,
  textCapitalization: .none,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  autofocus: false,
  focusNode: null,
  statesController: null,
  obscuringCharacter: '•',
  obscureText: false,
  autocorrect: true,
  smartDashesType: null,
  smartQuotesType: null,
  enableSuggestions: true,
  minLines: null,
  maxLines: 1,
  expands: false,
  readOnly: false,
  showCursor: null,
  maxLength: null,
  maxLengthEnforcement: null,
  onTapAlwaysCalled: false,
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  inputFormatters: null,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectionControls: null,
  dragStartBehavior: .start,
  mouseCursor: null,
  counterBuilder: null,
  scrollPhysics: null,
  scrollController: null,
  autofillHints: null,
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  contextMenuBuilder: null,
  canRequestFocus: true,
  undoController: null,
  spellCheckConfiguration: null,
  prefixBuilder: null,
  suffixBuilder: null,
  clearable: (value) => false,
  rightArrowToComplete: false,
  // {@endcategory}
  // {@category "Content"}
  autoHide: true,
  contentAnchor: AlignmentDirectional.topStart,
  fieldAnchor: AlignmentDirectional.bottomStart,
  contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 300),
  contentSpacing: const .spacing(4),
  contentOverflow: .flip,
  contentOffset: .zero,
  contentHideRegion: .excludeChild,
  contentGroupId: null,
  contentOnTapHide: () {},
  contentScrollController: null,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  filter: (query) => ['Apple', 'Banana'].where((item) => item.toLowerCase().startsWith(query.toLowerCase())),
  contentBuilder: (context, query, values) => [for (final value in values) .item(value: value)],
  contentEmptyBuilder: FAutocomplete.defaultContentEmptyBuilder,
  contentLoadingBuilder: FAutocomplete.defaultContentLoadingBuilder,
  contentErrorBuilder: (context, error, stackTrace) => const Text('Error'),
  // {@endcategory}
);

final builder = FAutocomplete.builder(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  filter: (query) => ['Apple', 'Banana'].where((item) => item.toLowerCase().startsWith(query.toLowerCase())),
  contentBuilder: (context, query, values) => [for (final value in values) .item(value: value)],
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Popover Control"}
  popoverControl: const .managed(),
  // {@endcategory}
  // {@category "Form"}
  label: const Text('Label'),
  description: const Text('Description'),
  errorBuilder: FFormFieldProperties.defaultErrorBuilder,
  forceErrorText: null,
  onSaved: (value) {},
  onReset: () {},
  validator: (value) => null,
  autovalidateMode: .disabled,
  // {@endcategory}
  // {@category "Field"}
  hint: 'Hint',
  builder: (context, style, states, child) => child,
  magnifierConfiguration: null,
  groupId: EditableText,
  keyboardType: null,
  textInputAction: null,
  textCapitalization: .none,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  autofocus: false,
  focusNode: null,
  statesController: null,
  obscuringCharacter: '•',
  obscureText: false,
  autocorrect: true,
  smartDashesType: null,
  smartQuotesType: null,
  enableSuggestions: true,
  minLines: null,
  maxLines: 1,
  expands: false,
  readOnly: false,
  showCursor: null,
  maxLength: null,
  maxLengthEnforcement: null,
  onTapAlwaysCalled: false,
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  inputFormatters: null,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectionControls: null,
  dragStartBehavior: .start,
  mouseCursor: null,
  counterBuilder: null,
  scrollPhysics: null,
  scrollController: null,
  autofillHints: null,
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  contextMenuBuilder: null,
  canRequestFocus: true,
  undoController: null,
  spellCheckConfiguration: null,
  prefixBuilder: null,
  suffixBuilder: null,
  clearable: (value) => false,
  rightArrowToComplete: false,
  // {@endcategory}
  // {@category "Content"}
  autoHide: true,
  contentEmptyBuilder: FAutocomplete.defaultContentEmptyBuilder,
  contentLoadingBuilder: FAutocomplete.defaultContentLoadingBuilder,
  contentErrorBuilder: (context, error, stackTrace) => const Text('Error'),
  contentAnchor: AlignmentDirectional.topStart,
  fieldAnchor: AlignmentDirectional.bottomStart,
  contentConstraints: const FAutoWidthPortalConstraints(maxHeight: 300),
  contentSpacing: const .spacing(4),
  contentOverflow: .flip,
  contentOffset: .zero,
  contentHideRegion: .excludeChild,
  contentGroupId: null,
  contentOnTapHide: () {},
  contentScrollController: null,
  contentPhysics: const ClampingScrollPhysics(),
  contentDivider: .none,
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the autocomplete's text and selection.
final FAutocompleteControl lifted = .lifted(value: .empty, onChange: (value) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages the text editing state internally.
final FAutocompleteControl internal = .managed(initial: .empty, onChange: (value) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external `FAutocompleteController` to control the autocomplete's state.
final FAutocompleteControl external = .managed(
  // For demonstration purposes only. Don't create a controller inline, store in a State instead.
  controller: FAutocompleteController(text: 'Initial value'),
  onChange: (value) {},
);

// {@category "Popover Control" "`.lifted()`"}
/// Externally controls the popover's visibility.
final FPopoverControl popoverLifted = .lifted(shown: false, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with internal controller"}
/// Manages the popover's visibility internally.
final FPopoverControl popoverInternal = .managed(initial: true, onChange: (shown) {}, motion: const FPopoverMotion());

// {@category "Popover Control" "`.managed()` with external controller"}
/// Uses an external `FPopoverController` to control the popover's visibility.
final FPopoverControl popoverExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: FPopoverController(vsync: vsync, shown: true, motion: const FPopoverMotion()),
  onChange: (shown) {},
);

TickerProvider get vsync => throw UnimplementedError();
