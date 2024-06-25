part of 'card.dart';

@internal
final class FCardContent extends StatelessWidget {
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
              style: style.titleTextStyle,
              child: title,
            ),
          if (subtitle != null)
            DefaultTextStyle.merge(
              style: style.subtitleTextStyle,
              child: subtitle,
            ),
          if (child != null)
            Padding(
              padding:
                  (title == null && subtitle == null) ? const EdgeInsets.only(top: 4) : const EdgeInsets.only(top: 10),
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
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  final TextStyle subtitleTextStyle;

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 16)`.
  final EdgeInsets padding;

  /// Creates a [FCardContentStyle].
  const FCardContentStyle({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
  });

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme] and [typography].
  FCardContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : titleTextStyle = typography.xl2.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground,
        ),
        subtitleTextStyle = typography.sm.copyWith(color: colorScheme.mutedForeground),
        padding = const EdgeInsets.fromLTRB(16, 12, 16, 16);

  /// Returns a copy of this [FCardContentStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FCardContentStyle(
  ///   titleTextStyle: ...,
  ///   subtitleTextStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(titleTextStyle: ...);
  ///
  /// print(style.titleTextStyle == copy.titleTextStyle); // true
  /// print(style.subtitleTextStyle == copy.subtitleTextStyle); // false
  /// ```
  FCardContentStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    EdgeInsets? padding,
  }) =>
      FCardContentStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', titleTextStyle))
      ..add(DiagnosticsProperty('subtitle', subtitleTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCardContentStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle &&
          padding == other.padding;

  @override
  int get hashCode => titleTextStyle.hashCode ^ subtitleTextStyle.hashCode ^ padding.hashCode;
}
