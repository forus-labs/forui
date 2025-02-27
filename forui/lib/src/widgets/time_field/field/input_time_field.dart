part of '../time_field.dart';

class _InputTimeField extends FTimeField {
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool expands;
  final VoidCallback? onEditingComplete;
  final ValueChanged<FTime>? onSubmit;
  final MouseCursor? mouseCursor;
  final bool canRequestFocus;

  const _InputTimeField({
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.onEditingComplete,
    this.onSubmit,
    this.mouseCursor,
    this.canRequestFocus = true,
    super.controller,
    super.style,
    super.hour24,
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
  State<_InputTimeField> createState() => _InputTimeFieldState();

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
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'));
  }
}

class _InputTimeFieldState extends _FTimeFieldState<_InputTimeField> {
  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.timeFieldStyle;
    ValueWidgetBuilder<FTextFieldStateStyle>? prefix;
    ValueWidgetBuilder<FTextFieldStateStyle>? suffix;

    return TimeField(
      timeController: _controller,
      hour24: widget.hour24,
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
      onTap: null,
      canRequestFocus: widget.canRequestFocus,
      prefixBuilder: prefix,
      suffixBuilder: suffix,
      localizations: FLocalizations.of(context) ?? FDefaultLocalizations(),
      builder: (_, _, child) => child!,
    );
  }
}