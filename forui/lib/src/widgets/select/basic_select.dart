part of 'select.dart';

class _BasicSelect<T> extends FSelect<T> {
  final List<FSelectItemMixin> children;

  const _BasicSelect({
    required this.children,
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
    super.validator,
    super.errorBuilder,
    super.format,
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
    super.shift,
    super.hideOnTapOutside,
    super.directionPadding,
    super.autoHide,
    super.emptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.key,
  }) : super._();

  @override
  _BasicSelectState<T> createState() => _BasicSelectState<T>();
}

class _BasicSelectState<T> extends _State<_BasicSelect<T>, T> {
  @override
  Widget content(BuildContext context, FSelectStyle style) {
    if (widget.children.isEmpty) {
      return widget.emptyBuilder(context, style, null);
    }

    return Content<T>(
      controller: widget.contentScrollController,
      style: style.contentStyle,
      first: _controller.value == null,
      enabled: widget.enabled,
      scrollHandles: widget.contentScrollHandles,
      physics: widget.contentPhysics,
      children: widget.children,
    );
  }
}
