import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A set of colors that is part of a [FThemeData]. It is used to configure the color properties of Forui widgets.
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding colors
/// of widget styles configured via `inherit(...)` constructors.
///
/// The main color groups in this scheme are [primary], [secondary], [muted], [destructive], and [error].
/// * Primary colors are used for key widgets across the UI.
/// * Secondary colors are used for less prominent widgets.
/// * Mute colors are typically used for disabled widgets.
/// * Destructive colors are used for destructive actions such as "Delete" buttons.
/// * Error colors are typically used to highlight errors, such as invalid input in text-fields.
///
/// Each color group includes a `-Foreground` suffixed color, i.e. [primaryForeground], used to color text and other
/// visual elements on top of their respective background colors.
///
/// Hovered colors are derived by adjusting the lightness of the original color. To derive these colors, use the [hover]
/// method. The lightness can be adjusted with [hoverLighten].
///
/// Disabled colors are derived by adjusting the opacity. To derive these colors, use the [disable] method. The opacity
/// can be adjusted with [disabledOpacity].
///
/// See [FThemes] for predefined themes and color schemes.
final class FColors with Diagnosticable {
  /// The system brightness.
  ///
  /// This is typically used to determine the appearance of native UI elements such as on-screen keyboards.
  final Brightness brightness;

  /// The system overlay style.
  ///
  /// This is typically used to determine the appearance of native system overlays such as status bars.
  final SystemUiOverlayStyle systemOverlayStyle;

  /// The barrier color.
  ///
  /// Typically used as a background for modal/pop-up routes.
  final Color barrier;

  /// The background color.
  ///
  /// Typically used as a background for [foreground] colored widgets.
  final Color background;

  /// The foreground color.
  ///
  /// Typically used to color widgets against a [background].
  final Color foreground;

  /// The primary color.
  ///
  /// Typically used as a background for [primaryForeground] colored widgets.
  final Color primary;

  /// The primary foreground color.
  ///
  /// Typically used to color widgets against a [primary] colored background.
  final Color primaryForeground;

  /// The secondary color.
  ///
  /// Typically used as a background for [secondaryForeground] colored widgets.
  final Color secondary;

  /// The secondary foreground color.
  ///
  /// Typically used to color widgets against a [secondary] colored background.
  final Color secondaryForeground;

  /// The muted color.
  ///
  /// Typically used as a background for [mutedForeground] colored widgets.
  final Color muted;

  /// The muted foreground color.
  ///
  /// Typically used to color widgets against a [muted] colored background.
  final Color mutedForeground;

  /// The destructive color.
  ///
  /// Typically used as a background for [destructiveForeground] colored widgets.
  final Color destructive;

  /// The destructive foreground color.
  ///
  /// Typically used to color widgets against a [destructive] colored background.
  final Color destructiveForeground;

  /// The error color.
  ///
  /// Typically used as a background for [errorForeground] colored widgets.
  final Color error;

  /// The error foreground color.
  ///
  /// Typically used to color widgets against a [error] colored background.
  final Color errorForeground;

  /// The border color.
  final Color border;

  /// The percentage to lighten dark colors by. A higher value will result in a more pronounced lightening effect.
  ///
  /// Defaults to 0.075.
  ///
  /// ## Contract
  /// `0.0 <= hoverLighten <= 1.0`
  final double hoverLighten;

  /// The percentage to darken light colors by. A higher value will result in a more pronounced darkening effect.
  ///
  /// Defaults to 0.05.
  ///
  /// ## Contract
  /// `0.0 <= hoverDarken <= 1.0`
  final double hoverDarken;

  /// The opacity of the foreground color when a widget is disabled. Defaults to 0.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the value is less than 0 or greater than 1.
  final double disabledOpacity;

  /// Creates a [FColors].
  ///
  /// **Note:**
  /// Unless you are creating a completely new color scheme, modifying [FThemes]' predefined color schemes is preferred.
  const FColors({
    required this.brightness,
    required this.systemOverlayStyle,
    required this.barrier,
    required this.background,
    required this.foreground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.error,
    required this.errorForeground,
    required this.border,
    this.hoverLighten = 0.075,
    this.hoverDarken = 0.05,
    this.disabledOpacity = 0.5,
  }) : assert(0.0 <= hoverLighten && hoverLighten <= 1.0, 'hoverLighten must be between 0 and 1.'),
       assert(0.0 <= hoverDarken && hoverDarken <= 1.0, 'hoverDarken must be between 0 and 1.'),
       assert(0 <= disabledOpacity && disabledOpacity <= 1, 'disabledOpacity must be between 0 and 1.');

  /// Creates a linear interpolation between two [FColors] using the given factor [t].
  factory FColors.lerp(FColors a, FColors b, double t) => FColors(
    brightness: t < 0.5 ? a.brightness : b.brightness,
    systemOverlayStyle: t < 0.5 ? a.systemOverlayStyle : b.systemOverlayStyle,
    barrier: Color.lerp(a.barrier, b.barrier, t)!,
    background: Color.lerp(a.background, b.background, t)!,
    foreground: Color.lerp(a.foreground, b.foreground, t)!,
    primary: Color.lerp(a.primary, b.primary, t)!,
    primaryForeground: Color.lerp(a.primaryForeground, b.primaryForeground, t)!,
    secondary: Color.lerp(a.secondary, b.secondary, t)!,
    secondaryForeground: Color.lerp(a.secondaryForeground, b.secondaryForeground, t)!,
    muted: Color.lerp(a.muted, b.muted, t)!,
    mutedForeground: Color.lerp(a.mutedForeground, b.mutedForeground, t)!,
    destructive: Color.lerp(a.destructive, b.destructive, t)!,
    destructiveForeground: Color.lerp(a.destructiveForeground, b.destructiveForeground, t)!,
    error: Color.lerp(a.error, b.error, t)!,
    errorForeground: Color.lerp(a.errorForeground, b.errorForeground, t)!,
    border: Color.lerp(a.border, b.border, t)!,
    hoverLighten: lerpDouble(a.hoverLighten, b.hoverLighten, t)!,
    hoverDarken: lerpDouble(a.hoverDarken, b.hoverDarken, t)!,
    disabledOpacity: lerpDouble(a.disabledOpacity, b.disabledOpacity, t)!,
  );

