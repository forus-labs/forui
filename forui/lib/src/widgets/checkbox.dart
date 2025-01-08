import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A checkbox control that allows the user to toggle between checked and not checked.
///
/// For touch devices, a [FSwitch] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/form/checkbox for working examples.
/// * [FCheckboxStyle] for customizing a checkbox's appearance.
class FCheckbox extends StatefulWidget {
  /// The style. Defaults to [FThemeData.checkboxStyle].
  final FCheckboxStyle? style;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the checkbox is in an error state.
  final Widget? error;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticLabel;

  /// The current value of the checkbox.
  final bool value;

  /// Called when the user initiates a change to the FCheckBox's value: when they have checked or unchecked this box.
  final ValueChanged<bool>? onChange;

  /// Whether this checkbox is enabled. Defaults to true.
  final bool enabled;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// Creates a [FCheckbox].
  const FCheckbox({
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
  State<FCheckbox> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('value', value: value, ifTrue: 'checked'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _State extends State<FCheckbox> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focused = widget.autofocus;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.checkboxStyle;
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
              child: AnimatedSwitcher(
                duration: style.animationDuration,
                switchInCurve: style.curve,
                child: SizedBox.square(
                  key: ValueKey(widget.value),
                  dimension: 16,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: stateStyle.borderColor,
                        width: 0.6,
                      ),
                      color: widget.value ? stateStyle.checkedBackgroundColor : stateStyle.uncheckedBackgroundColor,
                    ),
                    child: widget.value
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
      ),
    );
  }
}

/// A [FCheckbox]'s style.
class FCheckboxStyle with Diagnosticable {
  /// The duration of the animation when the checkbox's switches between checked and unchecked. Defaults to 100ms.
  final Duration animationDuration;

  /// The curve of the animation when the checkbox's switches between checked and unchecked.
  ///
  /// Defaults to [Curves.linear].
  final Curve curve;

  /// The [FLabel]'s style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The [FCheckbox]'s style when it's enabled.
  final FCheckboxStateStyle enabledStyle;

  /// The [FCheckbox]'s style when it's disabled.
  final FCheckboxStateStyle disabledStyle;

  /// The [FCheckbox]'s style when it's in an error state.
  final FCheckboxErrorStyle errorStyle;

  /// Creates a [FCheckboxStyle].
  FCheckboxStyle({
    required this.labelLayoutStyle,
    required this.focusedOutlineStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.animationDuration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
  });

  /// Creates a [FCheckboxStyle] that inherits its properties from the given parameters.
  FCheckboxStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : this(
          labelLayoutStyle: FLabelStyles.inherit(style: style).horizontalStyle.layout,
          focusedOutlineStyle: FFocusedOutlineStyle(
            color: style.focusedOutlineStyle.color,
            borderRadius: BorderRadius.circular(4),
          ),
          enabledStyle: FCheckboxStateStyle(
            labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
            descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
            borderColor: colorScheme.primary,
            iconColor: colorScheme.primaryForeground,
            checkedBackgroundColor: colorScheme.primary,
            uncheckedBackgroundColor: colorScheme.background,
          ),
          disabledStyle: FCheckboxStateStyle(
            labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
            descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
            borderColor: colorScheme.disable(colorScheme.primary),
            iconColor: colorScheme.disable(colorScheme.primaryForeground),
            checkedBackgroundColor: colorScheme.disable(colorScheme.primary),
            uncheckedBackgroundColor: colorScheme.disable(colorScheme.background),
          ),
          errorStyle: FCheckboxErrorStyle(
            labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
            descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
            errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
            borderColor: colorScheme.error,
            iconColor: colorScheme.errorForeground,
            checkedBackgroundColor: colorScheme.error,
            uncheckedBackgroundColor: colorScheme.background,
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

  /// Returns a copy of this [FCheckboxStyle] with the given properties replaced.
  @useResult
  FCheckboxStyle copyWith({
    Duration? animationDuration,
    Curve? curve,
    FLabelLayoutStyle? labelLayoutStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
    FCheckboxStateStyle? enabledStyle,
    FCheckboxStateStyle? disabledStyle,
    FCheckboxErrorStyle? errorStyle,
  }) =>
      FCheckboxStyle(
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
      other is FCheckboxStyle &&
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

/// A checkbox state's style.
// ignore: avoid_implementing_value_types
class FCheckboxStateStyle with Diagnosticable implements FFormFieldStyle {
  /// The [FCheckbox]'s border color.
  final Color borderColor;

  /// The checked [FCheckbox]'s icon's color.
  final Color iconColor;

  /// The checked [FCheckbox]'s background color.
  final Color checkedBackgroundColor;

  /// The unchecked [FCheckbox]'s background color.
  final Color uncheckedBackgroundColor;

  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FCheckboxStateStyle].
  const FCheckboxStateStyle({
    required this.borderColor,
    required this.iconColor,
    required this.checkedBackgroundColor,
    required this.uncheckedBackgroundColor,
    required this.labelTextStyle,
    required this.descriptionTextStyle,
  });

  /// Returns a copy of this [FCheckboxStateStyle] with the given properties replaced.
  @override
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
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('borderColor', borderColor))
      ..add(ColorProperty('iconColor', iconColor))
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
          uncheckedBackgroundColor == other.uncheckedBackgroundColor &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode =>
      borderColor.hashCode ^
      iconColor.hashCode ^
      checkedBackgroundColor.hashCode ^
      uncheckedBackgroundColor.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode;
}

/// A checkbox's error state style.
// ignore: avoid_implementing_value_types
final class FCheckboxErrorStyle extends FCheckboxStateStyle implements FFormFieldErrorStyle {
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FCheckboxErrorStyle].
  FCheckboxErrorStyle({
    required this.errorTextStyle,
    required super.borderColor,
    required super.iconColor,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.checkedBackgroundColor,
    required super.uncheckedBackgroundColor,
  });

  /// Returns a copy of this [FCheckboxErrorStyle] with the given properties replaced.
  @override
  FCheckboxErrorStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
    Color? borderColor,
    Color? iconColor,
    Color? checkedBackgroundColor,
    Color? uncheckedBackgroundColor,
  }) =>
      FCheckboxErrorStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
        borderColor: borderColor ?? this.borderColor,
        iconColor: iconColor ?? this.iconColor,
        checkedBackgroundColor: checkedBackgroundColor ?? this.checkedBackgroundColor,
        uncheckedBackgroundColor: uncheckedBackgroundColor ?? this.uncheckedBackgroundColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FCheckboxErrorStyle &&
          runtimeType == other.runtimeType &&
          errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode => super.hashCode ^ errorTextStyle.hashCode;
}
