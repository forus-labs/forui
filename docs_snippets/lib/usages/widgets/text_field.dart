// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final textField = FTextField(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  label: const Text('Label'),
  hint: 'Enter text...',
  description: const Text('Description'),
  error: null,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Appearance"}
  expands: false,
  builder: (context, style, states, field) => field,
  prefixBuilder: null,
  suffixBuilder: null,
  clearable: (value) => false,
  clearIconBuilder: (context, style, clear) => const SizedBox.shrink(),
  counterBuilder: null,
  showCursor: null,
  mouseCursor: null,
  obscuringCharacter: '•',
  obscureText: false,
  // {@endcategory}
  // {@category "Text Input"}
  inputFormatters: null,
  autofillHints: null,
  keyboardType: .text,
  textInputAction: .done,
  textCapitalization: .none,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  autocorrect: true,
  smartDashesType: null,
  smartQuotesType: null,
  enableSuggestions: true,
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  spellCheckConfiguration: null,
  // {@endcategory}
  // {@category "Interaction"}
  contextMenuBuilder: (context, state) => const SizedBox.shrink(),
  readOnly: false,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectAllOnFocus: null,
  selectionControls: null,
  dragStartBehavior: .start,
  groupId: EditableText,
  statesController: null,
  undoController: null,
  // {@endcategory}
  // {@category "Lines/Length"}
  scrollPhysics: null,
  scrollController: null,
  minLines: null,
  maxLines: 1,
  maxLength: null,
  maxLengthEnforcement: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  canRequestFocus: true,
  magnifierConfiguration: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onTapAlwaysCalled: false,
  onTap: () {},
  onTapOutside: (event) {},
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  // {@endcategory}
);

final textFieldEmail = FTextField.email(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  label: const Text('Email'),
  hint: 'Enter email...',
  description: const Text('Description'),
  error: null,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Appearance"}
  expands: false,
  builder: (context, style, states, field) => field,
  prefixBuilder: null,
  suffixBuilder: null,
  clearable: (value) => false,
  clearIconBuilder: (context, style, clear) => const SizedBox.shrink(),
  counterBuilder: null,
  showCursor: null,
  mouseCursor: null,
  obscuringCharacter: '•',
  obscureText: false,
  // {@endcategory}
  // {@category "Text Input"}
  inputFormatters: null,
  autofillHints: const [AutofillHints.email],
  keyboardType: .emailAddress,
  textInputAction: .next,
  textCapitalization: .none,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  autocorrect: false,
  smartDashesType: null,
  smartQuotesType: null,
  enableSuggestions: true,
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  spellCheckConfiguration: null,
  // {@endcategory}
  // {@category "Interaction"}
  contextMenuBuilder: (context, state) => const SizedBox.shrink(),
  readOnly: false,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectAllOnFocus: null,
  selectionControls: null,
  dragStartBehavior: .start,
  groupId: EditableText,
  statesController: null,
  undoController: null,
  // {@endcategory}
  // {@category "Lines/Length"}
  scrollPhysics: null,
  scrollController: null,
  minLines: null,
  maxLines: 1,
  maxLength: null,
  maxLengthEnforcement: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  canRequestFocus: true,
  magnifierConfiguration: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onTapAlwaysCalled: false,
  onTap: () {},
  onTapOutside: (event) {},
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  // {@endcategory}
);

final textFieldMultiline = FTextField.multiline(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  label: const Text('Label'),
  hint: 'Enter text...',
  description: const Text('Description'),
  error: null,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Appearance"}
  expands: false,
  builder: (context, style, states, field) => field,
  prefixBuilder: null,
  suffixBuilder: null,
  clearable: (value) => false,
  clearIconBuilder: (context, style, clear) => const SizedBox.shrink(),
  counterBuilder: null,
  showCursor: null,
  mouseCursor: null,
  obscuringCharacter: '•',
  obscureText: false,
  // {@endcategory}
  // {@category "Text Input"}
  inputFormatters: null,
  autofillHints: null,
  keyboardType: null,
  textInputAction: null,
  textCapitalization: .sentences,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  autocorrect: true,
  smartDashesType: null,
  smartQuotesType: null,
  enableSuggestions: true,
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  spellCheckConfiguration: null,
  // {@endcategory}
  // {@category "Interaction"}
  contextMenuBuilder: (context, state) => const SizedBox.shrink(),
  readOnly: false,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectAllOnFocus: null,
  selectionControls: null,
  dragStartBehavior: .start,
  groupId: EditableText,
  statesController: null,
  undoController: null,
  // {@endcategory}
  // {@category "Lines/Length"}
  scrollPhysics: null,
  scrollController: null,
  minLines: null,
  maxLines: 1,
  maxLength: null,
  maxLengthEnforcement: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  canRequestFocus: true,
  magnifierConfiguration: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onTapAlwaysCalled: false,
  onTap: () {},
  onTapOutside: (event) {},
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  // {@endcategory}
);

