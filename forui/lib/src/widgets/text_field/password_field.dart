import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';

/// A callback for building a field's icon.
///
/// [style] is the field's style.
/// [obscure] controls the visibility of the password.
/// [states] is the current states of the widget.
///
/// See [FTextField.prefixBuilder] and [FTextField.suffixBuilder].
typedef FPasswordFieldIconBuilder<T> =
    Widget Function(BuildContext context, T style, ValueNotifier<bool> obscure, Set<WidgetState> states);

@internal
class PasswordField extends StatefulWidget {
  static Widget defaultToggleBuilder(
    BuildContext context,
    FTextFieldStyle style,
    ValueNotifier<bool> obscure,
    Set<WidgetState> states,
  ) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: style.obscureButtonPadding,
      child: FButton.icon(
        style: style.obscureButtonStyle,
        onPress: () => obscure.value = !obscure.value,
        child: Icon(
          obscure.value ? FIcons.eye : FIcons.eyeClosed,
          semanticLabel: obscure.value
              ? localizations.passwordFieldUnobscureTextButtonSemanticsLabel
              : localizations.passwordFieldObscureTextButtonSemanticsLabel,
        ),
      ),
    );
  }

  final FTextFieldStyle Function(FTextFieldStyle style)? style;
  final FFieldBuilder<FTextFieldStyle> builder;
  final Widget? label;
  final String? hint;
  final Widget? description;
  final Widget? error;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final Object groupId;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final String obscuringCharacter;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? minLines;
  final int maxLines;
  final bool expands;
  final bool readOnly;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool onTapAlwaysCalled;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmit;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool? ignorePointers;
  final bool enableInteractiveSelection;
  final bool? selectAllOnFocus;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final FTextFieldCounterBuilder? counterBuilder;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String> autofillHints;
  final String? restorationId;
  final bool stylusHandwritingEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool canRequestFocus;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final FPasswordFieldIconBuilder<FTextFieldStyle>? prefixBuilder;
  final FPasswordFieldIconBuilder<FTextFieldStyle>? suffixBuilder;
  final bool Function(TextEditingValue) clearable;
  final String? initialText;
  final ValueNotifier<bool>? obscureTextController;

  const PasswordField({
    required this.style,
    required this.builder,
    required this.label,
    required this.hint,
    required this.description,
    required this.error,
    required this.magnifierConfiguration,
    required this.groupId,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    required this.textInputAction,
    required this.textCapitalization,
    required this.textAlign,
    required this.textAlignVertical,
    required this.textDirection,
    required this.autofocus,
    required this.statesController,
    required this.obscuringCharacter,
    required this.autocorrect,
    required this.smartDashesType,
    required this.smartQuotesType,
    required this.enableSuggestions,
    required this.minLines,
    required this.maxLines,
    required this.expands,
    required this.readOnly,
    required this.showCursor,
    required this.maxLength,
    required this.maxLengthEnforcement,
    required this.onChange,
    required this.onTap,
    required this.onTapOutside,
    required this.onTapAlwaysCalled,
    required this.onEditingComplete,
    required this.onSubmit,
    required this.onAppPrivateCommand,
    required this.inputFormatters,
    required this.enabled,
    required this.ignorePointers,
    required this.enableInteractiveSelection,
    required this.selectAllOnFocus,
    required this.selectionControls,
    required this.dragStartBehavior,
    required this.mouseCursor,
    required this.counterBuilder,
    required this.scrollPhysics,
    required this.scrollController,
    required this.autofillHints,
    required this.restorationId,
    required this.stylusHandwritingEnabled,
    required this.enableIMEPersonalizedLearning,
    required this.contentInsertionConfiguration,
    required this.contextMenuBuilder,
    required this.canRequestFocus,
    required this.undoController,
    required this.spellCheckConfiguration,
    required this.prefixBuilder,
    required this.suffixBuilder,
    required this.clearable,
    required this.initialText,
    required this.obscureTextController,
    super.key,
  });

  @override
  State<PasswordField> createState() => _State();

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
      ..add(StringProperty('initialText', initialText))
      ..add(DiagnosticsProperty('obscureTextController', obscureTextController));
  }
}

class _State extends State<PasswordField> {
  late ValueNotifier<bool> _controller = widget.obscureTextController ?? ValueNotifier(true);

  @override
  void didUpdateWidget(PasswordField old) {
    super.didUpdateWidget(old);
    if (widget.obscureTextController != old.obscureTextController) {
      if (old.obscureTextController == null) {
        _controller.dispose();
      }
      _controller = widget.obscureTextController ?? ValueNotifier(true);
    }
  }

  @override
  void dispose() {
    if (widget.obscureTextController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _controller,
    builder: (context, obscured, child) => FTextField(
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
      obscureText: obscured,
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
      prefixBuilder: widget.prefixBuilder == null
          ? null
          : (context, style, states) => widget.prefixBuilder!(context, style, _controller, states),
      suffixBuilder: widget.suffixBuilder == null
          ? null
          : (context, style, states) => widget.suffixBuilder!(context, style, _controller, states),
      clearable: widget.clearable,
      initialText: widget.initialText,
    ),
  );
}
