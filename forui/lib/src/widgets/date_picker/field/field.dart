import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_picker/field/field_controller.dart';
import 'package:meta/meta.dart';

/// The locales not supported in a date field. It is mostly composed of locales that use non-western digits.
@internal
const unsupportedLocales = ['ar', 'bn', 'fa', 'my', 'ne', 'ps'];

@internal
class DateField extends StatefulWidget {
  final FCalendarController<DateTime?> calendarController;
  final FDatePickerStyle style;
  final ValueWidgetBuilder<FTextFieldStateStyle> builder;
  final Widget? label;
  final Widget? description;
  final Widget Function(BuildContext, String) errorBuilder;
  final bool enabled;
  final FormFieldSetter<DateTime>? onSaved;
  final FormFieldValidator<DateTime> validator;
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
  final int baselineYear;

  const DateField({
    required this.calendarController,
    required this.style,
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
    required this.baselineYear,
    super.key,
  });

  @override
  State<DateField> createState() => _DateFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('calendarController', calendarController))
      ..add(DiagnosticsProperty('style', style))
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
      ..add(DiagnosticsProperty('localizations', localizations))
      ..add(IntProperty('baselineYear', baselineYear));
  }
}

class _DateFieldState extends State<DateField> {
  late FLocalizations _localizations;
  late FieldController _controller;

  @override
  void initState() {
    super.initState();
    _localizations =
        unsupportedLocales.contains(widget.localizations.localeName) ? FDefaultLocalizations() : widget.localizations;
    _controller = FieldController(widget.calendarController, widget.style, _localizations, widget.baselineYear);
  }

  @override
  void didUpdateWidget(covariant DateField old) {
    super.didUpdateWidget(old);
    if (widget.localizations != old.localizations) {
      _localizations =
          unsupportedLocales.contains(widget.localizations.localeName) ? FDefaultLocalizations() : widget.localizations;
    }

    if (widget.calendarController != old.calendarController) {
      _controller.dispose();
      _controller = FieldController(widget.calendarController, widget.style, _localizations, widget.baselineYear);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onSaved = widget.onSaved;
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowUp): AdjustIntent(1),
        SingleActivator(LogicalKeyboardKey.arrowDown): AdjustIntent(-1),
      },
      child: Actions(
        actions: {
          AdjustIntent: CallbackAction<AdjustIntent>(onInvoke: (intent) => _controller.adjust(intent.amount)),
          ExtendSelectionByCharacterIntent: CallbackAction<ExtendSelectionByCharacterIntent>(
            onInvoke: (intent) => _controller.traverse(forward: intent.forward),
          ),
        },
        child: FTextField(
          controller: _controller,
          style: widget.style.textFieldStyle,
          statesController: _controller.states,
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
          onSaved: onSaved == null ? null : (_) => onSaved(widget.calendarController.value),
          validator: (value) => switch (widget.calendarController.value) {
            null when value == _controller.placeholder => widget.validator(null),
            null => _localizations.datePickerInvalidDateError,
            final value => widget.validator(value),
          },
          autovalidateMode: widget.autovalidateMode,
          forceErrorText: widget.forceErrorText,
          errorBuilder: widget.errorBuilder,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
