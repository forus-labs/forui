import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/resizable_box/resizable_box_controller.dart';
import 'package:meta/meta.dart';

@internal
sealed class Slider extends StatelessWidget {
  final ResizableBoxController controller;
  final Alignment alignment;
  final AxisDirection direction;
  final MouseCursor cursor;
  final double size;
  final int index;

  Slider({
    required this.controller,
    required this.alignment,
    required this.direction,
    required this.cursor,
    required this.size,
    required this.index,
    super.key,
  }) : assert(
          0 <= index && index < controller.controllers.length,
          'Index should be in the range: 0 <= index < ${controller.controllers.length}, but it is $index.',
        );

  @override
  Widget build(BuildContext context) {
    final enabled = switch (controller.interaction) {
      Resize _ => true,
      SelectAndResize(:final index) when index == this.index => true,
      _ => false,
    };

    return Align(
      alignment: alignment,
      child: MouseRegion(
        cursor: enabled ? cursor : MouseCursor.defer,
        child: Semantics(
          enabled: enabled,
          slider: true,
          child: _child(enabled: enabled),
        ),
      ),
    );
  }

  Widget _child({required bool enabled});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('direction', direction))
      ..add(DiagnosticsProperty('cursor', cursor))
      ..add(DoubleProperty('size', size))
      ..add(IntProperty('index', index));
  }
}

/// A slider to used resize the containing resizable along the horizontal axis.
@internal
final class HorizontalSlider extends Slider {
  HorizontalSlider.left({
    required super.controller,
    required super.index,
    required super.size,
    super.key,
  }) : super(
          alignment: Alignment.centerLeft,
          direction: AxisDirection.left,
          cursor: SystemMouseCursors.resizeLeftRight,
        );

  HorizontalSlider.right({
    required super.controller,
    required super.index,
    required super.size,
    super.key,
  }) : super(
          alignment: Alignment.centerRight,
          direction: AxisDirection.right,
          cursor: SystemMouseCursors.resizeLeftRight,
        );

  @override
  Widget _child({required bool enabled}) => SizedBox(
        width: size,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            if (!enabled || details.delta.dx == 0.0) {
              return;
            }

            final hitBoundary = controller.update(index, direction, details.delta);
            final aboveVelocity = (controller.hapticFeedbackVelocity ?? double.infinity) <= details.delta.distance;
            if (hitBoundary && aboveVelocity) {
              // TODO: haptic feedback
            }
          },
          onHorizontalDragEnd: (details) => controller.end(index, direction),
        ),
      );
}

/// A slider to used resize the containing resizable along the vertical axis.
@internal
final class VerticalSlider extends Slider {
  VerticalSlider.up({
    required super.controller,
    required super.index,
    required super.size,
    super.key,
  }) : super(
          alignment: Alignment.topCenter,
          direction: AxisDirection.up,
          cursor: SystemMouseCursors.resizeUpDown,
        );

  VerticalSlider.down({
    required super.controller,
    required super.index,
    required super.size,
    super.key,
  }) : super(
          alignment: Alignment.bottomCenter,
          direction: AxisDirection.down,
          cursor: SystemMouseCursors.resizeUpDown,
        );

  @override
  Widget _child({required bool enabled}) => SizedBox(
        height: size,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            if (!enabled || details.delta.dy == 0.0) {
              return;
            }

            final hitBoundary = controller.update(index, direction, details.delta);
            final aboveVelocity = (controller.hapticFeedbackVelocity ?? double.infinity) <= details.delta.distance;
            if (hitBoundary && aboveVelocity) {
              // TODO: haptic feedback
            }
          },
          onVerticalDragEnd: (details) => controller.end(index, direction),
        ),
      );
}
