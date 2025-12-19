part of 'select.dart';

class _BasicSelect<T> extends FMultiSelect<T> {
  final List<FSelectItemMixin> children;

  const _BasicSelect({
    required this.children,
    required super.format,
    super.control,
    super.popoverControl,
    super.style,
    super.autofocus,
    super.focusNode,
    super.prefixBuilder,
    super.suffixBuilder,
    super.label,
    super.description,
    super.enabled,
    super.onSaved,
    super.onReset,
    super.autovalidateMode,
    super.forceErrorText,
    super.validator,
    super.errorBuilder,
    super.hint,
    super.keepHint,
    super.sort,
    super.textAlign,
    super.textDirection,
    super.clearable,
    super.contentAnchor,
    super.fieldAnchor,
    super.contentConstraints,
    super.contentSpacing,
    super.contentOverflow,
    super.contentOffset,
    super.contentHideRegion,
    super.contentGroupId,
    super.contentEmptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.tagBuilder,
    super.key,
  }) : super._();

  @override
  State<_BasicSelect<T>> createState() => _BasicSelectState<T>();
}

class _BasicSelectState<T> extends _FMultiSelectState<_BasicSelect<T>, T> {
  @override
  Widget content(BuildContext context, FMultiSelectStyle style) {
    if (widget.children.isEmpty) {
      return widget.contentEmptyBuilder(context, style);
    }

    return Content<T>(
      controller: widget.contentScrollController,
      style: style.contentStyle,
      first: _controller.value.isEmpty,
      enabled: widget.enabled,
      scrollHandles: widget.contentScrollHandles,
      physics: widget.contentPhysics,
      divider: widget.contentDivider,
      children: widget.children,
    );
  }
}
