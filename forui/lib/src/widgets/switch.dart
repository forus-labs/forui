import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form_field.dart';

/// A control that allows the user to toggle between checked and unchecked.
///
/// Typically used to toggle the on/off state of a single setting. A [FSwitch] is internally a [FormField], therefore
/// it can be used in a form.
///
/// See:
/// * https://forui.dev/docs/switch for working examples.
/// * [FSwitchStyle] for customizing a switch's appearance.
class FSwitch extends FFormField<bool> {
  /// The style. Defaults to [FThemeData.switchStyle].
  final FSwitchStyle? style;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually change state until the parent widget
  /// rebuilds the switch with the new value.
  final ValueChanged<bool>? onChange;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  ///
  /// Defaults to false.
  ///
  /// Ideally, there is only one widget with autofocus set in each FocusScope. If there is more than one widget with
  /// autofocus set, then the first one added to the tree will get focus.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  ///
  /// If one is not supplied, then one will be automatically allocated, owned, and managed by this widget. The widget
  /// will be focusable even if a [focusNode] is not supplied. If supplied, the given `focusNode` will be hosted by this
  /// widget, but not owned. See [FocusNode] for more information on what being hosted and/or owned implies.
  ///
  /// Supplying a focus node is sometimes useful if an ancestor to this widget wants to control when this widget has the
  /// focus. The owner will be responsible for calling [FocusNode.dispose] on the focus node when it is done with it,
  /// but this widget will attach/detach and reparent the node when needed.
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses focus.
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
    this.semanticLabel,
    this.onChange,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.dragStartBehavior = DragStartBehavior.start,
    super.onSave,
    super.validator,
    super.initialValue = false,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  });

  @override
  Widget builder(BuildContext context, FormFieldState<bool> state) {
    final style = this.style ?? context.theme.switchStyle;
    final (labelState, switchStyle) = switch ((enabled, state.hasError)) {
      (true, false) => (FLabelState.enabled, style.enabledStyle),
      (false, false) => (FLabelState.disabled, style.disabledStyle),
      (_, true) => (
          FLabelState.error,
          style.enabledStyle
        ), // `enabledStyle` is used as error style doesn't contain any switch styles.
    };

    final value = state.value ?? initialValue;

    return Semantics(
      label: semanticLabel,
      enabled: enabled,
      toggled: value,
      child: FLabel(
        axis: Axis.horizontal,
        state: labelState,
        label: label,
        description: description,
        error: Text(state.errorText ?? ''),
        child: CupertinoSwitch(
          value: value,
          onChanged: (value) {
            if (!enabled) {
              return;
            }

            state.didChange(value);
            onChange?.call(!value);
          },
          applyTheme: false,
          activeColor: switchStyle.checkedColor,
          trackColor: switchStyle.uncheckedColor,
          thumbColor: switchStyle.thumbColor,
          focusColor: style.focusColor,
          autofocus: autofocus,
          focusNode: focusNode,
          onFocusChange: onFocusChange,
          dragStartBehavior: dragStartBehavior,
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
      : focusColor = colorScheme.primary,
        labelLayoutStyle = FLabelStyles.inherit(style: style).horizontal.layout,
        enabledStyle = FSwitchStateStyle(
          checkedColor: colorScheme.primary,
          uncheckedColor: colorScheme.border,
          thumbColor: colorScheme.background,
          labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
        ),
        disabledStyle = FSwitchStateStyle(
          checkedColor: colorScheme.primary.withOpacity(0.5),
          uncheckedColor: colorScheme.border.withOpacity(0.5),
          thumbColor: colorScheme.background,
          labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
        ),
        errorStyle = FSwitchErrorStyle(
          labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
          errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
        );

  /// The [FLabel]'s style.
  FLabelStyle get labelStyle => (
        layout: labelLayoutStyle,
        state: FLabelStateStyle(
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
      ..add(DiagnosticsProperty('errorStyle', errorStyle))
      ..add(DiagnosticsProperty('labelStyle', labelStyle));
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
  FFormFieldStyle copyWith({
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
