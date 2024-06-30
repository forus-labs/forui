part of 'text_field.dart';

@internal
class FTextFormField extends FormField<String> {

  static Widget _builder(FormFieldState<String> field) {
    final state = field as _State;
    final FTextFormField(:configuration, :initialDecoration, :style, :stateStyle) = state.widget;

    void onChange(String value) {
      field.didChange(value);
      configuration.onChange?.call(value);
    }

    return UnmanagedRestorationScope(
      bucket: state.bucket,
      child: TextField(
        controller: state._effectiveController,
        decoration: initialDecoration.copyWith(error: state.errorText), // TODO: Transformation function.
        focusNode: configuration.focusNode,
        undoController: configuration.undoController,
        cursorErrorColor: style.cursorColor,
        keyboardType: configuration.keyboardType,
        textInputAction: configuration.textInputAction,
        textCapitalization: configuration.textCapitalization,
        style: stateStyle.contentTextStyle,
        textAlign: configuration.textAlign,
        textAlignVertical: configuration.textAlignVertical,
        textDirection: configuration.textDirection,
        readOnly: configuration.readOnly,
        showCursor: configuration.showCursor,
        autofocus: configuration.autofocus,
        statesController: configuration.statesController,
        obscureText: configuration.obscureText,
        autocorrect: configuration.autocorrect,
        smartDashesType: configuration.smartDashesType,
        smartQuotesType: configuration.smartQuotesType,
        enableSuggestions: configuration.enableSuggestions,
        maxLines: configuration.maxLines,
        minLines: configuration.minLines,
        expands: configuration.expands,
        maxLength: configuration.maxLength,
        maxLengthEnforcement: configuration.maxLengthEnforcement,
        onChanged: onChange,
        onEditingComplete: configuration.onEditingComplete,
        onSubmitted: configuration.onSubmit,
        onAppPrivateCommand: configuration.onAppPrivateCommand,
        inputFormatters: configuration.inputFormatters,
        enabled: configuration.enabled,
        ignorePointers: configuration.ignorePointers,
        keyboardAppearance: style.keyboardAppearance,
        scrollPadding: style.scrollPadding,
        dragStartBehavior: configuration.dragStartBehavior,
        selectionControls: configuration.selectionControls,
        scrollController: configuration.scrollController,
        scrollPhysics: configuration.scrollPhysics,
        autofillHints: configuration.autofillHints,
        restorationId: configuration.restorationId,
        scribbleEnabled: configuration.scribbleEnabled,
        enableIMEPersonalizedLearning: configuration.enableIMEPersonalizedLearning,
        contextMenuBuilder: configuration.contextMenuBuilder,
        canRequestFocus: configuration.canRequestFocus,
        spellCheckConfiguration: configuration.spellCheckConfiguration,
        magnifierConfiguration: configuration.magnifierConfiguration,
      ),
    );
  }

  final FTextField configuration;
  final InputDecoration initialDecoration;
  final FTextFieldStyle style;
  final FTextFieldStateStyle stateStyle;

  FTextFormField({
    required this.configuration,
    required this.initialDecoration,
    required this.style,
    required this.stateStyle,
    super.key,
  }): super(
    onSaved: configuration.onSave,
    validator: configuration.validator,
    initialValue: configuration.initialValue,
    enabled: configuration.enabled,
    autovalidateMode: configuration.autovalidateMode,
    restorationId: configuration.restorationId,
    builder: _builder,
  );

  @override
  FormFieldState<String> createState() => _State();
}

// This class is based on Material's _TextFormFieldState implementation.
class _State extends FormFieldState<String> {
  // TODO: move decoration here

  RestorableTextEditingController? _controller;

  @override
  void initState() {
    super.initState();

    final controller = widget.configuration.controller;
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
    if (widget.configuration.controller == old.controller) {
      return;
    }

    old.controller?.removeListener(_handleControllerChanged);
    widget.configuration.controller?.addListener(_handleControllerChanged);

    if (old.controller != null && widget.configuration.controller == null) {
      _createLocalController(old.controller!.value);
    }

    if (widget.configuration.controller != null) {
      setValue(widget.configuration.controller!.text);
      if (old.controller == null) {
        unregisterFromRestoration(_controller!);
        _controller!.dispose();
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.configuration.controller?.removeListener(_handleControllerChanged);
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
    widget.configuration.onChange?.call(_effectiveController.text);
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

  TextEditingController get _effectiveController => widget.configuration.controller ?? _controller!.value;
}
