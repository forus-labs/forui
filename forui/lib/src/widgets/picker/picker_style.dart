import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// [FPickerStyle]'s style.
final class FPickerStyle with Diagnosticable {
  /// A ratio between the diameter of the cylinder and the viewport's size.
  final double diameterRatio;

  /// The angular compactness of the children on the wheel.
  final double squeeze;

  /// The zoomed-in rate of the magnifier.
  final double magnification;

  /// The opacity value applied to the wheel above and below the magnifier.
  final double overAndUnderCenterOpacity;

  /// The spacing between the picker's wheels. Defaults to 5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the spacing is less than 0.
  final double spacing;

  /// The picker's default text style.
  final TextStyle textStyle;

  /// The picker's default text height behavior.
  final TextHeightBehavior textHeightBehavior;

  /// The selection's border radius.
  final BorderRadius selectionBorderRadius;

  /// The selection's color.
  final Color selectionColor;

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FPickerStyle].
  const FPickerStyle({
    required this.textStyle,
    required this.selectionBorderRadius,
    required this.selectionColor,
    required this.focusedOutlineStyle,
    this.diameterRatio = 1.07,
    this.squeeze = 1,
    this.magnification = 1,
    this.overAndUnderCenterOpacity = 0.25,
    this.spacing = 5,
    this.textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
  })  : assert(0 < diameterRatio, 'The diameter ratio must be greater than 0.'),
        assert(0 < squeeze, 'The squeeze must be greater than 0.'),
        assert(0 < magnification, 'The magnification must be greater than 0.'),
        assert(
          0 <= overAndUnderCenterOpacity && overAndUnderCenterOpacity <= 1,
          'The over and under center opacity must be between 0 and 1.',
        ),
        assert(spacing >= 0, 'The spacing must be greater than or equal to 0.');

  /// Creates a [FPickerStyle] that inherits its properties.
  FPickerStyle.inherit({
    required FColorScheme colorScheme,
    required FStyle style,
    required FTypography typography,
  }) : this(
          textStyle: typography.lg.copyWith(fontWeight: FontWeight.w500),
          selectionBorderRadius: style.borderRadius,
          selectionColor: colorScheme.muted,
          focusedOutlineStyle: style.focusedOutlineStyle,
        );

  /// Returns a copy of this [FPickerStyle] with the given properties replaced.
  @useResult
  FPickerStyle copyWith({
    double? diameterRatio,
    double? squeeze,
    double? magnification,
    double? overAndUnderCenterOpacity,
    double? spacing,
    TextStyle? textStyle,
    TextHeightBehavior? textHeightBehavior,
    BorderRadius? selectionBorderRadius,
    Color? selectionColor,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) =>
      FPickerStyle(
        diameterRatio: diameterRatio ?? this.diameterRatio,
        squeeze: squeeze ?? this.squeeze,
        magnification: magnification ?? this.magnification,
        overAndUnderCenterOpacity: overAndUnderCenterOpacity ?? this.overAndUnderCenterOpacity,
        spacing: spacing ?? this.spacing,
        textStyle: textStyle ?? this.textStyle,
        textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
        selectionBorderRadius: selectionBorderRadius ?? this.selectionBorderRadius,
        selectionColor: selectionColor ?? this.selectionColor,
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('diameterRatio', diameterRatio))
      ..add(DoubleProperty('squeeze', squeeze))
      ..add(DoubleProperty('magnification', magnification))
      ..add(DoubleProperty('overAndUnderCenterOpacity', overAndUnderCenterOpacity))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('selectionBorderRadius', selectionBorderRadius))
      ..add(ColorProperty('selectionColor', selectionColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('textHeightBehavior', textHeightBehavior))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FPickerStyle &&
          runtimeType == other.runtimeType &&
          diameterRatio == other.diameterRatio &&
          squeeze == other.squeeze &&
          magnification == other.magnification &&
          overAndUnderCenterOpacity == other.overAndUnderCenterOpacity &&
          spacing == other.spacing &&
          selectionBorderRadius == other.selectionBorderRadius &&
          selectionColor == other.selectionColor &&
          textStyle == other.textStyle &&
          textHeightBehavior == other.textHeightBehavior &&
          focusedOutlineStyle == other.focusedOutlineStyle;

  @override
  int get hashCode =>
      diameterRatio.hashCode ^
      squeeze.hashCode ^
      magnification.hashCode ^
      overAndUnderCenterOpacity.hashCode ^
      spacing.hashCode ^
      selectionBorderRadius.hashCode ^
      selectionColor.hashCode ^
      textStyle.hashCode ^
      textHeightBehavior.hashCode ^
      focusedOutlineStyle.hashCode;
}
