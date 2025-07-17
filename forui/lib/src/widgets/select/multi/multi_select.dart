import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/search_content.dart';
import 'package:forui/src/widgets/select/multi/field.dart';
import 'package:meta/meta.dart';

part 'multi_select.style.dart';

/// A multi-select displays a list of options for the user to pick from.
///
/// It is a [FormField] and therefore can be used in a [Form] widget.
///
/// ## Why am I getting "No FMultiSelect<$T> found in context..." assertion errors?
/// This is likely because Dart could not infer [FMultiSelect]'s type parameter. Try specifying the type parameter for
/// `FMultiSelect`, `FSelectSection`, and `FSelectItem` (e.g., `FMultiSelect<MyType>`).
///
/// See:
/// * https://forui.dev/docs/form/select for working examples.
/// * [FMultiSelectController] for customizing the behavior of a select.
/// * [FMultiSelectStyle] for customizing the appearance of a select.
abstract class FMultiSelect<T> extends StatelessWidget {
  /// The default suffix builder that shows a upward and downward facing chevron icon.
  static Widget defaultIconBuilder(BuildContext _, (FMultiSelectStyle, Set<WidgetState>) styles, Widget? _) => Padding(
    padding: const EdgeInsetsDirectional.only(start: 4),
    child: IconTheme(data: styles.$1.fieldStyle.iconStyle, child: const Icon(FIcons.chevronDown)),
  );

  /// The default tag builder that builds a [FMultiSelectTag] with the given value.
  static Widget defaultTagBuilder<T>(
    BuildContext _,
    FMultiSelectController<T> controller,
    FMultiSelectStyle style,
    T value,
    Widget label,
  ) => FMultiSelectTag(style: style.tagStyle, label: label, onPress: () => controller.update(value, add: false));

