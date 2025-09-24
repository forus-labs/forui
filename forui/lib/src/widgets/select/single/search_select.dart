part of 'select.dart';

class _SearchSelect<T> extends FSelect<T> {
  final FSelectSearchFieldProperties searchFieldProperties;
  final FutureOr<Iterable<T>> Function(String query) filter;
  final FSelectSearchContentBuilder<T> contentBuilder;
  final Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder;
  final Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder;

  const _SearchSelect({
    required this.filter,
    required this.contentBuilder,
    required super.format,
    this.searchFieldProperties = const FSelectSearchFieldProperties(),
    this.contentLoadingBuilder = FSelect.defaultContentLoadingBuilder,
    this.contentErrorBuilder,
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
  _SearchSelectState<T> createState() => _SearchSelectState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('searchFieldProperties', searchFieldProperties))
      ..add(DiagnosticsProperty('filter', filter))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(ObjectFlagProperty.has('contentBuilder', contentBuilder))
      ..add(ObjectFlagProperty('searchLoadingBuilder', contentLoadingBuilder, ifPresent: 'searchLoadingBuilder'))
      ..add(ObjectFlagProperty('searchErrorBuilder', contentErrorBuilder, ifPresent: 'searchErrorBuilder'));
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
    emptyBuilder: (context) => widget.contentEmptyBuilder(context, style),
    loadingBuilder: widget.contentLoadingBuilder,
    errorBuilder: widget.contentErrorBuilder,
  );
}
