import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/text_field.dart';

/// Internal password field implementation used by [FTextField.password].
///
/// This widget wraps a regular [FTextField] and wires a visibility toggle.
/// It exposes an optional [obscureTextNotifier] ([ValueNotifier<bool>]) that
/// when non-null lets external code observe and control whether the password
/// is obscured. The controller's value mirrors [obscureText] directly
/// (true = obscured/hidden).
@internal
class PasswordField extends FTextField {
  final ValueNotifier<bool>? obscureTextNotifier;

  PasswordField({
    super.style,
    FFieldBuilder<FTextFieldStyle>? builder,
    super.label = const Text('Password'),
    super.hint,
    super.description,
    super.error,
    super.magnifierConfiguration,
    Object? groupId,
    super.controller,
    super.focusNode,
    super.keyboardType,
    super.textInputAction = TextInputAction.next,
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
    super.initialText,
    ValueNotifier<bool>? obscureText,
    super.key,
  }) : obscureTextNotifier = obscureText,
       super(
         builder: builder ?? Defaults.builder,
         groupId: groupId ?? EditableText,
         textCapitalization: textCapitalization ?? TextCapitalization.none,
         textAlign: textAlign ?? TextAlign.start,
         autofocus: autofocus ?? false,
         obscuringCharacter: obscuringCharacter ?? '•',
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
         obscureText: true,
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
  State<PasswordField> createState() => _PasswordFieldWithToggleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ValueNotifier<bool>?>('obscureTextNotifier', obscureTextNotifier));
  }
}

class _PasswordFieldWithToggleState extends State<PasswordField> {
  late ValueNotifier<bool> _obscureController;

  @override
  void initState() {
    super.initState();
    if (widget.obscureTextNotifier != null) {
      _obscureController = widget.obscureTextNotifier!;
    } else {
      // default: start obscured
      _obscureController = ValueNotifier<bool>(true);
    }
  }

  @override
  void didUpdateWidget(PasswordField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureTextNotifier != oldWidget.obscureTextNotifier) {
      if (oldWidget.obscureTextNotifier == null) {
        _obscureController.dispose();
      }

      if (widget.obscureTextNotifier != null) {
        _obscureController = widget.obscureTextNotifier!;
      } else {
        _obscureController = ValueNotifier<bool>(true);
      }
    }
  }

  @override
  void dispose() {
    if (widget.obscureTextNotifier == null) {
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
          widget.suffixBuilder == PasswordField._defaultToggleBuilder
          ? (context, style, states) => _buildToggleWidget(context, style, states, isObscured)
          : widget.suffixBuilder;

      return FTextField(
        style: widget.style,
        builder: widget.builder,
        label: widget.label,
        hint: widget.hint,
        description: widget.description,
        error: widget.error,
        magnifierConfiguration: widget.magnifierConfiguration,
        groupId: widget.groupId,
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        autofocus: widget.autofocus,
        statesController: widget.statesController,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: isObscured,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableSuggestions: widget.enableSuggestions,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        expands: widget.expands,
        readOnly: widget.readOnly,
        showCursor: widget.showCursor,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        onChange: widget.onChange,
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        onTapAlwaysCalled: widget.onTapAlwaysCalled,
        onEditingComplete: widget.onEditingComplete,
        onSubmit: widget.onSubmit,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        ignorePointers: widget.ignorePointers,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectAllOnFocus: widget.selectAllOnFocus,
        selectionControls: widget.selectionControls,
        dragStartBehavior: widget.dragStartBehavior,
        mouseCursor: widget.mouseCursor,
        counterBuilder: widget.counterBuilder,
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        autofillHints: widget.autofillHints,
        restorationId: widget.restorationId,
        stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        contextMenuBuilder: widget.contextMenuBuilder,
        canRequestFocus: widget.canRequestFocus,
        undoController: widget.undoController,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        prefixBuilder: widget.prefixBuilder,
        suffixBuilder: effectiveSuffixBuilder,
        clearable: widget.clearable,
        initialText: widget.initialText,
      );
    },
  );
}
