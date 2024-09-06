import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/slider.dart';
import 'package:meta/meta.dart';

@internal
class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:controller, :style, :layout, :enabled) = InheritedData.of(context);
    final FSliderStyle(:activeColor, :inactiveColor, :borderRadius, :crossAxisExtent, :markStyle, :thumbStyle) = style;
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
            for (final FSliderMark(:style, :percentage, :visible) in controller.marks)
              if (visible)
                position(
                  offset: percentage * controller.data.extent.total + half - ((style ?? markStyle).dimension / 2),
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
                            height: controller.data.extent.current + half,
                            width: crossAxisExtent,
                          ),
                        )
                    : (_, __) => position(
                          offset: controller.data.offset.min,
                          child: SizedBox(
                            height: crossAxisExtent,
                            width: controller.data.extent.current + half,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );

    if (enabled) {
      bar = GestureDetector(
        onTapDown: (details) => controller.tap(
          switch (layout.translate(details.localPosition)) {
            < 0 => 0,
            final translated when controller.data.extent.total < translated => controller.data.extent.total,
            final translated => translated,
          },
        ),
        child: bar,
      );
    }

    return bar;
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
