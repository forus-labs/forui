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
  final bool clearable;
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
    this.clearable = false,
    this.baselineInputYear = 2000,
    this.calendar = const FDateFieldCalendarProperties(),
    super.controller,
    super.style,
    super.autofocus,
    super.focusNode,
    super.builder,
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
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(DiagnosticsProperty('calendar', calendar))
      ..add(IntProperty('baselineInputYear', baselineInputYear));
  }
}

class _InputDateFieldState extends _FDateFieldState<_InputDateField> {
  @override
  void didUpdateWidget(covariant _InputDateField old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? FDateFieldController(vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.dateFieldStyle;

    final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>? prefix = switch (widget.prefixBuilder) {
      null => null,
      final builder when widget.calendar != null =>
        (context, styles, child) => MouseRegion(
          cursor: SystemMouseCursors.click,
          child: builder(context, (style, styles.$1, styles.$2), child),
        ),
      final builder => (context, styles, child) => builder(context, (style, styles.$1, styles.$2), child),
    };

    final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>? suffix = switch (widget.suffixBuilder) {
      null => null,
      final builder when widget.calendar != null =>
        (context, styles, child) => MouseRegion(
          cursor: SystemMouseCursors.click,
          child: builder(context, (style, styles.$1, styles.$2), child),
        ),
      final builder => (context, styles, child) => builder(context, (style, styles.$1, styles.$2), child),
    };

    final ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)> builder = switch (widget.calendar) {
      null => (context, data, child) => widget.builder(context, (style, data.$1, data.$2), child!),
      final properties =>
        (context, data, child) => _CalendarPopover(
          controller: _controller,
          style: style,
          properties: properties,
          child: widget.builder(context, (style, data.$1, data.$2), child!),
        ),
    };

    return DateInput(
      calendarController: _controller._calendar,
      onTap: widget.calendar == null ? null : _controller.calendar.show,
      style: style,
      label: widget.label,
      description: widget.description,
      errorBuilder: widget.errorBuilder,
      clearable: widget.clearable,
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

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
