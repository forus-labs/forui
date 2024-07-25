part of 'avatar.dart';

class _AvatarContent extends StatelessWidget {
  /// The profile image displayed within the circle.
  ///
  /// If the user's initials are used, use [placeholder] instead.
  final ImageProvider image;

  final FAvatarStyle? style;

  /// The circle's size.
  final double size;

  /// The fallback widget displayed if [image] fails to load.
  ///
  /// Typically used to display the user's initials using a [Text] widget
  /// styled with [FAvatarStyle.backgroundColor].
  final Widget? placeholder;

  const _AvatarContent({
    required this.image,
    required this.style,
    required this.size,
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
