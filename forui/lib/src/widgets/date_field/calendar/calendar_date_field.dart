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
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  @override
  final FHidePopoverRegion hideOnTapOutside;
  @override
  final bool directionPadding;
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

  const _CalendarDateField({
    this.format,
    this.hint,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.canRequestFocus = true,
    this.clearable = false,
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.anywhere,
    this.directionPadding = false,
    this.dayBuilder = FCalendar.defaultDayBuilder,
    this.start,
    this.end,
    this.today,
    this.initialType = FCalendarPickerType.day,
    this.autoHide = true,
    super.controller,
    super.style,
    super.autofocus,
    super.focusNode,
    super.builder,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled = true,
    super.onSaved,
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
    _controller.calendar.addListener(_updateFocus);
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
        _controller.calendar.removeListener(_updateFocus);
      }

      _controller = widget.controller ?? FDateFieldController(vsync: this);
      _controller._calendar.addListener(_updateTextController);
      _controller.calendar.addListener(_updateFocus);
      _updateTextController();
    }
  }

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

  void _updateFocus() {
    if (!_controller.calendar.shown) {
      _focus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.dateFieldStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final hint = widget.hint ?? localizations.dateFieldHint;
    final onSaved = widget.onSaved;
    return FTextField(
      focusNode: _focus,
      controller: _textController,
      style: style.textFieldStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      expands: widget.expands,
      mouseCursor: widget.mouseCursor,
      canRequestFocus: widget.canRequestFocus,
      onTap: _controller.calendar.toggle,
      hint: hint,
      readOnly: true,
      enableInteractiveSelection: false,
      prefixBuilder:
          widget.prefixBuilder == null
              ? null
              : (context, styles, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.prefixBuilder?.call(context, (style, styles.$1, styles.$2), null),
              ),
      suffixBuilder:
          widget.suffixBuilder == null
              ? null
              : (context, styles, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.suffixBuilder?.call(context, (style, styles.$1, styles.$2), null),
              ),
      clearable: widget.clearable ? (value) => value.text.isNotEmpty : (_) => false,
      label: widget.label,
      description: widget.description,
      enabled: widget.enabled,
      onSaved: onSaved == null ? null : (_) => onSaved(_controller.value),
      validator: (_) => _controller.validator(_controller.value),
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      errorBuilder: widget.errorBuilder,
      builder:
          (context, data, child) => _CalendarPopover(
            controller: _controller,
            style: style,
            properties: widget,
            child: widget.builder(context, (style, data.$1, data.$2), child),
          ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller._calendar.removeListener(_updateTextController);
      _controller.calendar.removeListener(_updateFocus);
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
  final Widget child;

  const _CalendarPopover({
    required this.controller,
    required this.style,
    required this.properties,
    required this.child,
  });

  @override
  Widget build(BuildContext _) => FPopover(
    style: style.popoverStyle,
    controller: controller.calendar,
    popoverAnchor: properties.anchor,
    childAnchor: properties.inputAnchor,
    shift: properties.shift,
    hideOnTapOutside: properties.hideOnTapOutside,
    directionPadding: properties.directionPadding,
    popoverBuilder:
        (_, _, _) => TextFieldTapRegion(
          child: ValueListenableBuilder(
            valueListenable: controller._calendar,
            builder:
                (_, value, _) => FCalendar(
                  style: style.calendarStyle,
                  controller: controller._calendar,
                  initialMonth: switch (value) {
                    null => null,
                    _ when value.isBefore(properties.start ?? DateTime.utc(1900)) => properties.today,
                    _ when value.isAfter(properties.end ?? DateTime.utc(2100)) => properties.today,
                    _ => value,
                  },
                  onPress: properties.autoHide ? (_) => controller.calendar.toggle() : null,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('properties', this.properties));
  }
}
