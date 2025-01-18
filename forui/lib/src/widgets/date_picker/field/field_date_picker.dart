part of '../date_picker.dart';

class _FieldDatePicker extends FDatePicker {
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final VoidCallback? onEditingComplete;
  final ValueChanged<DateTime>? onSubmit;
  final MouseCursor? mouseCursor;
  final bool canRequestFocus;
  final int baselineInputYear;
  final FDatePickerCalendarProperties? calendar;

  const _FieldDatePicker({
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.onEditingComplete,
    this.onSubmit,
    this.mouseCursor,
    this.canRequestFocus = true,
    this.baselineInputYear = 2000,
    this.calendar = const FDatePickerCalendarProperties(),
    super.controller,
    super.style,
    super.autofocus,
    super.focusNode,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled,
    super.onSaved,
    super.autovalidateMode,
    super.forceErrorText,
    super.errorBuilder,
    super.key,
  }) : super._();

  @override
  State<StatefulWidget> createState() => _FieldDatePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('textInputAction', textInputAction))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(ObjectFlagProperty.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty.has('onSubmit', onSubmit))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(DiagnosticsProperty('calendar', calendar))
      ..add(IntProperty('baselineInputYear', baselineInputYear));
  }
}

class _FieldDatePickerState extends _DatePickerState<_FieldDatePicker> {
  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.datePickerStyle;
    var prefix = widget.prefixBuilder?.call(context, style);
    var suffix = widget.suffixBuilder?.call(context, style);

    if (widget.calendar != null) {
      prefix = widget.prefixBuilder == null
          ? null
          : MouseRegion(
              cursor: SystemMouseCursors.click,
              child: widget.prefixBuilder?.call(context, style),
            );
      suffix = widget.suffixBuilder == null
          ? null
          : MouseRegion(
              cursor: SystemMouseCursors.click,
              child: widget.suffixBuilder?.call(context, style),
            );
    }

    Widget input = DateField(
      calendarController: _controller._calendar,
      onTap: widget.calendar == null ? null : _controller.calendar.show,
      style: style,
      label: widget.label,
      description: widget.description,
      errorBuilder: widget.errorBuilder,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: _controller.validator,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      expands: widget.expands,
      autofocus: widget.autofocus,
      onEditingComplete: widget.onEditingComplete,
      mouseCursor: widget.mouseCursor,
      canRequestFocus: widget.canRequestFocus,
      prefix: prefix,
      suffix: suffix,
      localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
      baselineYear: widget.baselineInputYear,
    );

    if (widget.calendar case final properties?) {
      input = _CalendarPopover(
        controller: _controller,
        style: style,
        properties: properties,
        child: input,
      );
    }

    return input;
  }
}
