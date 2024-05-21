part of 'card.dart';

/// Represents a content for [FCard].
final class FCardContent extends StatelessWidget {
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
    final style = this.style ?? FTheme.of(context).cardStyle.content;

    return Padding(
      padding: style.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: style.title),
          if (subtitle != null) Text(subtitle!, style: style.subtitle),
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
