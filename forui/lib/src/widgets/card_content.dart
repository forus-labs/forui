part of 'card.dart';

/// Represents a [FCard]'s content.
@internal final class FCardContent extends StatelessWidget {
  /// The title.
  final String? title;

  /// The subtitle.
  final String? subtitle;

  /// The child.
  final Widget? child;

  /// The style.
  final FCardContentStyle? style;

  /// Creates a [FCardContent].
  const FCardContent({this.title, this.subtitle, this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final font = context.theme.font;
    final style = this.style ?? context.theme.cardStyle.content;
    return Padding(
      padding: style.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: style.title.withFont(font)),
          if (subtitle != null) Text(subtitle!, style: style.subtitle.withFont(font)),
          if (child != null)
            Padding(
              padding: (title == null && subtitle == null) ? const EdgeInsets.only(top: 4) : const EdgeInsets.only(top: 10),
              child: child!,
            ),
        ],
      ),
    );
  }
}

/// [FCardContent]'s style.
final class FCardContentStyle with Diagnosticable {
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

  /// Creates a copy of this [FCardContentStyle] with the given properties replaced.
  FCardContentStyle copyWith({EdgeInsets? padding, TextStyle? title, TextStyle? subtitle}) => FCardContentStyle(
      padding: padding ?? this.padding,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
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
