import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'picker_style.design.dart';

/// [FPickerStyle]'s style.
class FPickerStyle with Diagnosticable, _$FPickerStyleFunctions {
  /// A ratio between the diameter of the cylinder and the viewport's size.
  @override
  final double diameterRatio;

  /// The angular compactness of the children on the wheel.
  @override
  final double squeeze;

  /// The zoomed-in rate of the magnifier.
  @override
  final double magnification;

  /// The opacity value applied to the wheel above and below the magnifier.
  @override
  final double overAndUnderCenterOpacity;

  /// The spacing between the picker's wheels. Defaults to 5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the spacing is less than 0.
  @override
  final double spacing;

  /// The picker's default text style.
  @override
  final TextStyle textStyle;

  /// The picker's default text height behavior.
  @override
  final TextHeightBehavior textHeightBehavior;

  /// An amount to add to the height of the selection.
  @override
  final double selectionHeightAdjustment;

  /// The selection's border radius.
  @override
  final BorderRadiusGeometry selectionBorderRadius;

  /// The selection's color.
  @override
  final Color selectionColor;

  /// The focused outline style.
  @override
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
    this.selectionHeightAdjustment = 0,
  }) : assert(0 < diameterRatio, 'diameterRatio ($diameterRatio) must be > 0'),
       assert(0 < squeeze, 'squeeze ($squeeze) must be > 0'),
       assert(0 < magnification, 'magnification ($magnification) must be > 0'),
       assert(
         0 <= overAndUnderCenterOpacity && overAndUnderCenterOpacity <= 1,
         'overAndUnderCenterOpacity ($overAndUnderCenterOpacity) must be between 0 and 1',
       ),
       assert(spacing >= 0, 'spacing ($spacing) must be >= 0');

  /// Creates a [FPickerStyle] that inherits its properties.
  FPickerStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
    : this(
        textStyle: typography.base.copyWith(fontWeight: FontWeight.w500),
        selectionBorderRadius: style.borderRadius,
        selectionColor: colors.muted,
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}
