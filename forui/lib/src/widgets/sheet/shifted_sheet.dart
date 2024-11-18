import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:meta/meta.dart';

@internal
class ShiftedSheet extends SingleChildRenderObjectWidget {
  final Layout side;
  final double value;
  final double dimensionRatio;

  const ShiftedSheet({
    required this.side,
    required this.value,
    required this.dimensionRatio,
    required super.child,
    super.key,
  });

  @override
  RenderBox createRenderObject(BuildContext context) => _ShiftedSheet(
        side: side,
        value: value,
        dimensionRatio: dimensionRatio,
      );

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, _ShiftedSheet renderObject) {
    renderObject
      ..side = side
      ..value = value
      ..dimensionRatio = dimensionRatio;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('value', value))
      ..add(DoubleProperty('dimensionRatio', dimensionRatio));
  }
}

class _ShiftedSheet extends RenderShiftedBox {
  Layout _side;
  double _value;
  double? _dimensionRatio;

  _ShiftedSheet({
    required Layout side,
    required double value,
    required double dimensionRatio,
  })  : _side = side,
        _value = value,
        _dimensionRatio = dimensionRatio,
        super(null);

  @override
  void performLayout() {
    size = constraints.biggest;

    if (child case final child?) {
      final childConstraints = constrainChild(constraints);
      assert(childConstraints.debugAssertIsValid(isAppliedConstraint: true), '');

      child.layout(childConstraints, parentUsesSize: !childConstraints.isTight);

      final childSize = childConstraints.isTight ? childConstraints.smallest : child.size;
      child.data.offset = positionChild(size, childSize);
    }
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final child = this.child;
    if (child == null) {
      return null;
    }

    final childConstraints = constrainChild(constraints);
    final result = child.getDryBaseline(childConstraints, baseline);
    if (result == null) {
      return null;
    }

    final childSize = childConstraints.isTight ? childConstraints.smallest : child.getDryLayout(childConstraints);
    return result + positionChild(constraints.biggest, childSize).dy;
  }

  BoxConstraints constrainChild(BoxConstraints constraints) => side.vertical
      ? BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          maxHeight: _dimensionRatio == null ? constraints.maxHeight : constraints.maxHeight * _dimensionRatio!,
        )
      : BoxConstraints(
          maxWidth: _dimensionRatio == null ? constraints.maxWidth : constraints.maxWidth * _dimensionRatio!,
          minHeight: constraints.maxHeight,
          maxHeight: constraints.maxHeight,
        );

  Offset positionChild(Size size, Size childSize) => switch (side) {
        Layout.ttb => Offset(0, childSize.height * (_value - 1)),
        Layout.btt => Offset(0, size.height - childSize.height * _value),
        Layout.ltr => Offset(childSize.width * (_value - 1), 0),
        Layout.rtl => Offset(size.width - childSize.width * _value, 0),
      };

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  @override
  double computeMinIntrinsicWidth(double height) {
    final width = BoxConstraints.tightForFinite(height: height).biggest.width;
    return width.isFinite ? width : 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final width = BoxConstraints.tightForFinite(height: height).biggest.width;
    return width.isFinite ? width : 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final height = BoxConstraints.tightForFinite(width: width).biggest.height;
    return height.isFinite ? height : 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final height = BoxConstraints.tightForFinite(width: width).biggest.height;
    return height.isFinite ? height : 0.0;
  }

  Layout get side => _side;

  set side(Layout value) {
    if (_side != value) {
      _side = value;
      markNeedsLayout();
    }
  }

  double get value => _value;

  set value(double value) {
    if (_value != value) {
      _value = value;
      markNeedsLayout();
    }
  }

  double? get dimensionRatio => _dimensionRatio;

  set dimensionRatio(double? value) {
    if (_dimensionRatio != value) {
      _dimensionRatio = value;
      markNeedsLayout();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('value', value))
      ..add(DoubleProperty('dimensionRatio', dimensionRatio));
  }
}
