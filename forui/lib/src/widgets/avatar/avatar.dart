import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/avatar/avatar_content.dart';

part 'avatar.design.dart';

/// An image element with a fallback for representing the user.
///
/// Typically used with a user's profile image. If the image fails to load, the fallback widget is used instead, which
/// usually displays the user's initials.
///
/// If the user's profile has no image, use the fallback property to display the initials using a [Text] widget styled
/// with [FAvatarStyle.backgroundColor].
///
/// See:
/// * https://forui.dev/docs/data/avatar for working examples.
class FAvatar extends StatelessWidget {
  /// The style. Defaults to [FThemeData.avatarStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create accordion
  /// ```
  final FAvatarStyle Function(FAvatarStyle style)? style;

  /// The circle's size. Defaults to 40.
  final double size;

  /// The child, typically an image.
  final Widget child;

  /// Creates an [FAvatar].
  FAvatar({
    required ImageProvider image,
    this.style,
    this.size = 40.0,
    String? semanticsLabel,
    Widget? fallback,
    super.key,
  }) : child = Content(style: style, size: size, image: image, semanticsLabel: semanticsLabel, fallback: fallback);

  /// Creates a [FAvatar] without a fallback.
  FAvatar.raw({Widget? child, this.style, this.size = 40.0, super.key})
    : child = child ?? PlaceholderContent(style: style, size: size);

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.avatarStyle) ?? context.theme.avatarStyle;
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      decoration: BoxDecoration(color: style.backgroundColor, shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: DefaultTextStyle(style: style.textStyle, child: child),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size));
  }
}

/// [FAvatar]'s style.
class FAvatarStyle with Diagnosticable, _$FAvatarStyleFunctions {
  /// The fallback's background color.
  @override
  final Color backgroundColor;

  /// The fallback's color.
  @override
  final Color foregroundColor;

  /// The text style for the fallback text.
  @override
  final TextStyle textStyle;

  /// Duration for the transition animation. Defaults to 500ms.
  @override
  final Duration fadeInDuration;

  /// Creates a [FAvatarStyle].
  const FAvatarStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textStyle,
    this.fadeInDuration = const Duration(milliseconds: 500),
  });

  /// Creates a [FAvatarStyle] that inherits its properties.
  FAvatarStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        backgroundColor: colors.muted,
        foregroundColor: colors.mutedForeground,
        textStyle: typography.base.copyWith(color: colors.mutedForeground, height: 0),
      );
}
