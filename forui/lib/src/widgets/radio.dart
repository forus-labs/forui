import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'radio.design.dart';

/// A radio button that typically allows the user to choose only one of a predefined set of options.
///
/// It is recommended to use [FSelectGroup] in conjunction with [FRadio.grouped] to create a group of radio
/// buttons.
///
/// See:
/// * https://forui.dev/docs/form/radio for working examples.
/// * [FRadioStyle] for customizing a radio's appearance.
class FRadio extends StatelessWidget {
  /// The style. Defaults to [FThemeData.radioStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create radio
  /// ```
  final FRadioStyle Function(FRadioStyle style)? style;

  /// The label displayed next to the radio.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the radio is in an error state.
  final Widget? error;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

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

  /// Creates a [FRadio] that is part of a [FSelectGroup].
  static FSelectGroupItem<T> grouped<T>({
    required T value,
    Widget? label,
    Widget? description,
    Widget? error,
    String? semanticsLabel,
    FRadioStyle? style,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
  }) => _Radio<T>(
    value: value,
    label: label,
    description: description,
    error: error,
    semanticsLabel: semanticsLabel,
    style: style,
    enabled: enabled,
    autofocus: autofocus,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
  );

  /// Creates a [FRadio].
  const FRadio({
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
    final style = this.style?.call(context.theme.radioStyle) ?? context.theme.radioStyle;
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

        return FLabel(
          axis: Axis.horizontal,
          states: formStates,
          style: style,
          label: label,
          description: description,
          error: error,
          // A separate FFocusedOutline is used instead of FTappable's built-in one so that only the radio,
          // rather than the entire FLabel, is outlined.
          child: FFocusedOutline(
            focused: states.contains(WidgetState.focused),
            style: style.focusedOutlineStyle,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: style.borderColor.resolve(states)),
                    color: style.backgroundColor.resolve(states),
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox.square(dimension: 10),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(color: style.indicatorColor.resolve(states), shape: BoxShape.circle),
                  child: AnimatedSize(
                    duration: style.motion.duration,
                    reverseDuration: style.motion.reverseDuration,
                    curve: style.motion.curve,
                    child: value ? const SizedBox.square(dimension: 9) : const SizedBox.shrink(),
                  ),
                ),
              ],
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
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _Radio<T> extends StatelessWidget with FSelectGroupItem<T> {
  @override
  final T value;
  final FRadioStyle? style;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final String? semanticsLabel;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;

  const _Radio({
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
    final radioStyle = this.style ?? style.radioStyle;

    return FRadio(
      style: radioStyle,
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

/// A [FRadio]'s style.
class FRadioStyle extends FLabelStyle with _$FRadioStyleFunctions {
  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The [FRadio]'s border color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> borderColor;

  /// The [FRadio]'s background color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> backgroundColor;

  /// The [FRadio]'s indicator color.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> indicatorColor;

  /// The motion-related properties.
  @override
  final FRadioMotion motion;

  /// Creates a [FRadioStyle].
  const FRadioStyle({
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    required this.borderColor,
    required this.backgroundColor,
    required this.indicatorColor,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.motion = const FRadioMotion(),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FRadioStyle] that inherits its properties.
  factory FRadioStyle.inherit({required FColors colors, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).horizontalStyle;
    return FRadioStyle(
      tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
      focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: BorderRadius.circular(100)),
      borderColor: FWidgetStateMap({
        WidgetState.error: colors.error,
        WidgetState.disabled: colors.disable(colors.primary),
        WidgetState.any: colors.primary,
      }),
      backgroundColor: FWidgetStateMap.all(colors.background),
      indicatorColor: FWidgetStateMap({
        WidgetState.error: colors.error,
        WidgetState.disabled: colors.disable(colors.primary),
        WidgetState.any: colors.primary,
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

/// The motion-related properties for a [FRadio].
class FRadioMotion with Diagnosticable, _$FRadioMotionFunctions {
  /// The duration of the animation when selected. Defaults to 100ms.
  @override
  final Duration duration;

  /// The duration of the reverse animation when unselected. Defaults to 100ms.
  @override
  final Duration reverseDuration;

  /// The curve of the animation. Defaults to [Curves.easeOutCirc].
  @override
  final Curve curve;

  /// Creates a [FRadioMotion].
  const FRadioMotion({
    this.duration = const Duration(milliseconds: 100),
    this.reverseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOutCirc,
  });
}
