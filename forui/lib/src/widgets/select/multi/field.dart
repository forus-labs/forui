import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/select_controller.dart';

part 'field.design.dart';

@internal
class Field<T> extends FormField<Set<T>> {
  final FMultiSelectController<T>? controller;
  final FMultiSelectStyle style;
  final bool autofocus;
  final FocusNode? focusNode;
  final FFieldIconBuilder<FMultiSelectStyle>? prefixBuilder;
  final FFieldIconBuilder<FMultiSelectStyle>? suffixBuilder;
  final Widget? label;
  final Widget? description;
  final Widget? hint;
  final bool keepHint;
  final int Function(T a, T b)? sort;
  final Widget Function(T value) format;
  final FMultiSelectTagBuilder<T> tagBuilder;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool clearable;
  final AlignmentGeometry anchor;
  final AlignmentGeometry fieldAnchor;
  final FPortalConstraints popoverConstraints;
  final FPortalSpacing spacing;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  final Offset offset;
  final FPopoverHideRegion hideRegion;
  final ValueChanged<Set<T>>? onChange;
  final Widget Function(BuildContext context, FMultiSelectController<T> controller) popoverBuilder;
  final int min;
  final int? max;

  Field({
    required this.controller,
    required this.style,
    required this.autofocus,
    required this.focusNode,
    required this.prefixBuilder,
    required this.suffixBuilder,
    required this.label,
    required this.description,
    required this.hint,
    required this.keepHint,
    required this.sort,
    required this.format,
    required this.tagBuilder,
    required this.textAlign,
    required this.textDirection,
    required this.clearable,
    required this.anchor,
    required this.fieldAnchor,
    required this.popoverConstraints,
    required this.spacing,
    required this.shift,
    required this.offset,
    required this.hideRegion,
    required this.onChange,
    required this.popoverBuilder,
    required this.min,
    required this.max,
    required super.enabled,
    required super.autovalidateMode,
    required super.forceErrorText,
    required super.errorBuilder,
    required void Function(Set<T> values)? onSaved,
    required super.onReset,
    required String? Function(Set<T> values)? validator,
    required super.initialValue,
    super.key,
  }) : super(
         onSaved: onSaved == null ? null : (v) => onSaved(v ?? {}),
         validator: validator == null ? null : (v) => validator(v ?? {}),
         builder: (formField) {
           final state = formField as _State<T>;
           final localizations = FLocalizations.of(state.context) ?? FDefaultLocalizations();
           final direction = textDirection ?? Directionality.maybeOf(state.context) ?? TextDirection.ltr;
           final padding = style.fieldStyle.contentPadding.resolve(direction);
           final values = sort == null ? state._controller.value : state._controller.value.sorted(sort);

           return Directionality(
             textDirection: direction,
             child: FLabel(
               axis: Axis.vertical,
               states: {if (!enabled) WidgetState.disabled, if (state.hasError) WidgetState.error},
               label: label,
               style: style.fieldStyle,
               description: description,
               // Error should never be null as doing so causes the widget tree to change. This causes overlays attached
               // to the field to fail as it is not smart enough to track the new location of the field in the widget tree.
               error: state.errorText == null || errorBuilder == null
                   ? const SizedBox()
                   : errorBuilder(state.context, state.errorText!),
               child: FPopover(
                 controller: state._controller.popover,
                 style: style.popoverStyle,
                 constraints: popoverConstraints,
                 popoverAnchor: anchor,
                 childAnchor: fieldAnchor,
                 spacing: spacing,
                 shift: shift,
                 offset: offset,
                 hideRegion: hideRegion,
                 shortcuts: {const SingleActivator(LogicalKeyboardKey.escape): state._toggle},
                 popoverBuilder: (context, controller) => InheritedSelectController<T>(
                   popover: state._controller.popover,
                   contains: (value) => state._controller.value.contains(value),
                   focus: (value) => state._controller.value.lastOrNull == value,
                   onPress: (value) => state._controller.update(value, add: !state._controller.value.contains(value)),
                   child: popoverBuilder(context, state._controller),
                 ),
                 child: FTappable(
                   style: style.fieldStyle.tappableStyle,
                   focusNode: state._focus,
                   onPress: enabled ? state._toggle : null,
                   builder: (context, states, child) {
                     states = {...states, if (!enabled) WidgetState.disabled, if (state.hasError) WidgetState.error};
                     return DecoratedBox(
                       decoration: style.fieldStyle.decoration.resolve(states),
                       child: Padding(
                         padding: padding.copyWith(top: 0, bottom: 0),
                         child: DefaultTextStyle.merge(
                           textAlign: textAlign,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               if (prefixBuilder case final prefix?) prefix(context, style, states),
                               Expanded(
                                 child: Padding(
                                   padding: padding.copyWith(left: 0, right: 0),
                                   child: Wrap(
                                     crossAxisAlignment: WrapCrossAlignment.center,
                                     spacing: style.fieldStyle.spacing,
                                     runSpacing: style.fieldStyle.runSpacing,
                                     children: [
                                       for (final value in values)
                                         tagBuilder(context, state._controller, style, value, format(value)),
                                       if (keepHint || state._controller.value.isEmpty)
                                         Padding(
                                           padding: style.fieldStyle.hintPadding,
                                           child: DefaultTextStyle.merge(
                                             style: style.fieldStyle.hintTextStyle.resolve(states),
                                             child: hint ?? Text(localizations.multiSelectHint),
                                           ),
                                         ),
                                     ],
                                   ),
                                 ),
                               ),
                               if (clearable && state._controller.value.isNotEmpty)
                                 Padding(
                                   padding: style.fieldStyle.clearButtonPadding,
                                   child: FButton.icon(
                                     style: style.fieldStyle.clearButtonStyle,
                                     onPress: () => state._controller.value = {},
                                     child: Icon(
                                       FIcons.x,
                                       semanticLabel: localizations.textFieldClearButtonSemanticsLabel,
                                     ),
                                   ),
                                 ),
                               if (suffixBuilder case final suffix?) suffix(context, style, states),
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

  @override
  FormFieldState<Set<T>> createState() => _State<T>();

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
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(FlagProperty('keepHint', value: keepHint, ifTrue: 'keepHint'))
      ..add(ObjectFlagProperty.has('sort', sort))
      ..add(ObjectFlagProperty.has('format', format))
      ..add(ObjectFlagProperty.has('tagBuilder', tagBuilder))
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
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder))
      ..add(IntProperty('min', min, defaultValue: 0))
      ..add(IntProperty('max', max, defaultValue: 0));
  }
}

class _State<T> extends FormFieldState<Set<T>> with SingleTickerProviderStateMixin {
  late FMultiSelectController<T> _controller;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        FMultiSelectController(vsync: this, min: widget.min, max: widget.max, value: widget.initialValue ?? {});
    _controller
      ..addListener(_handleChange)
      ..addValueListener(_onChange);

    _focus = widget.focusNode ?? FocusNode(debugLabel: 'FMultiSelect');
  }

  @override
  void didUpdateWidget(covariant Field<T> old) {
    super.didUpdateWidget(old);
    // DO NOT REORDER
    if (widget.focusNode != old.focusNode) {
      if (old.focusNode == null) {
        _focus.dispose();
      }
      _focus = widget.focusNode ?? FocusNode(debugLabel: 'FMultiSelect');
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      } else {
        old.controller?.removeListener(_handleChange);
        old.controller?.removeValueListener(_onChange);
      }

      if (widget.controller case final controller?) {
        _controller = controller;
      } else {
        _controller = FMultiSelectController(
          vsync: this,
          min: widget.min,
          max: widget.max,
          value: widget.initialValue ?? {},
        );
      }

      _controller
        ..addListener(_handleChange)
        ..addValueListener(_onChange);
    }
  }

  void _onChange(Set<T> value) => widget.onChange?.call(value);

  // Suppress changes that originated from within this class.
  //
  // In the case where a controller has been passed in to this widget, we register this change listener. In these
  // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
  // reset() method. In such cases, the FormField value will already have been set.
  void _handleChange() {
    if (!setEquals(_controller.value, value)) {
      didChange(_controller.value);
    }
  }

  void _toggle() {
    _controller.popover.status.isCompleted ? _focus.requestFocus() : _focus.unfocus();
    _controller.popover.toggle();
  }

  @override
  void didChange(Set<T>? value) {
    super.didChange(value);
    if (!setEquals(_controller.value, value)) {
      _controller.value = value ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    _controller.value = widget.initialValue ?? {};
    super.reset();
  }

  @override
  Field<T> get widget => super.widget as Field<T>;

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller
        ..removeListener(_handleChange)
        ..removeValueListener(_onChange);
    }

    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }
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
  @override
  final IconThemeData iconStyle;

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
    this.contentPadding = const EdgeInsetsGeometry.directional(start: 10, top: 6, bottom: 6, end: 8),
    this.hintPadding = const EdgeInsetsGeometry.directional(start: 4, top: 4, bottom: 4),
    this.spacing = 4,
    this.runSpacing = 4,
    this.clearButtonPadding = EdgeInsets.zero,
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

    return FMultiSelectFieldStyle(
      decoration: FWidgetStateMap({
        WidgetState.error: BoxDecoration(
          border: Border.all(color: colors.error, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled: BoxDecoration(
          border: Border.all(color: colors.disable(colors.border), width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.focused: BoxDecoration(
          border: Border.all(color: colors.primary, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.any: BoxDecoration(
          border: Border.all(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
      }),
      hintTextStyle: FWidgetStateMap({
        WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.border)),
        WidgetState.any: typography.sm.copyWith(color: colors.mutedForeground),
      }),
      iconStyle: IconThemeData(color: colors.mutedForeground, size: 18),
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
