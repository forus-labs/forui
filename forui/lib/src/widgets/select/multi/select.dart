// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form/multi_value_form_field.dart';
import 'package:forui/src/foundation/notifiers.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/inherited_controller.dart';
import 'package:forui/src/widgets/select/content/search_content.dart';

part 'basic_select.dart';

part 'search_select.dart';

part 'select.design.dart';

/// A function that builds a tag in a [FMultiSelect].
typedef FMultiSelectTagBuilder<T> =
    Widget Function(
      BuildContext context,
      bool enabled,
      FMultiValueNotifier<T> controller,
      FMultiSelectStyle style,
      T value,
      Widget label,
    );

/// A multi-select displays a list of options for the user to pick from.
///
/// It is a [FormField] and therefore can be used in a [Form] widget.
///
/// ## Why am I getting "No FMultiSelect<$T> found in context..." assertion errors?
/// This is likely because Dart could not infer [FMultiSelect]'s type parameter. Try specifying the type parameter for
/// `FMultiSelect`, `FSelectSection`, and `FSelectItem` (e.g., `FMultiSelect<MyType>`).
///
/// See:
/// * https://forui.dev/docs/form/multi-select for working examples.
/// * [FMultiValueNotifier] for customizing the behavior of a select.
/// * [FMultiSelectStyle] for customizing the appearance of a select.
abstract class FMultiSelect<T> extends StatefulWidget {
  /// The default suffix builder that shows a upward and downward facing chevron icon.
  static Widget defaultIconBuilder(BuildContext _, FMultiSelectStyle style, Set<WidgetState> states) => Padding(
    padding: const .directional(start: 4),
    child: IconTheme(data: style.fieldStyle.iconStyle.resolve(states), child: const Icon(FIcons.chevronDown)),
  );

  /// The default tag builder that builds a [FMultiSelectTag] with the given value.
  static Widget defaultTagBuilder<T>(
    BuildContext context,
    bool enabled,
    FMultiValueNotifier<T> controller,
    FMultiSelectStyle style,
    T value,
    Widget label,
  ) => FMultiSelectTag(
    style: style.tagStyle,
    label: label,
    onPress: enabled ? () => controller.update(value, add: false) : null,
  );

