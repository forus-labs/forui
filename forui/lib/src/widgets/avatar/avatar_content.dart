import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

@internal
final class Content extends StatelessWidget {
  final FAvatarStyle? style;
  final double size;
  final ImageProvider image;
  final String? semanticLabel;
  final Widget? fallback;

  const Content({
    required this.style,
    required this.size,
    required this.image,
    required this.semanticLabel,
    required this.fallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = this.fallback ?? PlaceholderContent(style: style ?? context.theme.avatarStyle, size: size);

    return Image(
      height: size,
      width: size,
      image: image,
      semanticLabel: semanticLabel,
      errorBuilder: (_, _, _) => fallback,
      frameBuilder:
          (_, child, frame, wasSynchronouslyLoaded) =>
              wasSynchronouslyLoaded
                  ? child
                  : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: frame == null ? fallback : child,
                  ),
      loadingBuilder: (_, child, loadingProgress) => loadingProgress == null ? child : fallback,
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
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

@internal
final class PlaceholderContent extends StatelessWidget {
  final FAvatarStyle? style;
  final double size;

  const PlaceholderContent({required this.size, this.style, super.key});

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
