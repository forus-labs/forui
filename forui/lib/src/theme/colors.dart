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
/// method. The lightness can be adjusted with [hoverLightness].
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

  /// The lightness adjustment range for hover effects.
  ///
  /// The `min` is applied to dark colors (lightness near 0) to lighten them, while the `max` value is to light colors
  /// (lightness near 1) to darken them. Values between are interpolated.
  ///
  /// The `threshold` defines the minimum lightness change that will always be applied. In other words, if the change in
  /// lightness is less than the threshold, then the threshold value will be used instead.
  ///
  /// Defaults to `(min: 0.15, max: -0.075)`.
  ///
  /// ## Contract
  /// Both values must be between -1 and 1, inclusive.
  final ({double min, double max, double threshold}) hoverLightness;

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
    this.hoverLightness = (min: 0.15, max: -0.075, threshold: 0.05),
    this.disabledOpacity = 0.5,
  }) : assert(0 <= disabledOpacity && disabledOpacity <= 1, 'The disabledOpacity must be between 0 and 1.');

  /// Returns a hovered color for the given [color] by adjusting its lightness.
  Color hover(Color color) {
    final hsl = HSLColor.fromColor(color);

    var lightness = lerpDouble(hoverLightness.min, hoverLightness.max, hsl.lightness)!;
    if (-hoverLightness.threshold < lightness && lightness < hoverLightness.threshold) {
      lightness = lightness.sign * hoverLightness.threshold;
    }
    return hsl.withLightness(clampDouble(hsl.lightness + lightness, 0.0, 1.0)).toColor();
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
    ({double min, double max, double threshold})? hoverLightness,
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
    hoverLightness: hoverLightness ?? this.hoverLightness,
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
      ..add(StringProperty('hoverLightness', hoverLightness.toString()))
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
          hoverLightness == other.hoverLightness &&
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
      hoverLightness.hashCode ^
      disabledOpacity.hashCode;
}
