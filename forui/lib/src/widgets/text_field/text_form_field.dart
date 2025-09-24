import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/field.dart';
import 'package:forui/src/widgets/text_field/password_field.dart';
import 'package:forui/src/widgets/text_field/password_form_field.dart';
import 'package:forui/src/widgets/text_field/text_field.dart';

/// A text field that is wrapped is a [FormField] for convenience.
///
/// It lets the user enter text, either with a hardware keyboard or with an onscreen keyboard.
///
/// See:
/// * https://forui.dev/docs/form/text-form-field for working examples.
/// * [FTextFieldStyle] for customizing a text field's appearance.
/// * [FTextField] for creating a text field that can be used in a form.
/// * [TextField] for more details about working with a text field.
class FTextFormField extends StatelessWidget with FFormFieldProperties<String> {
  /// Creates a [FTextFormField] configured for password entry with a visibility toggle.
  ///
  /// By default, [suffixBuilder] is an eye icon that toggles showing and hiding the password. Replace the toggle by
  /// providing a custom [suffixBuilder], or disable it by setting it to `null`.
  ///
  /// The [obscureTextController] parameter is a [ValueNotifier] that controls the obscuring state.
  ///
  /// [autofillHints] defaults to [AutofillHints.password]. Use [AutofillHints.newPassword] for new-password inputs.
  static Widget password({
    FTextFieldStyle Function(FTextFieldStyle style)? style,
    FFieldBuilder<FTextFieldStyle> builder = Defaults.builder,
    Widget? label,
    String? hint,
    Widget? description,
    Widget? error,
    TextMagnifierConfiguration? magnifierConfiguration,
    Object groupId = EditableText,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction textInputAction = TextInputAction.next,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool autofocus = false,
    WidgetStatesController? statesController,
    String obscuringCharacter = '•',
    bool autocorrect = false,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = false,
    int? minLines,
    int maxLines = 1,
    bool expands = false,
    bool readOnly = false,
    bool? showCursor,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChange,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    bool onTapAlwaysCalled = false,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmit,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    bool? ignorePointers,
    bool enableInteractiveSelection = true,
    bool? selectAllOnFocus,
    TextSelectionControls? selectionControls,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    MouseCursor? mouseCursor,
    FTextFieldCounterBuilder? counterBuilder,
    ScrollPhysics? scrollPhysics,
    ScrollController? scrollController,
    Iterable<String> autofillHints = const [AutofillHints.password],
    String? restorationId,
    bool stylusHandwritingEnabled = true,
    bool enableIMEPersonalizedLearning = true,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    EditableTextContextMenuBuilder contextMenuBuilder = Defaults.contextMenuBuilder,
    bool canRequestFocus = true,
    UndoHistoryController? undoController,
    SpellCheckConfiguration? spellCheckConfiguration,
    FPasswordFieldIconBuilder<FTextFieldStyle>? prefixBuilder,
    FPasswordFieldIconBuilder<FTextFieldStyle>? suffixBuilder = PasswordField.defaultToggleBuilder,
    bool Function(TextEditingValue) clearable = Defaults.clearable,
    ValueNotifier<bool>? obscureTextController,
    FormFieldSetter<String>? onSaved,
    VoidCallback? onReset,
    FormFieldValidator<String>? validator,
    String? initialText,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? forceErrorText,
    Widget Function(BuildContext context, String message) errorBuilder = _errorBuilder,
    Key? key,
  }) => PasswordFormField(
    properties: PasswordFieldProperties(
      style: style,
      builder: builder,
      label: label,
      hint: hint,
      description: description,
      error: null,
      magnifierConfiguration: magnifierConfiguration,
      groupId: groupId,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      autofocus: autofocus,
      statesController: statesController,
      obscuringCharacter: obscuringCharacter,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      readOnly: readOnly,
      showCursor: showCursor,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChange: onChange,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onEditingComplete: onEditingComplete,
      onSubmit: onSubmit,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      enabled: enabled,
      ignorePointers: ignorePointers,
      enableInteractiveSelection: enableInteractiveSelection,
      selectAllOnFocus: selectAllOnFocus,
      selectionControls: selectionControls,
      dragStartBehavior: dragStartBehavior,
      mouseCursor: mouseCursor,
      counterBuilder: counterBuilder,
      scrollPhysics: scrollPhysics,
      scrollController: scrollController,
      autofillHints: autofillHints,
      restorationId: restorationId,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contentInsertionConfiguration: contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      undoController: undoController,
      spellCheckConfiguration: spellCheckConfiguration,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      clearable: clearable,
      initialText: initialText,
      obscureTextController: obscureTextController,
    ),
    onSaved: onSaved,
    onReset: onReset,
    validator: validator,
    autovalidateMode: autovalidateMode,
    forceErrorText: forceErrorText,
    errorBuilder: errorBuilder,
    key: key,
  );