  /// The default loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultContentLoadingBuilder(BuildContext _, FSelectSearchStyle style) => Padding(
    padding: const EdgeInsets.all(13),
    child: FCircularProgress(style: style.progressStyle),
  );

  /// The default content empty builder that shows a localized message when there are no results.
  static Widget defaultContentEmptyBuilder(BuildContext context, FMultiSelectStyle style) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const .symmetric(horizontal: 8, vertical: 14),
      child: Text(localizations.selectNoResults, style: style.emptyTextStyle, textAlign: TextAlign.center),
    );
  }

  static String? _defaultValidator(Object? _) => null;

  /// The control that manages the multi-select's state.
  ///
  /// Defaults to [FMultiValueControl.managed] if not provided.
  final FMultiValueControl<T>? control;

  /// Defines how the multi-select's popover is controlled.
  ///
  /// Defaults to [FPopoverControl.managed].
  final FPopoverControl popoverControl;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create multi-select
  /// ```
  final FMultiSelectStyle Function(FMultiSelectStyle style)? style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// Builds a widget at the start of the select that can be pressed to toggle the popover. Defaults to no icon.
  final FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder;

  /// Builds a widget at the end of the select that can be pressed to toggle the popover. Defaults to [defaultIconBuilder].
  final FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.FFormFieldProperties.errorBuilder}
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.FFormFieldProperties.enabled}
  final bool enabled;

  /// {@macro forui.foundation.FFormFieldProperties.onSaved}
  final void Function(Set<T> values)? onSaved;

  /// {@macro forui.foundation.FFormFieldProperties.onReset}
  final VoidCallback? onReset;

  /// {@macro forui.foundation.FFormFieldProperties.validator}
  final String? Function(Set<T> values) validator;

  /// {@macro forui.foundation.FFormFieldProperties.autovalidateMode}
  final AutovalidateMode autovalidateMode;

  /// {@macro forui.foundation.FFormFieldProperties.forceErrorText}
  final String? forceErrorText;

  /// The hint.
  final Widget? hint;

  /// Whether to keep the hint visible when there are selected items. Defaults to true.
  final bool keepHint;

  /// The function used to sort the selected items. Defaults to the order in which they were selected.
  final int Function(T a, T b)? sort;

  /// The function formats the value for display in the select's field.
  final Widget Function(T value) format;

  /// The function used to build the tags for selected items.
  final FMultiSelectTagBuilder<T> tagBuilder;

  /// The alignment of the text within the select. Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// The text direction of the select.
  final TextDirection? textDirection;

  /// True if a clear button should be shown. Defaults to false.
  final bool clearable;

  /// The alignment point on the popover. Defaults to [AlignmentDirectional.topStart].
  final AlignmentGeometry contentAnchor;

  /// The alignment point on the select's field. Defaults to [AlignmentDirectional.bottomStart].
  final AlignmentGeometry fieldAnchor;

  /// The constraints to apply to the popover. Defaults to `const FAutoWidthPortalConstraints(maxHeight: 300)`.
  final FPortalConstraints contentConstraints;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing contentSpacing;

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow contentOverflow;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset contentOffset;

  /// {@macro forui.widgets.FPopover.hideRegion}
  final FPopoverHideRegion contentHideRegion;

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? contentGroupId;

  /// The builder that is called when the select is empty. Defaults to [FSelect.defaultContentEmptyBuilder].
  final Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder;

  /// The content's scroll controller.
  final ScrollController? contentScrollController;

  /// True if the content should show scroll handles instead of a scrollbar. Defaults to false.
  final bool contentScrollHandles;

  /// The content's scroll physics. Defaults to [ClampingScrollPhysics].
  final ScrollPhysics contentPhysics;

  /// The divider used to separate the content items. Defaults to [FItemDivider.none].
  final FItemDivider contentDivider;

  /// Creates a [FMultiSelect] from the given [items].
  ///
  /// For more control over the appearance of items, use [FMultiSelect.rich].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FMultiSelect({
    required Map<String, T> items,
    FMultiValueControl<T>? control,
    FPopoverControl popoverControl = const .managed(),
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    void Function(Set<T> values)? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = .onUnfocus,
    String? forceErrorText,
    String? Function(Set<T> values) validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Widget? hint,
    bool keepHint = true,
    int Function(T a, T b)? sort,
    FMultiSelectTagBuilder<T>? tagBuilder,
    TextAlign textAlign = .start,
    TextDirection? textDirection,
    bool clearable = false,
    AlignmentGeometry contentAnchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints contentConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing contentSpacing = const .spacing(4),
    FPortalOverflow contentOverflow = .flip,
    Offset contentOffset = Offset.zero,
    FPopoverHideRegion contentHideRegion = .excludeChild,
    Object? contentGroupId,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder =
        FMultiSelect.defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = .none,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return .rich(
      control: control,
      popoverControl: popoverControl,
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      label: label,
      description: description,
      format: (value) => Text(inverse[value] ?? ''),
      sort: sort,
      tagBuilder: tagBuilder,
      enabled: enabled,
      onSaved: onSaved,
      onReset: onReset,
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      validator: validator,
      errorBuilder: errorBuilder,
      hint: hint,
      keepHint: keepHint,
      textAlign: textAlign,
      textDirection: textDirection,
      clearable: clearable,
      contentAnchor: contentAnchor,
      fieldAnchor: fieldAnchor,
      contentConstraints: contentConstraints,
      contentSpacing: contentSpacing,
      contentOverflow: contentOverflow,
      contentOffset: contentOffset,
      contentHideRegion: contentHideRegion,
      contentGroupId: contentGroupId,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      key: key,
      children: [for (final MapEntry(:key, :value) in items.entries) .item(title: Text(key), value: value)],
    );
  }

  /// Creates a [FMultiSelect] with the given [children].
  const factory FMultiSelect.rich({
    required Widget Function(T value) format,
    required List<FSelectItemMixin> children,
    FMultiValueControl<T>? control,
    FPopoverControl popoverControl,
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    void Function(Set<T> values)? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    String? Function(Set<T> values) validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    Widget? hint,
    bool keepHint,
    int Function(T, T)? sort,
    FMultiSelectTagBuilder<T>? tagBuilder,
    TextAlign textAlign,
    TextDirection? textDirection,
    bool clearable,
    AlignmentGeometry contentAnchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints contentConstraints,
    FPortalSpacing contentSpacing,
    FPortalOverflow contentOverflow,
    Offset contentOffset,
    FPopoverHideRegion contentHideRegion,
    Object? contentGroupId,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    Key? key,
  }) = _BasicSelect<T>;

  /// Creates a searchable select with dynamic content based on the given [items] and search input.
  ///
  /// The [searchFieldProperties] can be used to customize the search field.
  ///
  /// The [filter] callback produces a list of items based on the search query. Defaults to returning items that start
  /// with the query string.
  /// The [contentLoadingBuilder] is used to show a loading indicator while the search results is processed
  /// asynchronously by [filter].
  /// The [contentErrorBuilder] is used to show an error message when [filter] is asynchronous and fails.
  ///
  /// For more control over the appearance of items, use [FMultiSelect.searchBuilder].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FMultiSelect.search(
    Map<String, T> items, {
    FutureOr<Iterable<T>> Function(String query)? filter,
    FSelectSearchFieldProperties searchFieldProperties = const FSelectSearchFieldProperties(),
    Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder =
        FMultiSelect.defaultContentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    FMultiValueControl<T>? control,
    FPopoverControl popoverControl = const .managed(),
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    void Function(Set<T> values)? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = .onUnfocus,
    String? forceErrorText,
    String? Function(Set<T> values) validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Widget? hint,
    bool keepHint = true,
    int Function(T, T)? sort,
    FMultiSelectTagBuilder<T>? tagBuilder,
    TextAlign textAlign = .start,
    TextDirection? textDirection,
    bool clearable = false,
    AlignmentGeometry contentAnchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints contentConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing contentSpacing = const .spacing(4),
    FPortalOverflow contentOverflow = .flip,
    Offset contentOffset = .zero,
    FPopoverHideRegion contentHideRegion = .excludeChild,
    Object? contentGroupId,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder = defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = .none,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return .searchBuilder(
      format: (value) => Text(inverse[value] ?? ''),
      filter:
          filter ??
          (query) => items.entries
              .where((entry) => entry.key.toLowerCase().startsWith(query.toLowerCase()))
              .map((entry) => entry.value)
              .toList(),
      contentBuilder: (context, _, values) => [
        for (final value in values) .item<T>(title: Text(inverse[value]!), value: value),
      ],
      searchFieldProperties: searchFieldProperties,
      contentLoadingBuilder: contentLoadingBuilder,
      contentErrorBuilder: contentErrorBuilder,
      control: control,
      popoverControl: popoverControl,
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      label: label,
      description: description,
      enabled: enabled,
      onSaved: onSaved,
      onReset: onReset,
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      validator: validator,
      errorBuilder: errorBuilder,
      hint: hint,
      keepHint: keepHint,
      sort: sort,
      tagBuilder: tagBuilder,
      textAlign: textAlign,
      textDirection: textDirection,
      clearable: clearable,
      contentAnchor: contentAnchor,
      fieldAnchor: fieldAnchor,
      contentConstraints: contentConstraints,
      contentSpacing: contentSpacing,
      contentOverflow: contentOverflow,
      contentOffset: contentOffset,
      contentHideRegion: contentHideRegion,
      contentGroupId: contentGroupId,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      key: key,
    );
  }

  /// Creates a searchable select with dynamic content based on search input.
  ///
  /// The [searchFieldProperties] can be used to customize the search field.
  ///
  /// The [filter] callback produces a list of items based on the search query either synchronously or asynchronously.
  /// The [contentBuilder] callback builds the list of items based on search results returned by [filter].
  /// The [contentLoadingBuilder] is used to show a loading indicator while the search results is processed
  /// asynchronously by [filter].
  /// The [contentErrorBuilder] is used to show an error message when [filter] is asynchronous and fails.
  const factory FMultiSelect.searchBuilder({
    required Widget Function(T) format,
    required FutureOr<Iterable<T>> Function(String query) filter,
    required FSelectSearchContentBuilder<T> contentBuilder,
    FSelectSearchFieldProperties searchFieldProperties,
    Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    FMultiValueControl<T>? control,
    FPopoverControl popoverControl,
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    void Function(Set<T> values)? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    String? Function(Set<T> values) validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    Widget? hint,
    bool keepHint,
    int Function(T, T)? sort,
    FMultiSelectTagBuilder<T>? tagBuilder,
    TextAlign textAlign,
    TextDirection? textDirection,
    bool clearable,
    AlignmentGeometry contentAnchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints contentConstraints,
    FPortalSpacing contentSpacing,
    FPortalOverflow contentOverflow,
    Offset contentOffset,
    FPopoverHideRegion contentHideRegion,
    Object? contentGroupId,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    Key? key,
  }) = _SearchSelect<T>;

  const FMultiSelect._({
    required this.format,
    this.control,
    this.popoverControl = const .managed(),
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.prefixBuilder,
    this.suffixBuilder = defaultIconBuilder,
    this.label,
    this.description,
    this.enabled = true,
    this.onSaved,
    this.onReset,
    this.autovalidateMode = .onUnfocus,
    this.forceErrorText,
    this.validator = _defaultValidator,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.hint,
    this.keepHint = true,
    this.sort,
    this.textAlign = .start,
    this.textDirection,
    this.clearable = false,
    this.contentAnchor = AlignmentDirectional.topStart,
    this.fieldAnchor = AlignmentDirectional.bottomStart,
    this.contentConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    this.contentSpacing = const .spacing(4),
    this.contentOverflow = .flip,
    this.contentOffset = .zero,
    this.contentHideRegion = .excludeChild,
    this.contentGroupId,
    this.contentEmptyBuilder = FMultiSelect.defaultContentEmptyBuilder,
    this.contentScrollController,
    this.contentScrollHandles = false,
    this.contentPhysics = const ClampingScrollPhysics(),
    this.contentDivider = .none,
    FMultiSelectTagBuilder<T>? tagBuilder,
    super.key,
  }) : tagBuilder = tagBuilder ?? defaultTagBuilder;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('popoverControl', popoverControl))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('format', format))
      ..add(ObjectFlagProperty.has('sort', sort))
      ..add(ObjectFlagProperty.has('tagBuilder', tagBuilder))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(FlagProperty('keepHint', value: keepHint, ifTrue: 'keepHint'))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(DiagnosticsProperty('contentAnchor', contentAnchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('contentConstraints', contentConstraints))
      ..add(DiagnosticsProperty('contentSpacing', contentSpacing))
      ..add(ObjectFlagProperty.has('contentOverflow', contentOverflow))
      ..add(DiagnosticsProperty('contentOffset', contentOffset))
      ..add(EnumProperty('contentHideRegion', contentHideRegion))
      ..add(DiagnosticsProperty('contentGroupId', contentGroupId))
      ..add(ObjectFlagProperty.has('emptyBuilder', contentEmptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(FlagProperty('contentScrollHandles', value: contentScrollHandles, ifTrue: 'contentScrollHandles'))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics))
      ..add(EnumProperty('contentDivider', contentDivider));
  }
}

