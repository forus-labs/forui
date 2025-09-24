import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form_field.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/search_content.dart';
import 'package:forui/src/widgets/select/select_controller.dart';

part 'basic_select.dart';

part 'search_select.dart';

part 'select.design.dart';

/// A select displays a list of options for the user to pick from.
///
/// It is a [FormField] and therefore can be used in a [Form] widget.
///
/// ## Why am I getting "No FSelect<$T> found in context..." assertion errors?
/// This is likely because Dart could not infer [FSelect]'s type parameter. Try specifying the type parameter for
/// `FSelect`, `FSelectSection`, and `FSelectItem` (e.g., `FSelect<MyType>`).
///
/// See:
/// * https://forui.dev/docs/form/select for working examples.
/// * [FSelectController] for customizing the behavior of a select.
/// * [FSelectStyle] for customizing the appearance of a select.
abstract class FSelect<T> extends StatefulWidget with FFormFieldProperties<T> {
  /// The default suffix builder that shows a upward and downward facing chevron icon.
  static Widget defaultIconBuilder(BuildContext _, FSelectStyle style, Set<WidgetState> _) => Padding(
    padding: const EdgeInsetsDirectional.only(end: 8.0),
    child: IconTheme(data: style.iconStyle, child: const Icon(FIcons.chevronDown)),
  );

