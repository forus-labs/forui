import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/search_content.dart';
import 'package:forui/src/widgets/select/multi/field.dart';

part 'select.design.dart';

/// A function that builds a tag in a [FMultiSelect].
typedef FMultiSelectTagBuilder<T> =
    Widget Function(
      BuildContext context,
      FMultiSelectController<T> controller,
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
/// * [FMultiSelectController] for customizing the behavior of a select.
/// * [FMultiSelectStyle] for customizing the appearance of a select.
abstract class FMultiSelect<T> extends StatelessWidget {
  /// The default suffix builder that shows a upward and downward facing chevron icon.
  static Widget defaultIconBuilder(BuildContext _, FMultiSelectStyle style, Set<WidgetState> states) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 4),
    child: IconTheme(data: style.fieldStyle.iconStyle, child: const Icon(FIcons.chevronDown)),
  );

  /// The default tag builder that builds a [FMultiSelectTag] with the given value.
  static Widget defaultTagBuilder<T>(
    BuildContext context,
    FMultiSelectController<T> controller,
    FMultiSelectStyle style,
    T value,
    Widget label,
  ) => FMultiSelectTag(style: style.tagStyle, label: label, onPress: () => controller.update(value, add: false));

  /// The default loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultContentLoadingBuilder(BuildContext _, FSelectSearchStyle style) => Padding(
    padding: const EdgeInsets.all(13),
    child: FCircularProgress(style: style.progressStyle),
  );

  /// The default content empty builder that shows a localized message when there are no results.
  static Widget defaultContentEmptyBuilder(BuildContext context, FMultiSelectStyle style) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Text(localizations.selectNoResults, style: style.emptyTextStyle, textAlign: TextAlign.center),
    );
  }

  static String? _defaultValidator(Object? _) => null;

  /// The controller.
  final FMultiSelectController<T>? controller;

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

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// Handler called when the selected value changes.
  final ValueChanged<Set<T>>? onChange;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final void Function(Set<T> values)? onSaved;

  /// {@macro forui.foundation.form_field_properties.onReset}
  final VoidCallback? onReset;

  /// {@macro forui.foundation.form_field_properties.validator}
  final String? Function(Set<T> values) validator;

  /// {@macro forui.foundation.form_field_properties.autovalidateMode}
  final AutovalidateMode autovalidateMode;

  /// {@macro forui.foundation.form_field_properties.forceErrorText}
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
  final AlignmentGeometry anchor;

  /// The alignment point on the select's field. Defaults to [AlignmentDirectional.bottomStart].
  final AlignmentGeometry fieldAnchor;

  /// The constraints to apply to the popover. Defaults to `const FAutoWidthPortalConstraints(maxHeight: 300)`.
  final FPortalConstraints popoverConstraints;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.hideRegion}
  final FPopoverHideRegion hideRegion;

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

  /// The minimum number of items that needs to be selected. Defaults to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both the [controller] and [min] are provided.
  final int min;

  /// The maximum number of items that can be selected. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both the [controller] and [max] are provided.
  final int? max;

  /// The initial value.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both the [controller] and [initialValue] are provided.
  final Set<T> initialValue;

  /// Creates a [FMultiSelect] from the given [items].
  ///
  /// For more control over the appearance of items, use [FMultiSelect.rich].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FMultiSelect({
    required Map<String, T> items,
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<Set<T>>? onChange,
    void Function(Set<T> values)? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    String? Function(Set<T> values) validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Widget? hint,
    bool keepHint = true,
    int Function(T a, T b)? sort,
    Widget Function(
      BuildContext context,
      FMultiSelectController<T> controller,
      FMultiSelectStyle style,
      T value,
      Widget label,
    )?
    tagBuilder,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool clearable = false,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FPopoverHideRegion hideRegion = FPopoverHideRegion.excludeChild,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder =
        FMultiSelect.defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    int min = 0,
    int? max,
    Set<T>? initialValue,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return FMultiSelect<T>.rich(
      controller: controller,
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
      onChange: onChange,
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
      anchor: anchor,
      fieldAnchor: fieldAnchor,
      popoverConstraints: popoverConstraints,
      spacing: spacing,
      shift: shift,
      offset: offset,
      hideRegion: hideRegion,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      min: min,
      max: max,
      initialValue: initialValue,
      key: key,
      children: [for (final MapEntry(:key, :value) in items.entries) FSelectItem(title: Text(key), value: value)],
    );
  }

  /// Creates a [FMultiSelect] with the given [children].
  factory FMultiSelect.rich({
    required Widget Function(T value) format,
    required List<FSelectItemMixin> children,
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<Set<T>>? onChange,
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
    AlignmentGeometry anchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints popoverConstraints,
    FPortalSpacing spacing,
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift,
    Offset offset,
    FPopoverHideRegion hideRegion,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    int min,
    int? max,
    Set<T>? initialValue,
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
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<Set<T>>? onChange,
    void Function(Set<T> values)? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    String? Function(Set<T> values) validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Widget? hint,
    bool keepHint = true,
    int Function(T, T)? sort,
    FMultiSelectTagBuilder<T>? tagBuilder,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool clearable = false,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FPopoverHideRegion hideRegion = FPopoverHideRegion.excludeChild,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder = defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    int min = 0,
    int? max,
    Set<T>? initialValue,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return FMultiSelect<T>.searchBuilder(
      format: (value) => Text(inverse[value] ?? ''),
      filter:
          filter ??
          (query) => items.entries
              .where((entry) => entry.key.toLowerCase().startsWith(query.toLowerCase()))
              .map((entry) => entry.value)
              .toList(),
      contentBuilder: (context, _, values) => [
        for (final value in values) FSelectItem<T>(title: Text(inverse[value]!), value: value),
      ],
      searchFieldProperties: searchFieldProperties,
      contentLoadingBuilder: contentLoadingBuilder,
      contentErrorBuilder: contentErrorBuilder,
      controller: controller,
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      label: label,
      description: description,
      enabled: enabled,
      onChange: onChange,
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
      anchor: anchor,
      fieldAnchor: fieldAnchor,
      popoverConstraints: popoverConstraints,
      spacing: spacing,
      shift: shift,
      offset: offset,
      hideRegion: hideRegion,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      min: min,
      max: max,
      initialValue: initialValue,
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
  factory FMultiSelect.searchBuilder({
    required Widget Function(T) format,
    required FutureOr<Iterable<T>> Function(String query) filter,
    required FSelectSearchContentBuilder<T> contentBuilder,
    FSelectSearchFieldProperties searchFieldProperties,
    Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<Set<T>>? onChange,
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
    AlignmentGeometry anchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints popoverConstraints,
    FPortalSpacing spacing,
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift,
    Offset offset,
    FPopoverHideRegion hideRegion,
    Widget Function(BuildContext context, FMultiSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    int min,
    int? max,
    Set<T>? initialValue,
    Key? key,
  }) = _SearchSelect<T>;

  FMultiSelect._({
    required this.format,
    this.controller,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.prefixBuilder,
    this.suffixBuilder = defaultIconBuilder,
    this.label,
    this.description,
    this.enabled = true,
    this.onChange,
    this.onSaved,
    this.onReset,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
    this.validator = _defaultValidator,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.hint,
    this.keepHint = true,
    this.sort,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.clearable = false,
    this.anchor = AlignmentDirectional.topStart,
    this.fieldAnchor = AlignmentDirectional.bottomStart,
    this.popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.contentEmptyBuilder = FMultiSelect.defaultContentEmptyBuilder,
    this.contentScrollController,
    this.contentScrollHandles = false,
    this.contentPhysics = const ClampingScrollPhysics(),
    this.contentDivider = FItemDivider.none,
    this.min = 0,
    this.max,
    Widget Function(
      BuildContext context,
      FMultiSelectController<T> controller,
      FMultiSelectStyle style,
      T value,
      Widget label,
    )?
    tagBuilder,
    Set<T>? initialValue,
    super.key,
  }) : tagBuilder = tagBuilder ?? defaultTagBuilder,
       initialValue = initialValue ?? controller?.value ?? {},
       assert(debugCheckInclusiveRange(min, max)),
       assert(
         controller == null || min == 0,
         'Cannot provide both a controller and min. To fix, set the min directly in the controller.',
       ),
       assert(
         controller == null || max == null,
         'Cannot provide both a controller and max. To fix, set the max directly in the controller.',
       ),
       assert(
         controller == null || initialValue == null,
         'Cannot provide both a controller and initialValue. To fix, set the initial Value directly in the controller.',
       );

  @override
  Widget build(BuildContext context) {
    final globalStyle = context.theme.multiSelectStyle;
    final style = this.style?.call(globalStyle) ?? globalStyle;
    return Field(
      controller: controller,
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      prefixBuilder: prefixBuilder,
      suffixBuilder: suffixBuilder,
      label: label,
      description: description,
      onChange: onChange,
      hint: hint,
      keepHint: keepHint,
      sort: sort,
      format: format,
      tagBuilder: tagBuilder,
      textAlign: textAlign,
      textDirection: textDirection,
      clearable: clearable,
      anchor: anchor,
      fieldAnchor: fieldAnchor,
      popoverConstraints: popoverConstraints,
      spacing: spacing,
      shift: shift,
      offset: offset,
      hideRegion: hideRegion,
      popoverBuilder: (context, controller) => _content(context, controller, style),
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      errorBuilder: errorBuilder,
      onSaved: onSaved,
      onReset: onReset,
      validator: validator,
      min: min,
      max: max,
      initialValue: initialValue,
    );
  }

  Widget _content(BuildContext context, FMultiSelectController<T> controller, FMultiSelectStyle style);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
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
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('popoverConstraints', popoverConstraints))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('emptyBuilder', contentEmptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(FlagProperty('contentScrollHandles', value: contentScrollHandles, ifTrue: 'contentScrollHandles'))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics))
      ..add(EnumProperty('contentDivider', contentDivider))
      ..add(IntProperty('min', min, defaultValue: 0))
      ..add(IntProperty('max', max, defaultValue: null))
      ..add(IterableProperty('initialValue', initialValue));
  }
}

