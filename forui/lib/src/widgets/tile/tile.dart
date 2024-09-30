import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:meta/meta.dart';

class FTile extends StatelessWidget {
  /// The tile's style. Defaults to the ancestor tile group's style if present, and [FThemeData.tileStyle] otherwise.
  ///
  /// Provide a style to prevent inheriting from the ancestor tile group's style.
  final FTileStyle? style;

  /// The builder for the tile's content.
  final ValueWidgetBuilder<FTileStyle> builder;

  /// A callback for when the tile is pressed.
  final VoidCallback? onPress;

  /// A callback for when the tile is long pressed.
  final VoidCallback? onLongPress;

  /// Creates a [FTile].
  FTile({
    required Widget title,
    this.style,
    this.onPress,
    this.onLongPress,
    Widget? prefix,
    Widget? subtitle,
    Widget? suffix,
    super.key,
  }) : builder = ((context, style, _) => FTileContent(
              style: style.content,
              prefix: prefix,
              title: title,
              subtitle: subtitle,
              suffix: suffix,
            ));

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.tileStyle; // TODO: inherit from tile group.
    final enabled = onPress != null || onLongPress != null;

    return FTappable(
      behavior: HitTestBehavior.translucent,
      onPress: onPress,
      onLongPress: onLongPress,
      shortPressDelay: Duration.zero,
      builder: (context, state, child) => DecoratedBox(
        decoration: switch (enabled && (state.hovered || state.shortPressed)) {
          true => style.enabledHoverDecoration,
          false => style.enabledDecoration,
        },
        child: child,
      ),
      child: Padding(
        padding: style.padding,
        child: builder(context, style, null),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

@internal
class FTileContent extends StatelessWidget {
  final FTileContentStyle style;
  final Widget? prefix;
  final Widget title;
  final Widget? subtitle;
  final Widget? suffix;

  const FTileContent({
    required this.style,
    required this.title,
    this.prefix,
    this.subtitle,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          if (prefix case final prefix?)
            Padding(
              padding: style.prefixPadding,
              child: prefix,
            ),
          Padding(
            padding: style.titlePadding,
            child: DefaultTextStyle.merge(
              style: style.titleTextStyle,
              overflow: TextOverflow.ellipsis,
              child: title,
            ),
          ),
          const Spacer(),
          if (subtitle case final subtitle?)
            Padding(
              padding: style.subtitlePadding,
              child: DefaultTextStyle.merge(
                style: style.subtitleTextStyle,
                overflow: TextOverflow.ellipsis,
                child: subtitle,
              ),
            ),
          if (suffix case final suffix?)
            Padding(
              padding: style.suffixPadding,
              child: suffix,
            ),
        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTile]'s style.
final class FTileStyle with Diagnosticable {
  /// The box decoration for an enabled tile.
  final BoxDecoration enabledDecoration;

  /// Th box decoration for an enabled tile when hovered.
  final BoxDecoration enabledHoverDecoration;

  // TODO: disabled decoration

  /// The padding surrounding the tile's content.
  final EdgeInsets padding;

  /// The default tile content's style.
  final FTileContentStyle content;

  /// Creates a [FTileStyle].
  FTileStyle({
    required this.enabledDecoration,
    required this.enabledHoverDecoration,
    required this.padding,
    required this.content,
  });

  /// Creates a [FTileStyle] that inherits from the given [colorScheme] and [typography].
  FTileStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          enabledDecoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
            border: Border.all(
              color: colorScheme.border,
            ),
          ),
          enabledHoverDecoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: style.borderRadius,
            border: Border.all(
              color: colorScheme.border,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          content: FTileContentStyle.inherit(colorScheme: colorScheme, typography: typography),
        );

  /// Returns a copy of this [FTileStyle] with the given fields replaced with the new values.
  @useResult
  FTileStyle copyWith({
    BoxDecoration? enabledDecoration,
    BoxDecoration? enabledHoverDecoration,
    EdgeInsets? padding,
    FTileContentStyle? content,
  }) =>
      FTileStyle(
        enabledDecoration: enabledDecoration ?? this.enabledDecoration,
        enabledHoverDecoration: enabledHoverDecoration ?? this.enabledHoverDecoration,
        padding: padding ?? this.padding,
        content: content ?? this.content,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledDecoration', enabledDecoration))
      ..add(DiagnosticsProperty('enabledHoverDecoration', enabledHoverDecoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTileStyle &&
          runtimeType == other.runtimeType &&
          enabledDecoration == other.enabledDecoration &&
          enabledHoverDecoration == other.enabledHoverDecoration &&
          padding == other.padding &&
          content == other.content;

  @override
  int get hashCode =>
      enabledDecoration.hashCode ^ enabledHoverDecoration.hashCode ^ padding.hashCode ^ content.hashCode;
}

/// A [FTile] content's style.
final class FTileContentStyle with Diagnosticable {
  /// The prefix widget's padding.
  final EdgeInsets prefixPadding;

  /// The title's padding.
  final EdgeInsets titlePadding;

  /// The subtitle's padding.
  final EdgeInsets subtitlePadding;

  /// The suffix widget's padding.
  final EdgeInsets suffixPadding;

  /// The title's text style.
  final TextStyle titleTextStyle;

  /// The subtitle's text style.
  final TextStyle subtitleTextStyle;

  /// Creates a [FTileContentStyle].
  FTileContentStyle({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.prefixPadding = const EdgeInsets.only(left: 5, right: 10),
    this.titlePadding = EdgeInsets.zero,
    this.subtitlePadding = EdgeInsets.zero,
    this.suffixPadding = const EdgeInsets.only(left: 10),
  });

  /// Creates a [FTileContentStyle] that inherits from the given [colorScheme] and [typography].
  FTileContentStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          titleTextStyle: typography.base,
          subtitleTextStyle: typography.base.copyWith(color: colorScheme.mutedForeground),
        );

  /// Returns a copy of this [FTileContentStyle] with the given fields replaced with the new values.
  @useResult
  FTileContentStyle copyWith({
    EdgeInsets? prefixPadding,
    EdgeInsets? titlePadding,
    EdgeInsets? subtitlePadding,
    EdgeInsets? suffixPadding,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) =>
      FTileContentStyle(
        prefixPadding: prefixPadding ?? this.prefixPadding,
        titlePadding: titlePadding ?? this.titlePadding,
        subtitlePadding: subtitlePadding ?? this.subtitlePadding,
        suffixPadding: suffixPadding ?? this.suffixPadding,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('prefixPadding', prefixPadding))
      ..add(DiagnosticsProperty('titlePadding', titlePadding))
      ..add(DiagnosticsProperty('subtitlePadding', subtitlePadding))
      ..add(DiagnosticsProperty('suffixPadding', suffixPadding))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTileContentStyle &&
          runtimeType == other.runtimeType &&
          prefixPadding == other.prefixPadding &&
          titlePadding == other.titlePadding &&
          subtitlePadding == other.subtitlePadding &&
          suffixPadding == other.suffixPadding &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle;

  @override
  int get hashCode =>
      prefixPadding.hashCode ^
      titlePadding.hashCode ^
      subtitlePadding.hashCode ^
      suffixPadding.hashCode ^
      titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode;
}
