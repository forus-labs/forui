import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/inherited_state.dart';
import 'package:forui/src/widgets/slider/thumb.dart';

@internal
class Track extends StatelessWidget {
  const Track({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :semanticFormatterCallback) = .of(context);
    final controller = InheritedController.of(context).controller;
    final position = layout.position;

    final crossAxisExtent = max(style.thumbSize, style.crossAxisExtent);
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    return SizedBox(
      height: height,
      width: width,
      child: Semantics(
        container: true,
        slider: true,
        enabled: true,
        value: semanticFormatterCallback(controller.value),
        child: Stack(
          alignment: .center,
          children: [
            const _GestureDetector(),
            if (controller.active.min)
              position(
                offset: controller.value.min * controller.value.pixelConstraints.extent,
                child: const Thumb(min: true),
              ),
            if (controller.active.max)
              position(
                offset: controller.value.max * controller.value.pixelConstraints.extent,
                child: const Thumb(min: false),
              ),
          ],
        ),
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
  static const Set<FSliderInteraction> tappable = {.tap, .tapAndSlideThumb};

  ({double min, double max})? _origin;
  Offset? _pointerOrigin;

  @override
  Widget build(BuildContext context) {
    final InheritedController(:controller, :minTooltipController, :maxTooltipController) = .of(context);
    final InheritedData(:style, :layout, :trackHitRegionCrossExtent, :enabled) = .of(context);

    Widget track = const Center(child: _Track());

    if (!enabled) {
      return track;
    }

    if (FTouch.primary || trackHitRegionCrossExtent != null) {
      final crossAxisExtent = trackHitRegionCrossExtent ?? max(style.thumbSize, style.crossAxisExtent);
      final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

      track = Container(height: height, width: width, color: const Color(0x00000000), child: track);
    }

    void start(DragStartDetails details) {
      _origin = controller.value.pixels;
      _pointerOrigin = details.localPosition;
      minTooltipController?.show();
      maxTooltipController?.show();
    }

    void end(DragEndDetails _) {
      _origin = null;
      _pointerOrigin = null;
      minTooltipController?.hide();
      maxTooltipController?.hide();
    }

    if (layout.vertical) {
      return GestureDetector(
        onTapDown: _tap(controller, minTooltipController, maxTooltipController, style.thumbSize, layout),
        onTapUp: (_) {
          minTooltipController?.hide();
          maxTooltipController?.hide();
        },
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(controller, layout),
        onVerticalDragEnd: end,
        child: track,
      );
    } else {
      return GestureDetector(
        onTapDown: _tap(controller, minTooltipController, maxTooltipController, style.thumbSize, layout),
        onTapUp: (_) {
          minTooltipController?.hide();
          maxTooltipController?.hide();
        },
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(controller, layout),
        onHorizontalDragEnd: end,
        child: track,
      );
    }
  }

  GestureTapDownCallback? _tap(
    FSliderController controller,
    FTooltipController? min,
    FTooltipController? max,
    double thumbSize,
    FLayout layout,
  ) {
    final translate = layout.translateTrackTap(controller.value.pixelConstraints.extent, thumbSize);

    void down(TapDownDetails details) {
      final offset = switch (translate(details.localPosition)) {
        < 0 => 0.0,
        final translated when controller.value.pixelConstraints.extent < translated =>
          controller.value.pixelConstraints.extent,
        final translated => translated,
      };

      switch (controller.tap(offset)) {
        case true:
          min?.show();
        case false:
          max?.show();
        default:
      }
    }

    return tappable.contains(controller.interaction) ? down : null;
  }

  GestureDragUpdateCallback? _drag(FSliderController controller, FLayout layout) {
    if (controller.interaction != FSliderInteraction.slide) {
      return null;
    }

    assert(
      controller.active.min ^ controller.active.max,
      'Slider must be active at one edge when ${controller.interaction}.',
    );

    final translate = layout.translateTrackDrag();

    return (details) {
      final origin = controller.active.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition - _pointerOrigin!), min: controller.active.min);
    };
  }
}

class _Track extends StatelessWidget {
  const _Track();

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :marks, :enabled) = InheritedData.of(context);
    final states = InheritedStates.of(context).states;
    final crossAxisExtent = style.crossAxisExtent;

    final extent = InheritedController.of(
      context,
      InheritedController.pixelConstraints,
    ).controller.value.pixelConstraints.extent;

    final position = layout.position;
    final half = style.thumbSize / 2;
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: style.borderRadius, color: style.inactiveColor.resolve(states)),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: .center,
          children: [
            for (var FSliderMark(style: markStyle, :value, :tick) in marks)
              if (tick)
                position(
                  offset: value * extent + half - ((markStyle ??= style.markStyle).tickSize / 2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: markStyle.tickColor.resolve(states)),
                    child: SizedBox.square(dimension: markStyle.tickSize),
                  ),
                ),
            const ActiveTrack(),
          ],
        ),
      ),
    );
  }
}

@internal
class ActiveTrack extends StatelessWidget {
  const ActiveTrack({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout) = .of(context);
    final states = InheritedStates.of(context).states;
    final crossAxisExtent = style.crossAxisExtent;
    final pixels = InheritedController.of(context, InheritedController.pixels).controller.value.pixels;

    final mainAxisExtent = pixels.max - pixels.min + style.thumbSize / 2;
    final (height, width) = layout.vertical ? (mainAxisExtent, crossAxisExtent) : (crossAxisExtent, mainAxisExtent);

    return layout.position(
      offset: pixels.min,
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: style.borderRadius, color: style.activeColor.resolve(states)),
        child: SizedBox(height: height, width: width),
      ),
    );
  }
}

@internal
extension Layouts on FLayout {
  double Function(Offset) translateTrackTap(double extent, double thumbSize) => switch (this) {
    .ltr => (offset) => offset.dx - thumbSize / 2,
    .rtl => (offset) => extent - offset.dx + thumbSize / 2,
    .ttb => (offset) => offset.dy - thumbSize / 2,
    .btt => (offset) => extent - offset.dy + thumbSize / 2,
  };

  double Function(Offset) translateTrackDrag() => switch (this) {
    .ltr => (delta) => delta.dx,
    .rtl => (delta) => -delta.dx,
    .ttb => (delta) => delta.dy,
    .btt => (delta) => -delta.dy,
  };

  Positioned Function({required double offset, required Widget child}) get position => switch (this) {
    .ltr => ({required offset, required child}) => Positioned(left: offset, child: child),
    .rtl => ({required offset, required child}) => Positioned(right: offset, child: child),
    .ttb => ({required offset, required child}) => Positioned(top: offset, child: child),
    .btt => ({required offset, required child}) => Positioned(bottom: offset, child: child),
  };
}
