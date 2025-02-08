import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'radio.style.dart';

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
class FRadioStyle with Diagnosticable, _$FRadioStyleFunctions {
  /// The duration of the animation when the radio's switches between selected and unselected. Defaults to 100ms.
  @override
  final Duration animationDuration;

  /// The curve of the animation when the radio's switches between selected and unselected.
  ///
  /// Defaults to [Curves.easeOutCirc].
  @override
  final Curve curve;

  /// The [FLabel]'s style.
  @override
  final FLabelLayoutStyle labelLayoutStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The [FRadio]'s when the radio is enabled.
  @override
  final FRadioStateStyle enabledStyle;

  /// The [FRadio]'s when the radio is disabled.
  @override
  final FRadioStateStyle disabledStyle;

  /// The [FRadio]'s when the radio is in an error state.
  @override
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
}

/// A [FRadio]'s state style.
// ignore: avoid_implementing_value_types
class FRadioStateStyle with Diagnosticable, _$FRadioStateStyleFunctions implements FFormFieldStyle {
  /// The border color.
  @override
  final Color borderColor;

  /// The selected color.
  @override
  final Color selectedColor;

  /// The background color.
  @override
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
}

/// A [FRadio]'s error style.
// ignore: avoid_implementing_value_types
final class FRadioErrorStyle extends FRadioStateStyle with _$FRadioErrorStyleFunctions implements FFormFieldErrorStyle {
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
}
