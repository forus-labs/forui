import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'text_field_mixin.dart';
part 'text_field_style.dart';

/// A text field.
///
/// It lets the user enter text, either with hardware keyboard or with an onscreen keyboard. A [FTextField] is internally
/// a [FormField].
///
/// See:
/// * https://forui.dev/docs/text-field for working examples.
/// * [FTextFieldStyle] for customizing a text field's appearance.
/// * [FTextFormField] for a text field that integrates with a [Form].
/// * [TextField] for more details about working with a text field.
final class FTextField extends StatelessWidget with FTextFieldMixin {
  @override
  final FTextFieldStyle? style;

  @override
  final Widget? label;

  @override
  final String? hint;

  @override
  final Widget? help;

  @override
  final Widget? error;

  @override
  final TextMagnifierConfiguration? magnifierConfiguration;

  @override
  final TextEditingController? controller;

  @override
  final FocusNode? focusNode;

  @override
  final TextInputType? keyboardType;

  @override
  final TextInputAction? textInputAction;

  @override
  final TextCapitalization textCapitalization;

  @override
  final TextAlign textAlign;

  @override
  final TextAlignVertical? textAlignVertical;

  @override
  final TextDirection? textDirection;

  @override
  final bool autofocus;

  @override
  final WidgetStatesController? statesController;

  @override
  final bool obscureText;

  @override
  final bool autocorrect;

  @override
  final SmartDashesType? smartDashesType;

  @override
  final SmartQuotesType? smartQuotesType;

  @override
  final bool enableSuggestions;

  @override
  final int? minLines;

  @override
  final int? maxLines;

  @override
  final bool expands;

  @override
  final bool readOnly;

  @override
  final bool? showCursor;

  @override
  final int? maxLength;

  @override
  final MaxLengthEnforcement? maxLengthEnforcement;

  @override
  final ValueChanged<String>? onChange;

  @override
  final VoidCallback? onEditingComplete;

  @override
  final ValueChanged<String>? onSubmit;

  @override
  final AppPrivateCommandCallback? onAppPrivateCommand;

  @override
  final List<TextInputFormatter>? inputFormatters;

  @override
  final bool enabled;

  @override
  final bool? ignorePointers;

  @override
  final bool enableInteractSelection;

  @override
  final TextSelectionControls? selectionControls;

  @override
  final DragStartBehavior dragStartBehavior;

  @override
  final ScrollPhysics? scrollPhysics;

  @override
  final ScrollController? scrollController;

  @override
  final Iterable<String>? autofillHints;

  @override
  final String? restorationId;

  @override
  final bool scribbleEnabled;

  @override
  final bool enableIMEPersonalizedLearning;

  @override
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  @override
  final bool canRequestFocus;

  @override
  final UndoHistoryController? undoController;

  @override
  final SpellCheckConfiguration? spellCheckConfiguration;

  @override
  final Widget? suffixIcon;

  /// Creates a [FTextField].
  const FTextField({
    this.style,
    this.label,
    this.hint,
    this.help,
    this.error,
    this.magnifierConfiguration,
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
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChange,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.suffixIcon,
    super.key,
  });

