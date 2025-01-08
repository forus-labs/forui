import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A radio button that typically allows the user to choose only one of a predefined set of options.
///
/// It is recommended to use [FSelectGroup] in conjunction with [FSelectGroupItem.radio] to create a group of radio
/// buttons.
///
/// See:
/// * https://forui.dev/docs/form/radio for working examples.
/// * [FRadioStyle] for customizing a radio's appearance.
class FRadio extends StatefulWidget {
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

  //// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticLabel;

  /// The current value of the radio.
  final bool value;

  /// Called when the user initiates a change to the [FRadio]'s value: when they have checked or unchecked this box.
  final ValueChanged<bool>? onChange;

  /// Whether this radio is enabled. Defaults to true.
  final bool enabled;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
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
  State<FRadio> createState() => _State();

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

class _State extends State<FRadio> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focused = widget.autofocus;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.radioStyle;
    final (labelState, stateStyle) = switch ((widget.enabled, widget.error != null)) {
      (true, false) => (FLabelState.enabled, style.enabledStyle),
      (false, false) => (FLabelState.disabled, style.disabledStyle),
      (_, true) => (FLabelState.error, style.errorStyle),
    };

    return GestureDetector(
      onTap: widget.enabled ? () => widget.onChange?.call(!widget.value) : null,
      child: FocusableActionDetector(
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onFocusChange: (focused) {
          setState(() => _focused = focused);
          widget.onFocusChange?.call(focused);
        },
        mouseCursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: Semantics(
          label: widget.semanticLabel,
          enabled: widget.enabled,
          checked: widget.value,
          child: FLabel(
            axis: Axis.horizontal,
            state: labelState,
            style: style.labelStyle,
            label: widget.label,
            description: widget.description,
            error: widget.error,
            child: FFocusedOutline(
              style: style.focusedOutlineStyle,
              focused: _focused,
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
                      child: widget.value ? const SizedBox.square(dimension: 9) : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A [FRadio]'s style.
class FRadioStyle with Diagnosticable {
  /// The duration of the animation when the radio's switches between selected and unselected. Defaults to 100ms.
  final Duration animationDuration;

  /// The curve of the animation when the radio's switches between selected and unselected.
  ///
  /// Defaults to [Curves.easeOutCirc].
  final Curve curve;

  /// The [FLabel]'s style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The [FRadio]'s when the radio is enabled.
  final FRadioStateStyle enabledStyle;

  /// The [FRadio]'s when the radio is disabled.
  final FRadioStateStyle disabledStyle;

  /// The [FRadio]'s when the radio is in an error state.
  final FRadioErrorStyle errorStyle;

  /// Creates a [FRadioStyle].
  FRadioStyle({
    required this.labelLayoutStyle,
    required this.focusedOutlineStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.animationDuration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOutCirc,
  });

  /// Creates a [FRadioStyle] that inherits its properties from the given parameters.
  FRadioStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : this(
          labelLayoutStyle: FLabelStyles.inherit(style: style).horizontalStyle.layout,
          focusedOutlineStyle: FFocusedOutlineStyle(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(100),
          ),
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
            borderColor: colorScheme.disable(colorScheme.primary),
            selectedColor: colorScheme.disable(colorScheme.primary),
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
    FFocusedOutlineStyle? focusedOutlineStyle,
    FRadioStateStyle? enabledStyle,
    FRadioStateStyle? disabledStyle,
    FRadioErrorStyle? errorStyle,
  }) =>
      FRadioStyle(
        animationDuration: animationDuration ?? this.animationDuration,
        curve: curve ?? this.curve,
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
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
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
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
          focusedOutlineStyle == other.focusedOutlineStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode =>
      animationDuration.hashCode ^
      curve.hashCode ^
      labelLayoutStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
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
