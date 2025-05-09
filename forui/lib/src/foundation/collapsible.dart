import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget that collapses and expands its child.
///
/// The child is completely clipped when the value is 0. When the value is 1, the child is fully visible.
/// It is recommended to lerp between 0 and 1 to create a smooth animation.
///
/// See:
/// * https://forui.dev/docs/foundation/collapsible for working examples.
class FCollapsible extends StatelessWidget {
  /// The value of the collapsible.
  final double value;

  /// The child of the collapsible.
  final Widget child;

  /// Creates a [FCollapsible].
  const FCollapsible({required this.value, required this.child, super.key});

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    // We use a combination of a custom render box & clip rect to avoid visual oddities. This is caused by
    // RenderPaddings (created by Paddings in the child) shrinking the constraints by the given padding, causing the
    // child to layout at a smaller size while the amount of padding remains the same.
    return _Expandable(value: value, child: ClipRect(clipper: _Clipper(value), child: child));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('value', value));
  }
}

class _Expandable extends SingleChildRenderObjectWidget {
  final double value;

  const _Expandable({required this.value, required super.child});

  @override
  RenderObject createRenderObject(BuildContext _) => _RenderExpandable(value);

  @override
  void updateRenderObject(BuildContext context, _RenderExpandable renderObject) => renderObject..value = value;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value));
  }
}

class _RenderExpandable extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  double _value;

  _RenderExpandable(this._value);

  @override
  void performLayout() {
    if (child case final child?) {
      child.layout(constraints.normalize(), parentUsesSize: true);
      size = Size(child.size.width, child.size.height * _value);
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child case final child?) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (size.contains(position) && child!.hitTest(result, position: position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }

    return false;
  }

  double get value => _value;

  set value(double value) {
    if (_value == value) {
      return;
    }

    _value = value;
    markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value));
  }
}

class _Clipper extends CustomClipper<Rect> {
  final double percentage;

  _Clipper(this.percentage);

  @override
  Rect getClip(Size size) => Offset.zero & Size(size.width, size.height * percentage);

  @override
  bool shouldReclip(covariant _Clipper oldClipper) => oldClipper.percentage != percentage;
}
