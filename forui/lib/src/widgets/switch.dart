import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'switch.design.dart';

/// A control that allows the user to toggle between checked and unchecked.
///
/// Typically used to toggle the on/off state of a single setting.
///
/// See:
/// * https://forui.dev/docs/form/switch for working examples.
/// * [FSwitchStyle] for customizing a switch's appearance.
class FSwitch extends StatelessWidget {
  /// The style. Defaults to [FThemeData.switchStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create switch
  /// ```
  final FSwitchStyle Function(FSwitchStyle style)? style;

  /// The label displayed next to the switch.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the switch is in an error state.
  final Widget? error;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// The current value of the switch.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually change state until the parent widget
  /// rebuilds the switch with the new value.
  final ValueChanged<bool>? onChange;

  /// Whether this switch is enabled. Defaults to true.
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
    this.semanticsLabel,
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
    final style = this.style?.call(context.theme.switchStyle) ?? context.theme.switchStyle;
    final formStates = {if (!enabled) WidgetState.disabled, if (error != null) WidgetState.error};
    final states = {if (value) WidgetState.selected, ...formStates};

    // The label is wrapped in a GestureDetector to improve affordance.
    return GestureDetector(
      onTap: enabled ? () => onChange?.call(!value) : null,
      child: FocusableActionDetector(
        enabled: enabled,
        autofocus: autofocus,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        child: Semantics(
          label: semanticsLabel,
          enabled: enabled,
          toggled: value,
          child: FLabel(
            axis: Axis.horizontal,
            states: formStates,
            style: style,
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
              activeTrackColor: style.trackColor.resolve(states),
              // Don't use [states] as it always contains [WidgetState.selected] but we want the unselected color.
              inactiveTrackColor: style.trackColor.resolve(formStates),
              thumbColor: style.thumbColor.resolve(states),
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
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior, defaultValue: DragStartBehavior.start));
  }
}

/// [FSwitch]'s style.
class FSwitchStyle extends FLabelStyle with _$FSwitchStyleFunctions {
  /// This [FSwitch]'s color when focused.
  @override
  final Color focusColor;

  /// The track's color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> trackColor;

  /// The thumb's color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> thumbColor;

  /// Creates a [FSwitchStyle].
  const FSwitchStyle({
    required this.focusColor,
    required this.trackColor,
    required this.thumbColor,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FSwitchStyle] that inherits its properties.
  factory FSwitchStyle.inherit({required FColors colors, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).horizontalStyle;
    return FSwitchStyle(
      focusColor: colors.primary,
      trackColor: FWidgetStateMap({
        // Disabled
        WidgetState.disabled & WidgetState.selected: colors.disable(colors.primary),
        WidgetState.disabled: colors.disable(colors.border),

        // Enabled / Error
        WidgetState.selected: colors.primary,
        WidgetState.any: colors.border,
      }),
      thumbColor: FWidgetStateMap.all(colors.background),
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
