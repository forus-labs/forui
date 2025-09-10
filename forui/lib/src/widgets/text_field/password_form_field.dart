import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/text_field.dart';

/// Internal password form field implementation used by [FTextFormField.password].
///
/// This widget wraps a regular [FTextFormField] and wires a visibility toggle.
/// It exposes an optional [obscureTextNotifier] ([ValueNotifier<bool>]) that
/// when non-null lets external code observe and control whether the password
/// is obscured. The controller's value mirrors [obscureText] directly
/// (true = obscured/hidden).
@internal
class PasswordFormField extends FTextFormField {
  static Widget _defaultErrorBuilder(BuildContext _, String text) => Text(text);

  final ValueNotifier<bool>? obscureTextNotifier;

  PasswordFormField({
    super.style,
    Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> states, Widget field)? builder,
    // TODO: Localize
    super.label = const Text('Password'),
    super.hint,
    super.description,
    super.magnifierConfiguration,
    Object? groupId,
    super.controller,
    super.focusNode,
    super.keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    TextAlign? textAlign,
    super.textAlignVertical,
    super.textDirection,
    bool? autofocus,
    super.statesController,
    String? obscuringCharacter,
    bool? autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    bool? enableSuggestions,
    super.minLines,
    int? maxLines,
    bool? expands,
    bool? readOnly,
    super.showCursor,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChange,
    super.onTap,
    super.onTapOutside,
    bool? onTapAlwaysCalled,
    super.onEditingComplete,
    super.onSubmit,
    super.onAppPrivateCommand,
    super.inputFormatters,
    bool? enabled,
    super.ignorePointers,
    bool? enableInteractiveSelection,
    super.selectAllOnFocus,
    super.selectionControls,
    DragStartBehavior? dragStartBehavior,
    super.mouseCursor,
    super.counterBuilder,
    super.scrollPhysics,
    super.scrollController,
    Iterable<String>? autofillHints,
    super.restorationId,
    bool? stylusHandwritingEnabled,
    bool? enableIMEPersonalizedLearning,
    super.contentInsertionConfiguration,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    bool? canRequestFocus,
    super.undoController,
    super.spellCheckConfiguration,
    super.prefixBuilder,
    super.suffixBuilder = _defaultToggleBuilder,
    bool Function(TextEditingValue)? clearable,
    super.onSaved,
    super.validator,
    super.initialText,
    AutovalidateMode? autovalidateMode,
    super.forceErrorText,
    Widget Function(BuildContext context, String message)? errorBuilder,
    ValueNotifier<bool>? obscureText,
    super.key,
  }) : obscureTextNotifier = obscureText,
       super(
         builder: builder ?? Defaults.builder,
         groupId: groupId ?? EditableText,
         textInputAction: textInputAction ?? TextInputAction.next,
         textCapitalization: textCapitalization ?? TextCapitalization.none,
         textAlign: textAlign ?? TextAlign.start,
         autofocus: autofocus ?? false,
         obscuringCharacter: obscuringCharacter ?? '•',
         obscureText: true,
         autocorrect: autocorrect ?? false,
         enableSuggestions: enableSuggestions ?? false,
         maxLines: maxLines ?? 1,
         expands: expands ?? false,
         readOnly: readOnly ?? false,
         onTapAlwaysCalled: onTapAlwaysCalled ?? false,
         enabled: enabled ?? true,
         enableInteractiveSelection: enableInteractiveSelection ?? true,
         dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
         autofillHints: autofillHints ?? const [AutofillHints.password],
         stylusHandwritingEnabled: stylusHandwritingEnabled ?? true,
         enableIMEPersonalizedLearning: enableIMEPersonalizedLearning ?? true,
         contextMenuBuilder: contextMenuBuilder ?? Defaults.contextMenuBuilder,
         canRequestFocus: canRequestFocus ?? true,
         clearable: clearable ?? Defaults.clearable,
         autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
         errorBuilder: errorBuilder ?? _defaultErrorBuilder,
       );

  // Default toggle builder for password visibility
  static Widget _defaultToggleBuilder(BuildContext context, FTextFieldStyle style, Set<WidgetState> states) {
    // This should not be called directly since it requires a controller
    throw StateError(
      'Default toggle builder should not be called without an obscureTextController. '
      'This is an internal implementation error.',
    );
  }

  @override
  Widget build(BuildContext context) => _PasswordFormFieldWithToggleState(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ValueNotifier<bool>?>('obscureTextNotifier', obscureTextNotifier));
  }
}

/// State widget for the password form field with toggle functionality
class _PasswordFormFieldWithToggleState extends StatefulWidget {
  final PasswordFormField field;

  const _PasswordFormFieldWithToggleState(this.field);

  @override
  State<_PasswordFormFieldWithToggleState> createState() => _PasswordFormFieldWithToggleStateImpl();
}

class _PasswordFormFieldWithToggleStateImpl extends State<_PasswordFormFieldWithToggleState> {
  late ValueNotifier<bool> _obscureController;

