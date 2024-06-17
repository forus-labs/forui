part of 'tabs.dart';

final class FTabContent extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? child;
  final FTabContentStyle? style;

  const FTabContent(
      {this.title, this.subtitle, this.child, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final font = context.theme.font;
    final style = this.style ?? context.theme.tabsStyle.content;
    return Container(
      decoration: style.decoration,
      padding: style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: style.title.withFont(font)),
          if (subtitle != null)
            Text(subtitle!, style: style.subtitle.withFont(font)),
          if (child != null)
            Padding(
              padding: (title == null && subtitle == null)
                  ? const EdgeInsets.only(top: 4)
                  : const EdgeInsets.only(top: 10),
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
final class FTabContentStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding.
  final EdgeInsets padding;

  /// The title.
  final TextStyle title;

  /// The subtitle.
  final TextStyle subtitle;

  /// Creates a [FTabContentStyle].
  const FTabContentStyle({
    required this.decoration,
    required this.padding,
    required this.title,
    required this.subtitle,
  });

  /// Creates a [FTabContentStyle] that inherits its properties from [colorScheme] and [font].
  FTabContentStyle.inherit(
      {required FColorScheme colorScheme, required FFont font,required FStyle style})
      : decoration = BoxDecoration(borderRadius: style.borderRadius,border: Border.all(color: colorScheme.border)),
        padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
        title = TextStyle(
          fontSize: font.base,
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground,
        ),
        subtitle = TextStyle(
          fontSize: font.sm,
          color: colorScheme.mutedForeground,
        );

  /// Creates a copy of this [FCardContentStyle] with the given properties replaced.
  FTabContentStyle copyWith(
          {BoxDecoration? decoration,
          EdgeInsets? padding,
          TextStyle? title,
          TextStyle? subtitle}) =>
      FTabContentStyle(
        decoration: decoration ?? this.decoration,
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
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty<BoxDecoration>('decoration', decoration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTabContentStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          title == other.title &&
          subtitle == other.subtitle;

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      title.hashCode ^
      subtitle.hashCode;
}
