import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A control that allows the user to toggle between checked and unchecked.
///
/// Typically used to toggle the on/off state of a single setting.
///
/// See:
/// * https://forui.dev/docs/form/switch for working examples.
/// * [FSwitchStyle] for customizing a switch's appearance.
class FSwitch extends StatelessWidget {
  /// The style. Defaults to [FThemeData.switchStyle].
  final FSwitchStyle? style;

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

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually change state until the parent widget
  /// rebuilds the switch with the new value.
  final ValueChanged<bool>? onChange;

  /// Whether this checkbox is enabled. Defaults to true.
  final bool enabled;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin at the position where the drag gesture won
  /// the arena. If set to [DragStartBehavior.down] it will begin at the position
  /// where a down event was first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  final DragStartBehavior dragStartBehavior;

  /// Creates a [FSwitch].
  const FSwitch({
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
    this.dragStartBehavior = DragStartBehavior.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.switchStyle;
    final (labelState, switchStyle) = switch ((enabled, error != null)) {
      (true, false) => (FLabelState.enabled, style.enabledStyle),
      (false, false) => (FLabelState.disabled, style.disabledStyle),
      (_, true) => (
          FLabelState.error,
          style.enabledStyle
        ), // `enabledStyle` is used as error style doesn't contain any switch styles.
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
          toggled: value,
          child: FLabel(
            axis: Axis.horizontal,
            state: labelState,
            style: style.labelStyle,
            label: label,
            description: description,
            error: error,
            child: CupertinoSwitch(
              value: value,
              onChanged: (value) {
                if (!enabled) {
                  return;
                }

                onChange?.call(value);
              },
              applyTheme: false,
              activeTrackColor: switchStyle.checkedColor,
              inactiveTrackColor: switchStyle.uncheckedColor,
              thumbColor: switchStyle.thumbColor,
              focusColor: style.focusColor,
              autofocus: autofocus,
              focusNode: focusNode,
              onFocusChange: onFocusChange,
              dragStartBehavior: dragStartBehavior,
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
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior, defaultValue: DragStartBehavior.start));
  }
}

/// [FSwitch]'s style.
final class FSwitchStyle with Diagnosticable {
  /// This [FSwitch]'s color when focused.
  final Color focusColor;

  /// The [FLabel]'s style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The [FSwitch]'s style when it's enabled.
  final FSwitchStateStyle enabledStyle;

  /// The [FSwitch]'s style when it's disabled.
  final FSwitchStateStyle disabledStyle;

  /// The [FSwitch]'s style when it has an error.
  final FSwitchErrorStyle errorStyle;

  /// Creates a [FSwitchStyle].
  const FSwitchStyle({
    required this.focusColor,
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
  });

  /// Creates a [FSwitchStyle] that inherits its properties from [colorScheme].
  FSwitchStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : this(
          focusColor: colorScheme.primary,
          labelLayoutStyle: FLabelStyles.inherit(style: style).horizontalStyle.layout,
          enabledStyle: FSwitchStateStyle(
            checkedColor: colorScheme.primary,
            uncheckedColor: colorScheme.border,
            thumbColor: colorScheme.background,
            labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
            descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
          ),
          disabledStyle: FSwitchStateStyle(
            checkedColor: colorScheme.disable(colorScheme.primary),
            uncheckedColor: colorScheme.disable(colorScheme.border),
            thumbColor: colorScheme.background,
            labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
            descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
          ),
          errorStyle: FSwitchErrorStyle(
            labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
            descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
            errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
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

  /// Returns a copy of this [FSwitchStyle] with the given properties replaced.
  @useResult
  FSwitchStyle copyWith({
    Color? focusColor,
    FLabelLayoutStyle? labelLayoutStyle,
    FSwitchStateStyle? enabledStyle,
    FSwitchStateStyle? disabledStyle,
    FSwitchErrorStyle? errorStyle,
  }) =>
      FSwitchStyle(
        focusColor: focusColor ?? this.focusColor,
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('focusColor', focusColor))
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSwitchStyle &&
          runtimeType == other.runtimeType &&
          focusColor == other.focusColor &&
          labelLayoutStyle == other.labelLayoutStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode =>
      focusColor.hashCode ^
      labelLayoutStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode;
}

/// [FSwitch]'s state style.
// ignore: avoid_implementing_value_types
final class FSwitchStateStyle with Diagnosticable implements FFormFieldStyle {
  /// The track's color when checked.
  final Color checkedColor;

  /// The track's color when unchecked.
  final Color uncheckedColor;

  /// The thumb's color.
  final Color thumbColor;

  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FSwitchStateStyle].
  FSwitchStateStyle({
    required this.checkedColor,
    required this.uncheckedColor,
    required this.thumbColor,
    required this.labelTextStyle,
    required this.descriptionTextStyle,
  });

  @override
  FSwitchStateStyle copyWith({
    Color? checkedColor,
    Color? uncheckedColor,
    Color? thumbColor,
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
  }) =>
      FSwitchStateStyle(
        checkedColor: checkedColor ?? this.checkedColor,
        uncheckedColor: uncheckedColor ?? this.uncheckedColor,
        thumbColor: thumbColor ?? this.thumbColor,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('checkedColor', checkedColor))
      ..add(ColorProperty('uncheckedColor', uncheckedColor))
      ..add(ColorProperty('thumbColor', thumbColor));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSwitchStateStyle &&
          runtimeType == other.runtimeType &&
          checkedColor == other.checkedColor &&
          uncheckedColor == other.uncheckedColor &&
          thumbColor == other.thumbColor &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode =>
      checkedColor.hashCode ^
      uncheckedColor.hashCode ^
      thumbColor.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode;
}

/// [FSwitch]'s error style.
// ignore: avoid_implementing_value_types
final class FSwitchErrorStyle with Diagnosticable implements FFormFieldErrorStyle {
  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  @override
  final TextStyle errorTextStyle;

  /// Creates a [FSwitchErrorStyle].
  FSwitchErrorStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    required this.errorTextStyle,
  });

  @override
  FSwitchErrorStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) =>
      FSwitchErrorStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSwitchErrorStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}
