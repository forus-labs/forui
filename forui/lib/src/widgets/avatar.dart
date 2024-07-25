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

  /// The fallback widget displayed if [image] fails to load.
  ///
  /// Typically used to display the user's initials using a [Text] widget
  /// styled with [FAvatarStyle.backgroundColor].
  ///
  /// Use [image] to display an image; use [placeholderBuilder] for initials.
  final Widget Function(BuildContext, FAvatarStyle) placeholderBuilder;

  /// Creates an [FAvatar].
  FAvatar({
    required ImageProvider image,
    Widget? placeholder,
    this.size = 40.0,
    this.style,
    super.key,
  }) : placeholderBuilder = ((context, style) => _AvatarContent(
              style: style,
              size: size,
              image: image,
              placeholder: placeholder,
            ));

  /// Creates a [FAvatar] with custom child.
  FAvatar.raw({
    Widget? child,
    this.size = 40.0,
    this.style,
    super.key,
  }) : placeholderBuilder = ((context, style) =>
            child ??
            _IconPlaceholder(
              style: style,
              size: size,
            ));

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
      child: Center(
        child: DefaultTextStyle(
          style: style.text,
          child: placeholderBuilder(context, style),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('placeholderBuilder', placeholderBuilder));
  }
}

/// [FAvatar]'s style.
final class FAvatarStyle with Diagnosticable {
  /// The placeholder's background color.
  final Color backgroundColor;

  /// The placeholder's color.
  final Color foregroundColor;

  /// Duration for the transition animation.
  final Duration fadeInDuration;

  /// The text style for the placeholder text.
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

class _AvatarContent extends StatelessWidget {
  final FAvatarStyle? style;

  /// The circle's size.
  final double size;

  /// The profile image displayed within the circle.
  ///
  /// If the user's initials are used, use [placeholder] instead.
  final ImageProvider image;

  /// The fallback widget displayed if [image] fails to load.
  ///
  /// Typically used to display the user's initials using a [Text] widget
  /// styled with [FAvatarStyle.backgroundColor].
  final Widget? placeholder;

  const _AvatarContent({
    required this.style,
    required this.size,
    required this.image,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;

    final placeholder = this.placeholder ?? _IconPlaceholder(style: style, size: size);

    return Image(
      filterQuality: FilterQuality.medium,
      image: image,
      errorBuilder: (context, exception, stacktrace) => placeholder,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: frame == null ? placeholder : child,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return placeholder;
      },
      fit: BoxFit.cover,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('image', image));
  }
}

class _IconPlaceholder extends StatelessWidget {
  final double size;
  final FAvatarStyle? style;

  const _IconPlaceholder({required this.size, this.style});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;
    return FAssets.icons.userRound(
      height: size / 2,
      colorFilter: ColorFilter.mode(style.foregroundColor, BlendMode.srcIn),
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