  @override
  void initState() {
    super.initState();
    if (widget.field.obscureTextNotifier != null) {
      _obscureController = widget.field.obscureTextNotifier!;
    } else {
      // default: start obscured
      _obscureController = ValueNotifier<bool>(true);
    }
  }

  @override
  void didUpdateWidget(_PasswordFormFieldWithToggleState oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.field.obscureTextNotifier != oldWidget.field.obscureTextNotifier) {
      if (oldWidget.field.obscureTextNotifier == null) {
        _obscureController.dispose();
      }

      if (widget.field.obscureTextNotifier != null) {
        _obscureController = widget.field.obscureTextNotifier!;
      } else {
        _obscureController = ValueNotifier<bool>(true);
      }
    }
  }

  @override
  void dispose() {
    if (widget.field.obscureTextNotifier == null) {
      _obscureController.dispose();
    }
    super.dispose();
  }

  Widget _buildToggleWidget(BuildContext context, FTextFieldStyle style, Set<WidgetState> states, bool isObscured) {
    final icon = isObscured ? FIcons.eye : FIcons.eyeOff;

    return FButton.icon(
      onPress: () => _obscureController.value = !_obscureController.value,
      style: FButtonStyle.ghost(),
      // TODO: localize the semantic label
      child: Icon(icon, semanticLabel: isObscured ? 'Show password' : 'Hide password'),
    );
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
    valueListenable: _obscureController,
    builder: (context, isObscured, child) {
      final FFieldIconBuilder<FTextFieldStyle>? effectiveSuffixBuilder =
          widget.field.suffixBuilder == PasswordFormField._defaultToggleBuilder
          ? (context, style, states) => _buildToggleWidget(context, style, states, isObscured)
          : widget.field.suffixBuilder;

      return FTextFormField(
        style: widget.field.style,
        builder: widget.field.builder,
        label: widget.field.label,
        hint: widget.field.hint,
        description: widget.field.description,
        magnifierConfiguration: widget.field.magnifierConfiguration,
        groupId: widget.field.groupId,
        controller: widget.field.controller,
        focusNode: widget.field.focusNode,
        keyboardType: widget.field.keyboardType,
        textInputAction: widget.field.textInputAction,
        textCapitalization: widget.field.textCapitalization,
        textAlign: widget.field.textAlign,
        textAlignVertical: widget.field.textAlignVertical,
        textDirection: widget.field.textDirection,
        autofocus: widget.field.autofocus,
        statesController: widget.field.statesController,
        obscuringCharacter: widget.field.obscuringCharacter,
        obscureText: isObscured,
        autocorrect: widget.field.autocorrect,
        smartDashesType: widget.field.smartDashesType,
        smartQuotesType: widget.field.smartQuotesType,
        enableSuggestions: widget.field.enableSuggestions,
        minLines: widget.field.minLines,
        maxLines: widget.field.maxLines,
        expands: widget.field.expands,
        readOnly: widget.field.readOnly,
        showCursor: widget.field.showCursor,
        maxLength: widget.field.maxLength,
        maxLengthEnforcement: widget.field.maxLengthEnforcement,
        onChange: widget.field.onChange,
        onTap: widget.field.onTap,
        onTapOutside: widget.field.onTapOutside,
        onTapAlwaysCalled: widget.field.onTapAlwaysCalled,
        onEditingComplete: widget.field.onEditingComplete,
        onSubmit: widget.field.onSubmit,
        onAppPrivateCommand: widget.field.onAppPrivateCommand,
        inputFormatters: widget.field.inputFormatters,
        enabled: widget.field.enabled,
        ignorePointers: widget.field.ignorePointers,
        enableInteractiveSelection: widget.field.enableInteractiveSelection,
        selectAllOnFocus: widget.field.selectAllOnFocus,
        selectionControls: widget.field.selectionControls,
        dragStartBehavior: widget.field.dragStartBehavior,
        mouseCursor: widget.field.mouseCursor,
        counterBuilder: widget.field.counterBuilder,
        scrollPhysics: widget.field.scrollPhysics,
        scrollController: widget.field.scrollController,
        autofillHints: widget.field.autofillHints,
        restorationId: widget.field.restorationId,
        stylusHandwritingEnabled: widget.field.stylusHandwritingEnabled,
        enableIMEPersonalizedLearning: widget.field.enableIMEPersonalizedLearning,
        contentInsertionConfiguration: widget.field.contentInsertionConfiguration,
        contextMenuBuilder: widget.field.contextMenuBuilder,
        canRequestFocus: widget.field.canRequestFocus,
        undoController: widget.field.undoController,
        spellCheckConfiguration: widget.field.spellCheckConfiguration,
        prefixBuilder: widget.field.prefixBuilder,
        suffixBuilder: effectiveSuffixBuilder,
        clearable: widget.field.clearable,
        onSaved: widget.field.onSaved,
        validator: widget.field.validator,
        initialText: widget.field.initialText,
        autovalidateMode: widget.field.autovalidateMode,
        forceErrorText: widget.field.forceErrorText,
        errorBuilder: widget.field.errorBuilder,
      );
    },
  );
}
