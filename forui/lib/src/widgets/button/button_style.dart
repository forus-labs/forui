part of 'button.dart';

/// Represents the theme data that is inherited by [FButtonStyle] and used by child [FButton].
class FButtonStyle extends FButtonDesign {
  /// The content.
  final FButtonContentStyle content;

  /// The box decoration for an enabled button.
  final BoxDecoration enabledBoxDecoration;

  /// The box decoration for a disabled button.
  final BoxDecoration disabledBoxDecoration;

  /// Creates a [FButtonStyle].
  FButtonStyle({
    required this.content,
    required this.enabledBoxDecoration,
    required this.disabledBoxDecoration,
  });

  /// Creates a copy of this [FButtonStyle] with the given properties replaced.
  FButtonStyle copyWith({
    FButtonContentStyle? content,
    BoxDecoration? enabledBoxDecoration,
    BoxDecoration? disabledBoxDecoration,
  }) =>
      FButtonStyle(
        content: content ?? this.content,
        enabledBoxDecoration: enabledBoxDecoration ?? this.enabledBoxDecoration,
        disabledBoxDecoration: disabledBoxDecoration ?? this.disabledBoxDecoration,
      );
}
