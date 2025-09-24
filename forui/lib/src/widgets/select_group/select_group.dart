import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

part 'select_group.design.dart';

/// A [FSelectGroup]'s controller.
typedef FSelectGroupController<T> = FMultiValueNotifier<T>;

/// Represents an item in a [FSelectGroup].
mixin FSelectGroupItem<T> on Widget {
  /// The value.
  T get value;
}

/// A [FSelectGroup]'s item data. Useful for creating your own [FSelectGroupItem].
class FSelectGroupItemData<T> extends InheritedWidget {
  /// Return the [FSelectGroup]'s item data.
  static FSelectGroupItemData<T> of<T>(BuildContext context) {
    assert(debugCheckHasAncestor<FSelectGroupItemData<T>>('${FSelectGroup<T>}', context, generic: true));
    return context.dependOnInheritedWidgetOfExactType<FSelectGroupItemData<T>>()!;
  }

  /// The controller.
  final FSelectGroupController<T> controller;

  /// The style.
  final FSelectGroupStyle style;

  /// True if the item is selected.
  final bool selected;

  /// The [FSelectGroup]'s item data.
  const FSelectGroupItemData({
    required this.controller,
    required this.style,
    required this.selected,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FSelectGroupItemData old) =>
      controller != old.controller || style != old.style || selected != old.selected;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'));
  }
}

/// A set of items that are treated as a single selection.
///
/// Typically used to group multiple [FCheckbox.grouped]s or [FRadio.grouped]s.
///
/// For touch devices, a [FSelectTileGroup] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/form/select-group for working examples.
/// * [FSelectGroupStyle] for customizing a select group's appearance.
class FSelectGroup<T> extends FormField<Set<T>> with FFormFieldProperties<Set<T>> {
  /// The controller.
  final FSelectGroupController<T> controller;

  /// The style. Defaults to [FThemeData.selectGroupStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-group
  /// ```
  final FSelectGroupStyle Function(FSelectGroupStyle style)? style;

  @override
  final Widget? label;

  @override
  final Widget? description;

  /// The items.
  final List<FSelectGroupItem<T>> children;

  /// The callback that is called when the value changes.
  final ValueChanged<Set<T>>? onChange;

  /// The callback that is called when an item is selected.
  final ValueChanged<(T, bool)>? onSelect;

  /// Creates a [FSelectGroup].
  FSelectGroup({
    required this.controller,
    required this.children,
    this.style,
    this.label,
    this.description,
    this.onChange,
    this.onSelect,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    super.onSaved,
    super.onReset,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.key,
  }) : super(
         initialValue: controller.value,
         errorBuilder: errorBuilder,
         builder: (field) {
           final state = field as _State;
           final groupStyle = style?.call(state.context.theme.selectGroupStyle) ?? state.context.theme.selectGroupStyle;
           final formStates = {if (!enabled) WidgetState.disabled, if (state.errorText != null) WidgetState.error};

           return FLabel(
             axis: Axis.vertical,
             states: formStates,
             style: groupStyle,
             label: label,
             description: description,
             error: state.errorText == null ? null : errorBuilder(state.context, state.errorText!),
             child: Column(
               children: [
                 for (final child in children)
                   Padding(
                     padding: groupStyle.itemPadding,
                     child: FSelectGroupItemData<T>(
                       controller: controller,
                       style: groupStyle,
                       selected: controller.contains(child.value),
                       child: child,
                     ),
                   ),
               ],
             ),
           );
         },
       );

  @override
  FormFieldState<Set<T>> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onSelect', onSelect));
  }
}

class _State<T> extends FormFieldState<Set<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
    widget.controller.addValueListener(widget.onChange);
    widget.controller.addUpdateListener(widget.onSelect);
  }

  @override
  void didUpdateWidget(covariant FSelectGroup<T> old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      widget.controller.addListener(_handleControllerChanged);
      old.controller.removeListener(_handleControllerChanged);
    }

    old.controller.removeValueListener(old.onChange);
    old.controller.removeUpdateListener(old.onSelect);
    widget.controller.addValueListener(widget.onChange);
    widget.controller.addUpdateListener(widget.onSelect);
  }

  @override
  void didChange(Set<T>? value) {
    super.didChange(value);
    if (!setEquals(widget.controller.value, value)) {
      widget.controller.value = value ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.value = widget.initialValue ?? {};
    super.reset();
  }

  @override
  void dispose() {
    widget.controller
      ..removeListener(_handleControllerChanged)
      ..removeValueListener(widget.onChange)
      ..removeUpdateListener(widget.onSelect);
    super.dispose();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (widget.controller.value != value) {
      didChange(widget.controller.value);
    }
  }

  @override
  FSelectGroup<T> get widget => super.widget as FSelectGroup<T>;
}

/// [FSelectGroup]'s style.
class FSelectGroupStyle extends FLabelStyle with Diagnosticable, _$FSelectGroupStyleFunctions {
  /// The [FCheckbox]'s style.
  @override
  final FCheckboxStyle checkboxStyle;

  /// The [FRadio]'s style.
  @override
  final FRadioStyle radioStyle;

  /// The padding surrounding an item. Defaults to `EdgeInsets.symmetric(vertical: 2)`.
  @override
  final EdgeInsetsGeometry itemPadding;

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.checkboxStyle,
    required this.radioStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 2),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FSelectGroupStyle] that inherits its properties.
  factory FSelectGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final vertical = FLabelStyles.inherit(style: style).verticalStyle;

    final labelTextStyle = FWidgetStateMap({
      WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary), fontWeight: FontWeight.w500),
      WidgetState.any: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
    });
    final descriptionTextStyle = FWidgetStateMap({
      WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.mutedForeground)),
      WidgetState.any: typography.sm.copyWith(color: colors.mutedForeground),
    });
    final errorTextStyle = typography.sm.copyWith(color: colors.error, fontWeight: FontWeight.w500);

    return FSelectGroupStyle(
      checkboxStyle: FCheckboxStyle.inherit(colors: colors, style: style).copyWith(
        labelTextStyle: labelTextStyle,
        descriptionTextStyle: descriptionTextStyle,
        errorTextStyle: errorTextStyle,
      ),
      radioStyle: FRadioStyle.inherit(colors: colors, style: style).copyWith(
        labelTextStyle: labelTextStyle,
        descriptionTextStyle: descriptionTextStyle,
        errorTextStyle: errorTextStyle,
      ),
      labelTextStyle: style.formFieldStyle.labelTextStyle,
      descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
      errorTextStyle: style.formFieldStyle.errorTextStyle,
      labelPadding: vertical.labelPadding,
      descriptionPadding: vertical.descriptionPadding,
      errorPadding: vertical.errorPadding,
      childPadding: vertical.childPadding,
    );
  }
}
