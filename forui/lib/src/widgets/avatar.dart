import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// An image element with a fallback for representing the user.
///
/// use image property to provide a profile image displayed within the circle.
/// Typically used with a user's profile image. If the image fails to load,
/// the placeholderBuilder property is used instead, which usually displays the user's initials.
///
/// If the user's profile has no image, use the placeholderBuilder property to provide
/// the initials using a [Text] widget styled with [FAvatarStyle.backgroundColor].
class FAvatar extends StatelessWidget {
  /// The style. Defaults to [FThemeData.avatarStyle].
  final FAvatarStyle? style;

  /// The circle's size.
  final double size;

  /// The child.
  final Widget child;

  /// Creates an [FAvatar].
  FAvatar({
    required ImageProvider image,
    Widget Function(BuildContext)? placeholderBuilder,
    this.size = 40.0,
    this.style,
    super.key,
  }) : child = _Avatar(
          style: style,
          size: size,
          image: image,
          placeholderBuilder: placeholderBuilder,
        );

  /// Creates a [FAvatar] with custom child.
  const FAvatar.raw({
    required this.child,
    this.size = 40.0,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
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
  /// The placeholder's background color.
  final Color backgroundColor;

  /// Duration for the transition animation.
  final Duration fadeInDuration;

  /// The text style for the placeholder text.
  final TextStyle text;

  /// Creates a [FAvatarStyle].
  const FAvatarStyle({
    required this.backgroundColor,
    required this.fadeInDuration,
    required this.text,
  });

  /// Creates a [FCardStyle] that inherits its properties from [colorScheme] and [typography].
  FAvatarStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : backgroundColor = colorScheme.muted,
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
    Duration? fadeInDuration,
    TextStyle? text,
  }) =>
      FAvatarStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        fadeInDuration: fadeInDuration ?? this.fadeInDuration,
        text: text ?? this.text,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAvatarStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          fadeInDuration == other.fadeInDuration &&
          text == other.text;

  @override
  int get hashCode => backgroundColor.hashCode ^ fadeInDuration.hashCode ^ text.hashCode;
}

class _Avatar extends StatelessWidget {
  final FAvatarStyle? style;

  /// The circle's size.
  final double size;

  /// The profile image displayed within the circle.
  ///
  /// If the user's initials are used, use [placeholderBuilder] instead.
  final ImageProvider image;

  /// The fallback widget displayed if [image] fails to load.
  ///
  /// Typically used to display the user's initials using a [Text] widget
  /// styled with [FAvatarStyle.backgroundColor].
  ///
  /// Use [image] to display an image; use [placeholderBuilder] for initials.
  final Widget Function(BuildContext)? placeholderBuilder;

  const _Avatar({
    required this.style,
    required this.size,
    required this.image,
    required this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;
    return Center(
      child: Image(
        filterQuality: FilterQuality.medium,
        image: image,
        errorBuilder: (context, exception, stacktrace) => DefaultTextStyle(
          style: style.text,
          child: placeholderBuilder != null ? placeholderBuilder!(context) : _Placeholder(size: size),
        ),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame == null
                ? DefaultTextStyle(
                    style: style.text,
                    child: placeholderBuilder != null ? placeholderBuilder!(context) : _Placeholder(size: size),
                  )
                : child,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return DefaultTextStyle(
            style: style.text,
            child: placeholderBuilder != null ? placeholderBuilder!(context) : _Placeholder(size: size),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('placeholderBuilder', placeholderBuilder))
      ..add(DiagnosticsProperty('image', image))
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('style', style));
  }
}

class _Placeholder extends StatelessWidget {
  final double size;

  const _Placeholder({required this.size});

  @override
  Widget build(BuildContext context) {
    final style = context.theme;

    return FAssets.icons.userRound(
      height: size / 2,
      colorFilter: ColorFilter.mode(style.colorScheme.mutedForeground, BlendMode.srcIn),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('size', size));
  }
}
