part of 'button.dart';

/// Represents the theme data that is inherited by [FButtonStyle] and used by child [FButton] widgets.
class FButtonStyle extends FButtonDesign {
  /// The background color.
  final Color background;

  /// The foreground color.
  final Color foreground;

  /// The primary color.
  final Color disabled;

  /// The border color.
  final Color border;

  /// The border radius.
  final BorderRadius borderRadius;

  /// The content.
  final FButtonContentStyle content;

  /// Creates a [FButtonStyle].
  FButtonStyle({
    required this.background,
    required this.foreground,
    required this.disabled,
    required this.border,
    required this.borderRadius,
    required this.content,
  });

  /// Creates a copy of this [FButtonTypeStyle] with the given properties replaced.
  FButtonStyle copyWith({
    Color? background,
    Color? foreground,
    Color? disabled,
    Color? border,
    BorderRadius? borderRadius,
    FButtonContentStyle? content,
  }) =>
      FButtonStyle(
        background: background ?? this.background,
        foreground: foreground ?? this.foreground,
        disabled: disabled ?? this.disabled,
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        content: content ?? this.content,
      );
}
