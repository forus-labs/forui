import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/field/field_controller.dart';
import 'package:forui/src/localizations/localization.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
abstract class Field<T> extends StatefulWidget {
  final ValueWidgetBuilder<FTextFieldStateStyle> builder;
  final Widget? label;
  final Widget? description;
  final Widget Function(BuildContext, String) errorBuilder;
  final bool enabled;
  final FormFieldSetter<T>? onSaved;
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
  final ValueWidgetBuilder<FTextFieldStateStyle>? prefixBuilder;
  final ValueWidgetBuilder<FTextFieldStateStyle>? suffixBuilder;
  final FLocalizations localizations;

  const Field({
    required this.builder,
    required this.label,
    required this.description,
    required this.errorBuilder,
    required this.enabled,
    required this.onSaved,
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
    required this.localizations,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
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
      ..add(DiagnosticsProperty('localizations', localizations));
  }
}

@internal
abstract class FieldState<T extends Field<U>, U> extends State<T> {
  late FLocalizations localizations;
  late FieldController controller;

  @override
  void initState() {
    super.initState();
    localizations =
        scriptNumerals.contains(widget.localizations.localeName) ? FDefaultLocalizations() : widget.localizations;
    controller = createController();
  }

  @protected
  FieldController createController();

  @override
  Widget build(BuildContext _) {
    final onSaved = widget.onSaved;
    return Shortcuts(
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
        child: FTextField(
          controller: controller,
          style: textFieldStyle,
          statesController: controller.states,
          builder: widget.builder,
          autocorrect: false,
          // We cannot use TextInputType.number as it is does not contain a done button.
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          minLines: 1,
          maxLines: 1,
          label: widget.label,
          description: widget.description,
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
          onSaved: onSaved == null ? null : (_) => onSaved(this.value),
          validator:
              (value) => switch (this.value) {
                null when value == controller.placeholder => widget.validator(null),
                null => invalidDateError,
                final value => widget.validator(value),
              },
          autovalidateMode: widget.autovalidateMode,
          forceErrorText: widget.forceErrorText,
          errorBuilder: widget.errorBuilder,
        ),
      ),
    );
  }

  @protected
  FTextFieldStyle get textFieldStyle;

  @protected
  U get value;

  @protected
  String get invalidDateError;

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
      ..add(StringProperty('invalidDateError', invalidDateError));
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
