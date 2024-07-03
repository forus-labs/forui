import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A checkbox control that allows the user to toggle between checked and not checked.
///
/// A [FCheckbox] is internally a [FormField], therefore it can be used in a form.
///
/// On touch devices, it is recommended to use a [FSwitch] instead of a [FCheckbox] in most cases.
///
/// See:
/// * https://forui.dev/docs/checkbox for working examples.
/// * [FCheckboxStyle] for customizing a checkbox's appearance.
class FCheckbox extends StatelessWidget {
  /// The style. Defaults to [FThemeData.checkboxStyle].
  final FCheckboxStyle? style;

  /// The semantic label of the checkbox used by accessibility frameworks.
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

  /// An optional method to call with the final value when the form is saved via [FormState.save].
  final FormFieldSetter<bool>? onSave;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null
  /// otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property.
  final FormFieldValidator<bool>? validator;

  /// An optional value to initialize the checkbox. Defaults to false.
  final bool initialValue;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled], the checkbox will be auto validated.
  /// Likewise, if this field is false, the widget will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// Used to enable/disable this checkbox auto validation and update its error text.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  ///
  /// If [AutovalidateMode.onUserInteraction], this checkbox will only auto-validate after its content changes. If
  /// [AutovalidateMode.always], it will auto-validate even without user interaction. If [AutovalidateMode.disabled],
  /// auto-validation will be disabled.
  final AutovalidateMode? autovalidateMode;

  /// Restoration ID to save and restore the state of the checkbox.
  ///
  /// Setting the restoration ID to a non-null value results in whether or not the checkbox validation persists.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed from the surrounding [RestorationScope]
  /// using the provided restoration ID.
  ///
  /// See also:
  ///  * [RestorationManager], which explains how state restoration works in Flutter.
  final String? restorationId;

  /// Creates a [FCheckbox].
  const FCheckbox({
    this.style,
    this.semanticLabel,
    this.onChange,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onSave,
    this.validator,
    this.initialValue = false,
    this.enabled = true,
    this.autovalidateMode,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.checkboxStyle;
    final stateStyle = enabled ? style.enabledStyle : style.disabledStyle;

    return FocusableActionDetector(
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: FormField<bool>(
          onSaved: onSave,
          validator: validator,
          initialValue: initialValue,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          restorationId: restorationId,
          builder: (state) {
            final value = state.value ?? initialValue;
            return Semantics(
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
                child: AnimatedSwitcher(
                  duration: style.animationDuration,
                  switchInCurve: style.curve,
                  child: SizedBox.square(
                    key: ValueKey(value),
                    dimension: 20,
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
                              height: 15,
                              width: 15,
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
            );
          },
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
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onSave', onSave))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(DiagnosticsProperty('initialValue', initialValue))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(EnumProperty('autovalidateMode', autovalidateMode))
      ..add(StringProperty('restorationId', restorationId));
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

  /// The checkbox's style when it's enabled.
  final FCheckboxStateStyle enabledStyle;

  /// The checkbox's style when it's disabled.
  final FCheckboxStateStyle disabledStyle;

  /// Creates a [FCheckboxStyle].
  FCheckboxStyle({
    required this.enabledStyle,
    required this.disabledStyle,
    this.animationDuration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
  });

  /// Creates a [FCheckboxStyle] that inherits its properties from the given [FColorScheme].
  FCheckboxStyle.inherit({required FColorScheme colorScheme})
      : animationDuration = const Duration(milliseconds: 100),
        curve = Curves.linear,
        enabledStyle = FCheckboxStateStyle(
          borderColor: colorScheme.primary,
          iconColor: colorScheme.background,
          checkedBackgroundColor: colorScheme.primary,
          uncheckedBackgroundColor: colorScheme.background,
        ),
        disabledStyle = FCheckboxStateStyle(
          borderColor: colorScheme.primary.withOpacity(0.5),
          iconColor: colorScheme.background.withOpacity(0.5),
          checkedBackgroundColor: colorScheme.primary.withOpacity(0.5),
          uncheckedBackgroundColor: colorScheme.background.withOpacity(0.5),
        );

  /// Returns a copy of this [FCheckboxStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FCheckboxStyle(
  ///   animationDuration: const Duration(minutes: 1),
  ///   curve: Curves.linear,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(
  ///   curve: Curves.bounceIn,
  /// );
  ///
  /// print(style.animationDuration); // const Duration(minutes: 1)
  /// print(copy.curve); // Curves.bounceIn
  /// ```
  FCheckboxStyle copyWith({
    Duration? animationDuration,
    Curve? curve,
    FCheckboxStateStyle? enabledStyle,
    FCheckboxStateStyle? disabledStyle,
  }) =>
      FCheckboxStyle(
        animationDuration: animationDuration ?? this.animationDuration,
        curve: curve ?? this.curve,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('animationDuration', animationDuration))
      ..add(DiagnosticsProperty('curve', curve))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCheckboxStyle &&
          runtimeType == other.runtimeType &&
          animationDuration == other.animationDuration &&
          curve == other.curve &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle;

  @override
  int get hashCode => animationDuration.hashCode ^ curve.hashCode ^ enabledStyle.hashCode ^ disabledStyle.hashCode;
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
  ///
  /// ```dart
  /// final style = FCheckBoxStateStyle(
  ///   iconColor: ...,
  ///   checkedBackgroundColor: ...,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(
  ///   checkedBackgroundColor: ...,
  /// );
  ///
  /// print(style.iconColor == copy.iconColor); // true
  /// print(style.checkedBackgroundColor == copy.checkedBackgroundColor); // false
  /// ```
  FCheckboxStateStyle copyWith({
    Color? borderColor,
    Color? iconColor,
    Color? checkedBackgroundColor,
    Color? uncheckedBackgroundColor,
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
