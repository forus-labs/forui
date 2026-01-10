import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form/form_field.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/inherited_controller.dart';
import 'package:forui/src/widgets/select/content/search_content.dart';
import 'package:forui/src/widgets/select/single/select_controller.dart';

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
  static Widget defaultIconBuilder(BuildContext _, FSelectStyle style, Set<WidgetState> states) => Padding(
    padding: const .directional(end: 8.0),
    child: IconTheme(data: style.fieldStyle.iconStyle.resolve(states), child: const Icon(FIcons.chevronDown)),
  );

  /// The default content loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultContentLoadingBuilder(BuildContext _, FSelectSearchStyle style) => Padding(
    padding: const .all(13),
    child: FCircularProgress(style: style.progressStyle),
  );

  /// The default content empty builder that shows a localized message when there are no results.
  static Widget defaultContentEmptyBuilder(BuildContext context, FSelectStyle style) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const .symmetric(horizontal: 8, vertical: 14),
      child: Text(localizations.selectNoResults, style: style.emptyTextStyle, textAlign: .center),
    );
  }

  static Widget _fieldBuilder(BuildContext _, FSelectStyle _, Set<WidgetState> _, Widget child) => child;

  static String? _defaultValidator(Object? _) => null;

  /// The control that manages the select's state.
  ///
  /// Defaults to [FSelectControl.managed] if not provided.
  final FSelectControl<T>? control;

  /// Defines how the select's popover is controlled.
  ///
  /// Defaults to [FPopoverControl.managed].
  final FPopoverControl popoverControl;

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

  /// The mouse cursor to use when the field is hovered over. Defaults to [MouseCursor.defer].
  final MouseCursor mouseCursor;

  /// Whether the field can request focus. Defaults to true.
  final bool canRequestFocus;

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

  /// True if the select should be automatically hidden after an item is selected. Defaults to false.
  final bool autoHide;

  /// The builder that is called when the select's content is empty. Defaults to [defaultContentEmptyBuilder].
  final Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder;

  /// The content's scroll controller.
  final ScrollController? contentScrollController;

  /// True if the content should show scroll handles instead of a scrollbar. Defaults to false.
  @Deprecated(
    'Usage of scroll handles seem to be low while its maintenance burden far outweighs its benefits. Please open an issue at https://github.com/duobaseio/forui/issues if you use it and think otherwise.',
  )
  final bool contentScrollHandles;

  /// The content's scroll physics. Defaults to [ClampingScrollPhysics].
  final ScrollPhysics contentPhysics;

  /// The divider used to separate the content items. Defaults to [FItemDivider.none].
  final FItemDivider contentDivider;

  /// Creates a [FSelect] from the given [items].
  ///
  /// For more control over the appearance of items, use [FSelect.rich].
  ///
  /// ## Contract
  /// Each key in [items] must map to a unique value. Having multiple keys map to the same value will result in
  /// undefined behavior.
  factory FSelect({
    required Map<String, T> items,
    FSelectControl<T>? control,
    FPopoverControl popoverControl = const .managed(),
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder = _fieldBuilder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = .onUnfocus,
    String? forceErrorText,
    FormFieldValidator<T> validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    String? hint,
    TextAlign textAlign = .start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands = false,
    MouseCursor mouseCursor = .defer,
    bool canRequestFocus = true,
    bool clearable = false,
    AlignmentGeometry contentAnchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints contentConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing contentSpacing = const .spacing(4),
    FPortalOverflow contentOverflow = .flip,
    Offset contentOffset = .zero,
    FPopoverHideRegion contentHideRegion = .excludeChild,
    Object? contentGroupId,
    bool autoHide = true,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder = defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    @Deprecated(
      'Usage of scroll handles seem to be low while its maintenance burden far outweighs its benefits. Please open an issue at https://github.com/duobaseio/forui/issues if you use it and think otherwise.',
    )
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
      builder: builder,
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
      format: (value) => inverse[value]!,
      hint: hint,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      expands: expands,
      mouseCursor: mouseCursor,
      canRequestFocus: canRequestFocus,
      clearable: clearable,
      contentAnchor: contentAnchor,
      fieldAnchor: fieldAnchor,
      contentConstraints: contentConstraints,
      contentSpacing: contentSpacing,
      contentOverflow: contentOverflow,
      contentOffset: contentOffset,
      contentHideRegion: contentHideRegion,
      contentGroupId: contentGroupId,
      autoHide: autoHide,
      contentEmptyBuilder: contentEmptyBuilder,
      contentScrollController: contentScrollController,
      contentScrollHandles: contentScrollHandles,
      contentPhysics: contentPhysics,
      contentDivider: contentDivider,
      key: key,
      children: [for (final MapEntry(:key, :value) in items.entries) .item(title: Text(key), value: value)],
    );
  }

  /// Creates a select with the given [children].
  const factory FSelect.rich({
    required String Function(T value) format,
    required List<FSelectItemMixin> children,
    FSelectControl<T>? control,
    FPopoverControl popoverControl,
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
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
    AlignmentGeometry contentAnchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints contentConstraints,
    FPortalSpacing contentSpacing,
    FPortalOverflow contentOverflow,
    Offset contentOffset,
    FPopoverHideRegion contentHideRegion,
    Object? contentGroupId,
    bool autoHide,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    @Deprecated(
      'Usage of scroll handles seem to be low while its maintenance burden far outweighs its benefits. Please open an issue at https://github.com/duobaseio/forui/issues if you use it and think otherwise.',
    )
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
    FSelectControl<T>? control,
    FPopoverControl popoverControl = const .managed(),
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus = false,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder = _fieldBuilder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder = defaultIconBuilder,
    Widget? label,
    Widget? description,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    VoidCallback? onReset,
    AutovalidateMode autovalidateMode = .onUnfocus,
    String? forceErrorText,
    FormFieldValidator<T> validator = _defaultValidator,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    String? hint,
    TextAlign textAlign = .start,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool expands = false,
    MouseCursor mouseCursor = .defer,
    bool canRequestFocus = true,
    bool clearable = false,
    AlignmentGeometry contentAnchor = AlignmentDirectional.topStart,
    AlignmentGeometry fieldAnchor = AlignmentDirectional.bottomStart,
    FPortalConstraints contentConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    FPortalSpacing contentSpacing = const .spacing(4),
    FPortalOverflow contentOverflow = .flip,
    Offset contentOffset = .zero,
    FPopoverHideRegion contentHideRegion = .excludeChild,
    Object? contentGroupId,
    bool autoHide = true,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder = defaultContentEmptyBuilder,
    ScrollController? contentScrollController,
    @Deprecated(
      'Usage of scroll handles seem to be low while its maintenance burden far outweighs its benefits. Please open an issue at https://github.com/duobaseio/forui/issues if you use it and think otherwise.',
    )
    bool contentScrollHandles = false,
    ScrollPhysics contentPhysics = const ClampingScrollPhysics(),
    FItemDivider contentDivider = .none,
    Key? key,
  }) {
    final inverse = {for (final MapEntry(:key, :value) in items.entries) value: key};
    return .searchBuilder(
      format: (value) => inverse[value]!,
      filter:
          filter ??
          (query) => [
            for (final MapEntry(:key, :value) in items.entries)
              if (key.toLowerCase().startsWith(query.toLowerCase())) value,
          ],
      contentBuilder: (context, _, values) => [
        for (final value in values) .item(title: Text(inverse[value]!), value: value),
      ],
      searchFieldProperties: searchFieldProperties,
      contentLoadingBuilder: contentLoadingBuilder,
      contentErrorBuilder: contentErrorBuilder,
      control: control,
      popoverControl: popoverControl,
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      builder: builder,
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
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      expands: expands,
      mouseCursor: mouseCursor,
      canRequestFocus: canRequestFocus,
      clearable: clearable,
      contentAnchor: contentAnchor,
      fieldAnchor: fieldAnchor,
      contentConstraints: contentConstraints,
      contentSpacing: contentSpacing,
      contentOverflow: contentOverflow,
      contentOffset: contentOffset,
      contentHideRegion: contentHideRegion,
      contentGroupId: contentGroupId,
      autoHide: autoHide,
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
  const factory FSelect.searchBuilder({
    required String Function(T value) format,
    required FutureOr<Iterable<T>> Function(String query) filter,
    required FSelectSearchContentBuilder<T> contentBuilder,
    FSelectSearchFieldProperties searchFieldProperties,
    Widget Function(BuildContext context, FSelectSearchStyle style) contentLoadingBuilder,
    Widget Function(BuildContext context, Object? error, StackTrace stackTrace)? contentErrorBuilder,
    FSelectControl<T>? control,
    FPopoverControl popoverControl,
    FSelectStyle Function(FSelectStyle style)? style,
    bool autofocus,
    FocusNode? focusNode,
    FFieldBuilder<FSelectStyle> builder,
    FFieldIconBuilder<FSelectStyle>? prefixBuilder,
    FFieldIconBuilder<FSelectStyle>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
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
    AlignmentGeometry contentAnchor,
    AlignmentGeometry fieldAnchor,
    FPortalConstraints contentConstraints,
    FPortalSpacing contentSpacing,
    FPortalOverflow contentOverflow,
    Offset contentOffset,
    FPopoverHideRegion contentHideRegion,
    Object? contentGroupId,
    bool autoHide,
    Widget Function(BuildContext context, FSelectStyle style) contentEmptyBuilder,
    ScrollController? contentScrollController,
    @Deprecated(
      'Usage of scroll handles seem to be low while its maintenance burden far outweighs its benefits. Please open an issue at https://github.com/duobaseio/forui/issues if you use it and think otherwise.',
    )
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    FItemDivider contentDivider,
    Key? key,
  }) = _SearchSelect<T>;

  const FSelect._({
    required this.format,
    this.control,
    this.popoverControl = const .managed(),
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.builder = _fieldBuilder,
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
    this.textAlign = .start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = .defer,
    this.canRequestFocus = true,
    this.clearable = false,
    this.contentAnchor = AlignmentDirectional.topStart,
    this.fieldAnchor = AlignmentDirectional.bottomStart,
    this.contentConstraints = const FAutoWidthPortalConstraints(maxHeight: 300),
    this.contentSpacing = const .spacing(4),
    this.contentOverflow = .flip,
    this.contentOffset = .zero,
    this.contentHideRegion = .excludeChild,
    this.contentGroupId,
    this.autoHide = true,
    this.contentEmptyBuilder = defaultContentEmptyBuilder,
    this.contentScrollController,
    @Deprecated(
      'Usage of scroll handles seem to be low while its maintenance burden far outweighs its benefits. Please open an issue at https://github.com/duobaseio/forui/issues if you use it and think otherwise.',
    )
    this.contentScrollHandles = false,
    this.contentPhysics = const ClampingScrollPhysics(),
    this.contentDivider = .none,
    super.key,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('popoverControl', popoverControl))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('prefixBuilder', prefixBuilder))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
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
      ..add(DiagnosticsProperty('contentAnchor', contentAnchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('contentConstraints', contentConstraints))
      ..add(DiagnosticsProperty('contentSpacing', contentSpacing))
      ..add(ObjectFlagProperty.has('contentOverflow', contentOverflow))
      ..add(DiagnosticsProperty('contentOffset', contentOffset))
      ..add(EnumProperty('contentHideRegion', contentHideRegion))
      ..add(DiagnosticsProperty('contentGroupId', contentGroupId))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'))
      ..add(ObjectFlagProperty.has('emptyBuilder', contentEmptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(FlagProperty('contentScrollHandles', value: contentScrollHandles, ifTrue: 'contentScrollHandles'))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics))
      ..add(EnumProperty('contentDivider', contentDivider));
  }
}

abstract class _State<S extends FSelect<T>, T> extends State<S> with TickerProviderStateMixin {
  late FSelectController<T> _controller;
  late FPopoverController _popoverController;
  late final TextEditingController _textController;
  late FocusNode _focus;
  bool _mutating = false;

  @override
  void initState() {
    super.initState();
    _controller = (widget.control ?? FSelectControl<T>.managed()).create(_updateTextController);
    _popoverController = widget.popoverControl.create(_handlePopoverChange, this);
    _textController = TextEditingController(
      text: _controller.value == null ? '' : widget.format(_controller.value as T),
    )..addListener(_updateSelectController);

    _focus = widget.focusNode ?? .new(debugLabel: 'FSelect');
  }

  @override
  void didUpdateWidget(covariant S old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? .new(debugLabel: 'FSelect');
    }

    final current = widget.control ?? FSelectControl<T>.managed();
    final previous = old.control ?? FSelectControl<T>.managed();
    final (controller, updated) = current.update(previous, _controller, _updateTextController);
    if (updated) {
      _controller = controller;
      _updateTextController();
    }
    _popoverController = widget.popoverControl
        .update(old.popoverControl, _popoverController, _handlePopoverChange, this)
        .$1;
  }

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

    if (widget.control case FSelectManagedControl(:final onChange?)) {
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
    final style = widget.style?.call(context.theme.selectStyle) ?? context.theme.selectStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    return Field<T>(
      controller: _controller,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      onSaved: widget.onSaved,
      onReset: widget.onReset,
      validator: widget.validator,
      builder: (state) => FTextField(
        control: .managed(controller: _textController),
        focusNode: _focus,
        style: style.fieldStyle,
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
          shortcuts: {const SingleActivator(.escape): _toggle},
          popoverBuilder: (_, popoverController) => TextFieldTapRegion(
            child: InheritedSelectController<T>(
              popover: popoverController,
              contains: (value) => _controller.value == value,
              focus: (value) => _controller.value == value,
              onPress: (value) async {
                if (widget.autoHide) {
                  _focus.requestFocus();
                  await _popoverController.hide();
                }

                _controller.value = value;
              },
              child: content(context, style),
            ),
          ),
          child: CallbackShortcuts(
            bindings: {const SingleActivator(.enter): _toggle},
            child: widget.builder(context, style, states, field),
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context, FSelectStyle style);

  void _toggle() {
    _popoverController.status.isCompleted ? _focus.requestFocus() : _focus.unfocus();
    _popoverController.toggle();
  }

  @override
  void dispose() {
    _textController.dispose();
    widget.popoverControl.dispose(_popoverController, _handlePopoverChange);
    (widget.control ?? FSelectControl<T>.managed()).dispose(_controller, _updateTextController);

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
  final FTextFieldStyle fieldStyle;

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
    required this.fieldStyle,
    required this.searchStyle,
    required this.contentStyle,
    required this.emptyTextStyle,
  });

  /// Creates a [FSelectStyle] that inherits its properties.
  FSelectStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        fieldStyle: .inherit(colors: colors, typography: typography, style: style),
        searchStyle: .inherit(colors: colors, typography: typography, style: style),
        contentStyle: .inherit(colors: colors, typography: typography, style: style),
        emptyTextStyle: typography.sm,
      );
}
