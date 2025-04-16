import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'form_field_style.style.dart';

/// A form field state's style.
class FFormFieldStyle with Diagnosticable, _$FFormFieldStyleFunctions {
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<TextStyle> labelTextStyle;

  /// The description's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<TextStyle> descriptionTextStyle;

  /// The error's text style.
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FFormFieldStyle].
  const FFormFieldStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    required this.errorTextStyle,
  });

  /// Creates a [FFormFieldStyle] that inherits its properties.
  FFormFieldStyle.inherit({required FColors colors, required FTypography typography})
    : labelTextStyle = FWidgetStateMap({
        WidgetState.error: typography.sm.copyWith(color: colors.error, fontWeight: FontWeight.w600),
        WidgetState.disabled: typography.sm.copyWith(
          color: colors.disable(colors.primary),
          fontWeight: FontWeight.w600,
        ),
        WidgetState.any: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
      }),
      descriptionTextStyle = FWidgetStateMap({
        WidgetState.error: typography.sm.copyWith(color: colors.mutedForeground),
        WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.mutedForeground)),
        WidgetState.any: typography.sm.copyWith(color: colors.mutedForeground),
      }),
      errorTextStyle = typography.sm.copyWith(color: colors.error, fontWeight: FontWeight.w600);
}
