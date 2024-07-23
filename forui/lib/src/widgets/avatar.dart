import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// An image element with a fallback for representing the user.
///
/// Typically used with a user's profile image, or, in the absence of
/// such an image, the user's initials.
///
/// If [image] fails then [placeholder] is used.
class FAvatar extends StatelessWidget {
  /// The style. Defaults to [FThemeData.avatarStyle].
  final FAvatarStyle? style;

  /// The background image of the circle.
  ///
  /// If the [FAvatar] is to have the user's initials, use [placeholder] instead.
  final ImageProvider image;

  /// The fallback widget if [image] cannot be displayed.
  ///
  /// If the avatar is to just have the user's initials, they are typically
  /// provided using a [Text] widget as the [placeholder] with a [FAvatarStyle.backgroundColor]:
  ///
  /// If the [FAvatar] is to have an image, use [image] instead.
  final Widget? placeholder;

  /// Creates an [FAvatar].
  const FAvatar({
    required this.image,
    this.style,
    this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;

    return Container(
      constraints: style.constraints,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: Image(
          image: image,
          errorBuilder: (context, exception, stacktrace) => DefaultTextStyle(
            style: style.text,
            child: placeholder ?? const _Placeholder(),
          ),
          fit: BoxFit.cover,
        ),
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

/// [FAvatar]'s style.
final class FAvatarStyle with Diagnosticable {
  /// The background color.
  final Color backgroundColor;

  /// The box constraints.
  final BoxConstraints constraints;

  /// The text style for the placeholder text.
  final TextStyle text;

  /// Creates a [FAvatarStyle].
  FAvatarStyle({
    required this.backgroundColor,
    required this.constraints,
    required this.text,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FAvatarStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : backgroundColor = colorScheme.muted,
        constraints = const BoxConstraints(minHeight: 40.0, minWidth: 40.0, maxHeight: 40.0, maxWidth: 40.0),
        text = typography.base.copyWith(
          color: colorScheme.mutedForeground,
          height: 0,
        );

  /// Returns a copy of this [FAvatarStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FAvatarStyle(
  ///   backgroundColor: ...,
  ///   constraints: ...,
  /// );
  ///
  /// final copy = style.copyWith(constraints: ...);
  ///
  /// print(style.backgroundColor == copy.backgroundColor); // true
  /// print(style.constraints == copy.constraints); // false
  /// ```
  @useResult
  FAvatarStyle copyWith({
    Color? backgroundColor,
    BoxConstraints? constraints,
    TextStyle? text,
  }) =>
      FAvatarStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        constraints: constraints ?? this.constraints,
        text: text ?? this.text,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAvatarStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          constraints == other.constraints &&
          text == other.text;

  @override
  int get hashCode => backgroundColor.hashCode ^ constraints.hashCode ^ text.hashCode;
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    final style = context.theme;

    return FAssets.icons.userRound(
      height: style.avatarStyle.constraints.maxHeight / 2,
      colorFilter: ColorFilter.mode(style.colorScheme.mutedForeground, BlendMode.srcIn),
    );
  }
}
