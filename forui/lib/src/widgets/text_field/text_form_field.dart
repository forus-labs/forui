part of 'text_field.dart';

class _Field extends FormField<String> {
  final FTextField parent;

  _Field({
    required FTextField parent,
    required FTextFieldStyle style,
    required FTextFieldStateStyle stateStyle,
    required Key? key,
  }) : this._(
          parent: parent,
          style: style,
          stateStyle: stateStyle,
          decoration: InputDecoration(
            suffixIcon: parent.suffix,
            // See https://stackoverflow.com/questions/70771410/flutter-how-can-i-remove-the-content-padding-for-error-in-textformfield
            prefix: Padding(padding: EdgeInsets.only(left: style.contentPadding.left)),
            contentPadding: style.contentPadding.copyWith(left: 0),
            hintText: parent.hint,
            hintStyle: stateStyle.hintTextStyle,
            helper: parent.help == null
                ? null
                : DefaultTextStyle.merge(style: stateStyle.footerTextStyle, child: parent.help!),
            helperStyle: stateStyle.footerTextStyle,
            error: parent.error == null
                ? null
                : DefaultTextStyle.merge(style: stateStyle.footerTextStyle, child: parent.error!),
            errorStyle: stateStyle.footerTextStyle,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: style.disabledStyle.unfocusedStyle.color,
                width: style.disabledStyle.unfocusedStyle.width,
              ),
              borderRadius: style.disabledStyle.unfocusedStyle.radius,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: style.enabledStyle.unfocusedStyle.color,
                width: style.enabledStyle.unfocusedStyle.width,
              ),
              borderRadius: style.enabledStyle.unfocusedStyle.radius,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: style.enabledStyle.focusedStyle.color,
                width: style.enabledStyle.focusedStyle.width,
              ),
              borderRadius: stateStyle.focusedStyle.radius,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: style.errorStyle.unfocusedStyle.color,
                width: style.errorStyle.unfocusedStyle.width,
              ),
              borderRadius: style.errorStyle.unfocusedStyle.radius,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: style.errorStyle.focusedStyle.color,
                width: style.errorStyle.focusedStyle.width,
              ),
              borderRadius: style.errorStyle.focusedStyle.radius,
            ),
          ),
          key: key,
        );

  _Field._({
    required this.parent,
    required FTextFieldStyle style,
    required FTextFieldStateStyle stateStyle,
    required InputDecoration decoration,
    super.key,
  }) : super(
          onSaved: parent.onSave,
          validator: parent.validator,
          initialValue: parent.initialValue,
          enabled: parent.enabled,
          autovalidateMode: parent.autovalidateMode,
          restorationId: parent.restorationId,
          builder: (field) {
            final state = field as _State;
            return UnmanagedRestorationScope(
              bucket: state.bucket,
              child: TextField(
                controller: state._effectiveController,
                decoration: decoration.copyWith(
                  error: state.errorText == null ? null : parent.errorBuilder(state.context, state.errorText!),
                ),
                focusNode: parent.focusNode,
                undoController: parent.undoController,
                cursorErrorColor: style.cursorColor,
                keyboardType: parent.keyboardType,
                textInputAction: parent.textInputAction,
                textCapitalization: parent.textCapitalization,
                style: stateStyle.contentTextStyle,
                textAlign: parent.textAlign,
                textAlignVertical: parent.textAlignVertical,
                textDirection: parent.textDirection,
                readOnly: parent.readOnly,
                showCursor: parent.showCursor,
                autofocus: parent.autofocus,
                statesController: parent.statesController,
                obscureText: parent.obscureText,
                autocorrect: parent.autocorrect,
                smartDashesType: parent.smartDashesType,
                smartQuotesType: parent.smartQuotesType,
                enableSuggestions: parent.enableSuggestions,
                maxLines: parent.maxLines,
                minLines: parent.minLines,
                expands: parent.expands,
                maxLength: parent.maxLength,
                maxLengthEnforcement: parent.maxLengthEnforcement,
                onChanged: (value) {
                  field.didChange(value);
                  parent.onChange?.call(value);
                },
                onEditingComplete: parent.onEditingComplete,
                onSubmitted: parent.onSubmit,
                onAppPrivateCommand: parent.onAppPrivateCommand,
                inputFormatters: parent.inputFormatters,
                enabled: parent.enabled,
                ignorePointers: parent.ignorePointers,
                keyboardAppearance: style.keyboardAppearance,
                scrollPadding: style.scrollPadding,
                dragStartBehavior: parent.dragStartBehavior,
                selectionControls: parent.selectionControls,
                scrollController: parent.scrollController,
                scrollPhysics: parent.scrollPhysics,
                autofillHints: parent.autofillHints,
                restorationId: parent.restorationId,
                scribbleEnabled: parent.scribbleEnabled,
                enableIMEPersonalizedLearning: parent.enableIMEPersonalizedLearning,
                contextMenuBuilder: parent.contextMenuBuilder,
                canRequestFocus: parent.canRequestFocus,
                spellCheckConfiguration: parent.spellCheckConfiguration,
                magnifierConfiguration: parent.magnifierConfiguration,
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

    if (widget.parent.controller case final controller?) {
      controller.addListener(_handleControllerChanged);
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
  void didUpdateWidget(_Field old) {
    super.didUpdateWidget(old);
    if (widget.parent.controller == old.parent.controller) {
      return;
    }

    widget.parent.controller?.addListener(_handleControllerChanged);
    old.parent.controller?.removeListener(_handleControllerChanged);

    switch ((widget.parent.controller, old.parent.controller)) {
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
    widget.parent.controller?.removeListener(_handleControllerChanged);
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
    widget.parent.onChange?.call(_effectiveController.text);
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  @override
  _Field get widget => super.widget as _Field;

  TextEditingController get _effectiveController => widget.parent.controller ?? _controller!.value;
}
