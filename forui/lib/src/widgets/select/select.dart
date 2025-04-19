import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/content/search_content.dart';
import 'package:forui/src/widgets/select/select_controller.dart';

part 'basic_select.dart';

part 'search_select.dart';

part 'select.style.dart';

/// A select displays a list of options for the user to pick from.
///
/// It is a [FormField] and therefore can be used in a [Form] widget.
///
/// See:
/// * https://forui.dev/docs/form/select for working examples.
/// * [FSelectController] for customizing the behavior of a select.
/// * [FSelectStyle] for customizing the appearance of a select.
abstract class FSelect<T> extends StatefulWidget {
  /// The default suffix builder that shows a upward and downward facing chevron icon.
  static Widget defaultIconBuilder(
    BuildContext _,
    (FSelectStyle, FTextFieldStyle, Set<WidgetState>) styles,
    Widget? _,
  ) => Padding(
    padding: const EdgeInsetsDirectional.only(end: 8.0),
    child: IconTheme(data: styles.$1.iconStyle, child: const Icon(FIcons.chevronDown)),
  );

  /// The default loading builder that shows a spinner when an asynchronous search is pending.
  static Widget defaultSearchLoadingBuilder(BuildContext _, FSelectSearchStyle style, Widget? _) =>
      Padding(padding: const EdgeInsets.all(8.0), child: FProgress.circularIcon(style: style.loadingIndicatorStyle));

  /// The default empty builder that shows a localized message when there are no results.
  static Widget defaultEmptyBuilder(BuildContext context, FSelectStyle style, Widget? _) {
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: Text(localizations.selectNoResults, style: style.emptyTextStyle),
    );
  }

  static Widget _fieldBuilder(BuildContext _, (FSelectStyle, FTextFieldStyle, Set<WidgetState>) _, Widget? child) =>
      child!;

  /// The default format function that converts the selected items to a comma separated string.
  static String defaultFormat(Object? selected) => selected.toString();

  static String? _defaultValidator(Object? _) => null;

  /// The controller.
  final FSelectController<T>? controller;

  /// The style.
  final FSelectStyle? style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// The builder used to decorate the select. It should use the given child.
  ///
  /// Defaults to returning the given child.
  final ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)> builder;

  /// Builds a widget at the start of the select that can be pressed to toggle the popover. Defaults to no icon.
  final ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)>? prefixBuilder;

  /// Builds a widget at the end of the select that can be pressed to toggle the popover. Defaults to
  /// [defaultIconBuilder].
  final ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final FormFieldSetter<T>? onSaved;

  /// Used to enable/disable this checkbox auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.onUnfocus].
  ///
  /// If [AutovalidateMode.onUserInteraction], this checkbox will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode autovalidateMode;

  /// An optional property that forces the [FormFieldState] into an error state by directly setting the
  /// [FormFieldState.errorText] property without running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText] will be set to the provided value,
  /// causing the form field to be considered invalid and to display the error message specified.
  ///
  /// When [validator] is provided, [forceErrorText] will override any error that it returns. [validator] will not be
  /// called unless [forceErrorText] is null.
  final String? forceErrorText;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a time in a picker is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<T> validator;

  /// The function that formats the selected items into a string. The items are sorted in order of selection.
  ///
  /// Defaults to [defaultFormat].
  final String Function(T) format;

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

  /// The alignment point on the popover. Defaults to [Alignment.topLeft].
  final AlignmentGeometry anchor;

  /// The alignment point on the select's field. Defaults to [Alignment.bottomLeft].
  final AlignmentGeometry fieldAnchor;

  /// The constraints to apply to the popover. Defaults to `const BoxConstraints(maxWidth: 200, maxHeight: 300)`.
  final BoxConstraints popoverConstraints;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@macro forui.widgets.FPopover.hideOnTapOutside}
  final FHidePopoverRegion hideOnTapOutside;

  /// Whether to add padding based on the popover direction. Defaults to false.
  final bool directionPadding;

  /// True if the select should be automatically hidden after an item is selected. Defaults to false.
  final bool autoHide;

  /// The builder that is called when the select is empty. Defaults to [defaultEmptyBuilder].
  final ValueWidgetBuilder<FSelectStyle> emptyBuilder;

  /// The content's scroll controller.
  final ScrollController? contentScrollController;

  /// True if the content should show scroll handles instead of a scrollbar. Defaults to false.
  final bool contentScrollHandles;

  /// The content's scroll physics. Defaults to [ClampingScrollPhysics].
  final ScrollPhysics contentPhysics;

  /// Creates a select with a list of selectable items.
  const factory FSelect({
    required List<FSelectItemMixin> children,
    FSelectController<T>? controller,
    FSelectStyle? style,
    bool autofocus,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)> builder,
    ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)>? prefixBuilder,
    ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<T> validator,
    Widget Function(BuildContext, String) errorBuilder,
    String Function(T) format,
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
    BoxConstraints popoverConstraints,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    FHidePopoverRegion hideOnTapOutside,
    bool directionPadding,
    bool autoHide,
    ValueWidgetBuilder<FSelectStyle> emptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    Key? key,
  }) = _BasicSelect<T>;

  /// Creates a searchable select with dynamic content based on search input.
  ///
  /// The [searchFieldProperties] can be used to customize the search field.
  ///
  /// The [filter] callback produces a list of items based on the search query either synchronously or asynchronously.
  /// The [contentBuilder] callback builds the list of items based on search results returned by [filter].
  /// The [searchLoadingBuilder] is used to show a loading indicator while the search results is processed
  /// asynchronously by [filter].
  /// The [searchErrorBuilder] is used to show an error message when [filter] is asynchronous and fails.
  const factory FSelect.search({
    required FSelectSearchFilter<T> filter,
    required FSelectSearchContentBuilder<T> contentBuilder,
    FSelectSearchFieldProperties searchFieldProperties,
    ValueWidgetBuilder<FSelectSearchStyle> searchLoadingBuilder,
    Widget Function(BuildContext, Object?, StackTrace)? searchErrorBuilder,
    FSelectController<T>? controller,
    FSelectStyle? style,
    bool autofocus,
    FocusNode? focusNode,
    ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)> builder,
    ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)>? prefixBuilder,
    ValueWidgetBuilder<(FSelectStyle, FTextFieldStyle, Set<WidgetState>)>? suffixBuilder,
    Widget? label,
    Widget? description,
    bool enabled,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode autovalidateMode,
    String? forceErrorText,
    FormFieldValidator<T> validator,
    Widget Function(BuildContext, String) errorBuilder,
    String Function(T) format,
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
    BoxConstraints popoverConstraints,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    FHidePopoverRegion hideOnTapOutside,
    bool directionPadding,
    bool autoHide,
    ValueWidgetBuilder<FSelectStyle> emptyBuilder,
    ScrollController? contentScrollController,
    bool contentScrollHandles,
    ScrollPhysics contentPhysics,
    Key? key,
  }) = _SearchSelect<T>;

  const FSelect._({
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
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
    this.validator = _defaultValidator,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.format = defaultFormat,
    this.hint,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.expands = false,
    this.mouseCursor = SystemMouseCursors.click,
    this.canRequestFocus = true,
    this.clearable = false,
    this.anchor = Alignment.topLeft,
    this.fieldAnchor = Alignment.bottomLeft,
    this.popoverConstraints = const BoxConstraints(maxWidth: 200, maxHeight: 300),
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
    this.autoHide = true,
    this.emptyBuilder = defaultEmptyBuilder,
    this.contentScrollController,
    this.contentScrollHandles = false,
    this.contentPhysics = const ClampingScrollPhysics(),
    super.key,
  });

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
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
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
      ..add(DiagnosticsProperty('constraints', popoverConstraints))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'))
      ..add(ObjectFlagProperty.has('emptyBuilder', emptyBuilder))
      ..add(DiagnosticsProperty('contentScrollController', contentScrollController))
      ..add(FlagProperty('contentScrollHandles', value: contentScrollHandles))
      ..add(DiagnosticsProperty('contentPhysics', contentPhysics));
  }
}

