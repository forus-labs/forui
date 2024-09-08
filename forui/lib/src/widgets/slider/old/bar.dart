import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/old/slider.dart';
import 'package:meta/meta.dart';

@internal
class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:controller, :style, :layout, :enabled) = InheritedData.of(context);
    final FSliderStyle(:activeColor, :inactiveColor, :borderRadius, :crossAxisExtent, :markStyles, :thumbStyle) = style;
    final markStyle = layout.vertical ? markStyles.vertical : markStyles.horizontal;
    final (height, width) = layout.vertical ? (crossAxisExtent, null) : (null, crossAxisExtent);

    // We use the thumb style's dimension as the bar's padding.
    final half = thumbStyle.dimension / 2;
    final position = layout.position;

    Widget bar = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: inactiveColor,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (final FSliderMark(:style, offset:percentage, :visible) in controller.marks)
              if (visible)
                position(
                  offset: percentage * controller.data.rawExtent.total + half - ((style ?? markStyle).dimension / 2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (style ?? markStyle).color,
                    ),
                    child: SizedBox.square(
                      dimension: (style ?? markStyle).dimension,
                    ),
                  ),
                ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: activeColor,
              ),
              child: ListenableBuilder(
                listenable: controller,
                builder: layout.vertical
                    ? (_, __) => position(
                          offset: controller.data.offset.min,
                          child: SizedBox(
                            height: controller.data.rawExtent.current + half,
                            width: crossAxisExtent,
                          ),
                        )
                    : (_, __) => position(
                          offset: controller.data.offset.min,
                          child: SizedBox(
                            height: crossAxisExtent,
                            width: controller.data.rawExtent.current + half,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );

    if (enabled) {
      const tappable = {FSliderInteraction.tap, FSliderInteraction.tapAndSlideThumb};
      final (horizontal, vertical) = _gestures(controller, layout);
      bar = GestureDetector(
        onTapDown: tappable.contains(controller.allowedInteraction)
            ? (details) => controller.tap(
                  switch (layout.translate(details.localPosition)) {
                    < 0 => 0,
                    final translated when controller.data.rawExtent.total < translated => controller.data.rawExtent.total,
                    final translated => translated,
                  },
                )
            : null,
        onHorizontalDragUpdate: horizontal,
        onVerticalDragUpdate: vertical,
        child: bar,
      );
    }

    return bar;
  }

  (GestureDragUpdateCallback?, GestureDragUpdateCallback?) _gestures(FSliderController controller, Layout layout) {
    if (controller.allowedInteraction != FSliderInteraction.slide) {
      return (null, null);
    }

    assert(
      !(controller.growable.min && controller.growable.max),
      'Slider cannot be growable at both edges when the allowed interaction is ${controller.allowedInteraction}.',
    );

    return switch (layout) {
      Layout.ltr => ((details) => controller.slide(details.delta.dx, min: controller.growable.min), null),
      Layout.rtl => ((details) => controller.slide(-details.delta.dx, min: controller.growable.min), null),
      Layout.ttb => (null, (details) => controller.slide(details.delta.dy, min: controller.growable.min)),
      Layout.btt => (null, (details) => controller.slide(-details.delta.dy, min: controller.growable.min)),
    };
  }
}

extension on Layout {
  Positioned Function({required double offset, required Widget child}) get position => switch (this) {
        Layout.ltr => ({required offset, required child}) => Positioned(left: offset, child: child),
        Layout.rtl => ({required offset, required child}) => Positioned(right: offset, child: child),
        Layout.ttb => ({required offset, required child}) => Positioned(top: offset, child: child),
        Layout.btt => ({required offset, required child}) => Positioned(bottom: offset, child: child),
      };
}
