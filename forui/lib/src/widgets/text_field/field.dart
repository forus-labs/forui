import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class Field extends FormField<String> {
  static InputDecoration _decoration(
    _State state,
    FTextField parent,
    FTextFieldStyle style,
    Set<WidgetState> states,
    Widget? suffix,
  ) {
    final textDirection = Directionality.maybeOf(state.context) ?? TextDirection.ltr;
    final padding = style.contentPadding.resolve(textDirection);

    return InputDecoration(
      isDense: true,
      prefixIcon: parent.prefixBuilder?.call(state.context, (style, states), null),
      suffixIcon: suffix,
      // See https://stackoverflow.com/questions/70771410/flutter-how-can-i-remove-the-content-padding-for-error-in-textformfield
      prefix: Padding(
        padding: switch (textDirection) {
          TextDirection.ltr => EdgeInsets.only(left: parent.prefixBuilder == null ? padding.left : 0),
          TextDirection.rtl => EdgeInsets.only(right: parent.prefixBuilder == null ? padding.right : 0),
        },
      ),
      prefixIconConstraints: const BoxConstraints(),
      suffixIconConstraints: const BoxConstraints(),
      contentPadding: switch (textDirection) {
        TextDirection.ltr => padding.copyWith(left: 0),
        TextDirection.rtl => padding.copyWith(right: 0),
      },
      hintText: parent.hint,
      hintStyle: WidgetStateTextStyle.resolveWith(style.hintTextStyle.resolve),
      fillColor: style.fillColor,
      filled: style.filled,
      border: WidgetStateInputBorder.resolveWith(style.border.resolve),
      error: state.hasError ? const SizedBox() : null, // Necessary to trigger error state.
    );
  }

  final FTextField parent;

  Field({required this.parent, required FTextFieldStyle style, super.key})
    : super(
        onSaved: parent.onSaved,
        validator: parent.validator,
        initialValue: parent.controller?.text ?? parent.initialValue,
        enabled: parent.enabled,
        autovalidateMode: parent.autovalidateMode,
        forceErrorText: parent.forceErrorText,
        restorationId: parent.restorationId,
        builder: (field) {
          final state = field as _State;
          final states = state._statesController.value;

          final suffixIcon = parent.suffixBuilder?.call(state.context, (style, states), null);
          final clear =
              parent.clearable(state._effectiveController.value)
                  ? Padding(
                    padding: style.clearButtonPadding,
                    child: FButton.icon(
                      style: style.clearButtonStyle,
                      onPress: () {
                        field.didChange('');
                        parent.onChange?.call('');
                      },
                      child: Icon(
                        FIcons.x,
                        semanticLabel:
                            (FLocalizations.of(state.context) ?? FDefaultLocalizations())
                                .textFieldClearButtonSemanticsLabel,
                      ),
                    ),
                  )
                  : null;

          final suffix = switch ((suffixIcon, clear)) {
            (final icon?, final clear?) when !states.contains(WidgetState.disabled) => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [clear, icon],
            ),
            (null, final clear?) when !states.contains(WidgetState.disabled) => clear,
            (final icon, _) => icon,
          };

          final textfield = TextField(
            controller: state._effectiveController,
            decoration: _decoration(state, parent, style, states, suffix),
            focusNode: parent.focusNode,
            undoController: parent.undoController,
            cursorErrorColor: style.cursorColor,
            keyboardType: parent.keyboardType,
            textInputAction: parent.textInputAction,
            textCapitalization: parent.textCapitalization,
            style: style.contentTextStyle.resolve(states),
            textAlign: parent.textAlign,
            textAlignVertical: parent.textAlignVertical,
            textDirection: parent.textDirection,
            readOnly: parent.readOnly,
            showCursor: parent.showCursor,
            autofocus: parent.autofocus,
            statesController: state._statesController,
            obscuringCharacter: parent.obscuringCharacter,
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
            onTap: parent.onTap,
            onTapAlwaysCalled: parent.onTapAlwaysCalled,
            onEditingComplete: parent.onEditingComplete,
            onSubmitted: parent.onSubmit,
            onAppPrivateCommand: parent.onAppPrivateCommand,
            inputFormatters: parent.inputFormatters,
            enabled: parent.enabled,
            ignorePointers: parent.ignorePointers,
            enableInteractiveSelection: parent.enableInteractiveSelection,
            keyboardAppearance: style.keyboardAppearance,
            scrollPadding: style.scrollPadding,
            dragStartBehavior: parent.dragStartBehavior,
            mouseCursor: parent.mouseCursor,
            buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
              final counter = parent.counterBuilder?.call(context, currentLength, maxLength, isFocused);
              return counter == null
                  ? null
                  : DefaultTextStyle.merge(style: style.counterTextStyle.resolve(states), child: counter);
            },
            selectionControls: parent.selectionControls,
            scrollController: parent.scrollController,
            scrollPhysics: parent.scrollPhysics,
            autofillHints: parent.autofillHints,
            restorationId: parent.restorationId,
            stylusHandwritingEnabled: parent.stylusHandwritingEnabled,
            enableIMEPersonalizedLearning: parent.enableIMEPersonalizedLearning,
            contentInsertionConfiguration: parent.contentInsertionConfiguration,
            contextMenuBuilder: parent.contextMenuBuilder,
            canRequestFocus: parent.canRequestFocus,
            spellCheckConfiguration: parent.spellCheckConfiguration,
            magnifierConfiguration: parent.magnifierConfiguration,
          );

          return UnmanagedRestorationScope(
            bucket: state.bucket,
            child: FLabel(
              axis: Axis.vertical,
              states: states,
              label: parent.label,
              style: style,
              description: parent.description,
              error: switch (state.errorText) {
                null => const SizedBox(),
                final error => parent.errorBuilder(state.context, error),
              },
              child: parent.builder(state.context, (style, states), textfield),
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
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    if (widget.parent.controller case final controller?) {
      controller.addListener(_handleTextEditingChange);
    } else {
      _registerController(RestorableTextEditingController(text: widget.initialValue));
    }

    _statesController =
        widget.parent.statesController ?? WidgetStatesController()
          ..addListener(_handleStatesChange);
    _statesController.update(WidgetState.error, widget.forceErrorText != null);
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
  void didUpdateWidget(Field old) {
    super.didUpdateWidget(old);
    if (widget.parent.controller == old.parent.controller) {
      return;
    }

    widget.parent.controller?.addListener(_handleTextEditingChange);
    old.parent.controller?.removeListener(_handleTextEditingChange);

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

    if (widget.parent.statesController != old.parent.statesController) {
      if (old.parent.statesController == null) {
        _statesController.dispose();
      } else {
        _statesController.removeListener(_handleStatesChange);
      }
      _statesController =
          widget.parent.statesController ?? WidgetStatesController()
            ..addListener(_handleStatesChange);
    }
  }

  @override
  void dispose() {
    if (widget.parent.statesController == null) {
      _statesController.dispose();
    } else {
      _statesController.removeListener(_handleStatesChange);
    }

    widget.parent.controller?.removeListener(_handleTextEditingChange);
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

  void _handleTextEditingChange() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void _handleStatesChange() => SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {}));

  @override
  Field get widget => super.widget as Field;

  TextEditingController get _effectiveController => widget.parent.controller ?? _controller!.value;
}
