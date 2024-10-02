import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A radio button that typically allows the user to choose only one of a predefined set of options.
///
/// It is recommended to use [FSelectGroup] in conjunction with [FSelectGroupItem.radio] to create a group of radio
/// buttons.
///
/// See:
/// * https://forui.dev/docs/radio for working examples.
/// * [FRadioStyle] for customizing a radio's appearance.
class FRadio extends StatelessWidget {
  /// The style. Defaults to [FThemeData.radioStyle].
  final FRadioStyle? style;

  /// The label displayed next to the radio.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the radio is in an error state.
  final Widget? error;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// The current value of the radio.
  final bool value;

  /// Called when the user initiates a change to the Fradio's value: when they have checked or unchecked this box.
  final ValueChanged<bool>? onChange;

  /// Whether this radio is enabled. Defaults to true.
  final bool enabled;

  /// Whether this radio should focus itself if nothing else is already focused. Defaults to false.
  final bool autofocus;

  /// Defines the [FocusNode] for this radio.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// Creates a [FRadio].
  const FRadio({
    this.style,
    this.label,
    this.description,
    this.error,
    this.semanticLabel,
    this.value = false,
    this.onChange,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.radioStyle;
    final (labelState, stateStyle) = switch ((enabled, error != null)) {
      (true, false) => (FLabelState.enabled, style.enabledStyle),
      (false, false) => (FLabelState.disabled, style.disabledStyle),
      (_, true) => (FLabelState.error, style.errorStyle),
    };

    return GestureDetector(
      onTap: enabled ? () => onChange?.call(!value) : null,
      child: FocusableActionDetector(
        enabled: enabled,
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        mouseCursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: Semantics(
          label: semanticLabel,
          enabled: enabled,
          checked: value,
          child: FLabel(
            axis: Axis.horizontal,
            state: labelState,
            style: style.labelStyle,
            label: label,
            description: description,
            error: error,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: stateStyle.borderColor),
                    color: stateStyle.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox.square(dimension: 10),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: stateStyle.selectedColor,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedSize(
                    duration: style.animationDuration,
                    curve: style.curve,
                    child: value ? const SizedBox.square(dimension: 9) : const SizedBox.shrink(),
                  ),
                ),
              ],
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
      ..add(FlagProperty('value', value: value, ifTrue: 'checked'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

/// A [FRadio]'s style.
class FRadioStyle with Diagnosticable {
  /// The duration of the animation when the radio's switches between selected and unselected.
  ///
  /// Defaults to `const Duration(milliseconds: 100)`.
  final Duration animationDuration;

  /// The curve of the animation when the radio's switches between selected and unselected.
  ///
  /// Defaults to [Curves.easeOutCirc].
  final Curve curve;

  /// The [FLabel]'s style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The [FRadio]'s when the radio is enabled.
  final FRadioStateStyle enabledStyle;

  /// The [FRadio]'s when the radio is disabled.
  final FRadioStateStyle disabledStyle;

  /// The [FRadio]'s when the radio is in an error state.
  final FRadioErrorStyle errorStyle;

  /// Creates a [FRadioStyle].
  FRadioStyle({
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.animationDuration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOutCirc,
  });

  /// Creates a [FRadioStyle] that inherits its properties from the given parameters.
  factory FRadioStyle.inherit({required FColorScheme colorScheme, required FStyle style}) => FRadioStyle(
        labelLayoutStyle: FLabelStyles.inherit(style: style).horizontal.layout,
        enabledStyle: FRadioStateStyle(
          labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
          borderColor: colorScheme.primary,
          selectedColor: colorScheme.primary,
          backgroundColor: colorScheme.background,
        ),
        disabledStyle: FRadioStateStyle(
          labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
          borderColor: colorScheme.primary.withOpacity(0.5),
          selectedColor: colorScheme.primary.withOpacity(0.5),
          backgroundColor: colorScheme.background,
        ),
        errorStyle: FRadioErrorStyle(
          labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
          errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
          borderColor: colorScheme.error,
          selectedColor: colorScheme.error,
          backgroundColor: colorScheme.background,
        ),
      );

  /// The [FLabel]'s style.

  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
        layout: labelLayoutStyle,
        state: FLabelStateStyles(
          enabledStyle: enabledStyle,
          disabledStyle: disabledStyle,
          errorStyle: errorStyle,
        ),
      );

  /// Returns a copy of this [FRadioStyle] with the given properties replaced.
  @useResult
  FRadioStyle copyWith({
    Duration? animationDuration,
    Curve? curve,
    FLabelLayoutStyle? labelLayoutStyle,
    FRadioStateStyle? enabledStyle,
    FRadioStateStyle? disabledStyle,
    FRadioErrorStyle? errorStyle,
  }) =>
      FRadioStyle(
        animationDuration: animationDuration ?? this.animationDuration,
        curve: curve ?? this.curve,
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
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
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FRadioStyle &&
          runtimeType == other.runtimeType &&
          animationDuration == other.animationDuration &&
          curve == other.curve &&
          labelLayoutStyle == other.labelLayoutStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode =>
      animationDuration.hashCode ^
      curve.hashCode ^
      labelLayoutStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode;
}

/// A [FRadio]'s state style.
// ignore: avoid_implementing_value_types
class FRadioStateStyle with Diagnosticable implements FFormFieldStyle {
  /// The border color.
  final Color borderColor;

  /// The selected color.
  final Color selectedColor;

  /// The background color.
  final Color backgroundColor;

  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FRadioStateStyle].
  FRadioStateStyle({
    required this.borderColor,
    required this.selectedColor,
    required this.backgroundColor,
    required this.labelTextStyle,
    required this.descriptionTextStyle,
  });

  /// Returns a copy of this [FRadioStateStyle] with the given properties replaced.
  @override
  @useResult
  FRadioStateStyle copyWith({
    Color? borderColor,
    Color? selectedColor,
    Color? backgroundColor,
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
  }) =>
      FRadioStateStyle(
        borderColor: borderColor ?? this.borderColor,
        selectedColor: selectedColor ?? this.selectedColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('borderColor', borderColor))
      ..add(ColorProperty('selectedColor', selectedColor))
      ..add(ColorProperty('backgroundColor', backgroundColor));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FRadioStateStyle &&
          runtimeType == other.runtimeType &&
          borderColor == other.borderColor &&
          selectedColor == other.selectedColor &&
          backgroundColor == other.backgroundColor &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode =>
      borderColor.hashCode ^
      selectedColor.hashCode ^
      backgroundColor.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode;
}

/// A [FRadio]'s error style.
// ignore: avoid_implementing_value_types
final class FRadioErrorStyle extends FRadioStateStyle implements FFormFieldErrorStyle {
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FRadioErrorStyle].
  FRadioErrorStyle({
    required super.borderColor,
    required super.selectedColor,
    required super.backgroundColor,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required this.errorTextStyle,
  });

  /// Returns a copy of this [FRadioErrorStyle] with the given properties replaced.
  @override
  @useResult
  FRadioErrorStyle copyWith({
    Color? borderColor,
    Color? selectedColor,
    Color? backgroundColor,
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) =>
      FRadioErrorStyle(
        borderColor: borderColor ?? this.borderColor,
        selectedColor: selectedColor ?? this.selectedColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FRadioErrorStyle && runtimeType == other.runtimeType && errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode => errorTextStyle.hashCode;
}
