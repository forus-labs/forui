import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'style.style.dart';

/// A set of miscellaneous properties that is part of a [FThemeData].
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding
/// properties of widget styles configured via `inherit(...)` constructors.
class FStyle with Diagnosticable, _$FStyleFunctions {
  /// The style for the form field.
  @override
  final FFormFieldStyle formFieldStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The icon style.
  @override
  final IconThemeData iconStyle;

  /// The border radius. Defaults to `FLerpBorderRadius.circular(8)`.
  @override
  final BorderRadius borderRadius;

  /// The border width. Defaults to 1.
  @override
  final double borderWidth;

  /// The page's padding. Defaults to `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`.
  @override
  final EdgeInsets pagePadding;

  /// The shadow used for elevated widgets.
  @override
  final List<BoxShadow> shadow;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying [FThemes]' predefined styles should be preferred.
  const FStyle({
    required this.formFieldStyle,
    required this.focusedOutlineStyle,
    required this.iconStyle,
    required this.tappableStyle,
    this.borderRadius = const FLerpBorderRadius.all(Radius.circular(8), min: 24),
    this.borderWidth = 1,
    this.pagePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    this.shadow = const [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 2)],
  });

  /// Creates an [FStyle] that inherits its properties.
  FStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        formFieldStyle: FFormFieldStyle.inherit(colors: colors, typography: typography),
        focusedOutlineStyle: FFocusedOutlineStyle(
          color: colors.primary,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        iconStyle: IconThemeData(color: colors.primary, size: 20),
        tappableStyle: FTappableStyle(),
      );
}
