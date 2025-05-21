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
    final InheritedData(:style, :layout, :semanticFormatterCallback) = InheritedData.of(context);
    final controller = InheritedController.of(context);
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
        value: semanticFormatterCallback(controller.selection),
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
    final InheritedData(:style, :layout, :trackHitRegionCrossExtent, :enabled) = InheritedData.of(context);
    final controller = InheritedController.of(context);

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
      _origin = controller.selection.rawOffset;
      _pointerOrigin = details.localPosition;
      controller.tooltips.show();
    }

    void end(DragEndDetails _) {
      _origin = null;
      _pointerOrigin = null;
      controller.tooltips.hide();
    }

    if (layout.vertical) {
      return GestureDetector(
        onTapDown: _tap(controller, style.thumbSize, layout),
        onTapUp: (_) => controller.tooltips.hide(),
        onVerticalDragStart: start,
        onVerticalDragUpdate: _drag(controller, layout),
        onVerticalDragEnd: end,
        child: track,
      );
    } else {
      return GestureDetector(
        onTapDown: _tap(controller, style.thumbSize, layout),
        onTapUp: (_) => controller.tooltips.hide(),
        onHorizontalDragStart: start,
        onHorizontalDragUpdate: _drag(controller, layout),
        onHorizontalDragEnd: end,
        child: track,
      );
    }
  }

  GestureTapDownCallback? _tap(FSliderController controller, double thumbSize, FLayout layout) {
    final translate = layout.translateTrackTap(controller.selection.rawExtent.total, thumbSize);

    void down(TapDownDetails details) {
      final offset = switch (translate(details.localPosition)) {
        < 0 => 0.0,
        final translated when controller.selection.rawExtent.total < translated => controller.selection.rawExtent.total,
        final translated => translated,
      };

      switch (controller.tap(offset)) {
        case true:
          controller.tooltips.show(FSliderTooltipsController.min);
        case false:
          controller.tooltips.show(FSliderTooltipsController.max);
        default:
      }
    }

    return tappable.contains(controller.allowedInteraction) ? down : null;
  }

  GestureDragUpdateCallback? _drag(FSliderController controller, FLayout layout) {
    if (controller.allowedInteraction != FSliderInteraction.slide) {
      return null;
    }

    assert(
      controller.extendable.min ^ controller.extendable.max,
      'Slider must be extendable at one edge when ${controller.allowedInteraction}.',
    );

    final translate = layout.translateTrackDrag();

    return (details) {
      final origin = controller.extendable.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition - _pointerOrigin!), min: controller.extendable.min);
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

    final extent = InheritedController.of(context, InheritedController.rawExtent).selection.rawExtent.total;

    final position = layout.position;
    final half = style.thumbSize / 2;
    final (height, width) = layout.vertical ? (null, crossAxisExtent) : (crossAxisExtent, null);

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: style.borderRadius, color: style.inactiveColor.resolve(states)),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
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
    final InheritedData(:style, :layout) = InheritedData.of(context);
    final states = InheritedStates.of(context).states;
    final crossAxisExtent = style.crossAxisExtent;
    final rawOffset = InheritedController.of(context, InheritedController.rawOffset).selection.rawOffset;

    final mainAxisExtent = rawOffset.max - rawOffset.min + style.thumbSize / 2;
    final (height, width) = layout.vertical ? (mainAxisExtent, crossAxisExtent) : (crossAxisExtent, mainAxisExtent);

    return layout.position(
      offset: rawOffset.min,
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
    FLayout.ltr => (offset) => offset.dx - thumbSize / 2,
    FLayout.rtl => (offset) => extent - offset.dx + thumbSize / 2,
    FLayout.ttb => (offset) => offset.dy - thumbSize / 2,
    FLayout.btt => (offset) => extent - offset.dy + thumbSize / 2,
  };

  double Function(Offset) translateTrackDrag() => switch (this) {
    FLayout.ltr => (delta) => delta.dx,
    FLayout.rtl => (delta) => -delta.dx,
    FLayout.ttb => (delta) => delta.dy,
    FLayout.btt => (delta) => -delta.dy,
  };

  Positioned Function({required double offset, required Widget child}) get position => switch (this) {
    FLayout.ltr => ({required offset, required child}) => Positioned(left: offset, child: child),
    FLayout.rtl => ({required offset, required child}) => Positioned(right: offset, child: child),
    FLayout.ttb => ({required offset, required child}) => Positioned(top: offset, child: child),
    FLayout.btt => ({required offset, required child}) => Positioned(bottom: offset, child: child),
  };
}