final textFieldPassword = FTextField.password(
  // {@category "Core"}
  style: (style) => style,
  enabled: true,
  label: const Text('Password'),
  hint: 'Enter password...',
  description: const Text('Description'),
  error: null,
  // {@endcategory}
  // {@category "Control"}
  control: const .managed(),
  // {@endcategory}
  // {@category "Obscure Control"}
  obscureTextControl: const .managed(),
  // {@endcategory}
  // {@category "Appearance"}
  expands: false,
  builder: (context, style, states, field) => field,
  prefixBuilder: null,
  suffixBuilder: null,
  clearable: (value) => false,
  clearIconBuilder: (context, style, clear) => const SizedBox.shrink(),
  counterBuilder: null,
  showCursor: null,
  mouseCursor: null,
  obscuringCharacter: '•',
  // {@endcategory}
  // {@category "Text Input"}
  inputFormatters: null,
  autofillHints: const [AutofillHints.password],
  keyboardType: null,
  textInputAction: .next,
  textCapitalization: .none,
  textAlign: .start,
  textAlignVertical: null,
  textDirection: null,
  autocorrect: false,
  smartDashesType: null,
  smartQuotesType: null,
  enableSuggestions: false,
  restorationId: null,
  stylusHandwritingEnabled: true,
  enableIMEPersonalizedLearning: true,
  contentInsertionConfiguration: null,
  spellCheckConfiguration: null,
  // {@endcategory}
  // {@category "Interaction"}
  contextMenuBuilder: (context, state) => const SizedBox.shrink(),
  readOnly: false,
  ignorePointers: null,
  enableInteractiveSelection: true,
  selectAllOnFocus: null,
  selectionControls: null,
  dragStartBehavior: .start,
  groupId: EditableText,
  statesController: null,
  undoController: null,
  // {@endcategory}
  // {@category "Lines/Length"}
  scrollPhysics: null,
  scrollController: null,
  minLines: null,
  maxLines: 1,
  maxLength: null,
  maxLengthEnforcement: null,
  // {@endcategory}
  // {@category "Accessibility"}
  autofocus: false,
  focusNode: null,
  canRequestFocus: true,
  magnifierConfiguration: null,
  // {@endcategory}
  // {@category "Callbacks"}
  onTapAlwaysCalled: false,
  onTap: () {},
  onTapOutside: (event) {},
  onEditingComplete: () {},
  onSubmit: (value) {},
  onAppPrivateCommand: (action, data) {},
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Externally controls the text field value.
final FTextFieldControl lifted = .lifted(value: .empty, onChange: (value) {});

// {@category "Control" "`.managed()` with internal controller"}
/// Manages text field state internally.
final FTextFieldControl managedInternal = .managed(initial: .empty, onChange: (value) {});

// {@category "Control" "`.managed()` with external controller"}
/// Uses an external controller for text field management.
final FTextFieldControl managedExternal = .managed(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: TextEditingController(),
  onChange: (value) {},
);

// {@category "Obscure Control" "`.lifted()`"}
/// Externally controls the obscure text state.
final FObscureTextControl obscureLifted = .lifted(value: true, onChange: (obscured) {});

// {@category "Obscure Control" "`.managed()` with internal controller"}
/// Manages obscure text state internally.
final FObscureTextControl obscureManagedInternal = .managed(initial: true, onChange: (obscured) {});

// {@category "Obscure Control" "`.managed()` with external controller"}
/// Uses an external controller for obscure text management.
final FObscureTextControl obscureManagedExternal = .managed(
  // For demonstration purposes only. Don't create a notifier inline, store it in a State instead.
  controller: ValueNotifier<bool>(true),
  onChange: (obscured) {},
);
