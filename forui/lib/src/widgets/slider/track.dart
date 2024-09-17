import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/slider/inherited_data.dart';

@internal
class Track extends StatelessWidget {
  const Track({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout) = InheritedData.of(context);
    final controller = InheritedController.of(context);
    final position = layout.position;

    final crossAxisExtent = max(style.thumbStyle.dimension, style.crossAxisExtent);
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _GestureDetector(),
          if (controller.extendable.min)
            position(
              offset: controller.selection.offset.min * controller.selection.rawExtent.total,
              child: const Thumb(min: true),
            ),
          if (controller.extendable.max)
            position(
              offset: controller.selection.offset.max * controller.selection.rawExtent.total,
              child: const Thumb(min: false),
            ),
        ],
      ),
    );
  }
}

class _GestureDetector extends StatefulWidget {
  const _GestureDetector();

  @override
  State<_GestureDetector> createState() => _GestureDetectorState();
}

class _GestureDetectorState extends State<_GestureDetector> {
  static const tappable = {FSliderInteraction.tap, FSliderInteraction.tapAndSlideThumb};

  ({double min, double max})? _origin;
  Offset? _pointerOrigin;

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :enabled, :semanticFormatterCallback) = InheritedData.of(context);
    final controller = InheritedController.of(context);

    final track = Semantics(
      slider: true,
      enabled: enabled,
      value: semanticFormatterCallback(controller.selection),
      child: const _Track(),
    );

    if (!enabled) {
      return track;
    }

    if (tappable.contains(controller.allowedInteraction)) {
      return GestureDetector(
        onTapDown: _tap(controller, style, layout),
        onTapUp: (_) => controller.tooltips.hide(),
        onTapCancel: controller.tooltips.hide,
        child: track,
      );
    }

    void start(DragStartDetails details) {
      _origin = controller.selection.rawOffset;
      _pointerOrigin = details.localPosition;
      controller.tooltips.show();
    }

    void end(DragEndDetails details) {
      _origin = null;
      _pointerOrigin = null;
      controller.tooltips.hide();
    }

    if (layout.vertical) {
      return GestureDetector(
        onTapDown: _tap(controller, style, layout),
        onTapUp: (_) => controller.tooltips.hide(),
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(controller, style, layout),
        onVerticalDragEnd: end,
        child: track,
      );
    } else {
      return GestureDetector(
        onTapDown: _tap(controller, style, layout),
        onTapUp: (_) => controller.tooltips.hide(),
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(controller, style, layout),
        onHorizontalDragEnd: end,
        child: track,
      );
    }
  }

  GestureTapDownCallback? _tap(FSliderController controller, FSliderStyle style, Layout layout) {
    final translate = layout.translateTrackTap(controller.selection.rawExtent.total, style);

    void down(TapDownDetails details) {
      final offset = switch (translate(details.localPosition)) {
        < 0 => 0.0,
        final translated when controller.selection.rawExtent.total < translated => controller.selection.rawExtent.total,
        final translated => translated,
      };

      controller.tap(offset);
    }

    return tappable.contains(controller.allowedInteraction) ? down : null;
  }

  GestureDragUpdateCallback? _drag(FSliderController controller, FSliderStyle style, Layout layout) {
    if (controller.allowedInteraction != FSliderInteraction.slide) {
      return null;
    }

    assert(
      controller.extendable.min ^ controller.extendable.max,
      'Slider must be extendable at one edge when ${controller.allowedInteraction}.',
    );

    final translate = layout.translateTrackDrag(style);

    void drag(DragUpdateDetails details) {
      final origin = controller.extendable.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition - _pointerOrigin!), min: controller.extendable.min);
    }

    return drag;
  }
}

class _Track extends StatelessWidget {
  const _Track();

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :marks, :enabled) = InheritedData.of(context);
    final FSliderStyle(:inactiveColor, :borderRadius, :crossAxisExtent, :markStyle, :thumbStyle) = style;

    final extent = InheritedController.of(context, InheritedController.rawExtent).selection.rawExtent.total;

    final position = layout.position;
    final half = thumbStyle.dimension / 2;
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    return DecoratedBox(
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
            for (var FSliderMark(:style, :value, :tick) in marks)
              if (tick)
                position(
                  offset: value * extent + half - ((style ??= markStyle).tickDimension / 2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: style.tickColor,
                    ),
                    child: SizedBox.square(
                      dimension: style.tickDimension,
                    ),
                  ),
                ),
            const _ActiveTrack(),
          ],
        ),
      ),
    );
  }
}

class _ActiveTrack extends StatelessWidget {
  const _ActiveTrack();

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout) = InheritedData.of(context);
    final FSliderStyle(:activeColor, :borderRadius, :crossAxisExtent, :thumbStyle) = style;
    final rawOffset = InheritedController.of(context, InheritedController.rawOffset).selection.rawOffset;

    final mainAxisExtent = rawOffset.max - rawOffset.min + thumbStyle.dimension / 2;
    final (height, width) = layout.vertical ? (mainAxisExtent, crossAxisExtent) : (crossAxisExtent, mainAxisExtent);

    return layout.position(
      offset: rawOffset.min,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: activeColor,
        ),
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
    );
  }
}

@internal
extension Layouts on Layout {
  double Function(Offset) translateTrackTap(double extent, FSliderStyle style) => switch (this) {
        Layout.ltr => (offset) => offset.dx - style.thumbStyle.dimension / 2,
        Layout.rtl => (offset) => extent - offset.dx + style.thumbStyle.dimension / 2,
        Layout.ttb => (offset) => offset.dy - style.thumbStyle.dimension / 2,
        Layout.btt => (offset) => extent - offset.dy + style.thumbStyle.dimension / 2,
      };

  double Function(Offset) translateTrackDrag(FSliderStyle style) => switch (this) {
        Layout.ltr => (delta) => delta.dx - style.thumbStyle.dimension / 2,
        Layout.rtl => (delta) => -delta.dx,
        Layout.ttb => (delta) => delta.dy - style.thumbStyle.dimension / 2,
        Layout.btt => (delta) => -delta.dy,
      };

  Positioned Function({required double offset, required Widget child}) get position => switch (this) {
        Layout.ltr => ({required offset, required child}) => Positioned(left: offset, child: child),
        Layout.rtl => ({required offset, required child}) => Positioned(right: offset, child: child),
        Layout.ttb => ({required offset, required child}) => Positioned(top: offset, child: child),
        Layout.btt => ({required offset, required child}) => Positioned(bottom: offset, child: child),
      };
}
