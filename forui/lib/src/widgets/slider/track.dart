import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/slider/inherited_data.dart';

@internal
class Track extends StatelessWidget {
  const Track({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:controller, :style, :layout, :marks, :enabled) = InheritedData.of(context);
    final FSliderStyle(:activeColor, :inactiveColor, :borderRadius, :crossAxisExtent, :markStyles, :thumbStyle) = style;
    final markStyle = layout.vertical ? markStyles.vertical : markStyles.horizontal;
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    // We use the thumb style's dimension as the bar's padding.
    final half = thumbStyle.dimension / 2;
    final position = layout.position;

    Widget track = DecoratedBox(
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
            for (final FSliderMark(:style, :offset, :tick) in marks)
              if (tick)
                position(
                  offset:
                      offset * controller.selection.rawExtent.total + half - ((style ?? markStyle).tickDimension / 2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (style ?? markStyle).tickColor,
                    ),
                    child: SizedBox.square(
                      dimension: (style ?? markStyle).tickDimension,
                    ),
                  ),
                ),
            ListenableBuilder(
              listenable: controller,
              builder: layout.vertical
                  ? (_, __) => position(
                        offset: controller.selection.rawOffset.min,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: activeColor,
                          ),
                          child: SizedBox(
                            height: controller.selection.rawOffset.max - controller.selection.rawOffset.min + half,
                            width: crossAxisExtent,
                          ),
                        ),
                      )
                  : (_, __) => position(
                        offset: controller.selection.offset.min,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: activeColor,
                          ),
                          child: SizedBox(
                            height: crossAxisExtent,
                            width: controller.selection.rawOffset.max - controller.selection.rawOffset.min + half,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );

    if (enabled) {
      final (horizontal, vertical) = _dragGestures(controller, layout);
      track = GestureDetector(
        onTapDown: _tapGesture(controller, layout),
        onHorizontalDragUpdate: horizontal,
        onVerticalDragUpdate: vertical,
        child: track,
      );
    }

    return track;
  }

  GestureTapDownCallback? _tapGesture(FSliderController controller, Layout layout) {
    if (const {FSliderInteraction.tap, FSliderInteraction.tapAndSlideThumb}.contains(controller.allowedInteraction)) {
      return (details) {
        controller.tap(
          switch (layout.translate(details.localPosition)) {
            < 0 => 0,
            final translated when controller.selection.rawExtent.total < translated =>
            controller.selection.rawExtent.total,
            final translated => translated,
          },
        );
      };
    } else {
      return null;
    }
  }

  (GestureDragUpdateCallback?, GestureDragUpdateCallback?) _dragGestures(FSliderController controller, Layout layout) {
    if (controller.allowedInteraction != FSliderInteraction.slide) {
      return (null, null);
    }

    assert(
    !(controller.extendable.min && controller.extendable.max),
    'Slider cannot be extendable at both edges when the allowed interaction is ${controller.allowedInteraction}.',
    );

    return switch (layout) {
      Layout.ltr => ((details) => controller.slide(details.delta.dx, min: controller.extendable.min), null),
      Layout.rtl => ((details) => controller.slide(-details.delta.dx, min: controller.extendable.min), null),
      Layout.ttb => (null, (details) => controller.slide(details.delta.dy, min: controller.extendable.min)),
      Layout.btt => (null, (details) => controller.slide(-details.delta.dy, min: controller.extendable.min)),
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
