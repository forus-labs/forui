import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/keys.dart';

part 'checkbox.design.dart';

/// A checkbox control that allows the user to toggle between checked and not checked.
///
/// For touch devices, a [FSwitch] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/form/checkbox for working examples.
/// * [FCheckboxStyle] for customizing a checkboxes appearance.
class FCheckbox extends StatelessWidget {
  /// The style. Defaults to [FThemeData.checkboxStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create checkbox
  /// ```
  final FCheckboxStyle Function(FCheckboxStyle style)? style;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the checkbox is in an error state.
  final Widget? error;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

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

  /// Creates a [FCheckbox] that is part of a [FSelectGroup].
  static FSelectGroupItem<T> grouped<T>({
    required T value,
    FCheckboxStyle? style,
    Widget? label,
    Widget? description,
    Widget? error,
    String? semanticsLabel,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
  }) => _Checkbox(
    value: value,
    style: style,
    label: label,
    description: description,
    error: error,
    semanticsLabel: semanticsLabel,
    enabled: enabled,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
  );

  /// Creates a [FCheckbox].
  const FCheckbox({
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.checkboxStyle) ?? context.theme.checkboxStyle;
    final formStates = {
      if (!enabled) WidgetState.disabled,
      if (error != null) WidgetState.error,
      if (value) WidgetState.selected,
    };

    return FTappable(
      style: style.tappableStyle,
      semanticsLabel: semanticsLabel,
      selected: value,
      onPress: enabled ? () => onChange?.call(!value) : null,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      builder: (context, states, _) {
        states = {...states, ...formStates};

        final iconTheme = style.iconStyle.maybeResolve(states);
        final decoration = style.decoration.resolve(states);
        return FLabel(
          axis: Axis.horizontal,
          states: formStates,
          style: style,
          label: label,
          description: description,
          error: error,
          // A separate FFocusedOutline is used instead of FTappable's built-in one so that only the checkbox,
          // rather than the entire FLabel, is outlined.
          child: FFocusedOutline(
            focused: states.contains(WidgetState.focused),
            style: style.focusedOutlineStyle,
            child: AnimatedSwitcher(
              duration: style.motion.fadeInDuration,
              reverseDuration: style.motion.fadeOutDuration,
              switchInCurve: style.motion.fadeInCurve,
              switchOutCurve: style.motion.fadeOutCurve,
              // This transition builder is necessary because of https://github.com/flutter/flutter/issues/121336#issuecomment-1482620874
              transitionBuilder: (child, opacity) => FadeTransition(opacity: opacity, child: child),
              child: SizedBox.square(
                // We use the derived iconTheme and decoration as keys to prevent the animation from triggering between
                // states with the same appearance.
                key: ListKey([iconTheme, decoration]),
                dimension: style.size,
                child: DecoratedBox(
                  decoration: decoration,
                  child: iconTheme == null
                      ? const SizedBox()
                      : IconTheme(data: iconTheme, child: const Icon(FIcons.check)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('value', value: value, ifTrue: 'checked'))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _Checkbox<T> extends StatelessWidget with FSelectGroupItem<T> {
  @override
  final T value;
  final FCheckboxStyle? style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final String? semanticsLabel;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const _Checkbox({
    required this.value,
    this.style,
    this.label,
    this.description,
    this.error,
    this.semanticsLabel,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FSelectGroupItemData(:controller, :selected, :style) = FSelectGroupItemData.of<T>(context);
    final checkboxStyle = this.style ?? style.checkboxStyle;
    return FCheckbox(
      style: checkboxStyle,
      label: label,
      description: description,
      semanticsLabel: semanticsLabel,
      error: error,
      value: selected,
      onChange: (state) => controller.update(value, add: state),
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      key: key,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('autofocus', value: autofocus, ifFalse: 'not autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

/// A checkboxes style.
class FCheckboxStyle extends FLabelStyle with _$FCheckboxStyleFunctions {
  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The checkboxes size. Defaults to 16.
  @override
  final double size;

  /// The icon style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The box decoration.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The motion-related properties.
  @override
  final FCheckboxMotion motion;

  /// Creates a [FCheckboxStyle].
  const FCheckboxStyle({
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    required this.iconStyle,
    required this.decoration,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.size = 16,
    this.motion = const FCheckboxMotion(),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FCheckboxStyle] that inherits its properties.
  factory FCheckboxStyle.inherit({required FColors colors, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).horizontalStyle;
    return FCheckboxStyle(
      tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
      focusedOutlineStyle: style.focusedOutlineStyle.copyWith(borderRadius: BorderRadius.circular(4)),
      iconStyle: FWidgetStateMap({
        WidgetState.selected & WidgetState.error: IconThemeData(color: colors.errorForeground, size: 14),
        WidgetState.selected & ~WidgetState.disabled: IconThemeData(color: colors.primaryForeground, size: 14),
        WidgetState.selected & WidgetState.disabled: IconThemeData(
          color: colors.disable(colors.primaryForeground),
          size: 14,
        ),
      }),
      decoration: FWidgetStateMap({
        // Error
        WidgetState.error & WidgetState.selected: BoxDecoration(borderRadius: style.borderRadius, color: colors.error),
        WidgetState.error: BoxDecoration(
          borderRadius: style.borderRadius,
          border: Border.all(color: colors.error, width: 0.6),
          color: colors.background,
        ),

        // Disabled
        WidgetState.disabled & WidgetState.selected: BoxDecoration(
          borderRadius: style.borderRadius,
          color: colors.disable(colors.primary),
        ),
        WidgetState.disabled: BoxDecoration(
          borderRadius: style.borderRadius,
          border: Border.all(color: colors.disable(colors.primary), width: 0.6),
          color: colors.disable(colors.background),
        ),

        // Enabled
        WidgetState.selected: BoxDecoration(borderRadius: style.borderRadius, color: colors.primary),
        WidgetState.any: BoxDecoration(
          borderRadius: style.borderRadius,
          border: Border.all(color: colors.primary, width: 0.6),
          color: colors.background,
        ),
      }),
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

/// The motion-related properties for a [FCheckbox].
class FCheckboxMotion with Diagnosticable, _$FCheckboxMotionFunctions {
  /// The duration of the fade in animation. Defaults to 100ms.
  @override
  final Duration fadeInDuration;

  /// The duration of the fade out animation. Defaults to 100ms.
  @override
  final Duration fadeOutDuration;

  /// The curve of the fade in animation. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve of the fade out animation. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// Creates a [FCheckboxMotion].
  const FCheckboxMotion({
    this.fadeInDuration = const Duration(milliseconds: 100),
    this.fadeOutDuration = const Duration(milliseconds: 100),
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
  });
}
