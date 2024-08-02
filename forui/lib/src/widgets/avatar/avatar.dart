import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'avatar_content.dart';

/// An image element with a fallback for representing the user.
///
/// Typically used with a user's profile image. If the image fails to load, the fallback widget is used instead, which
/// usually displays the user's initials.
///
/// If the user's profile has no image, use the fallback property to display the initials using a [Text] widget styled
/// with [FAvatarStyle.backgroundColor].
class FAvatar extends StatelessWidget {
  /// The style. Defaults to [FThemeData.avatarStyle].
  final FAvatarStyle? style;

  /// The circle's size.
  final double size;

  /// The child, typically an image.
  final Widget child;

  /// Creates an [FAvatar].
  FAvatar({
    required ImageProvider image,
    this.style,
    this.size = 40.0,
    String? semanticLabel,
    Widget? fallback,
    super.key,
  }) : child = _AvatarContent(
          style: style,
          size: size,
          image: image,
          semanticLabel: semanticLabel,
          fallback: fallback,
        );

  /// Creates a [FAvatar] without a fallback.
  FAvatar.raw({
    Widget? child,
    this.style,
    this.size = 40.0,
    super.key,
  }) : child = child ?? _Placeholder(style: style, size: size);

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;

    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: DefaultTextStyle(
        style: style.text,
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// [FAvatar]'s style.
final class FAvatarStyle with Diagnosticable {
  /// The fallback's background color.
  final Color backgroundColor;

  /// The fallback's color.
  final Color foregroundColor;

  /// Duration for the transition animation.
  final Duration fadeInDuration;

  /// The text style for the fallback text.
  final TextStyle text;

  /// Creates a [FAvatarStyle].
  const FAvatarStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.fadeInDuration,
    required this.text,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FAvatarStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : backgroundColor = colorScheme.muted,
        foregroundColor = colorScheme.mutedForeground,
        fadeInDuration = const Duration(milliseconds: 500),
        text = typography.base.copyWith(
          color: colorScheme.mutedForeground,
          height: 0,
        );

  /// Returns a copy of this [FAvatarStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FAvatarStyle(
  ///   backgroundColor: ...,
  ///   fadeInDuration: ...,
  /// );
  ///
  /// final copy = style.copyWith(fadeInDuration: ...);
  ///
  /// print(style.backgroundColor == copy.backgroundColor); // true
  /// print(style.fadeInDuration == copy.fadeInDuration); // false
  /// ```
  @useResult
  FAvatarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Duration? fadeInDuration,
    TextStyle? text,
  }) =>
      FAvatarStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
        fadeInDuration: fadeInDuration ?? this.fadeInDuration,
        text: text ?? this.text,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAvatarStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          fadeInDuration == other.fadeInDuration &&
          text == other.text;

  @override
  int get hashCode => backgroundColor.hashCode ^ foregroundColor.hashCode ^ fadeInDuration.hashCode ^ text.hashCode;
}
