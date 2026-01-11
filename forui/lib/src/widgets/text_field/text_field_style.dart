import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'text_field_style.design.dart';

/// The text field style.
class FTextFieldStyle extends FLabelStyle with _$FTextFieldStyleFunctions {
  /// The appearance of the keyboard. Defaults to [FColors.brightness].
  ///
  /// This setting is only honored on iOS devices.
  @override
  final Brightness keyboardAppearance;

  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  @override
  final Color cursorColor;

  /// The base fill color of the decoration's container colors.
  @override
  final Color? fillColor;

  /// If true the decoration's container is filled with [fillColor]. Defaults to false.
  @override
  final bool filled;

  /// The padding surrounding this text field's content.
  ///
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 14, vertical: 14)`.
  @override
  final EdgeInsetsGeometry contentPadding;

  /// The padding surrounding the clear button. Defaults to `EdgeInsetsDirectional.only(end: 4)`.
  @override
  final EdgeInsetsGeometry clearButtonPadding;

  /// The padding surrounding the obscured text toggle. Defaults to `EdgeInsetsDirectional.only(end: 4)`.
  @override
  final EdgeInsetsGeometry obscureButtonPadding;

  /// Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  ///
  /// Defaults to `EdgeInsets.all(20)`.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially off the screen or
  /// overlapped by the keyboard) then it will attempt to make itself visible by scrolling a surrounding [Scrollable],
  /// if one is present. This value controls how far from the edges of a [Scrollable] the TextField will be positioned
  /// after the scroll.
  @override
  final EdgeInsets scrollPadding;

  /// The prefix & suffix icon styles.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The clear button's style when [FTextField.clearable] is true.
  @override
  final FButtonStyle clearButtonStyle;

  /// The obscured text toggle's style when enabled in [FTextField.password].
  @override
  final FButtonStyle obscureButtonStyle;

  /// The content's [TextStyle].
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<TextStyle> contentTextStyle;

  /// The hint's [TextStyle].
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<TextStyle> hintTextStyle;

  /// The counter's [TextStyle].
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<TextStyle> counterTextStyle;

  /// The border.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  @override
  final FWidgetStateMap<InputBorder> border;

  /// Creates a [FTextFieldStyle].
  FTextFieldStyle({
    required this.keyboardAppearance,
    required this.iconStyle,
    required this.clearButtonStyle,
    required this.obscureButtonStyle,
    required this.contentTextStyle,
    required this.hintTextStyle,
    required this.counterTextStyle,
    required this.border,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.cursorColor = CupertinoColors.activeBlue,
    this.fillColor,
    this.filled = false,
    this.contentPadding = const .symmetric(horizontal: 10, vertical: 10),
    this.clearButtonPadding = const .directional(end: 4),
    this.obscureButtonPadding = const .directional(end: 4),
    this.scrollPadding = const .all(20),
    super.labelPadding,
    super.descriptionPadding,
    super.errorPadding,
    super.childPadding,
  });

  /// Creates a [FTextFieldStyle] that inherits its properties.
  factory FTextFieldStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final label = FLabelStyles.inherit(style: style).verticalStyle;
    final ghost = FButtonStyles.inherit(colors: colors, typography: typography, style: style).ghost;
    final textStyle = typography.sm.copyWith(fontFamily: typography.defaultFontFamily);
    final iconStyle = FWidgetStateMap({
      WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 17),
      WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 17),
    });
    final bounceableButtonStyle = ghost.copyWith(
      iconContentStyle: ghost.iconContentStyle.copyWith(iconStyle: iconStyle),
    );

    return .new(
      keyboardAppearance: colors.brightness,
      iconStyle: iconStyle,
      clearButtonStyle: bounceableButtonStyle,
      obscureButtonStyle: bounceableButtonStyle.copyWith(
        tappableStyle: (style) =>
            style.copyWith(motion: (motion) => motion.copyWith(bounceTween: FTappableMotion.noBounceTween)),
      ),
      contentTextStyle: FWidgetStateMap({
        WidgetState.disabled: textStyle.copyWith(color: colors.disable(colors.primary)),
        WidgetState.any: textStyle.copyWith(color: colors.primary),
      }),
      hintTextStyle: FWidgetStateMap({
        WidgetState.disabled: textStyle.copyWith(color: colors.disable(colors.border)),
        WidgetState.any: textStyle.copyWith(color: colors.mutedForeground),
      }),
      counterTextStyle: FWidgetStateMap({
        WidgetState.disabled: textStyle.copyWith(color: colors.disable(colors.primary)),
        WidgetState.any: textStyle.copyWith(color: colors.primary),
      }),
      border: FWidgetStateMap({
        WidgetState.error: OutlineInputBorder(
          borderSide: BorderSide(color: colors.error, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.disabled: OutlineInputBorder(
          borderSide: BorderSide(color: colors.disable(colors.border), width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.focused: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primary, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
        WidgetState.any: OutlineInputBorder(
          borderSide: BorderSide(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius,
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
