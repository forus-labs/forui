import 'package:forui/forui.dart';

/// [FButtonStyle]'s style.
class FButtonStyles {
  /// The primary style.
  final FButtonStyle primary;

  /// The secondary style.
  final FButtonStyle secondary;

  /// The destructive style.
  final FButtonStyle destructive;

  /// The outlined style.
  final FButtonStyle outlined;

  /// Creates a [FButtonStyle].
  const FButtonStyles({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outlined,
  });

  /// Creates a [FButtonStyle] that inherits its properties from [data] and [style].
  FButtonStyles.inherit({required FFontData font, required FStyleData style})
      : primary = FButtonStyle(
          background: style.primary,
          foreground: style.primaryForeground,
          disabled: style.mutedForeground,
          border: style.primary,
          borderRadius: style.borderRadius,
          content: FButtonContentStyle.inherit(style: style, font: font, color: style.primaryForeground,),
        ),
        secondary = FButtonStyle(
          background: style.mutedForeground,
          foreground: style.secondaryForeground,
          disabled: style.mutedForeground,
          border: style.mutedForeground,
          borderRadius: style.borderRadius,
            content: FButtonContentStyle.inherit(style: style, font: font, color: style.secondaryForeground,),
        ),
        destructive = FButtonStyle(
          background: style.destructive,
          foreground: style.foreground,
          disabled: style.mutedForeground,
          border: style.destructive,
          borderRadius: style.borderRadius,
            content: FButtonContentStyle.inherit(style: style, font: font, color: style.foreground,),
        ),
        outlined = FButtonStyle(
          background: style.secondary,
          foreground: style.secondaryForeground,
          disabled: style.mutedForeground,
          border: style.mutedForeground,
          borderRadius: style.borderRadius,
            content: FButtonContentStyle.inherit(style: style, font: font, color: style.secondaryForeground,),
        );
}
