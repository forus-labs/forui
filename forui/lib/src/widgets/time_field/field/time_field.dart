import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/field/field.dart';
import 'package:forui/src/foundation/field/field_controller.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/time_field/field/time_field_controller.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
class TimeField extends Field<FTime?> {
  final FTimeFieldController timeController;
  final FTimeFieldStyle style;
  final bool hour24;

  const TimeField({
    required this.timeController,
    required this.hour24,
    required this.style,
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
  State<TimeField> createState() => _TimeFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('timeController', timeController))
      ..add(FlagProperty('hour24', value: hour24, ifTrue: 'hour24'))
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
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('prefixBuilder', prefixBuilder))
      ..add(DiagnosticsProperty('suffixBuilder', suffixBuilder))
      ..add(DiagnosticsProperty('localizations', localizations));
  }
}

class _TimeFieldState extends FieldState<TimeField, FTime?> {
  @override
  void didUpdateWidget(covariant TimeField old) {
    super.didUpdateWidget(old);
    if (widget.localizations != old.localizations) {
      localizations = scriptNumerals.contains(widget.localizations.localeName) ? FDefaultLocalizations() : widget.localizations;
      controller.dispose();
      controller = createController();

    } else if (widget.timeController != old.timeController) {
      controller.dispose();
      controller = createController();
    }
  }

  @override
  @protected
  FieldController createController() {
    final format = widget.hour24 ? DateFormat.Hm(localizations.localeName) : DateFormat.jm(localizations.localeName);
    return TimeFieldController(localizations, widget.timeController, format, widget.style.textFieldStyle);
  }

  @override
  @protected
  FTextFieldStyle get textFieldStyle => widget.style.textFieldStyle;

  @override
  @protected
  FTime? get value => widget.timeController.value;
}
