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
  final FPortalSpacing spacing;
  @override
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  @override
  final Offset offset;
  @override
  final FPopoverHideRegion hideRegion;
  @override
  final VoidCallback? onTapHide;
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
    this.mouseCursor = MouseCursor.defer,
    this.canRequestFocus = true,
    this.anchor = Alignment.topLeft,
    this.inputAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    super.controller,
    super.style,
    super.initialTime,
    super.hour24,
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
  late FocusNode _focus = widget.focusNode ?? FocusNode(debugLabel: 'FTimeField');
  DateFormat? _format;

  @override
  void initState() {
    super.initState();
    _controller._picker.addListener(_updateTextController);
    _controller.addValueListener(_onChange);
  }

  @override
  void didUpdateWidget(covariant _PickerTimeField old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? FocusNode(debugLabel: 'FTimeField');
    }

    if (widget.hour24 != old.hour24) {
      final localizations = FLocalizations.of(context)?.localeName;
      _format = widget.hour24 ? DateFormat.Hm(localizations) : DateFormat.jm(localizations);
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        _controller._picker.removeListener(_updateTextController);
        _controller.removeValueListener(_onChange);
      }

      _controller = widget.controller ?? FTimeFieldController(vsync: this, initialTime: _controller.value);
      _controller._picker.addListener(_updateTextController);
      _controller.addValueListener(_onChange);
      _updateTextController();
    }
  }

  void _onChange(FTime? time) => widget.onChange?.call(time);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localizations = FLocalizations.of(context)?.localeName;
    _format = widget.hour24 ? DateFormat.Hm(localizations) : DateFormat.jm(localizations);

    _updateTextController();
  }

  void _updateTextController() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_controller._picker.value case final value) {
        final time = value.withDate(DateTime(1970));
        _textController.text = widget.format?.format(time) ?? _format?.format(time) ?? '';
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller._picker.removeListener(_updateTextController);
      _controller.removeValueListener(_onChange);
    }

    if (widget.focusNode == null) {
      _focus.dispose();
    }
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.timeFieldStyle) ?? context.theme.timeFieldStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    return PickerFormField(
      controller: _controller,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      onReset: widget.onReset,
      validator: _controller.validator,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      initialTime: widget.initialTime,
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
        hint: widget.hint ?? localizations.dateFieldHint,
        readOnly: true,
        enableInteractiveSelection: false,
        prefixBuilder: widget.prefixBuilder == null
            ? null
            : (context, _, states) => widget.prefixBuilder!(context, style, states),
        suffixBuilder: widget.suffixBuilder == null
            ? null
            : (context, _, states) => widget.suffixBuilder!(context, style, states),
        label: widget.label,
        description: widget.description,
        enabled: widget.enabled,
        error: state.hasError ? widget.errorBuilder(state.context, state.errorText ?? '') : null,
        builder: (context, _, states, field) => _PickerPopover(
          controller: _controller,
          style: style,
          hour24: widget.hour24,
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
    const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_controller.popover.status)
        ? _focus.requestFocus()
        : _focus.unfocus();
    _controller.popover.toggle();
  }
}

class _PickerPopover extends StatelessWidget {
  final FTimeFieldController controller;
  final FTimeFieldStyle style;
  final FTimeFieldPickerProperties properties;
  final bool hour24;
  final bool autofocus;
  final FocusNode? fieldFocusNode;
  final Widget child;

  const _PickerPopover({
    required this.controller,
    required this.style,
    required this.properties,
    required this.hour24,
    required this.autofocus,
    required this.fieldFocusNode,
    required this.child,
  });

  @override
  Widget build(BuildContext _) => FPopover(
    style: style.popoverStyle,
    controller: controller.popover,
    constraints: style.popoverConstraints,
    popoverAnchor: properties.anchor,
    childAnchor: properties.inputAnchor,
    spacing: properties.spacing,
    shift: properties.shift,
    offset: properties.offset,
    hideRegion: properties.hideRegion,
    onTapHide: properties.onTapHide,
    autofocus: autofocus,
    shortcuts: {const SingleActivator(LogicalKeyboardKey.escape): _hide},
    popoverBuilder: (_, _) => TextFieldTapRegion(
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
    child: child,
  );

  void _hide() {
    fieldFocusNode?.requestFocus();
    controller.popover.hide();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('properties', this.properties))
      ..add(DiagnosticsProperty('hour24', hour24))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('fieldFocusNode', fieldFocusNode));
  }
}