abstract class _State<S extends FSelect<T>, T> extends State<S> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late FSelectController<T> _controller;
  late FocusNode _focus;
  bool _mutating = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FSelectController(vsync: this);

    _focus = widget.focusNode ?? FocusNode(debugLabel: 'FSelect');
    _textController.addListener(_updateSelectController);
    _controller.addListener(_updateTextController);
    _controller.popover.addListener(_updateFocus);
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
        old.controller!.popover.removeListener(_updateFocus);
        old.controller!.removeListener(_updateTextController);
      }

      _controller = widget.controller ?? FSelectController(vsync: this);
      _controller.addListener(_updateTextController);
      _controller.popover.addListener(_updateFocus);
      _updateTextController();
    }
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
  }

  void _updateFocus() {
    if (!_controller.popover.shown) {
      _focus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.selectStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final onSaved = widget.onSaved;
    return FTextField(
      focusNode: _focus,
      controller: _textController,
      style: style.selectFieldStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      expands: widget.expands,
      mouseCursor: widget.mouseCursor,
      canRequestFocus: widget.canRequestFocus,
      onTap: _show,
      hint: widget.hint ?? localizations.selectHint,
      readOnly: true,
      enableInteractiveSelection: false,
      prefixBuilder:
          widget.prefixBuilder == null
              ? null
              : (context, styles, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.prefixBuilder?.call(context, (style, styles.$1, styles.$2), null),
              ),
      suffixBuilder:
          widget.suffixBuilder == null
              ? null
              : (context, styles, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.suffixBuilder?.call(context, (style, styles.$1, styles.$2), null),
              ),
      clearable: widget.clearable ? (_) => _controller.value != null : (_) => false,
      label: widget.label,
      description: widget.description,
      enabled: widget.enabled,
      onSaved: onSaved == null ? null : (_) => onSaved(_controller.value),
      validator: (_) => widget.validator(_controller.value),
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      errorBuilder: widget.errorBuilder,
      builder:
          (context, data, child) => FPopover(
            style: style.popoverStyle,
            controller: _controller.popover,
            popoverAnchor: widget.anchor,
            childAnchor: widget.fieldAnchor,
            shift: widget.shift,
            hideOnTapOutside: widget.hideOnTapOutside,
            directionPadding: widget.directionPadding,
            popoverBuilder:
                (_, _, _) => ConstrainedBox(
                  constraints: widget.popoverConstraints,
                  child: SelectControllerData<T>(
                    contains: (value) => _controller.value == value,
                    onPress: (value) async {
                      if (widget.autoHide) {
                        await _controller.popover.hide();
                      }

                      _controller.value = value;
                    },
                    child: content(context, style),
                  ),
                ),
            child: CallbackShortcuts(
              bindings: {
                const SingleActivator(LogicalKeyboardKey.enter): _show,
                const SingleActivator(LogicalKeyboardKey.tab): _focus.nextFocus,
              },
              child: widget.builder(context, (style, data.$1, data.$2), child),
            ),
          ),
    );
  }

  Widget content(BuildContext context, FSelectStyle style);

  void _show() {
    _focus.unfocus();
    _controller.popover.toggle();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.popover.removeListener(_updateFocus);
      _controller.removeListener(_updateTextController);
    }
    _textController.dispose();
    _focus.dispose();
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

  ///The default text style when there are no results.
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
