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
    super.control,
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
    super.onReset,
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
  String get _focusLabel => 'InputDateField';

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange, this);
  }

  @override
  void didUpdateWidget(covariant _InputDateField old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleOnChange, this).$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case Managed(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.dateFieldStyle) ?? context.theme.dateFieldStyle;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(.enter): () {
          _focus.unfocus();
          _controller.popover.hide();
        },
      },
      child: DateInput(
        controller: _controller,
        calendarController: _controller.calendar,
        onTap: widget.calendar == null ? null : _controller.popover.show,
        style: style,
        label: widget.label,
        description: widget.description,
        errorBuilder: widget.errorBuilder,
        clearable: widget.clearable,
        enabled: widget.enabled,
        onSaved: widget.onSaved,
        onReset: widget.onReset,
        validator: _controller.validator,
        autovalidateMode: widget.autovalidateMode,
        forceErrorText: widget.forceErrorText,
        focusNode: _focus,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        expands: widget.expands,
        autofocus: widget.autofocus,
        onEditingComplete: widget.onEditingComplete,
        mouseCursor: widget.mouseCursor,
        canRequestFocus: widget.canRequestFocus,
        prefixBuilder: widget.prefixBuilder == null
            ? null
            : (context, _, states) => widget.prefixBuilder!(context, style, states),
        suffixBuilder: widget.suffixBuilder == null
            ? null
            : (context, _, states) => widget.suffixBuilder!(context, style, states),
        localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
        baselineYear: widget.baselineInputYear,
        builder: switch (widget.calendar) {
          null => (context, _, states, child) => widget.builder(context, style, states, child),
          final properties => (context, _, states, child) => _CalendarPopover(
            controller: _controller,
            style: style,
            properties: properties,
            autofocus: false,
            fieldFocusNode: null,
            child: widget.builder(context, style, states, child),
          ),
        },
      ),
    );
  }
}

class _InputOnlyDateField extends FDateField {
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

  const _InputOnlyDateField({
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
    super.control,
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
    super.onReset,
    super.autovalidateMode,
    super.forceErrorText,
    super.errorBuilder,
    super.key,
  }) : super._();

  @override
  State<_InputOnlyDateField> createState() => _InputOnlyDateFieldState();

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
      ..add(IntProperty('baselineInputYear', baselineInputYear));
  }
}

class _InputOnlyDateFieldState extends _FDateFieldState<_InputOnlyDateField> {
  @override
  String get _focusLabel => 'InputOnlyDateField';

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange, this);
  }

  @override
  void didUpdateWidget(covariant _InputOnlyDateField old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleOnChange, this).$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case Managed(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.dateFieldStyle) ?? context.theme.dateFieldStyle;
    return DateInput(
      controller: _controller,
      calendarController: _controller.calendar,
      onTap: null,
      style: style,
      label: widget.label,
      description: widget.description,
      errorBuilder: widget.errorBuilder,
      clearable: widget.clearable,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      onReset: widget.onReset,
      validator: _controller.validator,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      focusNode: _focus,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      expands: widget.expands,
      autofocus: widget.autofocus,
      onEditingComplete: widget.onEditingComplete,
      mouseCursor: widget.mouseCursor,
      canRequestFocus: widget.canRequestFocus,
      prefixBuilder: widget.prefixBuilder == null
          ? null
          : (context, _, states) => widget.prefixBuilder!(context, style, states),
      suffixBuilder: widget.suffixBuilder == null
          ? null
          : (context, _, states) => widget.suffixBuilder!(context, style, states),
      localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
      baselineYear: widget.baselineInputYear,
      builder: (context, _, states, child) => widget.builder(context, style, states, child),
    );
  }
}
