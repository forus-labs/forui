import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
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
  static Widget _errorBuilder(BuildContext _, String text) => Text(text);

  /// {@macro forui.text_field.style}
  final FTextFieldStyle Function(FTextFieldStyle)? style;

  /// {@macro forui.text_field.builder}
  final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)> builder;

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
  final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>? prefixBuilder;

  /// {@macro forui.text_field.suffixBuilder}
  final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>? suffixBuilder;

  /// {@macro forui.text_field.clearable}
  final bool Function(TextEditingValue) clearable;

  @override
  final FormFieldSetter<String>? onSaved;

  @override
  final FormFieldValidator<String>? validator;

  /// {@macro forui.text_field.initialValue}
  final String? initialText;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final Widget Function(BuildContext, String) errorBuilder;

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
    this.validator,
    this.initialText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    super.key,
  });

  /// Creates a [FTextFormField] configured for passwords.
  ///
  /// [autofillHints] defaults to [AutofillHints.password]. It should be overridden with [AutofillHints.newPassword]
  /// when handling the creation of new passwords.
  const FTextFormField.password({
    this.style,
    this.builder = Defaults.builder,
    this.label = const Text('Password'),
    this.hint,
    this.description,
    this.magnifierConfiguration,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
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
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.counterBuilder,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints = const [AutofillHints.password],
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
    this.validator,
    this.initialText,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.forceErrorText,
    this.errorBuilder = _errorBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => _FormField(this, key: key);

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

class _FormField extends FormField<String> {
  final FTextFormField field;

  _FormField(this.field, {super.key})
    : super(
        onSaved: field.onSaved,
        validator: field.validator,
        initialValue: field.controller?.text ?? field.initialText,
        enabled: field.enabled,
        autovalidateMode: field.autovalidateMode,
        forceErrorText: field.forceErrorText,
        restorationId: field.restorationId,
        builder: (formField) {
          final state = formField as _State;
          return UnmanagedRestorationScope(
            bucket: state.bucket,
            child: FTextField(
              style: field.style,
              builder: field.builder,
              label: field.label,
              hint: field.hint,
              description: field.description,
              error: switch (state.errorText) {
                null => null,
                final error => field.errorBuilder(state.context, error),
              },
              magnifierConfiguration: field.magnifierConfiguration,
              groupId: field.groupId,
              controller: state._effectiveController,
              focusNode: field.focusNode,
              keyboardType: field.keyboardType,
              textInputAction: field.textInputAction,
              textCapitalization: field.textCapitalization,
              textAlign: field.textAlign,
              textAlignVertical: field.textAlignVertical,
              textDirection: field.textDirection,
              autofocus: field.autofocus,
              statesController: field.statesController,
              obscuringCharacter: field.obscuringCharacter,
              obscureText: field.obscureText,
              autocorrect: field.autocorrect,
              smartDashesType: field.smartDashesType,
              smartQuotesType: field.smartQuotesType,
              enableSuggestions: field.enableSuggestions,
              minLines: field.minLines,
              maxLines: field.maxLines,
              expands: field.expands,
              readOnly: field.readOnly,
              showCursor: field.showCursor,
              maxLength: field.maxLength,
              maxLengthEnforcement: field.maxLengthEnforcement,
              onChange: (value) {
                state.didChange(value);
                field.onChange?.call(value);
              },
              onTap: field.onTap,
              onTapAlwaysCalled: field.onTapAlwaysCalled,
              onEditingComplete: field.onEditingComplete,
              onSubmit: field.onSubmit,
              onAppPrivateCommand: field.onAppPrivateCommand,
              inputFormatters: field.inputFormatters,
              enabled: field.enabled,
              ignorePointers: field.ignorePointers,
              enableInteractiveSelection: field.enableInteractiveSelection,
              selectionControls: field.selectionControls,
              dragStartBehavior: field.dragStartBehavior,
              mouseCursor: field.mouseCursor,
              counterBuilder: field.counterBuilder,
              scrollPhysics: field.scrollPhysics,
              scrollController: field.scrollController,
              autofillHints: field.autofillHints,
              restorationId: field.restorationId,
              stylusHandwritingEnabled: field.stylusHandwritingEnabled,
              enableIMEPersonalizedLearning: field.enableIMEPersonalizedLearning,
              contentInsertionConfiguration: field.contentInsertionConfiguration,
              contextMenuBuilder: field.contextMenuBuilder,
              canRequestFocus: field.canRequestFocus,
              undoController: field.undoController,
              spellCheckConfiguration: field.spellCheckConfiguration,
              prefixBuilder: field.prefixBuilder,
              suffixBuilder: field.suffixBuilder,
              clearable: field.clearable,
              key: key,
            ),
          );
        },
      );

  @override
  FormFieldState<String> createState() => _State();
}

// This class is based on Material's _TextFormFieldState implementation.
class _State extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.field.controller case final controller?) {
      controller.addListener(_handleTextEditingChange);
    } else {
      _registerController(RestorableTextEditingController(text: widget.initialValue));
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller case final controller?) {
      registerForRestoration(controller, 'controller');
    }

    // Make sure to update the internal [FormFieldState] value to sync up with text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController(RestorableTextEditingController controller) {
    assert(_controller == null, '_controller is already initialized.');
    _controller = controller;
    if (!restorePending) {
      registerForRestoration(controller, 'controller');
    }
  }

  @override
  void didUpdateWidget(covariant _FormField old) {
    super.didUpdateWidget(old);
    if (widget.field.controller == old.field.controller) {
      return;
    }

    widget.field.controller?.addListener(_handleTextEditingChange);
    old.field.controller?.removeListener(_handleTextEditingChange);

    switch ((widget.field.controller, old.field.controller)) {
      case (final current?, _):
        setValue(current.text);
        if (_controller != null) {
          unregisterFromRestoration(_controller!);
          _controller?.dispose();
          _controller = null;
        }

      case (null, final old?):
        _registerController(RestorableTextEditingController.fromValue(old.value));
    }
  }

  @override
  void dispose() {
    widget.field.controller?.removeListener(_handleTextEditingChange);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  // Suppress changes that originated from within this class.
  //
  // In the case where a controller has been passed in to this widget, we register this change listener. In these
  // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
  // reset() method. In such cases, the FormField value will already have been set.
  void _handleTextEditingChange() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  @override
  _FormField get widget => super.widget as _FormField;

  TextEditingController get _effectiveController => widget.field.controller ?? _controller!.value;
}
