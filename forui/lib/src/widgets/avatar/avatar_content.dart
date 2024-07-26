part of 'avatar.dart';

class _AvatarContent extends StatelessWidget {
  final ImageProvider image;
  final double size;
  final FAvatarStyle? style;
  final Widget? fallback;

  const _AvatarContent({
    required this.image,
    required this.size,
    this.style,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.avatarStyle;

    final fallback = this.fallback ?? _Placeholder(style: style, size: size);

    return Image(
      height: size,
      width: size,
      filterQuality: FilterQuality.medium,
      image: image,
      errorBuilder: (context, exception, stacktrace) => fallback,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: frame == null ? fallback : child,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return fallback;
      },
      fit: BoxFit.cover,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('image', image))
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('style', style));
  }
}

class _Placeholder extends StatelessWidget {
  final double size;
  final FAvatarStyle? style;

  const _Placeholder({required this.size, this.style});

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
