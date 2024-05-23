part of 'card.dart';

/// [FCard]'s style.
final class FCardStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The [FCardContent] style.
  final FCardContentStyle content;

  /// Creates a [FCardStyle].
  FCardStyle({required this.decoration, required this.content});

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [style].
  FCardStyle.inherit({required FColorScheme colorScheme, required FStyle style}):
    decoration = BoxDecoration(
      border: Border.all(color: colorScheme.border),
      borderRadius: style.borderRadius,
    ),
    content = FCardContentStyle.inherit(colorScheme: colorScheme);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      .add(DiagnosticsProperty<FCardContentStyle>('content', content));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FCardStyle &&
    runtimeType == other.runtimeType &&
    decoration == other.decoration &&
    content == other.content;

  @override
  int get hashCode => decoration.hashCode ^ content.hashCode;

}
