part of 'avatar.dart';

class _AvatarContent extends StatelessWidget {
  final FAvatarStyle? style;
  final double size;
  final ImageProvider image;
  final String? semanticLabel;
  final Widget? fallback;

  const _AvatarContent({
    required this.style,
    required this.size,
    required this.image,
    required this.semanticLabel,
    required this.fallback,
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
      semanticLabel: semanticLabel,
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
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty('image', image))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty('fallback', fallback));
  }
}

class _Placeholder extends StatelessWidget {
  final FAvatarStyle? style;
  final double size;

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
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size));
  }
}
