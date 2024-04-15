import 'package:flutter/material.dart';

/// A class that holds the theme data for the app.
class FThemeData {
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

  /// The border radius.
  final BorderRadius borderRadius;

  /// Creates a [FThemeData].
  const FThemeData({
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
    required this.borderRadius,
  });

  /// Creates a copy of this theme data with the given properties replaced.
  FThemeData copyWith({
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
    BorderRadius? borderRadius,
  }) =>
      FThemeData(
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
        borderRadius: borderRadius ?? this.borderRadius,
      );
}