class _BasicSelect<T> extends FMultiSelect<T> {
  final List<FSelectItemMixin> children;

  _BasicSelect({
    required this.children,
    required super.format,
    super.controller,
    super.style,
    super.autofocus,
    super.focusNode,
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
    super.keepHint,
    super.sort,
    super.textAlign,
    super.textDirection,
    super.clearable,
    super.anchor,
    super.fieldAnchor,
    super.popoverConstraints,
    super.spacing,
    super.shift,
    super.offset,
    super.hideRegion,
    super.contentEmptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.tagBuilder,
    super.min,
    super.max,
    super.initialValue,
    super.key,
  }) : super._();

  @override
  Widget _content(BuildContext context, FMultiSelectController<T> controller, FMultiSelectStyle style) {
    if (children.isEmpty) {
      return contentEmptyBuilder(context, style);
    }

    return Content<T>(
      controller: contentScrollController,
      style: style.contentStyle,
      first: controller.value.isEmpty,
      enabled: enabled,
      scrollHandles: contentScrollHandles,
      physics: contentPhysics,
      divider: contentDivider,
      children: children,
    );
  }
}

class _SearchSelect<T> extends FMultiSelect<T> {
  final FSelectSearchFieldProperties searchFieldProperties;
  final FutureOr<Iterable<T>> Function(String query) filter;
  final FSelectSearchContentBuilder<T> contentBuilder;
  final Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder;
  final Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder;

