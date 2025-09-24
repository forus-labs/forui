import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/input.dart';
import 'package:forui/src/foundation/input/input_controller.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/date_field/input/date_input_controller.dart';

@internal
class DateInput extends Input<DateTime?> {
  final FCalendarController<DateTime?> calendarController;
  final FDateFieldStyle style;
  final int baselineYear;

  const DateInput({
    required this.calendarController,
    required this.style,
    required this.baselineYear,
    required super.controller,
    required super.builder,
    required super.label,
    required super.description,
    required super.errorBuilder,
    required super.enabled,
    required super.onSaved,
    required super.onReset,
    required super.validator,
    required super.autovalidateMode,
    required super.forceErrorText,
    required super.focusNode,
    required super.textInputAction,
    required super.textAlign,
    required super.textAlignVertical,
    required super.textDirection,
    required super.autofocus,
    required super.expands,
    required super.onEditingComplete,
    required super.mouseCursor,
    required super.onTap,
    required super.canRequestFocus,
    required super.prefixBuilder,
    required super.suffixBuilder,
    required super.clearable,
    required super.localizations,
    super.key,
  });

  @override
  State<DateInput> createState() => _DateInputState();

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

class _DateInputState extends InputState<DateInput, DateTime?> {
  @override
  void didUpdateWidget(covariant DateInput old) {
    super.didUpdateWidget(old);
    if (widget.localizations != old.localizations) {
      localizations = scriptNumerals.contains(widget.localizations.localeName)
          ? FDefaultLocalizations()
          : widget.localizations;
      controller.dispose();
      controller = createController();
    } else if (widget.calendarController != old.calendarController) {
      controller.dispose();
      controller = createController();
    }
  }

  @override
  @protected
  InputController createController() =>
      DateInputController(widget.calendarController, localizations, widget.style.textFieldStyle, widget.baselineYear);

  @override
  @protected
  bool clearable(TextEditingValue value) => value.text != controller.placeholder;

  @override
  @protected
  FTextFieldStyle get textFieldStyle => widget.style.textFieldStyle;

  @override
  @protected
  DateTime? get value => widget.calendarController.value;

  @override
  @protected
  String get errorMessage => localizations.dateFieldInvalidDateError;
}
