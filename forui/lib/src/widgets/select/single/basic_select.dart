part of 'select.dart';

class _BasicSelect<T> extends FSelect<T> {
  final List<FSelectItemMixin> children;

  const _BasicSelect({
    required this.children,
    required super.format,
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
    super.onChange,
    super.onSaved,
    super.onReset,
    super.autovalidateMode,
    super.forceErrorText,
    super.validator,
    super.errorBuilder,
    super.hint,
    super.textAlign,
    super.textAlignVertical,
    super.textDirection,
    super.expands,
    super.mouseCursor,
    super.canRequestFocus,
    super.clearable,
    super.anchor,
    super.fieldAnchor,
    super.popoverConstraints,
    super.spacing,
    super.shift,
    super.offset,
    super.hideRegion,
    super.autoHide,
    super.contentEmptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.initialValue,
    super.key,
  }) : super._();

  @override
  _BasicSelectState<T> createState() => _BasicSelectState<T>();
}

class _BasicSelectState<T> extends _State<_BasicSelect<T>, T> {
  @override
  Widget content(BuildContext context, FSelectStyle style) {
    if (widget.children.isEmpty) {
      return widget.contentEmptyBuilder(context, style);
    }

    return Content<T>(
      controller: widget.contentScrollController,
      style: style.contentStyle,
      first: _controller.value == null,
      enabled: widget.enabled,
      scrollHandles: widget.contentScrollHandles,
      physics: widget.contentPhysics,
      divider: widget.contentDivider,
      children: widget.children,
    );
  }
}
