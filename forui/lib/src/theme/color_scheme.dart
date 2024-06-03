import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A set of colors that can be used to configure the colors of most widgets.
///
/// See the pre-defined themes' color schemes in [FThemes].
final class FColorScheme with Diagnosticable {

  /// The background color.
  final Color background;

  /// The foreground color.
  final Color foreground;

  /// The primary color.
  final Color primary;

  /// The primary foreground color.
  final Color primaryForeground;

  /// The secondary color.
  final Color secondary;

  /// The secondary foreground color.
  final Color secondaryForeground;

  /// The muted color.
  final Color muted;

  /// The muted foreground color.
  final Color mutedForeground;

  /// The destructive color.
  final Color destructive;

  /// The destructive foreground color.
  final Color destructiveForeground;

  /// The border color.
  final Color border;

  /// Creates a [FColorScheme].
  const FColorScheme({
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
    required this.border,
  });

  /// Creates a copy of this [FColorScheme] with the given properties replaced.
  FColorScheme copyWith({
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
    Color? border,
  }) =>
      FColorScheme(
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
        border: border ?? this.border,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
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
      ..add(ColorProperty('border', border));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FColorScheme &&
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
    border == other.border;

  @override
  int get hashCode =>
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
    border.hashCode;

}