abstract class _FMultiSelectState<S extends FMultiSelect<T>, T> extends State<S> with TickerProviderStateMixin {
  late FMultiValueNotifier<T> _controller;
  late FPopoverController _popoverController;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = (widget.control ?? FMultiValueControl<T>.managed()).create(_handleChange);
    _popoverController = widget.popoverControl.create(_handlePopoverChange, this);
    _focus = widget.focusNode ?? FocusNode(debugLabel: 'FMultiSelect');
  }

  @override
  void didUpdateWidget(covariant S old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? FocusNode(debugLabel: 'FMultiSelect');
    }

    final current = widget.control ?? FMultiValueControl<T>.managed();
    final previous = old.control ?? FMultiValueControl<T>.managed();
    _controller = current.update(previous, _controller, _handleChange).$1;
    _popoverController = widget.popoverControl
        .update(old.popoverControl, _popoverController, _handlePopoverChange, this)
        .$1;
  }

  @override
  void dispose() {
    widget.popoverControl.dispose(_popoverController, _handlePopoverChange);
    (widget.control ?? FMultiValueControl<T>.managed()).dispose(_controller, _handleChange);
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }

  void _handleChange() {
    if (widget.control case FMultiValueManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  void _handlePopoverChange() {
    if (widget.popoverControl case FPopoverManagedControl(:final onChange?)) {
      onChange(_popoverController.status.isForwardOrCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.multiSelectStyle) ?? context.theme.multiSelectStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final direction = widget.textDirection ?? Directionality.maybeOf(context) ?? .ltr;
    final padding = style.fieldStyle.contentPadding.resolve(direction);

    return MultiValueFormField<T>(
      controller: _controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      onSaved: widget.onSaved == null ? null : (v) => widget.onSaved!(v ?? {}),
      validator: (v) => widget.validator(v ?? {}),
      builder: (state) {
        final values = widget.sort == null ? _controller.value : _controller.value.sorted(widget.sort!);
        return Directionality(
          textDirection: direction,
          child: FLabel(
            axis: Axis.vertical,
            states: {if (!widget.enabled) WidgetState.disabled, if (state.hasError) WidgetState.error},
            label: widget.label,
            style: style.fieldStyle,
            description: widget.description,
            // Error should never be null as doing so causes the widget tree to change.
            error: state.errorText == null ? const SizedBox() : widget.errorBuilder(context, state.errorText!),
            child: FPopover(
              control: .managed(controller: _popoverController),
              style: style.contentStyle,
              constraints: widget.contentConstraints,
              popoverAnchor: widget.contentAnchor,
              childAnchor: widget.fieldAnchor,
              spacing: widget.contentSpacing,
              overflow: widget.contentOverflow,
              offset: widget.contentOffset,
              hideRegion: widget.contentHideRegion,
              groupId: widget.contentGroupId,
              shortcuts: {const SingleActivator(LogicalKeyboardKey.escape): _toggle},
              popoverBuilder: (context, controller) => InheritedSelectController<T>(
                popover: _popoverController,
                contains: (value) => _controller.value.contains(value),
                focus: (value) => _controller.value.lastOrNull == value,
                onPress: (value) => _controller.update(value, add: !_controller.value.contains(value)),
                child: content(context, style),
              ),
              child: FTappable(
                style: style.fieldStyle.tappableStyle,
                focusNode: _focus,
                onPress: widget.enabled ? _toggle : null,
                builder: (context, states, child) {
                  states = {
                    ...states,
                    if (!widget.enabled) WidgetState.disabled,
                    if (state.hasError) WidgetState.error,
                  };
                  return DecoratedBox(
                    decoration: style.fieldStyle.decoration.resolve(states),
                    child: Padding(
                      padding: padding.copyWith(top: 0, bottom: 0),
                      child: DefaultTextStyle.merge(
                        textAlign: widget.textAlign,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.prefixBuilder case final prefix?) prefix(context, style, states),
                            Expanded(
                              child: Padding(
                                padding: padding.copyWith(left: 0, right: 0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: style.fieldStyle.spacing,
                                  runSpacing: style.fieldStyle.runSpacing,
                                  children: [
                                    for (final value in values)
                                      widget.tagBuilder(
                                        context,
                                        widget.enabled,
                                        _controller,
                                        style,
                                        value,
                                        widget.format(value),
                                      ),
                                    if (widget.keepHint || _controller.value.isEmpty)
                                      Padding(
                                        padding: style.fieldStyle.hintPadding,
                                        child: DefaultTextStyle.merge(
                                          style: style.fieldStyle.hintTextStyle.resolve(states),
                                          child: widget.hint ?? Text(localizations.multiSelectHint),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (widget.enabled && widget.clearable && _controller.value.isNotEmpty)
                              Padding(
                                padding: style.fieldStyle.clearButtonPadding,
                                child: FButton.icon(
                                  style: style.fieldStyle.clearButtonStyle,
                                  onPress: () => _controller.value = {},
                                  child: Icon(
                                    FIcons.x,
                                    semanticLabel: localizations.textFieldClearButtonSemanticsLabel,
                                  ),
                                ),
                              ),
                            if (widget.suffixBuilder case final suffix?) suffix(context, style, states),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggle() {
    _popoverController.status.isCompleted ? _focus.requestFocus() : _focus.unfocus();
    _popoverController.toggle();
  }

  /// Builds the content displayed in the popover.
  Widget content(BuildContext context, FMultiSelectStyle style);
}

/// A [FMultiSelect]'s style.
class FMultiSelectStyle with Diagnosticable, _$FMultiSelectStyleFunctions {
  /// The field's style.
  @override
  final FMultiSelectFieldStyle fieldStyle;

  /// The tag's style.
  @override
  final FMultiSelectTagStyle tagStyle;

  /// The search's style.
  @override
  final FSelectSearchStyle searchStyle;

  /// The content's style.
  @override
  final FSelectContentStyle contentStyle;

  /// The default text style when there are no results.
  @override
  final TextStyle emptyTextStyle;

  /// Creates a [FMultiSelectStyle].
  FMultiSelectStyle({
    required this.fieldStyle,
    required this.tagStyle,
    required this.searchStyle,
    required this.contentStyle,
    required this.emptyTextStyle,
  });

  /// Creates a [FMultiSelectStyle] that inherits its properties.
  FMultiSelectStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        fieldStyle: .inherit(colors: colors, typography: typography, style: style),
        tagStyle: .inherit(colors: colors, typography: typography, style: style),
        searchStyle: .inherit(colors: colors, typography: typography, style: style),
        contentStyle: .inherit(colors: colors, typography: typography, style: style),
        emptyTextStyle: typography.sm,
      );
}

/// A [FMultiSelectFieldStyle]'s style.
class FMultiSelectFieldStyle extends FLabelStyle with Diagnosticable, _$FMultiSelectFieldStyleFunctions {
  /// The multi-select field's decoration.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<Decoration> decoration;

  /// The multi-select field's padding. Defaults to `EdgeInsets.only(start: 10, top: 6, bottom: 6, end: 8)`.
  @override
  final EdgeInsetsGeometry contentPadding;

  /// The spacing between tags. Defaults to 4.
  @override
  final double spacing;

  /// The spacing between the rows of tags. Defaults to 4.
  @override
  final double runSpacing;

  /// The multi-select field hint's text style.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<TextStyle> hintTextStyle;

  /// The multi-select field's hint padding. Defaults to `EdgeInsetsDirectional.only(start: 4, top: 4, bottom: 4)`.
  ///
  /// The vertical padding should typically be the same as the [FMultiSelectTagStyle.padding].
  @override
  final EdgeInsetsGeometry hintPadding;

  /// The multi-select field's icon style.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The clear button's style when [FMultiSelect.clearable] is true.
  @override
  final FButtonStyle clearButtonStyle;

  /// The padding surrounding the clear button. Defaults to [EdgeInsets.zero].
  @override
  final EdgeInsetsGeometry clearButtonPadding;

  /// The multi-select field's tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FMultiSelectFieldStyle].
  FMultiSelectFieldStyle({
    required this.decoration,
    required this.hintTextStyle,
    required this.iconStyle,
    required this.clearButtonStyle,
    required this.tappableStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.contentPadding = const .directional(start: 10, top: 6, bottom: 6, end: 8),
    this.hintPadding = const .directional(start: 4, top: 4, bottom: 4),
    this.spacing = 4,
    this.runSpacing = 4,
    this.clearButtonPadding = .zero,
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FMultiSelectFieldStyle] that inherits its properties.
  factory FMultiSelectFieldStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) {
    final label = FLabelStyles.inherit(style: style).verticalStyle;
    final ghost = FButtonStyles.inherit(colors: colors, typography: typography, style: style).ghost;

    return .new(
      decoration: FWidgetStateMap({
        WidgetState.error: BoxDecoration(
          border: .all(color: colors.error, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled: BoxDecoration(
          border: .all(color: colors.disable(colors.border), width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.focused: BoxDecoration(
          border: .all(color: colors.primary, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.any: BoxDecoration(
          border: .all(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
      }),
      hintTextStyle: FWidgetStateMap({
        WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.border)),
        WidgetState.any: typography.sm.copyWith(color: colors.mutedForeground),
      }),
      iconStyle: FWidgetStateMap({
        WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 17),
        WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 17),
      }),
      clearButtonStyle: ghost.copyWith(
        iconContentStyle: ghost.iconContentStyle.copyWith(
          iconStyle: FWidgetStateMap({
            WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 17),
            WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 17),
          }),
        ),
      ),
      tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
      labelTextStyle: style.formFieldStyle.labelTextStyle,
      descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
      errorTextStyle: style.formFieldStyle.errorTextStyle,
      labelPadding: label.labelPadding,
      descriptionPadding: label.descriptionPadding,
      errorPadding: label.errorPadding,
      childPadding: label.childPadding,
    );
  }
}