  /// Creates a [FTextField] configured for emails.
  const FTextField.email({
    this.style,
    this.label,
    this.hint = 'Email',
    this.help,
    this.error,
    this.magnifierConfiguration,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
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
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.email],
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.suffixIcon,
    super.key,
  });

  /// Creates a [FTextField] configured for passwords.
  ///
  /// [autofillHints] defaults to [AutofillHints.password]. It should be overridden with [AutofillHints.newPassword]
  /// when handling the creation of new passwords.
  const FTextField.password({
    this.style,
    this.label,
    this.hint = 'Password',
    this.help,
    this.error,
    this.magnifierConfiguration,
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
    this.obscureText = true,
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
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.password],
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.suffixIcon,
    super.key,
  });

  /// Creates a [FTextField] configured for multiline inputs.
  ///
  /// The text field's height can be configured by adjusting [minLines]. By default, the text field will expand every
  /// time a new line is added. To limit the maximum height of the text field and make it scrollable, consider setting
  /// [maxLines].
  const FTextField.multiline({
    this.style,
    this.label,
    this.hint,
    this.help,
    this.error,
    this.magnifierConfiguration,
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
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final typography = theme.typography;
    final style = this.style ?? theme.textFieldStyle;
    final stateStyle = switch (this) {
      _ when !enabled => style.disabled,
      _ when error != null => style.error,
      _ => style.enabled,
    };

    final textField = MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 7),
              child: DefaultTextStyle.merge(
                style: stateStyle.labelTextStyle,
                child: label!,
              ),
            ),
          Material(
            color: Colors.transparent,
            child: Theme(
              // The selection colors are defined in a Theme instead of TextField since TextField does not expose parameters
              // for overriding selectionHandleColor.
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: style.cursorColor,
                  selectionColor: style.cursorColor.withOpacity(0.4),
                  selectionHandleColor: style.cursorColor,
                ),
                cupertinoOverrideTheme: CupertinoThemeData(
                  primaryColor: style.cursorColor,
                ),
              ),
              child: _textField(context, typography, style, stateStyle),
            ),
          ),
        ],
      ),
    );

    final materialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    return materialLocalizations == null
        ? Localizations(
            locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
            delegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            child: textField,
          )
        : textField;
  }

  Widget _textField(
    BuildContext context,
    FTypography typography,
    FTextFieldStyle style,
    FTextFieldStateStyle current,
  ) {
    final rawError = this.error == null
        ? null
        : DefaultTextStyle.merge(
            style: current.footerTextStyle,
            child: this.error!,
          );

    final rawHelp = this.help == null
        ? null
        : DefaultTextStyle.merge(
            style: current.footerTextStyle,
            child: this.help!,
          );

    return TextField(
      controller: controller,
      focusNode: focusNode,
      undoController: undoController,
      cursorErrorColor: style.cursorColor,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        // See https://stackoverflow.com/questions/70771410/flutter-how-can-i-remove-the-content-padding-for-error-in-textformfield
        prefix: Padding(padding: EdgeInsets.only(left: style.contentPadding.left)),
        contentPadding: style.contentPadding.copyWith(left: 0),
        hintText: hint,
        hintStyle: current.hintTextStyle,
        helper: rawHelp,
        helperStyle: current.footerTextStyle,
        error: rawError,
        errorStyle: current.footerTextStyle,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: style.disabled.unfocused.color,
            width: style.disabled.unfocused.width,
          ),
          borderRadius: style.disabled.unfocused.radius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: style.enabled.unfocused.color,
            width: style.enabled.unfocused.width,
          ),
          borderRadius: style.enabled.unfocused.radius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: style.enabled.focused.color,
            width: style.enabled.focused.width,
          ),
          borderRadius: current.focused.radius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: style.error.unfocused.color,
            width: style.error.unfocused.width,
          ),
          borderRadius: style.error.unfocused.radius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: style.error.focused.color,
            width: style.error.focused.width,
          ),
          borderRadius: style.error.focused.radius,
        ),
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: current.contentTextStyle,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      readOnly: readOnly,
      showCursor: showCursor,
      autofocus: autofocus,
      statesController: statesController,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: onChange,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmit,
      onAppPrivateCommand: onAppPrivateCommand,
      inputFormatters: inputFormatters,
      enabled: enabled,
      ignorePointers: ignorePointers,
      keyboardAppearance: style.keyboardAppearance,
      scrollPadding: style.scrollPadding,
      dragStartBehavior: dragStartBehavior,
      selectionControls: selectionControls,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      restorationId: restorationId,
      scribbleEnabled: scribbleEnabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
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
      ..add(DiagnosticsProperty('onChange', onChange))
      ..add(DiagnosticsProperty('onEditingComplete', onEditingComplete))
      ..add(DiagnosticsProperty('onSubmit', onSubmit))
      ..add(DiagnosticsProperty('onAppPrivateCommand', onAppPrivateCommand))
      ..add(IterableProperty('inputFormatters', inputFormatters))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('ignorePointers', value: ignorePointers, ifTrue: 'ignorePointers'))
      ..add(FlagProperty('enableInteractSelection', value: enableInteractSelection, ifTrue: 'enableInteractSelection'))
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('scrollPhysics', scrollPhysics))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(IterableProperty('autofillHints', autofillHints))
      ..add(StringProperty('restorationId', restorationId))
      ..add(FlagProperty('scribbleEnabled', value: scribbleEnabled, ifTrue: 'scribbleEnabled'))
      ..add(
        FlagProperty(
          'enableIMEPersonalizedLearning',
          value: enableIMEPersonalizedLearning,
          ifTrue: 'enableIMEPersonalizedLearning',
        ),
      )
      ..add(DiagnosticsProperty('contextMenuBuilder', contextMenuBuilder))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('undoController', undoController))
      ..add(DiagnosticsProperty('spellCheckConfiguration', spellCheckConfiguration))
      ..add(DiagnosticsProperty('suffixIcon', suffixIcon));
  }
}