  /// The default content loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultContentLoadingBuilder(BuildContext _, FSelectSearchStyle style) => Padding(
    padding: const EdgeInsets.all(13),
    child: FCircularProgress(style: style.progressStyle),
  );

  /// The default content empty builder that shows a localized message when there are no results.
  static Widget defaultContentEmptyBuilder(BuildContext context, FSelectStyle style) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Text(localizations.selectNoResults, style: style.emptyTextStyle, textAlign: TextAlign.center),
    );
  }

  static Widget _fieldBuilder(BuildContext _, FSelectStyle _, Set<WidgetState> _, Widget child) => child;

  static String? _defaultValidator(Object? _) => null;

  /// The controller.
  final FSelectController<T>? controller;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select
  /// ```
  final FSelectStyle Function(FSelectStyle style)? style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// The builder used to decorate the select. It should use the given child.
  ///
  /// Defaults to returning the given child.
  final FFieldBuilder<FSelectStyle> builder;

  /// Builds a widget at the start of the select that can be pressed to toggle the popover. Defaults to no icon.
  final FFieldIconBuilder<FSelectStyle>? prefixBuilder;

  /// Builds a widget at the end of the select that can be pressed to toggle the popover. Defaults to
  /// [defaultIconBuilder].
  final FFieldIconBuilder<FSelectStyle>? suffixBuilder;

  @override
  final Widget? label;

  @override
  final Widget? description;

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  @override
  final bool enabled;

  /// Handler called when the selected value changes.
  final ValueChanged<T?>? onChange;

  @override
  final FormFieldSetter<T>? onSaved;

  @override
  final VoidCallback? onReset;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final String? forceErrorText;

  @override
  final FormFieldValidator<T> validator;

  /// The function that formats the selected items into a string. The items are sorted in order of selection.
  final String Function(T value) format;

  /// The [hint] that is displayed when the select is empty. Defaults to the current locale's
  /// [FLocalizations.selectHint].
  final String? hint;

  /// The alignment of the text within the select. Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// The vertical alignment of the text and can be useful when used with a prefix or suffix.
  final TextAlignVertical? textAlignVertical;

  /// The text direction of the select.
  final TextDirection? textDirection;

  /// True if the select should expand to fill the available space. Defaults to false.
  final bool expands;

  /// The mouse cursor to use when the field is hovered over. Defaults to [SystemMouseCursors.click].
  final MouseCursor mouseCursor;

  /// Whether the field can request focus. Defaults to true.
  final bool canRequestFocus;

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

  /// True if the select should be automatically hidden after an item is selected. Defaults to false.
  final bool autoHide;

  /// The builder that is called when the select's content is empty. Defaults to [defaultContentEmptyBuilder].
  final Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder;

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
  final T? initialValue;

  /// Creates a [FSelect] from the given [items].
  ///
  /// For more control over the appearance of items, use [FSelect.rich].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FSelect({
    required Map<String, T> items,
    FSelectController<T>? controller,
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder = _fieldBuilder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<T?>? onChange,
    FormFieldSetter<T>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    FormFieldValidator<T> validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    String? hint,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool canRequestFocus = true,
    bool clearable = false,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FPopoverHideRegion hideRegion = FPopoverHideRegion.excludeChild,
    bool autoHide = true,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder = defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    T? initialValue,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return FSelect<T>.rich(
      controller: controller,
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      builder: builder,
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
      format: (value) => inverse[value]!,
      hint: hint,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      expands: expands,
      mouseCursor: mouseCursor,
      canRequestFocus: canRequestFocus,
      clearable: clearable,
      anchor: anchor,
      fieldAnchor: fieldAnchor,
      popoverConstraints: popoverConstraints,
      spacing: spacing,
      shift: shift,
      offset: offset,
      hideRegion: hideRegion,
      autoHide: autoHide,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      initialValue: initialValue,
      key: key,
      children: [for (final MapEntry(:key, :value) in items.entries) FSelectItem(title: Text(key), value: value)],
    );
  }

  /// Creates a select with the given [children].
  const factory FSelect.rich({
    required String Function(T value) format,
    required List<FSelectItemMixin> children,
    FSelectController<T>? controller,
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<T?>? onChange,
    FormFieldSetter<T>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<T> validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    String? hint,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    MouseCursor mouseCursor,
    bool canRequestFocus,
    bool clearable,
    AlignmentGeometry anchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints popoverConstraints,
    FPortalSpacing spacing,
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift,
    Offset offset,
    FPopoverHideRegion hideRegion,
    bool autoHide,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    T? initialValue,
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
  /// For more control over the appearance of items, use [FSelect.searchBuilder].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FSelect.search({
    required Map<String, T> items,
    FutureOr<Iterable<T>> Function(String query)? filter,
    FSelectSearchFieldProperties searchFieldProperties = const FSelectSearchFieldProperties(),
    Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder =
        FSelect.defaultContentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    FSelectController<T>? controller,
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder = _fieldBuilder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    ValueChanged<T?>? onChange,
    FormFieldSetter<T>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUnfocus,
    String? forceErrorText,
    FormFieldValidator<T> validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    String? hint,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool canRequestFocus = true,
    bool clearable = false,
    AlignmentGeometry anchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing spacing = const FPortalSpacing(4),
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift = FPortalShift.flip,
    Offset offset = Offset.zero,
    FPopoverHideRegion hideRegion = FPopoverHideRegion.excludeChild,
    bool autoHide = true,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder = defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = FItemDivider.none,
    T? initialValue,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return FSelect<T>.searchBuilder(
      format: (value) => inverse[value]!,
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
      builder: builder,
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
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      expands: expands,
      mouseCursor: mouseCursor,
      canRequestFocus: canRequestFocus,
      clearable: clearable,
      anchor: anchor,
      fieldAnchor: fieldAnchor,
      popoverConstraints: popoverConstraints,
      spacing: spacing,
      shift: shift,
      offset: offset,
      hideRegion: hideRegion,
      autoHide: autoHide,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
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
  const factory FSelect.searchBuilder({
    required String Function(T value) format,
    required FutureOr<Iterable<T>> Function(String query) filter,
    required FSelectSearchContentBuilder<T> contentBuilder,
    FSelectSearchFieldProperties searchFieldProperties,
    Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    FSelectController<T>? controller,
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    ValueChanged<T?>? onChange,
    FormFieldSetter<T>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<T> validator,
    Widget Function(BuildContext context, String message) errorBuilder,
    String? hint,
    TextAlign textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands,
    MouseCursor mouseCursor,
    bool canRequestFocus,
    bool clearable,
    AlignmentGeometry anchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints popoverConstraints,
    FPortalSpacing spacing,
    Offset Function(Size size, FPortalChildBox childBox, FPortalBox portalBox) shift,
    Offset offset,
    FPopoverHideRegion hideRegion,
    bool autoHide,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    T? initialValue,
    Key? key,
  }) = _SearchSelect<T>;

  const FSelect._({
    required this.format,
    this.controller,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.builder = _fieldBuilder,
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
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.canRequestFocus = true,
    this.clearable = false,
    this.anchor = AlignmentDirectional.topStart,
    this.fieldAnchor = AlignmentDirectional.bottomStart,
    this.popoverConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    this.spacing = const FPortalSpacing(4),
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.autoHide = true,
    this.contentEmptyBuilder = defaultContentEmptyBuilder,
    this.contentScrollController,
    this.contentScrollHandles = false,
    this.contentPhysics = const ClampingScrollPhysics(),
    this.contentDivider = FItemDivider.none,
    this.initialValue,
    super.key,
  }) : assert(
         controller == null || initialValue == null,
         'Cannot provide both a controller and initialValue. To fix, set the initial value directly in the controller.',
       );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(ObjectFlagProperty.has('format', format))
      ..add(StringProperty('hint', hint))
      ..add(EnumProperty('textAlign', textAlign))
      ..add(DiagnosticsProperty('textAlignVertical', textAlignVertical))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(DiagnosticsProperty('mouseCursor', mouseCursor))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('popoverConstraints', popoverConstraints))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'))
      ..add(ObjectFlagProperty.has('emptyBuilder', contentEmptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(FlagProperty('contentScrollHandles', value: contentScrollHandles, ifTrue: 'contentScrollHandles'))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics))
      ..add(EnumProperty('contentDivider', contentDivider))
      ..add(DiagnosticsProperty('initialValue', initialValue));
  }
}

