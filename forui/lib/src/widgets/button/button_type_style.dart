import 'package:flutter/material.dart';

/// Represents the theme data that is inherited by [FButtonStyle] and used by child [FButton] widgets.
class FButtonTypeStyle {
  /// The background color.
  final Color background;

  /// The foreground color.
  final Color foreground;

  /// The primary color.
  final Color disabled;

  /// The border color.
  final Color border;

  /// Creates a [FButtonTypeStyle].
  const FButtonTypeStyle({
    required this.background,
    required this.foreground,
    required this.disabled,
    required this.border,
  });

  /// Creates a copy of this [FButtonTypeStyle] with the given properties replaced.
  FButtonTypeStyle copyWith({
    Color? background,
    Color? foreground,
    Color? disabled,
    Color? border,
  }) =>
      FButtonTypeStyle(
        background: background ?? this.background,
        foreground: foreground ?? this.foreground,
        disabled: disabled ?? this.disabled,
        border: border ?? this.border,
      );
}