  _SearchSelect({
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
    super.keepHint,
    super.sort,
    super.textAlign,
    super.textDirection,
    super.clearable,
    super.anchor,
    super.fieldAnchor,
    super.popoverConstraints,
    super.spacing,
    super.shift,
    super.offset,
    super.hideRegion,
    super.contentEmptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.tagBuilder,
    super.min,
    super.max,
    super.initialValue,
    super.key,
  }) : super._();

  @override
  Widget _content(BuildContext context, FMultiSelectController<T> controller, FMultiSelectStyle style) =>
      SearchContent<T>(
        scrollController: contentScrollController,
        searchStyle: style.searchStyle,
        contentStyle: style.contentStyle,
        properties: searchFieldProperties,
        scrollHandles: contentScrollHandles,
        first: controller.value.isEmpty,
        enabled: enabled,
        physics: contentPhysics,
        divider: contentDivider,
        filter: filter,
        builder: contentBuilder,
        emptyBuilder: (context) => contentEmptyBuilder(context, style),
        loadingBuilder: contentLoadingBuilder,
        errorBuilder: contentErrorBuilder,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('searchFieldProperties', searchFieldProperties))
      ..add(DiagnosticsProperty('filter', filter))
      ..add(ObjectFlagProperty.has('contentBuilder', contentBuilder))
      ..add(ObjectFlagProperty('searchLoadingBuilder', contentLoadingBuilder, ifPresent: 'searchLoadingBuilder'))
      ..add(ObjectFlagProperty('searchErrorBuilder', contentErrorBuilder, ifPresent: 'searchErrorBuilder'));
  }
}

/// A [FMultiSelect]'s style.
class FMultiSelectStyle with Diagnosticable, _$FMultiSelectStyleFunctions {
  /// The field's style.
  @override
  final FMultiSelectFieldStyle fieldStyle;

  /// The tag's style.
  @override
  final FMultiSelectTagStyle tagStyle;

  /// The popover's style.
  @override
  final FPopoverStyle popoverStyle;

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
    required this.popoverStyle,
    required this.searchStyle,
    required this.contentStyle,
    required this.emptyTextStyle,
  });

  /// Creates a [FMultiSelectStyle] that inherits its properties.
  FMultiSelectStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        fieldStyle: FMultiSelectFieldStyle.inherit(colors: colors, typography: typography, style: style),
        tagStyle: FMultiSelectTagStyle.inherit(colors: colors, typography: typography, style: style),
        popoverStyle: FPopoverStyle.inherit(colors: colors, style: style),
        searchStyle: FSelectSearchStyle.inherit(colors: colors, typography: typography, style: style),
        contentStyle: FSelectContentStyle.inherit(colors: colors, typography: typography, style: style),
        emptyTextStyle: typography.sm,
      );
}
