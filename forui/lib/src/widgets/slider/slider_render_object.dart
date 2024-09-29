import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/alignment.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/widgets/slider/inherited_state.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/src/widgets/slider/inherited_data.dart';

@internal
class HorizontalSliderRenderObject extends _SliderRenderObject {
  const HorizontalSliderRenderObject({super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    final InheritedData(:style, :layout, :marks, :trackMainAxisExtent) = InheritedData.of(context);
    final stateStyle = InheritedState.of(context).style;
    return _RenderHorizontalSlider(style, stateStyle, layout, marks, trackMainAxisExtent);
  }
}

@internal
class VerticalSliderRenderObject extends _SliderRenderObject {
  const VerticalSliderRenderObject({super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    final InheritedData(:style, :layout, :marks, :trackMainAxisExtent) = InheritedData.of(context);
    final stateStyle = InheritedState.of(context).style;
    return _RenderVerticalSlider(style, stateStyle, layout, marks, trackMainAxisExtent);
  }
}

abstract class _SliderRenderObject extends MultiChildRenderObjectWidget {
  const _SliderRenderObject({super.key, super.children});

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, covariant _RenderSlider renderObject) {
    final InheritedData(:style, :layout, :marks, :trackMainAxisExtent) = InheritedData.of(context);
    final stateStyle = InheritedState.of(context).style;
    renderObject
      ..style = style
      ..stateStyle = stateStyle
      ..sliderLayout = layout
      ..marks = marks
      ..mainAxisExtent = trackMainAxisExtent;
  }
}

class _RenderHorizontalSlider extends _RenderSlider {
  _RenderHorizontalSlider(super._style, super._stateStyle, super._layout, super._marks, super._mainAxisExtent);

  @override
  void performLayout() {
    final loosened = constraints.loosen();

    // Layout parts, assuming top-left corner of track/origin is (0, 0).
    final insets = _style.labelLayoutStyle.childPadding;
    final (:label, :paddedTrack, :description, :error, :slider) = layoutParts(
      loosened,
      switch (_mainAxisExtent) {
        final extent? => loosened.copyWith(maxWidth: extent + insets.left + insets.right),
        null => loosened,
      },
    );

    // Calculate offset to move the top/left corner of track/origin from (0, 0), such that no part of the slider has a
    // negative offset.
    final boxes = [label, paddedTrack, description, error];
    final largest = boxes.order(by: (box) => box.size.width).max!;
    boxes.remove(largest);

    // Check whether the marks are larger than the largest label/description/error.
    final sliderOffset = Offset(
      0,
      label.size.height + (slider.marks.values.map((r) => r.top).where((y) => y.isNegative).minOrNull?.abs() ?? 0),
    );

    paddedTrack.data.offset = sliderOffset;
    for (final MapEntry(key: label, value: rect) in slider.marks.entries) {
      label.data.offset = rect.topLeft + sliderOffset;
    }

    var height = label.size.height + slider.size.height;
    description.data.offset = Offset(0, height);

    height += description.size.height;
    error.data.offset = Offset(0, height);

    final width = [label.size, slider.size, description.size, error.size].order(by: (size) => size.width).max!.width;
    size = constraints.constrain(Size(width, height + error.size.height));
  }
}

class _RenderVerticalSlider extends _RenderSlider {
  _RenderVerticalSlider(super._style, super._stateStyle, super._layout, super._marks, super._mainAxisExtent);

  @override
  void performLayout() {
    final loosened = constraints.loosen();

    // Layout parts, assuming top-left corner of track/origin is (0, 0).
    final insets = _style.labelLayoutStyle.childPadding;
    final (:label, :paddedTrack, :description, :error, :slider) = layoutParts(
      loosened,
      switch (_mainAxisExtent) {
        final extent? => loosened.copyWith(maxHeight: extent + insets.top + insets.bottom),
        null => loosened,
      },
    );

    // Calculate offset to move the top/left corner of track/origin from (0, 0), such that no part of the slider has a
    // negative offset.
    final boxes = [label, paddedTrack, description, error];
    final largest = boxes.order(by: (box) => box.size.width).max!;
    boxes.remove(largest);

    // Check whether the marks are larger than the largest label/description/error.
    final largestMiddleOffset = largest.size.bottomCenter(Offset.zero).dx;
    final marksOffset = slider.marks.values.map((rect) => rect.left).where((x) => x.isNegative).minOrNull?.abs() ?? 0;

    final double middle;
    final double largestOffset;
    final Offset sliderOffset;

    if (largestMiddleOffset < marksOffset) {
      middle = marksOffset;
      sliderOffset = Offset(marksOffset, label.size.height);
      largestOffset = marksOffset + paddedTrack.size.width / 2;
    } else {
      middle = largestMiddleOffset;
      sliderOffset = Offset(largestMiddleOffset - paddedTrack.size.width / 2, label.size.height);
      largestOffset = 0.0;
    }

    // Center align the slider's parts.
    largest.data.offset = Offset(max(largestOffset - largest.size.width / 2, 0), 0);
    for (final box in boxes) {
      box.data.offset = Offset(middle - box.size.width / 2, 0);
    }

    paddedTrack.data.offset = sliderOffset;
    for (final MapEntry(key: label, value: rect) in slider.marks.entries) {
      label.data.offset = rect.topLeft + sliderOffset;
    }

    var height = label.size.height + slider.size.height;
    description.data.offset = Offset(description.data.offset.dx, height);

    height += description.size.height;
    error.data.offset = Offset(error.data.offset.dx, height);

    final width = max(largest.size.width, (sliderOffset & slider.size).right);
    size = constraints.constrain(Size(width, height + error.size.height));
  }
}

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

typedef _Parts = ({
  RenderBox paddedTrack,
  RenderBox label,
  RenderBox description,
  RenderBox error,
  ({Map<RenderBox, Rect> marks, Size size}) slider,
});

abstract class _RenderSlider extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  FSliderStyle _style;
  FSliderStateStyle _stateStyle;
  Layout _layout;
  List<FSliderMark> _marks;
  double? _mainAxisExtent;
  late Rect Function(RenderBox, Size, FSliderMark, FSliderMarkStyle) _positionMark;

