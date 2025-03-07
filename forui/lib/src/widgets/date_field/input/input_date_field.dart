part of '../date_field.dart';

class _InputDateField extends FDateField {
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
  final FDateFieldCalendarProperties? calendar;

  const _InputDateField({
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
    this.calendar = const FDateFieldCalendarProperties(),
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
  State<_InputDateField> createState() => _InputDateFieldState();

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

class _InputDateFieldState extends _FDateFieldState<_InputDateField> {
  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.dateFieldStyle;

    final ValueWidgetBuilder<FTextFieldStateStyle>? prefix = switch (widget.prefixBuilder) {
      null => null,
      final builder when widget.calendar != null =>
        (context, stateStyle, child) =>
            MouseRegion(cursor: SystemMouseCursors.click, child: builder(context, (style, stateStyle), child)),
      final builder => (context, stateStyle, child) => builder(context, (style, stateStyle), child),
    };

    final ValueWidgetBuilder<FTextFieldStateStyle>? suffix = switch (widget.suffixBuilder) {
      null => null,
      final builder when widget.calendar != null =>
        (context, stateStyle, child) =>
            MouseRegion(cursor: SystemMouseCursors.click, child: builder(context, (style, stateStyle), child)),
      final builder => (context, stateStyle, child) => builder(context, (style, stateStyle), child),
    };

    final ValueWidgetBuilder<FTextFieldStateStyle> builder = switch (widget.calendar) {
      null => (_, _, child) => child!,
      final properties =>
        (_, _, child) => _CalendarPopover(controller: _controller, style: style, properties: properties, child: child!),
    };

    return DateInput(
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
      prefixBuilder: prefix,
      suffixBuilder: suffix,
      localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
      baselineYear: widget.baselineInputYear,
      builder: builder,
    );
  }
}
