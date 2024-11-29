import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/src/foundation/rendering.dart';

@internal

///
typedef SizeChangeCallback = void Function(Size size);

/// This is based on Material's _BottomSheetLayoutWithSizeListener.
@internal
class ShiftedSheet extends SingleChildRenderObjectWidget {
  final Layout side;
  final double value;
  final double? mainAxisMaxRatio;
  final SizeChangeCallback onChange;

  const ShiftedSheet({
    required this.side,
    required this.value,
    required this.mainAxisMaxRatio,
    required this.onChange,
    required super.child,
    super.key,
  });

  @override
  RenderBox createRenderObject(BuildContext context) => _ShiftedSheet(
        side: side,
        value: value,
        mainAxisMaxRatio: mainAxisMaxRatio,
        onChange: onChange,
      );

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, _ShiftedSheet renderObject) {
    renderObject
      ..side = side
      ..value = value
      ..mainAxisMaxRatio = mainAxisMaxRatio
      ..onChange = onChange;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('value', value))
      ..add(DoubleProperty('mainAxisMaxRatio', mainAxisMaxRatio))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }
}

class _ShiftedSheet extends RenderShiftedBox {
  Layout _side;
  double _value;
  double? _mainAxisMaxRatio;
  SizeChangeCallback _onChange;
  Size _previous = Size.zero;

  _ShiftedSheet({
    required Layout side,
    required double value,
    required double? mainAxisMaxRatio,
    required SizeChangeCallback onChange,
  })  : _side = side,
        _value = value,
        _mainAxisMaxRatio = mainAxisMaxRatio,
        _onChange = onChange,
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

      if (_previous != childSize) {
        _previous = childSize;
        _onChange.call(_previous);
      }
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
          maxHeight: _mainAxisMaxRatio == null ? constraints.maxHeight : constraints.maxHeight * _mainAxisMaxRatio!,
        )
      : BoxConstraints(
          maxWidth: _mainAxisMaxRatio == null ? constraints.maxWidth : constraints.maxWidth * _mainAxisMaxRatio!,
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

  double? get mainAxisMaxRatio => _mainAxisMaxRatio;

  set mainAxisMaxRatio(double? value) {
    if (_mainAxisMaxRatio != value) {
      _mainAxisMaxRatio = value;
      markNeedsLayout();
    }
  }

  SizeChangeCallback get onChange => _onChange;

  set onChange(SizeChangeCallback value) {
    if (_onChange != value) {
      _onChange = value;
      markNeedsLayout();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('side', side))
      ..add(DoubleProperty('value', value))
      ..add(DoubleProperty('mainAxisRatio', mainAxisMaxRatio))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }
}
