part of '../date_field.dart';

// ignore: avoid_implementing_value_types
class _CalendarDateField extends FDateField implements FDateFieldCalendarProperties {
  final DateFormat? format;
  final String? hint;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final MouseCursor mouseCursor;
  final bool canRequestFocus;
  final bool clearable;
  @override
  final AlignmentGeometry anchor;
  @override
  final AlignmentGeometry inputAnchor;
  @override
  final FPortalSpacing spacing;
  @override
  final Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift;
  @override
  final Offset offset;
  @override
  final FPopoverHideRegion hideRegion;
  @override
  final VoidCallback? onTapHide;
  @override
  final ValueWidgetBuilder<FCalendarDayData> dayBuilder;
  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @override
  final DateTime? today;
  @override
  final FCalendarPickerType initialType;
  @override
  final bool autoHide;

  _CalendarDateField({
    this.format,
    this.hint,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = MouseCursor.defer,
    this.canRequestFocus = true,
    this.clearable = false,
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.start,
    this.end,
    this.today,
    this.initialType = FCalendarPickerType.day,
    this.autoHide = true,
    super.controller,
    super.style,
    super.initialDate,
    super.autofocus,
    super.focusNode,
    super.builder,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled = true,
    super.onChange,
    super.onSaved,
    super.onReset,
    super.autovalidateMode = AutovalidateMode.onUnfocus,
    super.forceErrorText,
    super.errorBuilder,
    super.key,
  }) : super._();

  @override
  State<StatefulWidget> createState() => _CalendarDatePickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('format', format))
      ..add(StringProperty('hint', hint))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'));
  }
}

class _CalendarDatePickerState extends _FDateFieldState<_CalendarDateField> {
  final TextEditingController _textController = TextEditingController();
  late FocusNode _focus = widget.focusNode ?? FocusNode();
  DateFormat? _format;

  @override
  void initState() {
    super.initState();
    _controller._calendar.addListener(_updateTextController);
    _controller.addValueListener(_onChange);
  }

  @override
  void didUpdateWidget(covariant _CalendarDateField old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? FocusNode();
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        _controller._calendar.removeListener(_updateTextController);
        _controller.removeValueListener(_onChange);
      }

      _controller = widget.controller ?? FDateFieldController(vsync: this, initialDate: _controller.value);
      _controller._calendar.addListener(_updateTextController);
      _controller.addValueListener(widget.onChange);
      _updateTextController();
    }
  }

  void _onChange(DateTime? date) => widget.onChange?.call(date);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _format = DateFormat.yMMMd(FLocalizations.of(context)?.localeName);
    _updateTextController();
  }

  void _updateTextController() {
    if (_controller._calendar.value case final value?) {
      _textController.text = widget.format?.format(value) ?? _format?.format(value) ?? '';
    } else {
      _textController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.dateFieldStyle) ?? context.theme.dateFieldStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final hint = widget.hint ?? localizations.dateFieldHint;
    final onSaved = widget.onSaved;

    return Field(
      controller: _controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      onSaved: onSaved,
      onReset: widget.onReset,
      validator: _controller.validator,
      initialValue: widget.initialDate,
      builder: (state) => FTextField(
        focusNode: _focus,
        controller: _textController,
        style: style.textFieldStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        expands: widget.expands,
        mouseCursor: widget.mouseCursor,
        canRequestFocus: widget.canRequestFocus,
        onTap: _onTap,
        onTapAlwaysCalled: true,
        hint: hint,
        readOnly: true,
        enableInteractiveSelection: false,
        prefixBuilder: widget.prefixBuilder == null
            ? null
            : (context, _, states) => widget.prefixBuilder!(context, style, states),
        suffixBuilder: widget.suffixBuilder == null
            ? null
            : (context, _, states) => widget.suffixBuilder!(context, style, states),
        clearable: widget.clearable ? (value) => value.text.isNotEmpty : (_) => false,
        label: widget.label,
        description: widget.description,
        error: state.hasError ? widget.errorBuilder(context, state.errorText ?? '') : null,
        enabled: widget.enabled,
        builder: (context, _, states, field) => _CalendarPopover(
          controller: _controller,
          style: style,
          properties: widget,
          autofocus: true,
          fieldFocusNode: _focus,
          child: CallbackShortcuts(
            bindings: {const SingleActivator(LogicalKeyboardKey.enter): _onTap},
            child: widget.builder(context, style, states, field),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_controller.calendar.status)
        ? _focus.requestFocus()
        : _focus.unfocus();
    _controller.calendar.toggle();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller._calendar.removeListener(_updateTextController);
      _controller.removeValueListener(_onChange);
    }

    if (widget.focusNode == null) {
      _focus.dispose();
    }
    _textController.dispose();
    super.dispose();
  }
}

class _CalendarPopover extends StatelessWidget {
  final FDateFieldController controller;
  final FDateFieldStyle style;
  final FDateFieldCalendarProperties properties;
  final bool autofocus;
  final FocusNode? fieldFocusNode;
  final Widget child;

  const _CalendarPopover({
    required this.controller,
    required this.style,
    required this.properties,
    required this.autofocus,
    required this.fieldFocusNode,
    required this.child,
  });

  @override
  Widget build(BuildContext _) => FPopover(
    traversalEdgeBehavior: TraversalEdgeBehavior.parentScope,
    style: style.popoverStyle,
    controller: controller.calendar,
    popoverAnchor: properties.anchor,
    childAnchor: properties.inputAnchor,
    spacing: properties.spacing,
    shift: properties.shift,
    offset: properties.offset,
    hideRegion: properties.hideRegion,
    autofocus: autofocus,
    shortcuts: {const SingleActivator(LogicalKeyboardKey.escape): _hide},
    popoverBuilder: (_, _) => TextFieldTapRegion(
      child: ValueListenableBuilder(
        valueListenable: controller._calendar,
        builder: (_, value, _) => FCalendar(
          style: style.calendarStyle,
          controller: controller._calendar,
          initialMonth: switch (value) {
            null => null,
            _ when value.isBefore(properties.start ?? DateTime.utc(1900)) => properties.today,
            _ when value.isAfter(properties.end ?? DateTime.utc(2100)) => properties.today,
            _ => value,
          },
          onPress: properties.autoHide ? (_) => _hide() : null,
          dayBuilder: properties.dayBuilder,
          start: properties.start,
          end: properties.end,
          today: properties.today,
          initialType: properties.initialType,
        ),
      ),
    ),
    child: child,
  );

  void _hide() {
    fieldFocusNode?.requestFocus();
    controller.calendar.hide();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('properties', this.properties))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('fieldFocusNode', fieldFocusNode));
  }
}
