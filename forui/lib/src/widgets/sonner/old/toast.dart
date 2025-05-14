import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

@internal
class AnimatedToast extends StatelessWidget {
  final FSonnerStyle style;
  final Offset offset;
  final Alignment alignment;
  final int index;
  final double? dismissing;
  final bool expanded;
  final bool closing;
  final VoidCallback? onClose;
  final Widget child;

  const AnimatedToast({
    required this.style,
    required this.offset,
    required this.alignment,
    required this.index,
    required this.dismissing,
    required this.expanded,
    required this.closing,
    required this.onClose,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext _) => TweenAnimationBuilder(
    tween: Tween(end: index.toDouble()),
    curve: style.curve,
    duration: style.animationDuration,
    builder:
        (_, index, _) => TweenAnimationBuilder(
          tween: Tween(begin: index > 0 ? 1.0 : 0.0, end: closing && dismissing == null ? 0.0 : 1.0),
          curve: style.curve,
          duration: style.animationDuration,
          onEnd: closing ? onClose : null,
          builder:
              (_, transition, _) => TweenAnimationBuilder(
                tween: Tween(end: expanded ? 1.0 : 0.0),
                curve: style.expandingCurve,
                duration: style.expandingDuration,
                builder: (_, expand, _) {
                  final dismissing = this.dismissing ?? 0.0;
                  final nonCollapsingProgress = (1.0 - expand) * transition;
                  var offset = this.offset * (1.0 - transition);

                  // Previous alignment is a shit name. It's supposed to be how to position a collapsed toast relative to the first toast.
                  // when its behind another toast, shift it up based on index
                  final previousAlignment = widget.previousAlignment;
                  offset +=
                      Offset(
                        (widget.collapsedOffset.dx * previousAlignment.x) * nonCollapsingProgress,
                        (widget.collapsedOffset.dy * previousAlignment.y) * nonCollapsingProgress,
                      ) *
                      index;

                  final expandingShift = Offset(
                    previousAlignment.x * (16 * style.scale) * expand,
                    previousAlignment.y * (16 * style.scale) * expand,
                  );

                  offset += expandingShift;

                  // and then add the spacing when its in expanded mode
                  offset +=
                      Offset(
                        (style.expandedSpacing * previousAlignment.x) * expand,
                        (style.expandedSpacing * previousAlignment.y) * expand,
                      ) *
                      index;

                  var fractionalOffset = Offset(alignment.x * (1.0 - transition), alignment.y * (1.0 - transition));

                  fractionalOffset += Offset(dismissing, 0);

                  // when its behind another toast AND is expanded, shift it up based on index and the size of self
                  fractionalOffset += Offset(expand * previousAlignment.x, expand * previousAlignment.y) * index;

                  double opacity = style.expandingOpacity + (1.0 - style.expandingOpacity) * transition;

                  // fade out the toast behind
                  opacity *= pow(style.collapsedOpacity, index * nonCollapsingProgress);
                  opacity *= 1 - dismissing.abs();

                  final scale = 1.0 * pow(style.collapsedScale, index * (1 - expand));

                  return Transform.translate(
                    offset: offset,
                    child: FractionalTranslation(
                      translation: fractionalOffset,
                      child: Opacity(opacity: opacity.clamp(0, 1), child: Transform.scale(scale: scale, child: child)),
                    ),
                  );
                },
              ),
        ),
  );
}
