import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/src/widgets/text_field/text_field.dart';

/// A [FormField] that contains a [FTextField].
///
/// This is a convenience widget that wraps a [FTextField] widget in a [FormField].
///
/// See:
/// * https://forui.dev/docs/text-field for working text-field examples.
/// * [FTextFieldStyle] for customizing a text field's appearance.
/// * [FTextField], which is the underlying text field without the Form integration.
/// * [TextFormField] for more details about working with a text form field.
class FTextFormField extends FormField<String> with FTextFieldMixin {

  static Widget _textField(FormFieldState<String> field) {
    final state = field as _State;
    final widget = state.widget;

    return UnmanagedRestorationScope(
      bucket: state.bucket,
      child: FTextField(
        style: widget.style,
        label: widget.label,
        rawLabel: widget.rawLabel,
        hint: widget.hint,
        hintMaxLines: widget.hintMaxLines,
        help: widget.help,
        rawHelp: widget.rawHelp,
        helpMaxLines: widget.helpMaxLines,
        error: widget.error,
        rawError: widget.rawError,
        errorMaxLines: widget.errorMaxLines,
        magnifierConfiguration: widget.magnifierConfiguration,
        controller: state._effectiveController,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        autofocus: widget.autofocus,
        statesController: widget.statesController,
        obscureText: widget.obscureText,
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
        onChange: (value) {
          field.didChange(value);
          widget.onChange?.call(value);
        },
        onEditingComplete: widget.onEditingComplete,
        onSubmit: widget.onSubmit,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        ignorePointers: widget.ignorePointers,
        enableInteractSelection: widget.enableInteractSelection,
        selectionControls: widget.selectionControls,
        dragStartBehavior: widget.dragStartBehavior,
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        autofillHints: widget.autofillHints,
        restorationId: widget.restorationId,
        scribbleEnabled: widget.scribbleEnabled,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        contextMenuBuilder: widget.contextMenuBuilder,
        canRequestFocus: widget.canRequestFocus,
        undoController: widget.undoController,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        suffixIcon: widget.suffixIcon,
        key: widget.key,
      ),
    );
  }

  @override
  final FTextFieldStyle? style;

  @override
  final String? label;

  @override
  final Widget? rawLabel;

  @override
  final String? hint;

  @override
  final int? hintMaxLines;

  @override
  final String? help;

  @override
  final Widget? rawHelp;

  @override
  final int? helpMaxLines;

  @override
  final String? error;

  @override
  final Widget? rawError;

  @override
  final int? errorMaxLines;

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

  /// Creates a [FTextFormField].
  ///
  /// ## Contract:
  /// Throws [AssertionError] if:
  /// * both [label] and [rawLabel] are not null
  /// * both [help] and [rawHelp] are not null
  /// * both [error] and [rawError] are not null
  FTextFormField({
    this.style,
    this.label,
    this.rawLabel,
    this.hint,
    this.hintMaxLines,
    this.help,
    this.rawHelp,
    this.helpMaxLines,
    this.error,
    this.rawError,
    this.errorMaxLines,
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
    this.ignorePointers,
    this.enableInteractSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.suffixIcon,
    String? initialValue,
    super.key,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.onSaved,
    super.validator,
  }):
    assert(label == null || rawLabel == null, 'Cannot provide both a label and a rawLabel.'),
    assert(help == null || rawHelp == null, 'Cannot provide both a help and a rawHelp.'),
    assert(error == null || rawError == null, 'Cannot provide both an error and a rawError.'),
    assert(initialValue == null || controller == null, 'Cannot provide both a initialValue and a controller.'),
    super(
      initialValue: controller != null ? controller.text : (initialValue ?? ''),
      builder: _textField,
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

    final controller = widget.controller;
    if (controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);

    } else {
      controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      registerForRestoration(_controller!, 'controller');
    }

    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _createLocalController([TextEditingValue? value]) {
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      registerForRestoration(_controller!, 'controller');
    }
  }

  @override
  void didUpdateWidget(TextFormField old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    old.controller?.removeListener(_handleControllerChanged);
    widget.controller?.addListener(_handleControllerChanged);

    if (old.controller != null && widget.controller == null) {
      _createLocalController(old.controller!.value);
    }

    if (widget.controller != null) {
      setValue(widget.controller!.text);
      if (old.controller == null) {
        unregisterFromRestoration(_controller!);
        _controller!.dispose();
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
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
    // Set the controller value before calling super.reset() to let
    // _handleControllerChanged suppress the change.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
    widget.onChange?.call(_effectiveController.text);
  }


  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  @override
  FTextFormField get widget => super.widget as FTextFormField;

  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

}
