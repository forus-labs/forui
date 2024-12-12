import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

@internal
class Content extends StatelessWidget {
  final Widget? image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? child;
  final FCardContentStyle? style;

  const Content({
    this.image,
    this.title,
    this.subtitle,
    this.child,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.cardStyle.contentStyle;

    return Padding(
      padding: style.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            ClipRRect(
              borderRadius: context.theme.style.borderRadius,
              child: image,
            ),
          if ((title != null || subtitle != null || child != null) && image != null) const SizedBox(height: 10),
          if (title != null)
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.titleTextStyle,
              child: title!,
            ),
          if (subtitle != null)
            DefaultTextStyle.merge(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              style: style.subtitleTextStyle,
              child: subtitle!,
            ),
          if (title != null && subtitle != null && image == null) const SizedBox(height: 8),
          if (child != null) child!,
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('image', image));
  }
}

/// [FCard] content's style.
final class FCardContentStyle with Diagnosticable {
  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  final TextStyle subtitleTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(16)`.
  final EdgeInsets padding;

  /// Creates a [FCardContentStyle].
  const FCardContentStyle({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const EdgeInsets.all(16),
  });

  /// Creates a [FCardContentStyle] that inherits its properties from [colorScheme] and [typography].
  FCardContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          titleTextStyle: typography.xl2.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.foreground,
            height: 1.5,
          ),
          subtitleTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
        );

  /// Returns a copy of this [FCardContentStyle] with the given properties replaced.
  @useResult
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
