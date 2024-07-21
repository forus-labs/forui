import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// An image element with a fallback for representing the user.
///
/// Typically used with a user's profile image, or, in the absence of
/// such an image, the user's initials. A given user's initials should
/// always be paired with the same background color, for consistency.
///
/// If [backgroundImage] fails then [FAvatarStyle.backgroundColor] is used.
///
/// The [onBackgroundImageError] parameter must be null if the [backgroundImage]
/// is null.
///
class FAvatar extends StatelessWidget {
  /// The style. Defaults to [FThemeData.avatarStyle].
  final FAvatarStyle? style;

  /// The background image of the circle. Changing the background
  /// image will cause the avatar to animate to the new image.
  ///
  /// If the [FAvatar] is to have the user's initials, use [child] instead.
  final ImageProvider? backgroundImage;

  /// An optional error callback for errors emitted when loading
  /// [backgroundImage].
  final ImageErrorListener? onBackgroundImageError;

  /// The widget below this widget in the tree.
  ///
  /// If the avatar is to just have the user's initials, they are typically
  /// provided using a [Text] widget as the [child] and a [backgroundColor]:
  ///
  /// If the [FAvatar] is to have an image, use [backgroundImage] instead.
  final Widget? child;

  /// Creates an [FAvatar].
  const FAvatar({
    super.key,
    this.style,
    this.backgroundImage,
    this.onBackgroundImageError,
    this.child,
  }) : assert(
          backgroundImage != null || onBackgroundImageError == null,
          'The [onBackgroundImageError] parameter must be null if the [backgroundImage] is null.',
        );

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;

    return AnimatedContainer(
      constraints: style.constraints,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                onError: onBackgroundImageError,
                fit: BoxFit.cover,
              )
            : null,
        shape: BoxShape.circle,
      ),
      child: child == null
          ? null
          : Center(
              // Need to disable text scaling here so that the text doesn't
              // escape the avatar when the textScaleFactor is large.
              child: MediaQuery.withNoTextScaling(
                child: DefaultTextStyle(
                  style: style.text,
                  child: child!,
                ),
              ),
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('backgroundImage', backgroundImage))
      ..add(ObjectFlagProperty<ImageErrorListener?>.has('onBackgroundImageError', onBackgroundImageError));
  }
}

/// [FAvatar]'s style.
final class FAvatarStyle with Diagnosticable {
  /// The background color.
  final Color backgroundColor;

  /// The box constraints.
  final BoxConstraints constraints;

  /// The text style for the
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
        text = typography.base.copyWith(color: colorScheme.mutedForeground);

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
