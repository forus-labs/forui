import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A custom painter that draws tree connection lines from a parent to its children.
///
/// This painter draws:
/// - A vertical line from the top (parent item) to the last child
/// - Horizontal lines from the vertical line to each child
@internal
class FTreeChildrenLinePainter extends CustomPainter {
  /// The line style.
  final FTreeLineStyle lineStyle;

  /// The number of children.
  final int childCount;

  /// The spacing between children.
  final double childrenSpacing;

  /// The number of visible rows (including nested children) that each direct child occupies.
  final List<int> childRowCounts;

  /// The horizontal padding of each tree item.
  final double itemPadding;

  /// Creates a [FTreeChildrenLinePainter].
  const FTreeChildrenLinePainter({
    required this.lineStyle,
    required this.childCount,
    required this.childrenSpacing,
    required this.childRowCounts,
    required this.itemPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (childCount == 0) {
      return;
    }

    final paint = Paint()
      ..color = lineStyle.color
      ..strokeWidth = lineStyle.width
      ..style = PaintingStyle.stroke;

    const lineStartX = 0.0; // Vertical line starts at the left edge (we're already indented)

    // Calculate total number of rows and total spacing
    final totalRows = childRowCounts.reduce((a, b) => a + b);

    // Calculate the height of a single row based on actual rendered size
    final itemHeight = (size.height) / totalRows;

    // Calculate the vertical center position of each direct child
    final childPositions = <double>[];
    var currentY = itemHeight / 2; // Center of first child (which is in the first row)

    for (var i = 0; i < childCount; i++) {
      childPositions.add(currentY);
      // Move to next child: advance by this child's row count, plus spacing
      currentY += childRowCounts[i] * itemHeight;
    }

    // Draw vertical line from top to last child's center
    final lastChildY = childPositions.last;
    if (lineStyle.dashPattern != null) {
      _drawDashedLine(canvas, Offset.zero, Offset(lineStartX, lastChildY), paint, lineStyle.dashPattern!);
    } else {
      canvas.drawLine(Offset.zero, Offset(lineStartX, lastChildY), paint);
    }

    // Draw horizontal lines to each child
    final horizontalEndX = itemPadding - 2; // Stop 2px before the icon area
    for (final childY in childPositions) {
      if (lineStyle.dashPattern != null) {
        _drawDashedLine(
          canvas,
          Offset(lineStartX, childY),
          Offset(horizontalEndX, childY),
          paint,
          lineStyle.dashPattern!,
        );
      } else {
        canvas.drawLine(Offset(lineStartX, childY), Offset(horizontalEndX, childY), paint);
      }
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
  bool shouldRepaint(FTreeChildrenLinePainter oldDelegate) =>
      lineStyle != oldDelegate.lineStyle ||
      childCount != oldDelegate.childCount ||
      childrenSpacing != oldDelegate.childrenSpacing ||
      childRowCounts != oldDelegate.childRowCounts ||
      itemPadding != oldDelegate.itemPadding;
}