  /// The default loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultSearchLoadingBuilder(BuildContext _, FSelectSearchStyle style, Widget? _) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: FProgress.circularIcon(style: (s) => style.loadingIndicatorStyle),
  );

  /// The default empty builder that shows a localized message when there are no results.
  static Widget defaultEmptyBuilder(BuildContext context, FMultiSelectStyle style, Widget? _) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: Text(localizations.selectNoResults, style: style.emptyTextStyle),
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
  final FMultiSelectStyle Function(FMultiSelectStyle)? style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// Builds a widget at the start of the select that can be pressed to toggle the popover. Defaults to no icon.
  final ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? prefixBuilder;

  /// Builds a widget at the end of the select that can be pressed to toggle the popover. Defaults to [defaultIconBuilder].
  final ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// Handler called when the selected value changes.
  final ValueChanged<Set<T>>? onChange;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final void Function(Set<T>)? onSaved;

  /// {@macro forui.foundation.form_field_properties.validator}
  final String? Function(Set<T>) validator;

  /// {@macro forui.foundation.form_field_properties.autovalidateMode}
  final AutovalidateMode autovalidateMode;

  /// {@macro forui.foundation.form_field_properties.forceErrorText}
  final String? forceErrorText;

  /// The hint.
  final Widget? hint;

  /// The function used to sort the selected items. Defaults to the order in which they were selected.
  final int Function(T, T)? sort;

  /// The function formats the value for display in the select's field.
  final Widget Function(T) format;

  /// The function used to build the tags for selected items.
  final Widget Function(BuildContext, FMultiSelectController<T>, FMultiSelectStyle, T, Widget) tagBuilder;

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
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.hideOnTapOutside}
  final FHidePopoverRegion hideOnTapOutside;

  /// The builder that is called when the select is empty. Defaults to [FSelect.defaultEmptyBuilder].
  final ValueWidgetBuilder<FMultiSelectStyle> emptyBuilder;

  /// The content's scroll controller.
  final ScrollController? contentScrollController;

  /// True if the content should show scroll handles instead of a scrollbar. Defaults to false.
  final bool contentScrollHandles;

  /// The content's scroll physics. Defaults to [ClampingScrollPhysics].
  final ScrollPhysics contentPhysics;

  /// The divider used to separate the content items. Defaults to [FItemDivider.none].
  final FItemDivider contentDivider;

  /// The initial value.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both the controller and initialValue are provided.
  final Set<T> initialValue;

  /// Creates a select with a list of selectable items.
  factory FMultiSelect({
    required Widget Function(T) format,
    required List<FSelectItemMixin> children,
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle)? style,
    bool autofocus,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? prefixBuilder,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<Set<T>>? onChange,
    void Function(Set<T>)? onSaved,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    String? Function(Set<T>) validator,
    Widget Function(BuildContext, String) errorBuilder,
    Widget? hint,
    int Function(T, T)? sort,
    Widget Function(BuildContext, FMultiSelectController<T>, FMultiSelectStyle, T, Widget)? tagBuilder,
    TextAlign textAlign,
    TextDirection? textDirection,
    bool clearable,
    AlignmentGeometry anchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints popoverConstraints,
    FPortalSpacing spacing,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    Offset offset,
    FHidePopoverRegion hideOnTapOutside,
    ValueWidgetBuilder<FMultiSelectStyle> emptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    Set<T>? initialValue,
    Key? key,
  }) = _BasicSelect<T>;

  /// Creates a [FMultiSelect] from the given [items].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FMultiSelect.fromMap(
    Map<String, T> items, {
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? prefixBuilder,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<Set<T>>? onChange,
    void Function(Set<T>)? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    String? Function(Set<T>) validator = _defaultValidator,
    Widget Function(BuildContext, String) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Widget? hint,
    int Function(T, T)? sort,
    Widget Function(BuildContext, FMultiSelectController<T>, FMultiSelectStyle, T, Widget)? tagBuilder,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool clearable = false,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size, FPortalChildBox, FPortalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FHidePopoverRegion hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    ValueWidgetBuilder<FMultiSelectStyle> emptyBuilder = FMultiSelect.defaultEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    Set<T>? initialValue,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return FMultiSelect<T>(
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
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      validator: validator,
      errorBuilder: errorBuilder,
      hint: hint,
      textAlign: textAlign,
      textDirection: textDirection,
      clearable: clearable,
      anchor: anchor,
      fieldAnchor: fieldAnchor,
      popoverConstraints: popoverConstraints,
      spacing: spacing,
      shift: shift,
      offset: offset,
      hideOnTapOutside: hideOnTapOutside,
      emptyBuilder: emptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      initialValue: initialValue,
      key: key,
      children: [for (final MapEntry(:key, :value) in items.entries) FSelectItem(key, value)],
    );
  }

  /// Creates a searchable select with dynamic content based on search input.
  ///
  /// The [searchFieldProperties] can be used to customize the search field.
  ///
  /// The [filter] callback produces a list of items based on the search query either synchronously or asynchronously.
  /// The [contentBuilder] callback builds the list of items based on search results returned by [filter].
  /// The [searchLoadingBuilder] is used to show a loading indicator while the search results is processed
  /// asynchronously by [filter].
  /// The [searchErrorBuilder] is used to show an error message when [filter] is asynchronous and fails.
  factory FMultiSelect.search({
    required Widget Function(T) format,
    required FSelectSearchFilter<T> filter,
    required FSelectSearchContentBuilder<T> contentBuilder,
    FSelectSearchFieldProperties searchFieldProperties,
    ValueWidgetBuilder<FSelectSearchStyle> searchLoadingBuilder,
    Widget Function(BuildContext, Object?, StackTrace)? searchErrorBuilder,
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle)? style,
    bool autofocus,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? prefixBuilder,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<Set<T>>? onChange,
    void Function(Set<T>)? onSaved,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    String? Function(Set<T>) validator,
    Widget Function(BuildContext, String) errorBuilder,
    Widget? hint,
    int Function(T, T)? sort,
    Widget Function(BuildContext, FMultiSelectController<T>, FMultiSelectStyle, T, Widget)? tagBuilder,
    TextAlign textAlign,
    TextDirection? textDirection,
    bool clearable,
    AlignmentGeometry anchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints popoverConstraints,
    FPortalSpacing spacing,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    Offset offset,
    FHidePopoverRegion hideOnTapOutside,
    ValueWidgetBuilder<FMultiSelectStyle> emptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    Set<T>? initialValue,
    Key? key,
  }) = _SearchSelect<T>;

  /// Creates a searchable select with dynamic content based on the given [items] and search input.
  ///
  /// The [searchFieldProperties] can be used to customize the search field.
  ///
  /// The [filter] callback produces a list of items based on the search query. Defaults to returning items that start
  /// with the query string.
  /// The [searchLoadingBuilder] is used to show a loading indicator while the search results is processed
  /// asynchronously by [filter].
  /// The [searchErrorBuilder] is used to show an error message when [filter] is asynchronous and fails.
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FMultiSelect.searchFromMap(
    Map<String, T> items, {
    FSelectSearchFilter<T>? filter,
    FSelectSearchFieldProperties searchFieldProperties = const FSelectSearchFieldProperties(),
    ValueWidgetBuilder<FSelectSearchStyle> searchLoadingBuilder = FMultiSelect.defaultSearchLoadingBuilder,
    Widget Function(BuildContext, Object?, StackTrace)? searchErrorBuilder,
    FMultiSelectController<T>? controller,
    FMultiSelectStyle Function(FMultiSelectStyle)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? prefixBuilder,
    ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<Set<T>>? onChange,
    void Function(Set<T>)? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    String? Function(Set<T>) validator = _defaultValidator,
    Widget Function(BuildContext, String) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    Widget? hint,
    int Function(T, T)? sort,
    Widget Function(BuildContext, FMultiSelectController<T>, FMultiSelectStyle, T, Widget)? tagBuilder,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool clearable = false,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size, FPortalChildBox, FPortalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FHidePopoverRegion hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    ValueWidgetBuilder<FMultiSelectStyle> emptyBuilder = defaultEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    Set<T>? initialValue,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return FMultiSelect<T>.search(
      format: (value) => Text(inverse[value] ?? ''),
      filter:
          filter ??
          (query) => items.entries
              .where((entry) => entry.key.toLowerCase().startsWith(query.toLowerCase()))
              .map((entry) => entry.value)
              .toList(),
      contentBuilder: (context, data) => [for (final value in data.values) FSelectItem<T>(inverse[value]!, value)],
      searchFieldProperties: searchFieldProperties,
      searchLoadingBuilder: searchLoadingBuilder,
      searchErrorBuilder: searchErrorBuilder,
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
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      validator: validator,
      errorBuilder: errorBuilder,
      hint: hint,
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
      hideOnTapOutside: hideOnTapOutside,
      emptyBuilder: emptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      initialValue: initialValue,
      key: key,
    );
  }

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
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
    this.validator = _defaultValidator,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.hint,
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
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.emptyBuilder = FMultiSelect.defaultEmptyBuilder,
    this.contentScrollController,
    this.contentScrollHandles = false,
    this.contentPhysics = const ClampingScrollPhysics(),
    this.contentDivider = FItemDivider.none,
    Widget Function(BuildContext, FMultiSelectController<T>, FMultiSelectStyle, T, Widget)? tagBuilder,
    Set<T>? initialValue,
    super.key,
  }) : tagBuilder = tagBuilder ?? defaultTagBuilder,
       initialValue = initialValue ?? controller?.value ?? {},
       assert(controller == null || initialValue == null, 'Cannot provide both a controller and an initial value.');

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
      hideOnTapOutside: hideOnTapOutside,
      popoverBuilder: (context, controller) => _content(context, controller, style),
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      forceErrorText: forceErrorText,
      errorBuilder: errorBuilder,
      onSaved: onSaved,
      validator: validator,
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
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty.has('format', format))
      ..add(ObjectFlagProperty.has('sort', sort))
      ..add(ObjectFlagProperty.has('tagBuilder', tagBuilder))
      ..add(StringProperty('forceErrorText', forceErrorText))
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
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(ObjectFlagProperty.has('emptyBuilder', emptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(FlagProperty('contentScrollHandles', value: contentScrollHandles, ifTrue: 'contentScrollHandles'))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics))
      ..add(EnumProperty('contentDivider', contentDivider))
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
    super.autovalidateMode,
    super.forceErrorText,
    super.validator,
    super.errorBuilder,
    super.hint,
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
    super.hideOnTapOutside,
    super.emptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.tagBuilder,
    super.initialValue,
    super.key,
  }) : super._();

  @override
  Widget _content(BuildContext context, FMultiSelectController<T> controller, FMultiSelectStyle style) {
    if (children.isEmpty) {
      return emptyBuilder(context, style, null);
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
  final FSelectSearchFilter<T> filter;
  final FSelectSearchContentBuilder<T> contentBuilder;
  final ValueWidgetBuilder<FSelectSearchStyle> searchLoadingBuilder;
  final Widget Function(BuildContext, Object?, StackTrace)? searchErrorBuilder;

  _SearchSelect({
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
    super.hideOnTapOutside,
    super.emptyBuilder,
    super.contentScrollController,
    super.contentScrollHandles,
    super.contentPhysics,
    super.contentDivider,
    super.tagBuilder,
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
        emptyBuilder: (context) => emptyBuilder(context, style, null),
        loadingBuilder: searchLoadingBuilder,
        errorBuilder: searchErrorBuilder,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('searchFieldProperties', searchFieldProperties))
      ..add(DiagnosticsProperty('filter', filter))
      ..add(ObjectFlagProperty.has('contentBuilder', contentBuilder))
      ..add(ObjectFlagProperty('searchLoadingBuilder', searchLoadingBuilder, ifPresent: 'searchLoadingBuilder'))
      ..add(ObjectFlagProperty('searchErrorBuilder', searchErrorBuilder, ifPresent: 'searchErrorBuilder'));
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