abstract class _State<S extends FSelect<T>, T> extends State<S> with SingleTickerProviderStateMixin {
  late final TextEditingController _textController;
  late FSelectController<T> _controller;
  late FocusNode _focus;
  bool _mutating = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _initialText);
    _controller = widget.controller ?? FSelectController(vsync: this, value: widget.initialValue);
    _controller.addValueListener(_onChange);

    _focus = widget.focusNode ?? FocusNode(debugLabel: 'FSelect');

    _textController.addListener(_updateSelectController);
    _controller.addListener(_updateTextController);
  }

  String get _initialText {
    if (widget.initialValue case final value?) {
      return widget.format(value);
    } else if (widget.controller?.value case final value?) {
      return widget.format(value);
    } else {
      return '';
    }
  }

  @override
  void didUpdateWidget(covariant S old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? FocusNode(debugLabel: 'FSelect');
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        old.controller?.removeValueListener(_onChange);
        old.controller?.removeListener(_updateTextController);
      }

      if (widget.controller case final controller?) {
        _controller = controller;
      } else {
        _textController.text = widget.initialValue == null ? '' : widget.format(widget.initialValue as T);
        _controller = FSelectController(vsync: this, value: widget.initialValue);
      }

      _controller
        ..addValueListener(_onChange)
        ..addListener(_updateTextController);
      _updateTextController();
    }
  }

  void _onChange(T? value) => widget.onChange?.call(value);

  void _updateSelectController() {
    if (_mutating) {
      return;
    }

    try {
      _mutating = true;
      if (_textController.text.isEmpty) {
        _controller.value = null;
      }
    } finally {
      _mutating = false;
    }
  }

  void _updateTextController() {
    if (_mutating) {
      return;
    }

    try {
      _mutating = true;
      _textController.text = switch (_controller.value) {
        null => '',
        final value => widget.format(value),
      };
    } finally {
      _mutating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.selectStyle) ?? context.theme.selectStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    return Field(
      controller: _controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      onSaved: widget.onSaved,
      onReset: widget.onReset,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (state) => FTextField(
        focusNode: _focus,
        controller: _textController,
        style: style.selectFieldStyle,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: widget.textDirection,
        expands: widget.expands,
        mouseCursor: widget.mouseCursor,
        canRequestFocus: widget.canRequestFocus,
        onTap: _toggle,
        onTapAlwaysCalled: true,
        hint: widget.hint ?? localizations.selectHint,
        readOnly: true,
        enableInteractiveSelection: false,
        prefixBuilder: widget.prefixBuilder == null
            ? null
            : (context, _, states) => widget.prefixBuilder!(context, style, states),
        suffixBuilder: widget.suffixBuilder == null
            ? null
            : (context, _, states) => widget.suffixBuilder!(context, style, states),
        clearable: widget.clearable ? (_) => _controller.value != null : (_) => false,
        label: widget.label,
        description: widget.description,
        error: state.hasError ? widget.errorBuilder(state.context, state.errorText ?? '') : null,
        enabled: widget.enabled,
        builder: (context, _, states, field) => FPopover(
          controller: _controller.popover,
          style: style.popoverStyle,
          constraints: widget.popoverConstraints,
          popoverAnchor: widget.anchor,
          childAnchor: widget.fieldAnchor,
          spacing: widget.spacing,
          shift: widget.shift,
          offset: widget.offset,
          hideRegion: widget.hideRegion,
          shortcuts: {const SingleActivator(LogicalKeyboardKey.escape): _toggle},
          popoverBuilder: (_, popoverController) => TextFieldTapRegion(
            child: InheritedSelectController<T>(
              popover: popoverController,
              contains: (value) => _controller.value == value,
              focus: (value) => _controller.value == value,
              onPress: (value) async {
                if (widget.autoHide) {
                  _focus.requestFocus();
                  await _controller.popover.hide();
                }

                _controller.value = value;
              },
              child: content(context, style),
            ),
          ),
          child: CallbackShortcuts(
            bindings: {const SingleActivator(LogicalKeyboardKey.enter): _toggle},
            child: widget.builder(context, style, states, field),
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context, FSelectStyle style);

  void _toggle() {
    _controller.popover.status.isCompleted ? _focus.requestFocus() : _focus.unfocus();
    _controller.popover.toggle();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller
        ..removeValueListener(_onChange)
        ..removeListener(_updateTextController);
    }
    _textController.dispose();

    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }
}

/// A [FSelect]'s style.
class FSelectStyle with Diagnosticable, _$FSelectStyleFunctions {
  /// The select field's style.
  @override
  final FTextFieldStyle selectFieldStyle;

  /// The select field's icon style.
  @override
  final IconThemeData iconStyle;

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

  /// Creates a [FSelectStyle].
  FSelectStyle({
    required this.selectFieldStyle,
    required this.iconStyle,
    required this.popoverStyle,
    required this.searchStyle,
    required this.contentStyle,
    required this.emptyTextStyle,
  });

  /// Creates a [FSelectStyle] that inherits its properties.
  FSelectStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        selectFieldStyle: FTextFieldStyle.inherit(colors: colors, typography: typography, style: style),
        iconStyle: IconThemeData(color: colors.mutedForeground, size: 18),
        popoverStyle: FPopoverStyle.inherit(colors: colors, style: style),
        searchStyle: FSelectSearchStyle.inherit(colors: colors, typography: typography, style: style),
        contentStyle: FSelectContentStyle.inherit(colors: colors, typography: typography, style: style),
        emptyTextStyle: typography.sm,
      );
}
