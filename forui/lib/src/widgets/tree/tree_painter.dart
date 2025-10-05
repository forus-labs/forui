import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A custom painter that draws tree connection lines.
///
/// This painter draws the visual lines that connect parent and child items in a tree structure.
@internal
class FTreeLinePainter extends CustomPainter {
  /// The line style.
  final FTreeLineStyle lineStyle;

  /// The nesting depth of the item.
  final int depth;

  /// Whether the item has children.
  final bool hasChildren;

  /// Whether the item is expanded.
  final bool isExpanded;

  /// Whether this is the last child at its level.
  final bool isLast;

  /// The parent indices for line rendering.
  final List<bool> parentIndices;

  /// The indentation width for each level.
  final double indentWidth;

  /// Creates a [FTreeLinePainter].
  const FTreeLinePainter({
    required this.lineStyle,
    required this.depth,
    required this.hasChildren,
    required this.isExpanded,
    required this.isLast,
    required this.parentIndices,
    required this.indentWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (depth == 0) return; // No lines for root level

    final paint = Paint()
      ..color = lineStyle.color
      ..strokeWidth = lineStyle.width
      ..style = PaintingStyle.stroke;

    // Draw vertical lines for parent levels
    for (var i = 0; i < parentIndices.length; i++) {
      final isParentLast = parentIndices[i];
      if (!isParentLast) {
        final x = (i + 1) * indentWidth + indentWidth / 2;
        if (lineStyle.dashPattern != null) {
          _drawDashedLine(
            canvas,
            Offset(x, 0),
            Offset(x, size.height),
            paint,
            lineStyle.dashPattern!,
          );
        } else {
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
        }
      }
    }

    // Draw connector lines for current item
    final x = depth * indentWidth + indentWidth / 2;
    final y = size.height / 2;

    // Vertical line from top to middle (or bottom if last)
    if (isLast) {
      if (lineStyle.dashPattern != null) {
        _drawDashedLine(canvas, Offset(x, 0), Offset(x, y), paint, lineStyle.dashPattern!);
      } else {
        canvas.drawLine(Offset(x, 0), Offset(x, y), paint);
      }
    } else {
      if (lineStyle.dashPattern != null) {
        _drawDashedLine(canvas, Offset(x, 0), Offset(x, size.height), paint, lineStyle.dashPattern!);
      } else {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
    }

    // Horizontal line from vertical line to item
    final horizontalEndX = x + indentWidth / 2;
    if (lineStyle.dashPattern != null) {
      _drawDashedLine(canvas, Offset(x, y), Offset(horizontalEndX, y), paint, lineStyle.dashPattern!);
    } else {
      canvas.drawLine(Offset(x, y), Offset(horizontalEndX, y), paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint, List<double> dashPattern) {
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);

    final metric = path.computeMetrics().first;
    var distance = 0.0;
    var drawDash = true;
    var dashIndex = 0;

    while (distance < metric.length) {
      final dashLength = dashPattern[dashIndex % dashPattern.length];
      if (drawDash) {
        final extractPath = metric.extractPath(
          distance,
          distance + dashLength > metric.length ? metric.length : distance + dashLength,
        );
        canvas.drawPath(extractPath, paint);
      }
      distance += dashLength;
      drawDash = !drawDash;
      dashIndex++;
    }
  }

  @override
  bool shouldRepaint(FTreeLinePainter oldDelegate) =>
      lineStyle != oldDelegate.lineStyle ||
      depth != oldDelegate.depth ||
      hasChildren != oldDelegate.hasChildren ||
      isExpanded != oldDelegate.isExpanded ||
      isLast != oldDelegate.isLast ||
      parentIndices != oldDelegate.parentIndices ||
      indentWidth != oldDelegate.indentWidth;
}