  /// Generates a hovered variant of the given [color] by darkening light colors and lighting dark colors based on their
  /// HSL lightness.
  ///
  /// Colors at the extremes (very light or very dark) will be adjusted more aggressively than colors in the middle.
  ///
  /// The lightening and darkening are controlled by [hoverLighten] and [hoverDarken].
  Color hover(Color color) {
    final hsl = HSLColor.fromColor(color);
    final l = hsl.lightness;

    // More aggressive color change when close to extremes & less when in the middle.
    final (space, factor, sign) = l > 0.5 ? (1.0 - l, hoverDarken, -1) : (l, hoverLighten, 1);
    final aggressiveness = 1 + ((0.5 - space) / 0.5);
    final adjustment = factor * aggressiveness * sign;
    final lightness = clampDouble(l + adjustment, 0, 1);

    return hsl.withLightness(lightness).toColor();
  }

  /// Returns a disabled color for the [foreground] on the [background].
  ///
  /// [FColors.background] is used if [background] is not given.
  Color disable(Color foreground, [Color? background]) =>
      Color.alphaBlend(foreground.withValues(alpha: disabledOpacity), background ?? this.background);

  /// Returns a copy of this [FColors] with the given properties replaced.
  ///
  /// ```dart
  /// final colors = FColors(
  ///   brightness: Brightness.light,
  ///   background: Colors.blue,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = colors.copyWith(brightness: Brightness.dark);
  ///
  /// print(copy.brightness); // Brightness.dark
  /// print(copy.background); // Colors.blue
  /// ```
  @useResult
  FColors copyWith({
    Brightness? brightness,
    SystemUiOverlayStyle? systemOverlayStyle,
    Color? barrier,
    Color? background,
    Color? foreground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? error,
    Color? errorForeground,
    Color? border,
    double? hoverLighten,
    double? hoverDarken,
    double? disabledOpacity,
  }) => FColors(
    brightness: brightness ?? this.brightness,
    systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    barrier: barrier ?? this.barrier,
    background: background ?? this.background,
    foreground: foreground ?? this.foreground,
    primary: primary ?? this.primary,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    secondary: secondary ?? this.secondary,
    secondaryForeground: secondaryForeground ?? this.secondaryForeground,
    muted: muted ?? this.muted,
    mutedForeground: mutedForeground ?? this.mutedForeground,
    destructive: destructive ?? this.destructive,
    destructiveForeground: destructiveForeground ?? this.destructiveForeground,
    error: error ?? this.error,
    errorForeground: errorForeground ?? this.errorForeground,
    border: border ?? this.border,
    hoverLighten: hoverLighten ?? this.hoverLighten,
    hoverDarken: hoverDarken ?? this.hoverDarken,
    disabledOpacity: disabledOpacity ?? this.disabledOpacity,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('brightness', brightness))
      ..add(DiagnosticsProperty('systemOverlayStyle', systemOverlayStyle))
      ..add(ColorProperty('barrier', barrier))
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('foreground', foreground))
      ..add(ColorProperty('primary', primary))
      ..add(ColorProperty('primaryForeground', primaryForeground))
      ..add(ColorProperty('secondary', secondary))
      ..add(ColorProperty('secondaryForeground', secondaryForeground))
      ..add(ColorProperty('muted', muted))
      ..add(ColorProperty('mutedForeground', mutedForeground))
      ..add(ColorProperty('destructive', destructive))
      ..add(ColorProperty('destructiveForeground', destructiveForeground))
      ..add(ColorProperty('error', error))
      ..add(ColorProperty('errorForeground', errorForeground))
      ..add(ColorProperty('border', border))
      ..add(PercentProperty('hoverLighten', hoverLighten))
      ..add(PercentProperty('hoverDarken', hoverDarken))
      ..add(PercentProperty('disabledOpacity', disabledOpacity));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FColors &&
          brightness == other.brightness &&
          systemOverlayStyle == other.systemOverlayStyle &&
          barrier == other.barrier &&
          background == other.background &&
          foreground == other.foreground &&
          primary == other.primary &&
          primaryForeground == other.primaryForeground &&
          secondary == other.secondary &&
          secondaryForeground == other.secondaryForeground &&
          muted == other.muted &&
          mutedForeground == other.mutedForeground &&
          destructive == other.destructive &&
          destructiveForeground == other.destructiveForeground &&
          error == other.error &&
          errorForeground == other.errorForeground &&
          border == other.border &&
          hoverLighten == other.hoverLighten &&
          hoverDarken == other.hoverDarken &&
          disabledOpacity == other.disabledOpacity;

  @override
  int get hashCode =>
      brightness.hashCode ^
      systemOverlayStyle.hashCode ^
      barrier.hashCode ^
      background.hashCode ^
      foreground.hashCode ^
      primary.hashCode ^
      primaryForeground.hashCode ^
      secondary.hashCode ^
      secondaryForeground.hashCode ^
      muted.hashCode ^
      mutedForeground.hashCode ^
      destructive.hashCode ^
      destructiveForeground.hashCode ^
      error.hashCode ^
      errorForeground.hashCode ^
      border.hashCode ^
      hoverLighten.hashCode ^
      hoverDarken.hashCode ^
      disabledOpacity.hashCode;
}
