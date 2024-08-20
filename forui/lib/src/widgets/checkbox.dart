import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form_field.dart';

/// A checkbox control that allows the user to toggle between checked and not checked.
///
/// A [FCheckbox] is internally a [FormField], therefore it can be used in a form.
///
/// For touch devices, a [FSwitch] is generally recommended over a [FCheckbox].
///
/// See:
/// * https://forui.dev/docs/checkbox for working examples.
/// * [FCheckboxStyle] for customizing a checkbox's appearance.
class FCheckbox extends FFormField<bool> {
  /// The style. Defaults to [FThemeData.checkboxStyle].
  final FCheckboxStyle? style;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// Called when the user initiates a change to the FCheckBox's value: when they have checked or unchecked this box.
  final ValueChanged<bool>? onChange;

  /// Whether this checkbox should focus itself if nothing else is already focused. Defaults to false.
  final bool autofocus;

  /// Defines the [FocusNode] for this checkbox.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// Creates a [FCheckbox].
  const FCheckbox({
    this.style,
    this.label,
    this.description,
    this.semanticLabel,
    this.onChange,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.onSave,
    super.forceErrorText,
    super.validator,
    super.initialValue = false,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  });

  @override
  Widget builder(BuildContext context, FormFieldState<bool> state) {
    final style = this.style ?? context.theme.checkboxStyle;
    final (labelState, stateStyle) = switch ((enabled, state.hasError)) {
      (true, false) => (FLabelState.enabled, style.enabledStyle),
      (false, false) => (FLabelState.disabled, style.disabledStyle),
      (_, true) => (FLabelState.error, style.errorStyle),
    };
    final value = state.value ?? initialValue;

    return FocusableActionDetector(
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      mouseCursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
      child: Semantics(
        label: semanticLabel,
        enabled: enabled,
        checked: value,
        child: GestureDetector(
          onTap: enabled
              ? () {
                  state.didChange(!value);
                  onChange?.call(!value);
                }
              : null,
          child: FLabel(
            axis: Axis.horizontal,
            state: labelState,
            label: label,
            description: description,
            error: Text(state.errorText ?? ''),
            child: AnimatedSwitcher(
              duration: style.animationDuration,
              switchInCurve: style.curve,
              child: SizedBox.square(
                key: ValueKey(value),
                dimension: 16,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: stateStyle.borderColor,
                      width: 0.6,
                    ),
                    color: value ? stateStyle.checkedBackgroundColor : stateStyle.uncheckedBackgroundColor,
                  ),
                  child: value
                      ? FAssets.icons.check(
                          height: 14,
                          width: 14,
                          colorFilter: ColorFilter.mode(
                            stateStyle.iconColor,
                            BlendMode.srcIn,
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(DiagnosticsProperty('autofocus', autofocus))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

/// A [FCheckbox]'s style.
final class FCheckboxStyle with Diagnosticable {
  /// The duration of the animation when the checkbox's switches between checked and unchecked.
  ///
  /// Defaults to `const Duration(milliseconds: 100)`.
  final Duration animationDuration;

  /// The curve of the animation when the checkbox's switches between checked and unchecked.
  ///
  /// Defaults to [Curves.linear].
  final Curve curve;

  /// The [FLabel]'s style.
  final FLabelStyle? labelStyle;

  /// The checkbox's style when it's enabled.
  final FCheckboxStateStyle enabledStyle;

  /// The checkbox's style when it's disabled.
  final FCheckboxStateStyle disabledStyle;

  /// The checkbox's style when it's in an error state.
  final FCheckboxStateStyle errorStyle;

  /// Creates a [FCheckboxStyle].
  FCheckboxStyle({
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.animationDuration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
    this.labelStyle,
  });

  /// Creates a [FCheckboxStyle] that inherits its properties from the given [FColorScheme].
  FCheckboxStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : animationDuration = const Duration(milliseconds: 100),
        curve = Curves.linear,
        labelStyle = FLabelStyles.inherit(style: style).horizontal,
        enabledStyle = FCheckboxStateStyle(
          borderColor: colorScheme.primary,
          iconColor: colorScheme.primaryForeground,
          checkedBackgroundColor: colorScheme.primary,
          uncheckedBackgroundColor: colorScheme.background,
        ),
        disabledStyle = FCheckboxStateStyle(
          borderColor: colorScheme.primary.withOpacity(0.5),
          iconColor: colorScheme.primaryForeground.withOpacity(0.5),
          checkedBackgroundColor: colorScheme.primary.withOpacity(0.5),
          uncheckedBackgroundColor: colorScheme.background.withOpacity(0.5),
        ),
        errorStyle = FCheckboxStateStyle(
          borderColor: colorScheme.error,
          iconColor: colorScheme.errorForeground,
          checkedBackgroundColor: colorScheme.error,
          uncheckedBackgroundColor: colorScheme.background,
        );

  /// Returns a copy of this [FCheckboxStyle] with the given properties replaced.
  @useResult
  FCheckboxStyle copyWith({
    Duration? animationDuration,
    Curve? curve,
    FLabelStyle? labelStyle,
    FCheckboxStateStyle? enabledStyle,
    FCheckboxStateStyle? disabledStyle,
    FCheckboxStateStyle? errorStyle,
  }) =>
      FCheckboxStyle(
        animationDuration: animationDuration ?? this.animationDuration,
        curve: curve ?? this.curve,
        labelStyle: labelStyle ?? this.labelStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('animationDuration', animationDuration))
      ..add(DiagnosticsProperty('curve', curve))
      ..add(DiagnosticsProperty('labelStyle', labelStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCheckboxStyle &&
          runtimeType == other.runtimeType &&
          animationDuration == other.animationDuration &&
          curve == other.curve &&
          labelStyle == other.labelStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode =>
      animationDuration.hashCode ^
      curve.hashCode ^
      labelStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode;
}

/// A checkbox state's style.
final class FCheckboxStateStyle with Diagnosticable {
  /// The checkbox's border color.
  final Color borderColor;

  /// The checked checkbox's icon's color.
  final Color iconColor;

  /// The checked checkbox's background color.
  final Color checkedBackgroundColor;

  /// The unchecked checkbox's background color.
  final Color uncheckedBackgroundColor;

  /// Creates a [FCheckboxStateStyle].
  const FCheckboxStateStyle({
    required this.borderColor,
    required this.iconColor,
    required this.checkedBackgroundColor,
    required this.uncheckedBackgroundColor,
  });

  /// Returns a copy of this [FCheckboxStateStyle] with the given properties replaced.
  @useResult
  FCheckboxStateStyle copyWith({
    Color? borderColor,
    Color? iconColor,
    Color? checkedBackgroundColor,
    Color? uncheckedBackgroundColor,
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
  }) =>
      FCheckboxStateStyle(
        borderColor: borderColor ?? this.borderColor,
        iconColor: iconColor ?? this.iconColor,
        checkedBackgroundColor: checkedBackgroundColor ?? this.checkedBackgroundColor,
        uncheckedBackgroundColor: uncheckedBackgroundColor ?? this.uncheckedBackgroundColor,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('borderColor', borderColor))
      ..add(ColorProperty('checkedIconColor', iconColor))
      ..add(ColorProperty('checkedBackgroundColor', checkedBackgroundColor))
      ..add(ColorProperty('uncheckedBackgroundColor', uncheckedBackgroundColor));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCheckboxStateStyle &&
          runtimeType == other.runtimeType &&
          borderColor == other.borderColor &&
          iconColor == other.iconColor &&
          checkedBackgroundColor == other.checkedBackgroundColor &&
          uncheckedBackgroundColor == other.uncheckedBackgroundColor;

  @override
  int get hashCode =>
      borderColor.hashCode ^ iconColor.hashCode ^ checkedBackgroundColor.hashCode ^ uncheckedBackgroundColor.hashCode;
}
