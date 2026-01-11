import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/text_field/input/input.dart';
import 'package:forui/src/widgets/text_field/obscure_text_control.dart';

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
class PasswordFieldProperties with Diagnosticable {
  final FTextFieldStyle Function(FTextFieldStyle style)? style;
  final FFieldBuilder<FTextFieldStyle> builder;
  final Widget? label;
  final String? hint;
  final Widget? description;
  final Widget? error;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final Object groupId;
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
  final FFieldClearIconBuilder clearIconBuilder;
  final FObscureTextControl obscureTextControl;

  PasswordFieldProperties({
    required this.style,
    required this.builder,
    required this.label,
    required this.hint,
    required this.description,
    required this.error,
    required this.magnifierConfiguration,
    required this.groupId,
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
    required this.clearIconBuilder,
    required this.obscureTextControl,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty('magnifierConfiguration', magnifierConfiguration))
      ..add(DiagnosticsProperty('groupId', groupId))
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
      ..add(ObjectFlagProperty.has('clearIconBuilder', clearIconBuilder))
      ..add(DiagnosticsProperty('obscureTextControl', obscureTextControl));
  }
}

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
        onPress: states.contains(WidgetState.disabled) ? null : () => obscure.value = !obscure.value,
        child: Icon(
          obscure.value ? FIcons.eye : FIcons.eyeClosed,
          semanticLabel: obscure.value
              ? localizations.passwordFieldUnobscureTextButtonSemanticsLabel
              : localizations.passwordFieldObscureTextButtonSemanticsLabel,
        ),
      ),
    );
  }

  final TextEditingController controller;
  final PasswordFieldProperties properties;

  const PasswordField({required this.controller, required this.properties, super.key});

  @override
  State<PasswordField> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('properties', this.properties));
  }
}

class _State extends State<PasswordField> {
  late ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.properties.obscureTextControl.create(_handleOnChange);
  }

  @override
  void didUpdateWidget(PasswordField old) {
    super.didUpdateWidget(old);
    _controller = widget.properties.obscureTextControl
        .update(old.properties.obscureTextControl, _controller, _handleOnChange)
        .$1;
  }

  @override
  void dispose() {
    widget.properties.obscureTextControl.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.properties.obscureTextControl case FObscureTextManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _controller,
    builder: (context, obscured, child) => Input(
      controller: widget.controller,
      style: widget.properties.style,
      builder: widget.properties.builder,
      label: widget.properties.label,
      hint: widget.properties.hint,
      description: widget.properties.description,
      error: widget.properties.error,
      magnifierConfiguration: widget.properties.magnifierConfiguration,
      groupId: widget.properties.groupId,
      focusNode: widget.properties.focusNode,
      keyboardType: widget.properties.keyboardType,
      textInputAction: widget.properties.textInputAction,
      textCapitalization: widget.properties.textCapitalization,
      textAlign: widget.properties.textAlign,
      textAlignVertical: widget.properties.textAlignVertical,
      textDirection: widget.properties.textDirection,
      autofocus: widget.properties.autofocus,
      statesController: widget.properties.statesController,
      obscuringCharacter: widget.properties.obscuringCharacter,
      obscureText: obscured,
      autocorrect: widget.properties.autocorrect,
      smartDashesType: widget.properties.smartDashesType,
      smartQuotesType: widget.properties.smartQuotesType,
      enableSuggestions: widget.properties.enableSuggestions,
      minLines: widget.properties.minLines,
      maxLines: widget.properties.maxLines,
      expands: widget.properties.expands,
      readOnly: widget.properties.readOnly,
      showCursor: widget.properties.showCursor,
      maxLength: widget.properties.maxLength,
      maxLengthEnforcement: widget.properties.maxLengthEnforcement,
      onTap: widget.properties.onTap,
      onTapOutside: widget.properties.onTapOutside,
      onTapAlwaysCalled: widget.properties.onTapAlwaysCalled,
      onEditingComplete: widget.properties.onEditingComplete,
      onSubmit: widget.properties.onSubmit,
      onAppPrivateCommand: widget.properties.onAppPrivateCommand,
      inputFormatters: widget.properties.inputFormatters,
      enabled: widget.properties.enabled,
      ignorePointers: widget.properties.ignorePointers,
      enableInteractiveSelection: widget.properties.enableInteractiveSelection,
      selectAllOnFocus: widget.properties.selectAllOnFocus,
      selectionControls: widget.properties.selectionControls,
      dragStartBehavior: widget.properties.dragStartBehavior,
      mouseCursor: widget.properties.mouseCursor,
      counterBuilder: widget.properties.counterBuilder,
      scrollPhysics: widget.properties.scrollPhysics,
      scrollController: widget.properties.scrollController,
      autofillHints: widget.properties.autofillHints,
      restorationId: widget.properties.restorationId,
      stylusHandwritingEnabled: widget.properties.stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: widget.properties.enableIMEPersonalizedLearning,
      contentInsertionConfiguration: widget.properties.contentInsertionConfiguration,
      contextMenuBuilder: widget.properties.contextMenuBuilder,
      canRequestFocus: widget.properties.canRequestFocus,
      undoController: widget.properties.undoController,
      spellCheckConfiguration: widget.properties.spellCheckConfiguration,
      prefixBuilder: widget.properties.prefixBuilder == null
          ? null
          : (context, style, states) => widget.properties.prefixBuilder!(context, style, _controller, states),
      suffixBuilder: widget.properties.suffixBuilder == null
          ? null
          : (context, style, states) => widget.properties.suffixBuilder!(context, style, _controller, states),
      clearable: widget.properties.clearable,
      clearIconBuilder: widget.properties.clearIconBuilder,
    ),
  );
}
