import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/field.dart';
import 'package:forui/src/widgets/text_field/password_field.dart';

/// Internal password form field implementation used by [FTextFormField.password].
@internal
class PasswordFormField extends StatelessWidget with FFormFieldProperties<String> {
  final PasswordFieldProperties properties;

  @override
  final FormFieldSetter<String>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final FormFieldValidator<String>? validator;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  PasswordFormField({
    required this.properties,
    required this.onSaved,
    required this.onReset,
    required this.validator,
    required this.autovalidateMode,
    required this.forceErrorText,
    required this.errorBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Field(
    controller: properties.controller,
    onSaved: onSaved,
    onReset: onReset,
    validator: validator,
    initialValue: properties.controller?.text ?? properties.initialText,
    enabled: enabled,
    autovalidateMode: autovalidateMode,
    forceErrorText: forceErrorText,
    restorationId: properties.restorationId,
    builder: (state) => PasswordField(
      properties: PasswordFieldProperties(
        style: properties.style,
        builder: properties.builder,
        label: properties.label,
        hint: properties.hint,
        description: properties.description,
        error: switch (state.errorText) {
          null => null,
          final error => errorBuilder(state.context, error),
        },
        magnifierConfiguration: properties.magnifierConfiguration,
        groupId: properties.groupId,
        controller: state.effectiveController,
        initialText: null,
        // We set this to null to avoid conflicts with controller.
        focusNode: properties.focusNode,
        keyboardType: properties.keyboardType,
        textInputAction: properties.textInputAction,
        textCapitalization: properties.textCapitalization,
        textAlign: properties.textAlign,
        textAlignVertical: properties.textAlignVertical,
        textDirection: properties.textDirection,
        autofocus: properties.autofocus,
        statesController: properties.statesController,
        obscuringCharacter: properties.obscuringCharacter,
        autocorrect: properties.autocorrect,
        smartDashesType: properties.smartDashesType,
        smartQuotesType: properties.smartQuotesType,
        enableSuggestions: properties.enableSuggestions,
        minLines: properties.minLines,
        maxLines: properties.maxLines,
        expands: properties.expands,
        readOnly: properties.readOnly,
        showCursor: properties.showCursor,
        maxLength: properties.maxLength,
        maxLengthEnforcement: properties.maxLengthEnforcement,
        onChange: (value) {
          state.didChange(value);
          properties.onChange?.call(value);
        },
        onTap: properties.onTap,
        onTapOutside: properties.onTapOutside,
        onTapAlwaysCalled: properties.onTapAlwaysCalled,
        onEditingComplete: properties.onEditingComplete,
        onSubmit: properties.onSubmit,
        onAppPrivateCommand: properties.onAppPrivateCommand,
        inputFormatters: properties.inputFormatters,
        enabled: properties.enabled,
        ignorePointers: properties.ignorePointers,
        enableInteractiveSelection: properties.enableInteractiveSelection,
        selectAllOnFocus: properties.selectAllOnFocus,
        selectionControls: properties.selectionControls,
        dragStartBehavior: properties.dragStartBehavior,
        mouseCursor: properties.mouseCursor,
        counterBuilder: properties.counterBuilder,
        scrollPhysics: properties.scrollPhysics,
        scrollController: properties.scrollController,
        autofillHints: properties.autofillHints,
        restorationId: properties.restorationId,
        stylusHandwritingEnabled: properties.stylusHandwritingEnabled,
        enableIMEPersonalizedLearning: properties.enableIMEPersonalizedLearning,
        contentInsertionConfiguration: properties.contentInsertionConfiguration,
        contextMenuBuilder: properties.contextMenuBuilder,
        canRequestFocus: properties.canRequestFocus,
        undoController: properties.undoController,
        spellCheckConfiguration: properties.spellCheckConfiguration,
        prefixBuilder: properties.prefixBuilder,
        suffixBuilder: properties.suffixBuilder,
        clearable: properties.clearable,
        obscureTextController: properties.obscureTextController,
      ),
      key: key,
    ),
  );

  @override
  Widget? get label => properties.label;

  @override
  Widget? get description => properties.description;

  @override
  bool get enabled => properties.enabled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('properties', properties));
  }
}
