import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/field/field.dart';
import 'package:forui/src/foundation/field/field_controller.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_field/field/date_field_controller.dart';

@internal
class DateField extends Field<DateTime?> {
  final FCalendarController<DateTime?> calendarController;
  final int baselineYear;

  const DateField({
    required this.calendarController,
    required this.baselineYear,
    required super.style,
    required super.builder,
    required super.label,
    required super.description,
    required super.errorBuilder,
    required super.enabled,
    required super.onSaved,
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
    required super.localizations,
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

class _DateFieldState extends FieldState<DateField, DateTime?> {
  @override
  void didUpdateWidget(covariant DateField old) {
    super.didUpdateWidget(old);
    if (widget.calendarController != old.calendarController) {
      controller.dispose();
      controller = createController();
    }
  }

  @override
  @protected
  FieldController createController() =>
      DateFieldController(widget.calendarController, localizations, widget.style.textFieldStyle, widget.baselineYear);

  @override
  @protected
  DateTime? get value => widget.calendarController.value;
}
