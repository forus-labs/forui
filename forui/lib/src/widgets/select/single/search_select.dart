part of 'select.dart';

class _SearchSelect<T> extends FSelect<T> {
  final FSelectSearchFieldProperties searchFieldProperties;
  final FSelectSearchFilter<T> filter;
  final FSelectSearchContentBuilder<T> contentBuilder;
  final ValueWidgetBuilder<FSelectSearchStyle> searchLoadingBuilder;
  final Widget Function(BuildContext, Object?, StackTrace)? searchErrorBuilder;

  const _SearchSelect({
    required this.filter,
    required this.contentBuilder,
    required super.format,
    this.searchFieldProperties = const FSelectSearchFieldProperties(),
    this.searchLoadingBuilder = FSelect.defaultSearchLoadingBuilder,
    this.searchErrorBuilder,
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
    super.hideOnTapOutside,
    super.autoHide,
    super.emptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.initialValue,
    super.key,
  }) : super._();

  @override
  _SearchSelectState<T> createState() => _SearchSelectState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('searchFieldProperties', searchFieldProperties))
      ..add(DiagnosticsProperty('filter', filter))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(ObjectFlagProperty.has('contentBuilder', contentBuilder))
      ..add(ObjectFlagProperty('searchLoadingBuilder', searchLoadingBuilder, ifPresent: 'searchLoadingBuilder'))
      ..add(ObjectFlagProperty('searchErrorBuilder', searchErrorBuilder, ifPresent: 'searchErrorBuilder'));
  }
}

class _SearchSelectState<T> extends _State<_SearchSelect<T>, T> {
  @override
  Widget content(BuildContext context, FSelectStyle style) => SearchContent<T>(
    scrollController: widget.contentScrollController,
    searchStyle: style.searchStyle,
    contentStyle: style.contentStyle,
    properties: widget.searchFieldProperties,
    scrollHandles: widget.contentScrollHandles,
    first: _controller.value == null,
    enabled: widget.enabled,
    physics: widget.contentPhysics,
    divider: widget.contentDivider,
    filter: widget.filter,
    builder: widget.contentBuilder,
    emptyBuilder: (context) => widget.emptyBuilder(context, style, null),
    loadingBuilder: widget.searchLoadingBuilder,
    errorBuilder: widget.searchErrorBuilder,
  );
}
