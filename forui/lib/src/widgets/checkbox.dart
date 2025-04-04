import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'checkbox.style.dart';

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
  State<FCheckbox> createState() => _State();

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
          label: widget.semanticsLabel,
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
                  dimension: stateStyle.size,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: stateStyle.borderColor, width: 0.6),
                      color: widget.value ? stateStyle.checkedBackgroundColor : stateStyle.uncheckedBackgroundColor,
                    ),
                    child:
                        widget.value
                            ? IconTheme(data: stateStyle.iconStyle, child: const Icon(FIcons.check))
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
class FCheckboxStyle with Diagnosticable, _$FCheckboxStyleFunctions {
  /// The duration of the animation when the checkbox's switches between checked and unchecked. Defaults to 100ms.
  @override
  final Duration animationDuration;

  /// The curve of the animation when the checkbox's switches between checked and unchecked.
  ///
  /// Defaults to [Curves.linear].
  @override
  final Curve curve;

  /// The [FLabel]'s style.
  @override
  final FLabelLayoutStyle labelLayoutStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The [FCheckbox]'s style when it's enabled.
  @override
  final FCheckboxStateStyle enabledStyle;

  /// The [FCheckbox]'s style when it's disabled.
  @override
  final FCheckboxStateStyle disabledStyle;

  /// The [FCheckbox]'s style when it's in an error state.
  @override
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

  /// Creates a [FCheckboxStyle] that inherits its properties.
  FCheckboxStyle.inherit({required FColorScheme color, required FStyle style})
    : this(
        labelLayoutStyle: FLabelStyles.inherit(style: style).horizontalStyle.layout,
        focusedOutlineStyle: FFocusedOutlineStyle(
          color: style.focusedOutlineStyle.color,
          borderRadius: BorderRadius.circular(4),
        ),
        enabledStyle: FCheckboxStateStyle(
          labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
          borderColor: color.primary,
          iconStyle: IconThemeData(color: color.primaryForeground, size: 14),
          checkedBackgroundColor: color.primary,
          uncheckedBackgroundColor: color.background,
        ),
        disabledStyle: FCheckboxStateStyle(
          labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
          borderColor: color.disable(color.primary),
          iconStyle: IconThemeData(color: color.disable(color.primaryForeground), size: 14),
          checkedBackgroundColor: color.disable(color.primary),
          uncheckedBackgroundColor: color.disable(color.background),
        ),
        errorStyle: FCheckboxErrorStyle(
          labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
          errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
          borderColor: color.error,
          iconStyle: IconThemeData(color: color.errorForeground, size: 14),
          checkedBackgroundColor: color.error,
          uncheckedBackgroundColor: color.background,
        ),
      );

  /// The [FLabel]'s style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
    layout: labelLayoutStyle,
    state: FLabelStateStyles(enabledStyle: enabledStyle, disabledStyle: disabledStyle, errorStyle: errorStyle),
  );
}

/// A checkbox state's style.
// ignore: avoid_implementing_value_types
class FCheckboxStateStyle with Diagnosticable, _$FCheckboxStateStyleFunctions implements FFormFieldStyle {
  /// The checkbox's size. Defaults to 16.
  @override
  final double size;

  /// The checked icon's style.
  @override
  final IconThemeData iconStyle;

  /// The border color.
  @override
  final Color borderColor;

  /// The checked background color.
  @override
  final Color checkedBackgroundColor;

  /// The unchecked background color.
  @override
  final Color uncheckedBackgroundColor;

  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FCheckboxStateStyle].
  const FCheckboxStateStyle({
    required this.borderColor,
    required this.iconStyle,
    required this.checkedBackgroundColor,
    required this.uncheckedBackgroundColor,
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    this.size = 16,
  });
}

/// A checkbox's error state style.
final class FCheckboxErrorStyle extends FCheckboxStateStyle
    with _$FCheckboxErrorStyleFunctions
    implements
        // ignore: avoid_implementing_value_types
        FFormFieldErrorStyle {
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FCheckboxErrorStyle].
  FCheckboxErrorStyle({
    required this.errorTextStyle,
    required super.borderColor,
    required super.iconStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.checkedBackgroundColor,
    required super.uncheckedBackgroundColor,
    super.size,
  });
}