  static Widget _errorBuilder(BuildContext _, String text) => Text(text);

  /// {@macro forui.text_field.style}
  final FTextFieldStyle Function(FTextFieldStyle style)? style;

  /// {@macro forui.text_field.builder}
  final Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> states, Widget field) builder;

  /// {@macro forui.text_field.label}
  @override
  final Widget? label;

  /// {@macro forui.text_field.hint}
  final String? hint;

  /// {@macro forui.text_field.description}
  @override
  final Widget? description;

  /// {@macro forui.text_field.magnifier_configuration}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@macro forui.text_field_groupId}
  final Object groupId;

  /// {@macro forui.text_field.controller}
  final TextEditingController? controller;

  /// {@macro forui.text_field.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro forui.text_field.textInputAction}
  final TextInputAction? textInputAction;

  /// {@macro forui.text_field.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro forui.text_field.textAlign}
  final TextAlign textAlign;

  /// {@macro forui.text_field.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// {@macro forui.text_field.textDirection}
  final TextDirection? textDirection;

  /// {@macro forui.text_field.autofocus}
  final bool autofocus;

  /// {@macro forui.text_field.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.text_field.statesController}
  final WidgetStatesController? statesController;

  /// {@macro forui.text_field.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro forui.text_field.obscureText}
  final bool obscureText;

  /// {@macro forui.text_field.autocorrect}
  final bool autocorrect;

  /// {@macro forui.text_field.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro forui.text_field.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro forui.text_field.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro forui.text_field.minLines}
  final int? minLines;

  /// {@macro forui.text_field.maxLines}
  final int? maxLines;

  /// {@macro forui.text_field.expands}
  final bool expands;

  /// {@macro forui.text_field.readOnly}
  final bool readOnly;

  /// {@macro forui.text_field.showCursor}
  final bool? showCursor;

  /// {@macro forui.text_field.maxLength}
  final int? maxLength;

  /// {@macro forui.text_field.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@macro forui.text_field.onChange}
  final ValueChanged<String>? onChange;

  /// {@macro forui.text_field.onTap}
  final GestureTapCallback? onTap;

  /// {@macro forui.text_field.onTapAlwaysCalled}
  final TapRegionCallback? onTapOutside;

  /// {@macro forui.text_field.onTap}
  final bool onTapAlwaysCalled;

  /// {@macro forui.text_field.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro forui.text_field.onSubmit}
  final ValueChanged<String>? onSubmit;

  /// {@macro forui.text_field.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro forui.text_field.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro forui.text_field.enabled}
  @override
  final bool enabled;

  /// {@macro forui.text_field.ignorePointers}
  final bool? ignorePointers;

  /// {@macro forui.text_field.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro forui.text_field.selectAllOnFocus}
  final bool? selectAllOnFocus;

  /// {@macro forui.text_field.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro forui.text_field.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.text_field.mouseCursor}
  final MouseCursor? mouseCursor;

  /// {@macro forui.text_field.counterBuilder}
  final FTextFieldCounterBuilder? counterBuilder;

  /// {@macro forui.text_field.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro forui.text_field.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.text_field.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro forui.text_field.restorationId}
  final String? restorationId;

  /// {@macro forui.text_field.stylusHandwritingEnabled}
  final bool stylusHandwritingEnabled;

  /// {@macro forui.text_field.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro forui.text_field.contentInsertionConfiguration}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@macro forui.text_field.contextMenuBuilder}
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// {@macro forui.text_field.canRequestFocus}
  final bool canRequestFocus;

  /// {@macro forui.text_field.undoController}
  final UndoHistoryController? undoController;

  /// {@macro forui.text_field.spellCheckConfiguration}
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// {@macro forui.text_field.prefixBuilder}
  final Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> states)? prefixBuilder;

  /// {@macro forui.text_field.suffixBuilder}
  final Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> states)? suffixBuilder;

  /// {@macro forui.text_field.clearable}
  final bool Function(TextEditingValue) clearable;

  @override
  final FormFieldSetter<String>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final FormFieldValidator<String>? validator;

  /// {@macro forui.text_field.initialValue}
  final String? initialText;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// Creates a [FTextFormField].
  const FTextFormField({
    this.style,
    this.builder = Defaults.builder,
    this.label,
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectAllOnFocus,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = Defaults.contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = Defaults.clearable,
    this.onSaved,
    this.onReset,
    this.validator,
    this.initialText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    super.key,
  });

  /// Creates a [FTextFormField] configured for emails.
  const FTextFormField.email({
    this.style,
    this.builder = Defaults.builder,
    this.label = const Text('Email'),
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = false,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectAllOnFocus,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.email],
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = Defaults.contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = Defaults.clearable,
    this.onSaved,
    this.onReset,
    this.validator,
    this.initialText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    super.key,
  });

  /// Creates a [FTextFormField] configured for multiline inputs.
  ///
  /// The text field's height can be configured by adjusting [minLines]. By default, the text field will expand every
  /// time a new line is added. To limit the maximum height of the text field and make it scrollable, consider setting
  /// [maxLines].
  const FTextFormField.multiline({
    this.style,
    this.builder = Defaults.builder,
    this.label,
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines = 4,
    this.maxLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onTap,
    this.onTapOutside,
    this.onTapAlwaysCalled = false,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractiveSelection = true,
    this.selectAllOnFocus,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder = Defaults.contextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    this.clearable = Defaults.clearable,
    this.onSaved,
    this.onReset,
    this.validator,
    this.initialText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Field(
    controller: controller,
    onSaved: onSaved,
    onReset: onReset,
    validator: validator,
    initialValue: controller?.text ?? initialText,
    enabled: enabled,
    autovalidateMode: autovalidateMode,
    forceErrorText: forceErrorText,
    restorationId: restorationId,
    builder: (state) => FTextField(
      style: style,
      builder: builder,
      label: label,
      hint: hint,
      description: description,
      error: switch (state.errorText) {
        null => null,
        final error => errorBuilder(state.context, error),
      },
      magnifierConfiguration: magnifierConfiguration,
      groupId: groupId,
      controller: state.effectiveController,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      autofocus: autofocus,
      statesController: statesController,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      readOnly: readOnly,
      showCursor: showCursor,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChange: (value) {
        state.didChange(value);
        onChange?.call(value);
      },
      onTap: onTap,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onEditingComplete: onEditingComplete,
      onSubmit: onSubmit,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      enabled: enabled,
      ignorePointers: ignorePointers,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      selectAllOnFocus: selectAllOnFocus,
      dragStartBehavior: dragStartBehavior,
      mouseCursor: mouseCursor,
      counterBuilder: counterBuilder,
      scrollPhysics: scrollPhysics,
      scrollController: scrollController,
      autofillHints: autofillHints,
      restorationId: restorationId,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contentInsertionConfiguration: contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      undoController: undoController,
      spellCheckConfiguration: spellCheckConfiguration,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      clearable: clearable,
      key: key,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('keyboardType', keyboardType))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textCapitalization', textCapitalization))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('statesController', statesController))
      ..add(StringProperty('obscuringCharacter', obscuringCharacter, defaultValue: '•'))
      ..add(FlagProperty('obscureText', value: obscureText, ifTrue: 'obscureText'))
      ..add(FlagProperty('autocorrect', value: autocorrect, ifTrue: 'autocorrect'))
      ..add(EnumProperty('smartDashesType', smartDashesType))
      ..add(EnumProperty('smartQuotesType', smartQuotesType))
      ..add(FlagProperty('enableSuggestions', value: enableSuggestions, ifTrue: 'enableSuggestions'))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLines', maxLines))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(FlagProperty('showCursor', value: showCursor, ifTrue: 'showCursor'))
      ..add(IntProperty('maxLength', maxLength))
      ..add(EnumProperty('maxLengthEnforcement', maxLengthEnforcement))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(ObjectFlagProperty.has('onTapOutside', onTapOutside))
      ..add(FlagProperty('onTapAlwaysCalled', value: onTapAlwaysCalled, ifTrue: 'onTapAlwaysCalled'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(ObjectFlagProperty.has('onAppPrivateCommand', onAppPrivateCommand))
      ..add(IterableProperty('inputFormatters', inputFormatters))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('ignorePointers', value: ignorePointers, ifTrue: 'ignorePointers'))
      ..add(
        FlagProperty('enableInteractSelection', value: enableInteractiveSelection, ifTrue: 'enableInteractSelection'),
      )
      ..add(FlagProperty('selectAllOnFocus', value: selectAllOnFocus, ifTrue: 'selectAllOnFocus'))
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(ObjectFlagProperty.has('buildCounter', counterBuilder))
      ..add(DiagnosticsProperty('scrollPhysics', scrollPhysics))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(IterableProperty('autofillHints', autofillHints))
      ..add(StringProperty('restorationId', restorationId))
      ..add(
        FlagProperty('stylusHandwritingEnabled', value: stylusHandwritingEnabled, ifTrue: 'stylusHandwritingEnabled'),
      )
      ..add(
        FlagProperty(
          'enableIMEPersonalizedLearning',
          value: enableIMEPersonalizedLearning,
          ifTrue: 'enableIMEPersonalizedLearning',
        ),
      )
      ..add(DiagnosticsProperty('contentInsertionConfiguration', contentInsertionConfiguration))
      ..add(ObjectFlagProperty.has('contextMenuBuilder', contextMenuBuilder))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('undoController', undoController))
      ..add(DiagnosticsProperty('spellCheckConfiguration', spellCheckConfiguration))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('clearable', clearable))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(StringProperty('initialText', initialText))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}
