import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:forui/forui.dart';

@internal
class Field extends StatefulWidget {
  static bool defaultClearable(TextEditingValue _) => false;

  static Widget defaultContextMenuBuilder(BuildContext _, EditableTextState state) =>
      AdaptiveTextSelectionToolbar.editableText(editableTextState: state);

  static Widget defaultBuilder(BuildContext _, FTextFieldStyle _, Set<WidgetState> _, Widget child) => child;

  static Widget defaultClearIconBuilder(BuildContext context, FTextFieldStyle style, VoidCallback clear) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: style.clearButtonPadding,
      child: FButton.icon(
        style: style.clearButtonStyle,
        onPress: clear,
        child: Icon(FIcons.x, semanticLabel: localizations.textFieldClearButtonSemanticsLabel),
      ),
    );
  }

  final TextEditingController controller;
  final FTextFieldStyle Function(FTextFieldStyle)? style;
  final FFieldBuilder<FTextFieldStyle> builder;
  final Widget? label;
  final String? hint;
  final Widget? description;
  final Widget? error;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final Object groupId;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? minLines;
  final int? maxLines;
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
  final Iterable<String>? autofillHints;
  final String? restorationId;
  final bool stylusHandwritingEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool canRequestFocus;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final FFieldIconBuilder<FTextFieldStyle>? prefixBuilder;
  final FFieldIconBuilder<FTextFieldStyle>? suffixBuilder;
  final bool Function(TextEditingValue) clearable;
  final FFieldClearIconBuilder clearIconBuilder;

  const Field({
    required this.controller,
    required this.builder,
    required this.groupId,
    required this.textCapitalization,
    required this.textAlign,
    required this.autofocus,
    required this.obscuringCharacter,
    required this.obscureText,
    required this.autocorrect,
    required this.enableSuggestions,
    required this.expands,
    required this.readOnly,
    required this.onTapAlwaysCalled,
    required this.enabled,
    required this.enableInteractiveSelection,
    required this.dragStartBehavior,
    required this.stylusHandwritingEnabled,
    required this.enableIMEPersonalizedLearning,
    required this.canRequestFocus,
    required this.clearable,
    required this.clearIconBuilder,
    this.style,
    this.label,
    this.hint,
    this.description,
    this.error,
    this.magnifierConfiguration,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textAlignVertical,
    this.textDirection,
    this.statesController,
    this.smartDashesType,
    this.smartQuotesType,
    this.minLines,
    this.maxLines,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onSubmit,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.ignorePointers,
    this.selectAllOnFocus,
    this.selectionControls,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.restorationId,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.undoController,
    this.spellCheckConfiguration,
    this.prefixBuilder,
    this.suffixBuilder,
    super.key,
  });

  @override
  State<Field> createState() => _FieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(ObjectFlagProperty.has('style', style))
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
      ..add(StringProperty('obscuringCharacter', obscuringCharacter))
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
        FlagProperty(
          'enableInteractiveSelection',
          value: enableInteractiveSelection,
          ifTrue: 'enableInteractiveSelection',
        ),
      )
      ..add(FlagProperty('selectAllOnFocus', value: selectAllOnFocus, ifTrue: 'selectAllOnFocus'))
      ..add(DiagnosticsProperty('selectionControls', selectionControls))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(ObjectFlagProperty.has('counterBuilder', counterBuilder))
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
      ..add(ObjectFlagProperty.has('clearIconBuilder', clearIconBuilder));
  }
}

