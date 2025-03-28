import 'package:forui/forui.dart';
import 'package:flutter/widgets.dart';

FButtonStyle buttonStyle({
  required FTypography typography,
  required FStyle style,
  required Color enabledBoxColor,
  required Color enabledHoveredBoxColor,
  required Color disabledBoxColor,
  required Color enabledContentColor,
  required Color disabledContentColor,
}) => FButtonStyle(
  enabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius, color: enabledBoxColor),
  enabledHoverBoxDecoration: BoxDecoration(borderRadius: style.borderRadius, color: enabledHoveredBoxColor),
  disabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius, color: disabledBoxColor),
  focusedOutlineStyle: style.focusedOutlineStyle,
  contentStyle: buttonContentStyle(
    typography: typography,
    enabled: enabledContentColor,
    disabled: disabledContentColor,
  ),
  iconContentStyle: FButtonIconContentStyle(
    enabledStyle: IconThemeData(color: enabledContentColor, size: 20),
    disabledStyle: IconThemeData(color: disabledContentColor, size: 20),
  ),
  tappableStyle: style.tappableStyle,
);

FButtonContentStyle _buttonContentStyle({
  required FTypography typography,
  required Color enabled,
  required Color disabled,
}) => FButtonContentStyle(
  enabledTextStyle: typography.base.copyWith(color: enabled, fontWeight: FontWeight.w500, height: 1),
  disabledTextStyle: typography.base.copyWith(color: disabled, fontWeight: FontWeight.w500, height: 1),
  enabledIconStyle: IconThemeData(color: enabled, size: 20),
  disabledIconStyle: IconThemeData(color: disabled, size: 20),
);

