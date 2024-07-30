import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/src/widgets/resizable/resizable_controller.dart';

@internal
sealed class Slider extends StatelessWidget {
  final FResizableController controller;
  final Alignment alignment;
  final AxisDirection side;
  final MouseCursor cursor;
  final double size;
  final int index;

  Slider({
    required this.controller,
    required this.alignment,
    required this.side,
    required this.cursor,
    required this.size,
    required this.index,
    super.key,
  }) : assert(
          0 <= index && index < controller.regions.length,
          'Index should be in the range: 0 <= index < ${controller.regions.length}, but it is $index.',
        );

  @override
  Widget build(BuildContext context) => Align(
      alignment: alignment,
      child: MouseRegion(
        cursor: cursor,
        child: Semantics(
          slider: true,
          child: _child,
        ),
      ),
    );

  Widget get _child;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(DiagnosticsProperty('side', side))
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
          side: AxisDirection.left,
          cursor: SystemMouseCursors.resizeLeftRight,
        );

  HorizontalSlider.right({
    required super.controller,
    required super.index,
    required super.size,
    super.key,
  }) : super(
          alignment: Alignment.centerRight,
          side: AxisDirection.right,
          cursor: SystemMouseCursors.resizeLeftRight,
        );

  @override
  Widget get _child => SizedBox(
        width: size,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx == 0.0) {
              return;
            }

            controller.update(index, side, details.delta);
            // TODO: haptic feedback
          },
          onHorizontalDragEnd: (details) => controller.end(index, side),
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
          side: AxisDirection.up,
          cursor: SystemMouseCursors.resizeUpDown,
        );

  VerticalSlider.down({
    required super.controller,
    required super.index,
    required super.size,
    super.key,
  }) : super(
          alignment: Alignment.bottomCenter,
          side: AxisDirection.down,
          cursor: SystemMouseCursors.resizeUpDown,
        );

  @override
  Widget get _child => SizedBox(
        height: size,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            if (details.delta.dy == 0.0) {
              return;
            }

            controller.update(index, side, details.delta);
            // TODO: haptic feedback
          },
          onVerticalDragEnd: (details) => controller.end(index, side),
        ),
      );
}
