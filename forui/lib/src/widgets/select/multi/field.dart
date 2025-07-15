import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/select/select_controller.dart';

part 'field.style.dart';

@internal
class Field<T> extends FormField<Set<T>> {
  final FMultiSelectController<T>? controller;
  final FMultiSelectStyle style;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? prefixBuilder;
  final ValueWidgetBuilder<(FMultiSelectStyle, Set<WidgetState>)>? suffixBuilder;
  final Widget? label;
  final Widget? description;
  final ValueChanged<Set<T>>? onChange;
  final Widget? hint;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool canRequestFocus;
  final bool clearable;
  final AlignmentGeometry anchor;
  final AlignmentGeometry fieldAnchor;
  final FPortalConstraints popoverConstraints;
  final FPortalSpacing spacing;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  final Offset offset;
  final FHidePopoverRegion hideOnTapOutside;
  final Widget Function(BuildContext, FMultiSelectController<T>) popoverBuilder;

  Field({
    required this.controller,
    required this.style,
    required this.autofocus,
    required this.focusNode,
    required this.prefixBuilder,
    required this.suffixBuilder,
    required this.label,
    required this.description,
    required this.onChange,
    required this.hint,
    required this.textAlign,
    required this.textDirection,
    required this.canRequestFocus,
    required this.clearable,
    required this.anchor,
    required this.fieldAnchor,
    required this.popoverConstraints,
    required this.spacing,
    required this.shift,
    required this.offset,
    required this.hideOnTapOutside,
    required this.popoverBuilder,
    required super.enabled,
    required super.autovalidateMode,
    required super.forceErrorText,
    required super.errorBuilder,
    required void Function(Set<T>)? onSaved,
    required String? Function(Set<T>)? validator,
    required Set<T>? initialValue,
    super.key,
  }) : super(
         onSaved: onSaved == null ? null : (v) => onSaved(v ?? {}),
         validator: validator == null ? null : (v) => validator(v ?? {}),
         initialValue: initialValue ?? controller?.value,
         builder: (formField) {
           final state = formField as _State<T>;
           return Directionality(
             textDirection: textDirection ?? TextDirection.ltr,
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
                 hideOnTapOutside: hideOnTapOutside,
                 shortcuts: {const SingleActivator(LogicalKeyboardKey.escape): state._toggle},
                 popoverBuilder: (context, controller) => InheritedSelectController<T>(
                   popover: state._controller.popover,
                   contains: (value) => state._controller.value.contains(value),
                   focus: (value) => state._controller.value.lastOrNull == value,
                   onPress: (value) => state._controller.update(value, add: !state._controller.value.contains(value)),
                   child: popoverBuilder(context, state._controller),
                 ),
                 child: CallbackShortcuts(
                   bindings: {const SingleActivator(LogicalKeyboardKey.enter): state._toggle},
                   child: FTappable(
                     style: style.fieldStyle.tappableStyle,
                     focusNode: state._focus,
                     onPress: state._toggle,
                     builder: (context, states, child) => DecoratedBox(
                       decoration: style.fieldStyle.decoration.resolve(states),
                       child: Padding(
                         padding: style.fieldStyle.padding,
                         child: DefaultTextStyle.merge(
                           textAlign: textAlign,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Wrap(
                                 // TODO: Add pills
                                 children: [
                                   DefaultTextStyle.merge(
                                     style: style.fieldStyle.hintTextStyle.resolve(states),
                                     child: hint ?? const Text('TODO'),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
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
      ..add(EnumProperty('textAlign', textAlign))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('canRequestFocus', value: canRequestFocus, ifTrue: 'canRequestFocus'))
      ..add(FlagProperty('clearable', value: clearable, ifTrue: 'clearable'))
      ..add(DiagnosticsProperty('anchor', anchor))
      ..add(DiagnosticsProperty('fieldAnchor', fieldAnchor))
      ..add(DiagnosticsProperty('popoverConstraints', popoverConstraints))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder));
  }
}

class _State<T> extends FormFieldState<Set<T>> with SingleTickerProviderStateMixin {
  late FMultiSelectController<T> _controller;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FMultiSelectController(vsync: this, values: widget.initialValue);
    _controller.addListener(_handleChange);

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
        old.controller?.removeValueListener(_onChange);
      }

      if (widget.controller case final controller?) {
        _controller = controller;
      } else {
        _controller = FMultiSelectController(vsync: this, values: widget.initialValue);
      }

      _controller.addValueListener(_onChange);
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
      _controller.removeValueListener(_onChange);
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
  @override
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The multi-select field's padding. Defaults to `const EdgeInsets.only(left: 14, top: 10, bottom: 10, right: 8)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The multi-select field hint's text style.
  @override
  final FWidgetStateMap<TextStyle> hintTextStyle;

  /// The multi-select field's icon padding. Defaults to `EdgeInsets.zero`.
  @override
  final EdgeInsetsGeometry iconPadding;

  /// The multi-select field's icon style.
  @override
  final IconThemeData iconStyle;

  /// The multi-select field's tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FMultiSelectFieldStyle].
  FMultiSelectFieldStyle({
    required this.decoration,
    required this.hintTextStyle,
    required this.iconStyle,
    required this.tappableStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.padding = const EdgeInsets.only(left: 14, top: 10, bottom: 10, right: 8),
    this.iconPadding = EdgeInsets.zero,
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
      tappableStyle: style.tappableStyle.copyWith(bounceTween: FTappableStyle.noBounceTween),
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
