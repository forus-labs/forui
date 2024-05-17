part of 'card.dart';

/// Represents a content for [FCard].
final class FCardContent extends StatelessWidget {
  /// The title.
  final String? title;

  /// The subtitle.
  final String? subtitle;

  /// The child.
  final Widget? content;

  /// The style.
  final FCardContentStyle? style;

  /// Creates a [FCardContent].
  const FCardContent({this.title, this.subtitle, this.content, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).widgets.card.content;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: style.title),
          if (subtitle != null) Text(subtitle!, style: style.subtitle),
          if (content != null)
            Padding(
              padding: (title != null || subtitle != null) ? const EdgeInsets.only(top: 10) : const EdgeInsets.only(top: 4),
              child: content!,
            ),
        ],
      ),
    );
  }
}
