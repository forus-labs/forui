part of 'button.dart';

/// The button design. Either a pre-defined [FButtonVariant], or a custom [FButtonStyle].
sealed class FButtonDesign {}

/// A pre-defined button variant.
enum FButtonVariant implements FButtonDesign  {
  /// A primary-styled button.
  primary,

  /// A secondary-styled button.
  secondary,

  /// An outlined button.
  outlined,

  /// A destructive button.
  destructive,
}

/// Represents the theme data that is inherited by [FButtonStyle] and used by child [FButton].
class FButtonStyle extends FButtonDesign with Diagnosticable{

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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('content', content))
    ..add(DiagnosticsProperty('enabledBoxDecoration', enabledBoxDecoration))
    ..add(DiagnosticsProperty('disabledBoxDecoration', disabledBoxDecoration));
  }

}
