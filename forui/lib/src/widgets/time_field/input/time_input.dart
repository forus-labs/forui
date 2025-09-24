import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/input.dart';
import 'package:forui/src/foundation/input/input_controller.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/localizations/localizations_zh.dart';
import 'package:forui/src/widgets/time_field/input/time_input_controller.dart';

@internal
class TimeInput extends Input<FTime?> {
  final FTimeFieldController timeController;
  final FTimeFieldStyle style;
  final bool hour24;

  const TimeInput({
    required this.timeController,
    required this.hour24,
    required this.style,
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
    required super.localizations,
    super.clearable = false,
    super.key,
  });

  @override
  State<TimeInput> createState() => _TimeFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('timeController', timeController))
      ..add(FlagProperty('hour24', value: hour24, ifTrue: 'hour24'))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
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

class _TimeFieldState extends InputState<TimeInput, FTime?> {
  @override
  void didUpdateWidget(covariant TimeInput old) {
    super.didUpdateWidget(old);
    if (widget.localizations != old.localizations) {
      // We don't support scripts which period requires composing. This is due to how primitive underlying text field
      // composing support is. I'll gladly accept any PR that fixes this.
      localizations = switch (widget.localizations.localeName) {
        'zh_HK' || 'zh_TW' => FLocalizationsZh(),
        final name when scriptNumerals.contains(name) || scriptPeriods.contains(name) => FDefaultLocalizations(),
        _ => widget.localizations,
      };

      controller.dispose();
      controller = createController();
    } else if (widget.timeController != old.timeController) {
      controller.dispose();
      controller = createController();
    }
  }

  @override
  @protected
  InputController createController() {
    final format = widget.hour24 ? DateFormat.Hm(localizations.localeName) : DateFormat.jm(localizations.localeName);
    return TimeInputController(localizations, widget.timeController, format, widget.style.textFieldStyle);
  }

  @override
  @protected
  FTextFieldStyle get textFieldStyle => widget.style.textFieldStyle;

  @override
  @protected
  FTime? get value => widget.timeController.value;

  @override
  @protected
  String get errorMessage => localizations.timeFieldInvalidDateError;
}
