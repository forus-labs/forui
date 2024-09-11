import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/slider/inherited_data.dart';

@internal
class Track extends StatefulWidget {
  const Track({super.key});

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  ({double min, double max})? _origin;
  Offset? _pointerOrigin;

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :enabled, :semanticFormatterCallback) = InheritedData.of(context);
    final controller = InheritedController.of(context);

    Widget track = Semantics(
      slider: true,
      enabled: enabled,
      value: semanticFormatterCallback(controller.selection),
      child: const _Track(),
    );

    if (enabled) {
      final (down, up) = _tapGestures(controller, style, layout);
      final (horizontal, vertical) = _dragGestures(controller, style, layout);
      track = GestureDetector(
        onTapDown: down,
        onTapUp: up,
        onHorizontalDragStart: (details) {
          _origin = controller.selection.rawOffset;
          _pointerOrigin = details.localPosition;
        },
        onHorizontalDragUpdate: horizontal,
        onHorizontalDragEnd: (_) {
          _origin = null;
          _pointerOrigin = null;
          controller.tooltip?.hide();
        },
        onVerticalDragStart: (details) {
          _origin = controller.selection.rawOffset;
          _pointerOrigin = details.localPosition;
        },
        onVerticalDragUpdate: vertical,
        onVerticalDragEnd: (_) {
          _origin = null;
          _pointerOrigin = null;
          controller.tooltip?.hide();
        },
        child: track,
      );
    }

    return track;
  }

  (GestureTapDownCallback, GestureTapUpCallback) _tapGestures(
    FSliderController controller,
    FSliderStyle style,
    Layout layout,
  ) {
    const tappable = {FSliderInteraction.tap, FSliderInteraction.tapAndSlideThumb};

    final translate = layout.translate(style);
    void tap(TapDownDetails details) {
      controller.tooltip?.show();
      controller.tap(
        switch (translate(details.localPosition)) {
          < 0 => 0,
          final translated when controller.selection.rawExtent.total < translated =>
            controller.selection.rawExtent.total,
          final translated => translated,
        },
      );
    }

    return (
      tappable.contains(controller.allowedInteraction) ? tap : (_) => controller.tooltip?.show(),
      (_) => controller.tooltip?.hide(),
    );
  }

  (GestureDragUpdateCallback?, GestureDragUpdateCallback?) _dragGestures(
    FSliderController controller,
    FSliderStyle style,
    Layout layout,
  ) {
    if (controller.allowedInteraction != FSliderInteraction.slide) {
      return (null, null);
    }

    assert(
      !(controller.extendable.min && controller.extendable.max),
      'Slider cannot be extendable at both edges when the allowed interaction is ${controller.allowedInteraction}.',
    );

    final translate = layout.translate(style);
    void drag(DragUpdateDetails details) {
      final origin = controller.extendable.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition - _pointerOrigin!), min: controller.extendable.min);
    }

    return layout.vertical ? (null, drag) : (drag, null);
  }
}

class _Track extends StatelessWidget {
  const _Track();

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :layout, :marks, :enabled) = InheritedData.of(context);
    final FSliderStyle(:inactiveColor, :borderRadius, :crossAxisExtent, :markStyles, :thumbStyle) = style;
    final markStyle = layout.vertical ? markStyles.vertical : markStyles.horizontal;

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
            for (var FSliderMark(:style, :offset, :tick) in marks)
              if (tick)
                position(
                  offset: offset * extent + half - ((style ??= markStyle).tickDimension / 2),
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
  double Function(Offset) translate(FSliderStyle style) => switch (this) {
        Layout.ltr => (offset) => offset.dx - style.thumbStyle.dimension / 2,
        Layout.rtl => (offset) =>  -offset.dx,
        Layout.ttb => (offset) => offset.dy - style.thumbStyle.dimension / 2,
        Layout.btt => (offset) => -offset.dy,
      };

  Positioned Function({required double offset, required Widget child}) get position => switch (this) {
        Layout.ltr => ({required offset, required child}) => Positioned(left: offset, child: child),
        Layout.rtl => ({required offset, required child}) => Positioned(right: offset, child: child),
        Layout.ttb => ({required offset, required child}) => Positioned(top: offset, child: child),
        Layout.btt => ({required offset, required child}) => Positioned(bottom: offset, child: child),
      };
}
