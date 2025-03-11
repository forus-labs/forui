import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class FSelect<T> extends StatefulWidget {
  /// The default suffix builder that shows a upward and downward facing chevron icon.
  static Widget defaultIconBuilder(BuildContext _, (FTimeFieldStyle, FTextFieldStateStyle) styles, Widget? _) =>
      Padding(
        padding: const EdgeInsetsDirectional.only(end: 8.0),
        child: FIconStyleData(style: styles.$1.iconStyle, child: FIcon(FAssets.icons.chevronsUpDown)),
      );

  /// The default format function that converts the selected items to a comma separated string.
  static String defaultFormat<T>(Set<Object?> selected) => selected.map((e) => e.toString()).join(', ');

  /// The controller.
  final FSelectController<T>? controller;

  /// The style.
  final FTimeFieldStyle? style;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// Builds a widget at the start of the select that can be pressed to toggle the popover. Defaults to no icon.
  final ValueWidgetBuilder<(FTimeFieldStyle, FTextFieldStateStyle)>? prefixBuilder;

  /// Builds a widget at the end of the select that can be pressed to toggle the popover. Defaults to
  /// [defaultIconBuilder].
  final ValueWidgetBuilder<(FTimeFieldStyle, FTextFieldStateStyle)>? suffixBuilder;

  /// The label.
  final Widget? label;

  /// The description.
  final Widget? description;

  /// {@macro forui.foundation.form_field_properties.errorBuilder}
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@macro forui.foundation.form_field_properties.enabled}
  final bool enabled;

  /// {@macro forui.foundation.form_field_properties.onSaved}
  final FormFieldSetter<Set<T>>? onSaved;

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
  /// When [FTimeFieldController.validator] is provided, [forceErrorText] will override any error that it returns.
  /// [FTimeFieldController.validator] will not be called unless [forceErrorText] is null.
  final String? forceErrorText;

  /// The function that formats the selected items into a string. The items are sorted in order of selection.
  ///
  /// Defaults to [defaultFormat].
  final String Function(Set<T>) format;

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

  /// The constraints to apply to the popover. Defaults to `BoxConstraints()`.
  final BoxConstraints popoverConstraints;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@macro forui.widgets.FPopover.hideOnTapOutside}
  final FHidePopoverRegion hideOnTapOutside;

  /// Whether to add padding based on the popover direction. Defaults to false.
  final bool directionPadding;

  /// True if the dropdown menu should be automatically hidden after an item is selected. Defaults to false.
  final bool autoHide;

  const FSelect({
    this.controller,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.prefixBuilder,
    this.suffixBuilder = defaultIconBuilder,
    this.label,
    this.description,
    this.enabled = true,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.forceErrorText,
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
    this.popoverConstraints = const BoxConstraints(),
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
    this.autoHide = true,
    super.key,
  });

  @override
  State<FSelect<T>> createState() => _State<T>();

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
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
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
      ..add(FlagProperty('autoHide', value: autoHide, ifTrue: 'autoHide'));
  }
}

class _State<T> extends State<FSelect<T>> with SingleTickerProviderStateMixin {
  late FSelectController<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FSelectController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant FSelect<T> old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? FSelectController(vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.timeFieldStyle;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();
    final onSaved = widget.onSaved;
    return FTextField(
      // focusNode: _focus,
      style: style.textFieldStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      expands: widget.expands,
      mouseCursor: widget.mouseCursor,
      canRequestFocus: widget.canRequestFocus,
      onTap: _controller.popover.toggle,
      hint: widget.hint ?? localizations.selectHint,
      readOnly: true,
      enableInteractiveSelection: false,
      prefixBuilder:
          widget.prefixBuilder == null
              ? null
              : (context, stateStyle, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.prefixBuilder?.call(context, (style, stateStyle), null),
              ),
      suffixBuilder:
          widget.suffixBuilder == null
              ? null
              : (context, stateStyle, _) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.suffixBuilder?.call(context, (style, stateStyle), null),
              ),
      clearable: widget.clearable ? (_) => _controller.value.isNotEmpty : (_) => false,
      label: widget.label,
      description: widget.description,
      enabled: widget.enabled,
      onSaved: onSaved == null ? null : (_) => onSaved(_controller.value),
      validator: (_) => _controller.validator(_controller.value),
      autovalidateMode: widget.autovalidateMode,
      forceErrorText: widget.forceErrorText,
      errorBuilder: widget.errorBuilder,
      builder:
          (_, _, child) => FPopover(
            style: style.popoverStyle,
            controller: _controller.popover,
            popoverAnchor: widget.anchor,
            childAnchor: widget.fieldAnchor,
            shift: widget.shift,
            hideOnTapOutside: widget.hideOnTapOutside,
            directionPadding: widget.directionPadding,
            popoverBuilder:
                (_, _, _) => TextFieldTapRegion(
                  child: ConstrainedBox(
                    constraints: widget.popoverConstraints,
                    // TODO: Different select content.
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [

                      ]),
                    ),
                  ),
                ),
            child: child!,
          ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
