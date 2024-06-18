part of 'card.dart';

@internal final class FCardContent extends StatelessWidget {
  final String? title;
  final Widget? rawTitle;
  final String? subtitle;
  final Widget? rawSubtitle;
  final Widget? child;
  final FCardContentStyle? style;

  const FCardContent({
    this.title,
    this.rawTitle,
    this.subtitle,
    this.rawSubtitle,
    this.child, 
    this.style, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final style = this.style ?? context.theme.cardStyle.content;
    
    final title = switch ((this.title, rawTitle)) {
      (final String title, _) => Text(title),
      (_, final Widget title) => title,
      _ => null,
    };
    
    final subtitle = switch ((this.subtitle, rawSubtitle)) {
      (final String subtitle, _) => Text(subtitle),
      (_, final Widget subtitle) => subtitle,
      _ => null,
    };
    
    return Padding(
      padding: style.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            DefaultTextStyle.merge(
              style: style.title.scale(typography), 
              child: title,
            ),
          
          if (subtitle != null)
            DefaultTextStyle.merge(
              style: style.subtitle.scale(typography), 
              child: subtitle,
            ),

          if (child != null)
            Padding(
              padding: (title == null && subtitle == null) ? const EdgeInsets.only(top: 4) : const EdgeInsets.only(top: 10),
              child: child!,
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// A card content's style.
final class FCardContentStyle with Diagnosticable {

  /// The padding.
  final EdgeInsets padding;

  /// The title.
  final TextStyle title;

  /// The subtitle.
  final TextStyle subtitle;

  /// Creates a [FCardContentStyle].
  const FCardContentStyle({required this.padding, required this.title, required this.subtitle});

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme] and [typography].
  FCardContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography}):
    padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
    title = TextStyle(
      fontSize: typography.base,
      fontWeight: FontWeight.w600,
      color: colorScheme.foreground,
    ),
    subtitle = TextStyle(
      fontSize: typography.sm,
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
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('subtitle', subtitle));
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
