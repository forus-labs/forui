import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A set of color schemes for different states that is part of a [FThemeData]. It is used to configure the color
/// properties of Forui widgets.
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding colors
/// of widget styles configured via `inherit(...)` constructors.
///
/// See:
/// * [FThemes] for predefined themes and color schemes.
/// * [FStateColorScheme] for more information.
final class FColorScheme with Diagnosticable {
  /// The system brightness.
  ///
  /// This is typically used to determine the appearance of native UI elements such as on-screen keyboards.
  final Brightness brightness;

  /// The color scheme for enabled widgets, typically the default state.
  final FStateColorScheme enabled;

  /// The color scheme for enabled widgets that are hovered over.
  final FStateColorScheme enabledHovered;

  /// The color scheme for disabled widgets.
  final FStateColorScheme disabled;

  /// Creates a [FColorScheme].
  const FColorScheme({
    required this.brightness,
    required this.enabled,
    required this.enabledHovered,
    required this.disabled,
  });

  /// Returns a copy of this [FColorScheme] with the given properties replaced.
  @useResult
  FColorScheme copyWith({
    Brightness? brightness,
    FStateColorScheme? enabled,
    FStateColorScheme? enabledHovered,
    FStateColorScheme? disabled,
  }) =>
      FColorScheme(
        brightness: brightness ?? this.brightness,
        enabled: enabled ?? this.enabled,
        enabledHovered: enabledHovered ?? this.enabledHovered,
        disabled: disabled ?? this.disabled,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('brightness', brightness))
      ..add(DiagnosticsProperty('enabled', enabled))
      ..add(DiagnosticsProperty('enabledHovered', enabledHovered))
      ..add(DiagnosticsProperty('disabled', disabled));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FColorScheme &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          enabled == other.enabled &&
          enabledHovered == other.enabledHovered &&
          disabled == other.disabled;

  @override
  int get hashCode => brightness.hashCode ^ enabled.hashCode ^ enabledHovered.hashCode ^ disabled.hashCode;
}

/// A set of colors that is part of a [FColorScheme].
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
/// See [FThemes] for predefined themes and color schemes.
final class FStateColorScheme with Diagnosticable {
  // TODO: REMOVE
  /// The system brightness.
  ///
  /// This is typically used to determine the appearance of native UI elements such as on-screen keyboards.
  final Brightness brightness;

  // TODO: REMOVE
  /// The percentage, between `0` and `1`, used to set a color's lightness to derive a disabled color.
  final double disabledColorLightness;

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

  /// Creates a [FStateColorScheme].
  ///
  /// **Note:**
  /// Unless you are creating a completely new color scheme, modifying [FThemes]' predefined color schemes is preferred.
  const FStateColorScheme({
    required this.brightness,
    required this.disabledColorLightness,
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
  });

  // TODO: REMOVE
  /// Creates a disabled color from the given [color].
  ///
  /// See:
  /// * [disabledColorLightness].
  Color disable(Color color) => HSLColor.fromColor(color).withLightness(disabledColorLightness).toColor();

  /// Returns a copy of this [FColorScheme] with the given properties replaced.
  ///
  /// ```dart
  /// final scheme = FStateColorScheme(
  ///   brightness: Brightness.light,
  ///   background: Colors.blue,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = scheme.copyWith(brightness: Brightness.dark);
  ///
  /// print(copy.brightness); // Brightness.dark
  /// print(copy.background); // Colors.blue
  /// ```
  @useResult
  FStateColorScheme copyWith({
    Brightness? brightness,
    double? disabledColorLightness,
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
  }) =>
      FStateColorScheme(
        brightness: brightness ?? this.brightness,
        disabledColorLightness: disabledColorLightness ?? this.disabledColorLightness,
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
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('brightness', brightness))
      ..add(DoubleProperty('disabledColorLightness', disabledColorLightness))
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
      ..add(ColorProperty('border', border));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStateColorScheme &&
          brightness == other.brightness &&
          disabledColorLightness == other.disabledColorLightness &&
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
          border == other.border;

  @override
  int get hashCode =>
      brightness.hashCode ^
      disabledColorLightness.hashCode ^
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
      border.hashCode;
}

extension Lightness on Color {
  /// Returns a copy of this color with the lightness set to the given value.
  Color withLightness(double lightness) => HSLColor.fromColor(this).withLightness(lightness).toColor();
}
