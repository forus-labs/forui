part of '../time_field.dart';

// ignore: avoid_implementing_value_types
class _PickerTimeField extends FTimeField implements FTimeFieldPickerProperties {
  final DateFormat? format;
  final String? hint;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final MouseCursor mouseCursor;
  final bool canRequestFocus;
  @override
  final Alignment anchor;
  @override
  final Alignment inputAnchor;
  @override
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  @override
  final FHidePopoverRegion hideOnTapOutside;
  @override
  final bool directionPadding;
  @override
  final int hourInterval;
  @override
  final int minuteInterval;

  const _PickerTimeField({
    this.format,
    this.hint,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.canRequestFocus = true,
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.anywhere,
    this.directionPadding = false,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    super.controller,
    super.style,
    super.hour24,
    super.autofocus,
    super.focusNode,
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
  State<_PickerTimeField> createState() => _PickerTimeFieldState();

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
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'));
  }
}

class _PickerTimeFieldState extends _FTimeFieldState<_PickerTimeField> {
  final TextEditingController _textController = TextEditingController();
  DateFormat? _format;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller._picker.addListener(_updateTextController);
    _focus = widget.focusNode ?? FocusNode();
    _controller.popover.addListener(() {
      if (!_controller.popover.shown) {
        _focus.unfocus();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _PickerTimeField old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? FocusNode();
    }

    if (widget.hour24 != old.hour24) {
      final localizations = FLocalizations.of(context)?.localeName;
      _format = widget.hour24 ? DateFormat.Hm(localizations) : DateFormat.jm(localizations);
    }

    if (widget.controller != old.controller) {
      _controller._picker.addListener(_updateTextController);
      _updateTextController();
      _controller.popover.addListener(() {
        if (!_controller.popover.shown) {
          _focus.unfocus();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localizations = FLocalizations.of(context)?.localeName;
    _format = widget.hour24 ? DateFormat.Hm(localizations) : DateFormat.jm(localizations);

    _updateTextController();
  }

  void _updateTextController() {
    if (_controller._picker.value case final value) {
      final time = value.withDate(DateTime(1970));
      _textController.text = widget.format?.format(time) ?? _format?.format(time) ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.timeFieldStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
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
      onTap: _controller.popover.toggle,
      hint: widget.hint ?? localizations.dateFieldHint,
      readOnly: true,
      enableInteractiveSelection: false,
      prefixBuilder:
          widget.prefixBuilder == null
              ? null
              : (context, stateStyle, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.prefixBuilder?.call(context, (style, stateStyle), null),
              ),
      suffixBuilder:
          widget.suffixBuilder == null
              ? null
              : (context, stateStyle, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.suffixBuilder?.call(context, (style, stateStyle), null),
              ),
      label: widget.label,
      description: widget.description,
      enabled: widget.enabled,
      onSaved: onSaved == null ? null : (_) => onSaved(_controller.value),
      validator: (_) => _controller.validator(_controller.value),
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      errorBuilder: widget.errorBuilder,
      builder:
          (_, _, child) => _PickerPopover(
            controller: _controller,
            style: style,
            hour24: widget.hour24,
            properties: widget,
            child: child!,
          ),
    );
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    _textController.dispose();
    super.dispose();
  }
}

class _PickerPopover extends StatelessWidget {
  final FTimeFieldController controller;
  final FTimeFieldStyle style;
  final FTimeFieldPickerProperties properties;
  final bool hour24;
  final Widget child;

  const _PickerPopover({
    required this.controller,
    required this.style,
    required this.properties,
    required this.hour24,
    required this.child,
  });

  @override
  Widget build(BuildContext _) => FPopover(
    style: style.popoverStyle,
    controller: controller.popover,
    popoverAnchor: properties.anchor,
    childAnchor: properties.inputAnchor,
    shift: properties.shift,
    hideOnTapOutside: properties.hideOnTapOutside,
    directionPadding: properties.directionPadding,
    popoverBuilder:
        (_, _, _) => TextFieldTapRegion(
          child: ConstrainedBox(
            constraints: style.popoverConstraints,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FTimePicker(
                controller: controller._picker,
                style: style.pickerStyle,
                hour24: hour24,
                hourInterval: properties.hourInterval,
                minuteInterval: properties.minuteInterval,
              ),
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
      ..add(DiagnosticsProperty('properties', this.properties))
      ..add(DiagnosticsProperty('hour24', hour24));
  }
}
