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
  final FPortalOverflow overflow;
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
    this.textAlign = .start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = .defer,
    this.canRequestFocus = true,
    this.anchor = .topLeft,
    this.inputAnchor = .bottomLeft,
    this.spacing = const .spacing(4),
    this.overflow = .flip,
    this.offset = .zero,
    this.hideRegion = .excludeChild,
    this.onTapHide,
    this.hourInterval = 1,
    this.minuteInterval = 1,
    super.control,
    super.style,
    super.hour24,
    super.autofocus,
    super.focusNode,
    super.builder,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled = true,
    super.onSaved,
    super.onReset,
    super.autovalidateMode = .onUnfocus,
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
  final TextEditingController _textController = .new();
  late FocusNode _focus = widget.focusNode ?? .new(debugLabel: 'FTimeField');
  DateFormat? _format;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleOnChange, this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localizations = FLocalizations.of(context)?.localeName;
    _format = widget.hour24 ? .Hm(localizations) : .jm(localizations);

    _updateTextController();
  }

  @override
  void didUpdateWidget(covariant _PickerTimeField old) {
    super.didUpdateWidget(old);

    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? .new(debugLabel: 'FTimeField');
    }

    if (widget.hour24 != old.hour24) {
      final localizations = FLocalizations.of(context)?.localeName;
      _format = widget.hour24 ? .Hm(localizations) : .jm(localizations);
    }

    final(controller, updated) = widget.control.update(old.control, _controller, _handleOnChange, this);
    if (updated) {
      _controller = controller;
      _updateTextController();
    }
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    _textController.dispose();
    super.dispose();
  }

  void _handleOnChange() {
    _updateTextController();
    if (widget.control case Managed(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _updateTextController() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_controller.picker.value case final value) {
        final time = value.withDate(DateTime(1970));
        _textController.text = widget.format?.format(time) ?? _format?.format(time) ?? '';
      }
    });
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
      builder: (state) => FTextField(
        control: .managed(controller: _textController),
        focusNode: _focus,
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
            bindings: {const SingleActivator(.enter): _onTap},
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
    control: .managed(controller: controller.popover),
    style: style.popoverStyle,
    constraints: style.popoverConstraints,
    popoverAnchor: properties.anchor,
    childAnchor: properties.inputAnchor,
    spacing: properties.spacing,
    overflow: properties.overflow,
    offset: properties.offset,
    hideRegion: properties.hideRegion,
    onTapHide: properties.onTapHide,
    autofocus: autofocus,
    shortcuts: {const SingleActivator(.escape): _hide},
    popoverBuilder: (_, _) => TextFieldTapRegion(
      child: Padding(
        padding: const .symmetric(horizontal: 5.0),
        child: FTimePicker(
          control: .managed(controller: controller.picker),
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
