// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_group/select_group_item.dart';

part 'select_group.style.dart';

/// A [FSelectGroup]'s controller.
typedef FSelectGroupController<T> = FMultiValueNotifier<T>;

/// A set of items that are treated as a single selection.
///
/// Typically used to group multiple [FSelectGroupItem.checkbox]s or [FSelectGroupItem.radio]s.
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
  final FSelectGroupStyle? style;

  @override
  final Widget? label;

  @override
  final Widget? description;

  @override
  final Widget Function(BuildContext, String) errorBuilder;

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
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.onChange,
    this.onSelect,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.key,
  }) : super(
         builder: (field) {
           final state = field as _State;
           final groupStyle = style ?? state.context.theme.selectGroupStyle;
           final (labelState, error) = switch (state.errorText) {
             _ when !enabled => (FLabelState.disabled, null),
             final text? => (FLabelState.error, errorBuilder(state.context, text)),
             null => (FLabelState.enabled, null),
           };

           return FLabel(
             axis: Axis.vertical,
             state: labelState,
             style: groupStyle.labelStyle,
             label: label,
             description: description,
             error: error,
             child: Column(
               children: [
                 for (final child in children)
                   FSelectGroupItemData<T>(
                     controller: controller,
                     style: groupStyle,
                     selected: controller.contains(child.value),
                     child: child,
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
class FSelectGroupStyle with Diagnosticable, _$FSelectGroupStyleFunctions {
  /// The [FLabel]'s style.
  @override
  final FLabelLayoutStyle labelLayoutStyle;

  /// The [FSelectGroup]'s style when it's enabled.
  @override
  final FSelectGroupStateStyle enabledStyle;

  /// The [FSelectGroup]'s style when it's disabled.
  @override
  final FSelectGroupStateStyle disabledStyle;

  /// The [FSelectGroup]'s style when it has an error.
  @override
  final FSelectGroupErrorStyle errorStyle;

  /// The [FSelectGroupItem.checkbox]'s style.
  @override
  final FCheckboxSelectGroupStyle checkboxStyle;

  /// The [FSelectGroupItem.radio]'s style.
  @override
  final FRadioSelectGroupStyle radioStyle;

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    required this.checkboxStyle,
    required this.radioStyle,
  });

  /// Creates a [FSelectGroupStyle] that inherits its properties from the given parameters.
  factory FSelectGroupStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) => FSelectGroupStyle(
    labelLayoutStyle: FLabelStyles.inherit(style: style).verticalStyle.layout,
    enabledStyle: FSelectGroupStateStyle(
      labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
    ),
    disabledStyle: FSelectGroupStateStyle(
      labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
    ),
    errorStyle: FSelectGroupErrorStyle(
      labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
      errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
    ),
    checkboxStyle: FCheckboxSelectGroupStyle.inherit(
      style: FCheckboxStyle.inherit(colors: colors, style: style).transform(
        (style) => style.copyWith(
          enabledStyle: style.enabledStyle.copyWith(
            labelTextStyle: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
            descriptionTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
          ),
          disabledStyle: style.disabledStyle.copyWith(
            labelTextStyle: typography.sm.copyWith(color: colors.disable(colors.primary), fontWeight: FontWeight.w500),
            descriptionTextStyle: typography.sm.copyWith(color: colors.disable(colors.mutedForeground)),
          ),
          errorStyle: style.errorStyle.copyWith(
            labelTextStyle: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
            descriptionTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
            errorTextStyle: typography.sm.copyWith(color: colors.error, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ),
    radioStyle: FRadioSelectGroupStyle.inherit(
      style: FRadioStyle.inherit(colors: colors, style: style).transform(
        (style) => style.copyWith(
          enabledStyle: style.enabledStyle.copyWith(
            labelTextStyle: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
            descriptionTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
          ),
          disabledStyle: style.disabledStyle.copyWith(
            labelTextStyle: typography.sm.copyWith(color: colors.disable(colors.primary), fontWeight: FontWeight.w500),
            descriptionTextStyle: typography.sm.copyWith(color: colors.disable(colors.mutedForeground)),
          ),
          errorStyle: style.errorStyle.copyWith(
            labelTextStyle: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
            descriptionTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
            errorTextStyle: typography.sm.copyWith(color: colors.error, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ),
  );

  /// The [FLabel]'s style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
    layout: labelLayoutStyle,
    state: FLabelStateStyles(enabledStyle: enabledStyle, disabledStyle: disabledStyle, errorStyle: errorStyle),
  );
}

/// [FSelectGroup]'s state style.
// ignore: avoid_implementing_value_types
class FSelectGroupStateStyle with Diagnosticable, _$FSelectGroupStateStyleFunctions implements FFormFieldStyle {
  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FSelectGroupStateStyle].
  FSelectGroupStateStyle({required this.labelTextStyle, required this.descriptionTextStyle});
}

/// [FSelectGroup]'s error style.
// ignore: avoid_implementing_value_types
class FSelectGroupErrorStyle with Diagnosticable, _$FSelectGroupErrorStyleFunctions implements FFormFieldErrorStyle {
  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  @override
  final TextStyle errorTextStyle;

  /// Creates a [FSelectGroupErrorStyle].
  FSelectGroupErrorStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    required this.errorTextStyle,
  });
}
