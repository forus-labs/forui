part of 'card.dart';

/// [FCardContent]'s style.
class FCardContentStyle with Diagnosticable {
  /// The padding.
  final EdgeInsets padding;

  /// The title.
  final TextStyle title;

  /// The subtitle.
  final TextStyle subtitle;

  /// Creates a [FCardContentStyle].
  const FCardContentStyle({required this.padding, required this.title, required this.subtitle});

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme].
  FCardContentStyle.inherit({required FColorScheme colorScheme}):
      padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
      title = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.foreground,
      ),
      subtitle = TextStyle(
        fontSize: 12,
        color: colorScheme.mutedForeground,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
      ..add(DiagnosticsProperty<TextStyle>('title', title))
      ..add(DiagnosticsProperty<TextStyle>('subtitle', subtitle));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FCardContentStyle &&
    runtimeType == other.runtimeType &&
    padding == other.padding &&
    title == other.title &&
    subtitle == other.subtitle;

  @override
  int get hashCode => padding.hashCode ^ title.hashCode ^ subtitle.hashCode;

}
