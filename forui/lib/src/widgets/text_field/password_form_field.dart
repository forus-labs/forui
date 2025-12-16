import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/input/form_input.dart';
import 'package:forui/src/widgets/text_field/password_field.dart';
import 'package:forui/src/widgets/text_field/text_field_control.dart';

/// Internal password form field implementation used by [FTextFormField.password].
@internal
class PasswordFormField extends StatelessWidget with FFormFieldProperties<String> {
  final FTextFieldControl control;

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
    required this.control,
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
  Widget build(BuildContext context) => TextFieldControl(
    key: key,
    control: control,
    builder: (context, controller, _) => FormInput(
      controller: controller,
      onSaved: onSaved,
      onReset: onReset,
      validator: validator,
      initialValue: controller.text,
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      restorationId: properties.restorationId,
      builder: (state) => PasswordField(
        controller: controller,
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
          clearIconBuilder: properties.clearIconBuilder,
          obscureTextControl: properties.obscureTextControl,
        ),
      ),
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
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('properties', properties));
  }
}