class _FieldState extends State<Field> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = widget.statesController ?? .new();
    _statesController.addListener(_handleStatesChange);
  }

  @override
  void didUpdateWidget(covariant Field old) {
    super.didUpdateWidget(old);
    if (widget.statesController != old.statesController) {
      if (old.statesController == null) {
        _statesController.dispose();
      } else {
        _statesController.removeListener(_handleStatesChange);
      }

      _statesController = widget.statesController ?? .new();
      _statesController.addListener(_handleStatesChange);
    }
  }

  void _handleStatesChange() => SchedulerBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      setState(() {});
    }
  });

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.textFieldStyle) ?? context.theme.textFieldStyle;
    final states = {..._statesController.value};

    final textfield = TextField(
      controller: widget.controller,
      decoration: _decoration(style),
      focusNode: widget.focusNode,
      undoController: widget.undoController,
      cursorErrorColor: style.cursorColor,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: style.contentTextStyle.resolve(states),
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      statesController: _statesController,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmit,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      ignorePointers: widget.ignorePointers,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      keyboardAppearance: style.keyboardAppearance,
      scrollPadding: style.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      mouseCursor: widget.mouseCursor,
      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
        final counter = widget.counterBuilder?.call(context, currentLength, maxLength, isFocused);
        return counter == null
            ? null
            : DefaultTextStyle.merge(style: style.counterTextStyle.resolve(states), child: counter);
      },
      selectAllOnFocus: widget.selectAllOnFocus,
      selectionControls: widget.selectionControls,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      restorationId: widget.restorationId,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      contextMenuBuilder: widget.contextMenuBuilder,
      canRequestFocus: widget.canRequestFocus,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
      groupId: widget.groupId,
    );

    Widget field = FLabel(
      axis: .vertical,
      states: states,
      label: widget.label,
      style: style,
      description: widget.description,
      // Error should never be null as doing so causes the widget tree to change. This causes overlays attached to
      // the textfield to fail as it is not smart enough to track the new location of the textfield in the widget tree.
      error: widget.error ?? const SizedBox(),
      expands: widget.expands,
      child: widget.builder(context, style, states, textfield),
    );

    field = MergeSemantics(
      child: Material(
        color: Colors.transparent,
        child: Theme(
          // The selection colors are defined in a Theme instead of TextField since TextField does not expose parameters
          // for overriding selectionHandleColor.
          data: Theme.of(context).copyWith(
            visualDensity: .standard,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: style.cursorColor,
              selectionColor: style.cursorColor.withValues(alpha: 0.4),
              selectionHandleColor: style.cursorColor,
            ),
          ),
          child: CupertinoTheme(
            // Theme.cupertinoOverrideTheme cannot be used because of https://github.com/flutter/flutter/issues/161573.
            data: CupertinoTheme.of(context).copyWith(primaryColor: style.cursorColor),
            child: field,
          ),
        ),
      ),
    );

    final materialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    if (materialLocalizations == null) {
      field = Localizations(
        locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: field,
      );
    }

    return field;
  }

  InputDecoration _decoration(FTextFieldStyle style) {
    final textDirection = Directionality.maybeOf(context) ?? .ltr;
    final padding = style.contentPadding.resolve(textDirection);
    final states = _statesController.value;

    final suffix = widget.suffixBuilder?.call(context, style, states);
    final clear = widget.clearable(widget.controller.value)
        ? widget.clearIconBuilder(context, style, () => widget.controller.text = '')
        : null;

    return InputDecoration(
      isDense: true,
      prefixIcon: widget.prefixBuilder?.call(context, style, states),
      suffixIcon: switch ((suffix, clear)) {
        (final icon?, final clear?) when !states.contains(WidgetState.disabled) => Row(
          mainAxisAlignment: .end,
          mainAxisSize: .min,
          children: [clear, icon],
        ),
        (null, final clear?) when !states.contains(WidgetState.disabled) => clear,
        (final icon, _) => icon,
      },
      // See https://stackoverflow.com/questions/70771410/flutter-how-can-i-remove-the-content-padding-for-error-in-textformfield
      prefix: Padding(
        padding: switch (textDirection) {
          .ltr => .only(left: widget.prefixBuilder == null ? padding.left : 0),
          .rtl => .only(right: widget.prefixBuilder == null ? padding.right : 0),
        },
      ),
      prefixIconConstraints: const BoxConstraints(),
      suffixIconConstraints: const BoxConstraints(),
      contentPadding: switch (textDirection) {
        .ltr => padding.copyWith(left: 0),
        .rtl => padding.copyWith(right: 0),
      },
      hintText: widget.hint,
      hintStyle: WidgetStateTextStyle.resolveWith(style.hintTextStyle.resolve),
      fillColor: style.fillColor,
      filled: style.filled,
      border: WidgetStateInputBorder.resolveWith(style.border.resolve),
      // This is done to trigger the error state. We don't pass in error directly since we build our own using FLabel.
      error: widget.error == null ? null : const SizedBox(),
    );
  }

  @override
  void dispose() {
    if (widget.statesController == null) {
      _statesController.dispose();
    } else {
      _statesController.removeListener(_handleStatesChange);
    }
    super.dispose();
  }
}