  _RenderSlider(this._style, this._stateStyle, this._layout, this._marks, this._mainAxisExtent) {
    _positionMark = _position;
  }

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = _Data();

  _Parts layoutParts(BoxConstraints constraints, BoxConstraints trackMainAxis) {
    final paddedTrack = firstChild!..layout(trackMainAxis, parentUsesSize: true);

    final label = childAfter(paddedTrack)!..layout(constraints, parentUsesSize: true);
    final description = childAfter(label)!..layout(constraints, parentUsesSize: true);
    final error = childAfter(description)!..layout(constraints, parentUsesSize: true);

    final (marks, sliderSize) = _layoutMarks(constraints, paddedTrack, childAfter(error));

    return (
      paddedTrack: paddedTrack,
      label: label,
      description: description,
      error: error,
      slider: (marks: marks, size: sliderSize),
    );
  }

  (Map<RenderBox, Rect>, Size) _layoutMarks(BoxConstraints constraints, RenderBox paddedTrack, RenderBox? label) {
    final marks = <RenderBox, Rect>{};
    var minX = 0.0;
    var minY = 0.0;
    var maxX = paddedTrack.size.width;
    var maxY = paddedTrack.size.height;

    final positionMark = _positionMark;
    for (final mark in _marks) {
      if (label == null) {
        break;
      }

      label.layout(constraints, parentUsesSize: true);

      final rect = positionMark(paddedTrack, label.size, mark, mark.style ?? _stateStyle.markStyle);
      marks[label] = rect;

      minX = min(minX, rect.left);
      maxX = max(maxX, rect.right);
      minY = min(minY, rect.top);
      maxY = max(maxY, rect.bottom);

      label = childAfter(label);
    }

    return (marks, Size(maxX - minX, maxY - minY));
  }

  Rect Function(RenderBox, Size, FSliderMark, FSliderMarkStyle) get _position {
    final insets = _style.labelLayoutStyle.childPadding;
    return switch (_layout) {
      Layout.ltr => (track, label, mark, style) {
          final offset = _anchor(track.size.width - insets.left - insets.right, insets.left, mark.value, style);
          return _rect(label, mark, Offset(offset.$1, offset.$2 + insets.top), style);
        },
      Layout.rtl => (track, size, mark, style) {
          final offset = _anchor(track.size.width - insets.left - insets.right, insets.left, 1 - mark.value, style);
          return _rect(size, mark, Offset(offset.$1, offset.$2 + insets.top), style);
        },
      Layout.ttb => (track, size, mark, style) {
          final offset = _anchor(track.size.height - insets.top - insets.bottom, insets.top, mark.value, style);
          return _rect(size, mark, Offset(offset.$2, offset.$1), style);
        },
      Layout.btt => (track, size, mark, style) {
          final offset = _anchor(track.size.height - insets.top - insets.bottom, insets.top, 1 - mark.value, style);
          return _rect(size, mark, Offset(offset.$2, offset.$1), style);
        },
    };
  }

  (double, double) _anchor(double extent, double padding, double offset, FSliderMarkStyle markStyle) {
    final thumb = _style.thumbSize;
    final trackMainAxis = (extent - thumb) * offset;
    final anchorMainAxis = (thumb / 2) + trackMainAxis + padding;

    final adjustment = _style.crossAxisExtent < thumb ? (thumb - _style.crossAxisExtent) / 2 : 0;
    final crossAxisOffset = (markStyle.labelOffset < 0 ? 0.0 : _style.crossAxisExtent + adjustment);
    final anchorCrossAxis = markStyle.labelOffset + crossAxisOffset;

    return (anchorMainAxis, anchorCrossAxis);
  }

  Rect _rect(Size size, FSliderMark mark, Offset anchor, FSliderMarkStyle markStyle) {
    final rect = anchor & size;
    return rect.shift(anchor - markStyle.labelAnchor.relative(to: size, origin: anchor));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // We paint the labels first, then the track so that the thumb is painted on top of the labels.
    var child = lastChild;
    while (child != null) {
      final childParentData = child.parentData! as _Data;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.previousSibling;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('stateStyle', stateStyle))
      ..add(EnumProperty('layout', sliderLayout))
      ..add(IterableProperty('marks', marks))
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent));
  }

  FSliderStyle get style => _style;

  set style(FSliderStyle value) {
    if (_style == value) {
      return;
    }

    _style = value;
    _positionMark = _position;
    markNeedsLayout();
  }

  FSliderStateStyle get stateStyle => _stateStyle;

  set stateStyle(FSliderStateStyle value) {
    if (_stateStyle == value) {
      return;
    }

    _stateStyle = value;
    markNeedsLayout();
  }

  Layout get sliderLayout => _layout;

  set sliderLayout(Layout value) {
    if (_layout == value) {
      return;
    }

    _layout = value;
    _positionMark = _position;
    markNeedsLayout();
  }

  List<FSliderMark> get marks => _marks;

  set marks(List<FSliderMark> value) {
    if (_marks.equals(value)) {
      return;
    }

    _marks = value;
    markNeedsLayout();
  }

  double? get mainAxisExtent => _mainAxisExtent;

  set mainAxisExtent(double? value) {
    if (_mainAxisExtent == value) {
      return;
    }

    _mainAxisExtent = value;
    markNeedsLayout();
  }
}
