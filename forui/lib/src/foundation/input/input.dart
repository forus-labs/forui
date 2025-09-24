import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form_field.dart';
import 'package:forui/src/foundation/input/input_controller.dart';
import 'package:forui/src/localizations/localization.dart';

@internal
abstract class Input<T> extends StatefulWidget {
  final ValueNotifier<T?> controller;
  final Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> state, Widget child) builder;
  final Widget? label;
  final Widget? description;
  final Widget Function(BuildContext context, String message) errorBuilder;
  final bool enabled;
  final FormFieldSetter<T>? onSaved;
  final VoidCallback? onReset;
  final FormFieldValidator<T> validator;
  final AutovalidateMode autovalidateMode;
  final String? forceErrorText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final bool autofocus;
  final VoidCallback? onEditingComplete;
  final MouseCursor? mouseCursor;
  final VoidCallback? onTap;
  final bool canRequestFocus;
  final Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> state)? prefixBuilder;
  final Widget Function(BuildContext context, FTextFieldStyle style, Set<WidgetState> state)? suffixBuilder;
  final bool clearable;
  final FLocalizations localizations;

  const Input({
    required this.controller,
    required this.builder,
    required this.label,
    required this.description,
    required this.errorBuilder,
    required this.enabled,
    required this.onSaved,
    required this.onReset,
    required this.validator,
    required this.autovalidateMode,
    required this.forceErrorText,
    required this.focusNode,
    required this.textInputAction,
    required this.textAlign,
    required this.textAlignVertical,
    required this.textDirection,
    required this.autofocus,
    required this.expands,
    required this.onEditingComplete,
    required this.mouseCursor,
    required this.onTap,
    required this.canRequestFocus,
    required this.prefixBuilder,
    required this.suffixBuilder,
    required this.clearable,
    required this.localizations,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(ObjectFlagProperty.has('onTap', onTap))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('prefixBuilder', prefixBuilder))
      ..add(DiagnosticsProperty('suffixBuilder', suffixBuilder))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(DiagnosticsProperty('localizations', localizations));
  }
}

@internal
abstract class InputState<T extends Input<U>, U> extends State<T> {
  late FLocalizations localizations;
  late InputController controller;

  @override
  void initState() {
    super.initState();
    localizations = scriptNumerals.contains(widget.localizations.localeName)
        ? FDefaultLocalizations()
        : widget.localizations;
    controller = createController();
  }

  @protected
  InputController createController();

  @override
  Widget build(BuildContext _) => Shortcuts(
    shortcuts: const {
      SingleActivator(LogicalKeyboardKey.arrowUp): AdjustIntent(1),
      SingleActivator(LogicalKeyboardKey.arrowDown): AdjustIntent(-1),
    },
    child: Actions(
      actions: {
        AdjustIntent: CallbackAction<AdjustIntent>(onInvoke: (intent) => controller.adjust(intent.amount)),
        ExtendSelectionByCharacterIntent: CallbackAction<ExtendSelectionByCharacterIntent>(
          onInvoke: (intent) => controller.traverse(forward: intent.forward),
        ),
      },
      child: Field<U>(
        controller: widget.controller,
        enabled: widget.enabled,
        onSaved: widget.onSaved,
        onReset: widget.onReset,
        initialValue: widget.controller.value,
        validator: (value) => switch (this.value) {
          null when controller.text == controller.placeholder => widget.validator(null),
          null => errorMessage,
          final value => widget.validator(value),
        },
        autovalidateMode: widget.autovalidateMode,
        forceErrorText: widget.forceErrorText,
        builder: (state) => FTextField(
          controller: controller,
          style: textFieldStyle,
          statesController: controller.statesController,
          builder: widget.builder,
          autocorrect: false,
          // We cannot use TextInputType.number as it does not contain a done button on iOS.
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          minLines: 1,
          label: widget.label,
          description: widget.description,
          error: state.hasError ? widget.errorBuilder(context, state.errorText ?? '') : null,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          expands: widget.expands,
          autofocus: widget.autofocus,
          onEditingComplete: widget.onEditingComplete,
          mouseCursor: widget.mouseCursor,
          onTap: widget.onTap,
          canRequestFocus: widget.canRequestFocus,
          prefixBuilder: widget.prefixBuilder,
          suffixBuilder: widget.suffixBuilder,
          clearable: widget.clearable ? clearable : (_) => false,
        ),
      ),
    ),
  );

  @protected
  bool clearable(TextEditingValue value) => false;

  @protected
  FTextFieldStyle get textFieldStyle;

  @protected
  U get value;

  @protected
  String get errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle))
      ..add(DiagnosticsProperty('value', value))
      ..add(StringProperty('errorMessage', errorMessage));
  }
}

@internal
class AdjustIntent extends Intent {
  final int amount;

  const AdjustIntent(this.amount);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('amount', amount));
  }
}
