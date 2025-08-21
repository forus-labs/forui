import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class Content extends StatelessWidget {
  final FAvatarStyle Function(FAvatarStyle style)? style;
  final double size;
  final ImageProvider image;
  final String? semanticsLabel;
  final Widget? fallback;

  const Content({
    required this.style,
    required this.size,
    required this.image,
    required this.semanticsLabel,
    required this.fallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = this.fallback ?? PlaceholderContent(style: style, size: size);

    return Image(
      height: size,
      width: size,
      image: image,
      semanticLabel: semanticsLabel,
      errorBuilder: (_, _, _) => fallback,
      frameBuilder: (_, child, frame, wasSynchronouslyLoaded) => wasSynchronouslyLoaded
          ? child
          : AnimatedSwitcher(duration: const Duration(milliseconds: 500), child: frame == null ? fallback : child),
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
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

@internal
class PlaceholderContent extends StatelessWidget {
  final FAvatarStyle Function(FAvatarStyle style)? style;
  final double size;

  const PlaceholderContent({required this.size, this.style, super.key});

  @override
  Widget build(BuildContext context) => Icon(
    FIcons.userRound,
    size: size / 2,
    color: (style?.call(context.theme.avatarStyle) ?? context.theme.avatarStyle).foregroundColor,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('size', size));
  }
}
