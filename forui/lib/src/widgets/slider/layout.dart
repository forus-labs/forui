import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/alignment.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/inherited_data.dart';
import 'package:forui/src/widgets/slider/track.dart';

@internal
class SliderLayout extends StatefulWidget {
  final FSliderController controller;
  final FLabelLayoutStyle layoutStyle;
  final FSliderStateStyle stateStyle;
  final FLabelState state;
  final Layout layout;
  final Widget label;
  final Widget description;
  final Widget error;
  final List<FSliderMark> marks;
  final BoxConstraints constraints;
  final double? mainAxisExtent;

  const SliderLayout({
    required this.controller,
    required this.layoutStyle,
    required this.stateStyle,
    required this.state,
    required this.layout,
    required this.label,
    required this.description,
    required this.error,
    required this.marks,
    required this.constraints,
    required this.mainAxisExtent,
    super.key,
  });

  @override
  State<SliderLayout> createState() => _SliderLayoutState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('layoutStyle', layoutStyle))
      ..add(DiagnosticsProperty('stateStyle', stateStyle))
      ..add(EnumProperty('state', state))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent));
  }

  double get _mainAxisExtent {
    final insets = layoutStyle.childPadding;
    final extent = switch (mainAxisExtent) {
      final extent? => extent,
      _ when layout.vertical => constraints.maxHeight - insets.top - insets.bottom,
      _ => constraints.maxWidth - insets.left - insets.right,
    };

    if (extent.isInfinite) {
      throw FlutterError(
        switch (layout.vertical) {
          true => 'A vertical FSlider was given an infinite height although it needs a finite height. To fix this, '
              'consider supplying a mainAxisExtent or placing FSlider in a SizedBox.',
          false => 'A horizontal FSlider was given an infinite width although it needs a finite width. To fix this, '
              'consider supplying a mainAxisExtent or placing FSlider in a SizedBox.',
        },
      );
    }

    return extent - stateStyle.thumbStyle.size;
  }
}

class _SliderLayoutState extends State<SliderLayout> {
  @override
  void initState() {
    super.initState();
    widget.controller.attach(widget._mainAxisExtent, widget.marks);
  }

  @override
  void didUpdateWidget(covariant SliderLayout old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller ||
        widget.layout != old.layout ||
        widget._mainAxisExtent != old._mainAxisExtent ||
        !widget.marks.equals(old.marks)) {
      widget.controller.attach(widget._mainAxisExtent, widget.marks);
    }
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :stateStyle, :semanticFormatterCallback, :enabled) = InheritedData.of(context);
    final markStyle = stateStyle.markStyle;
    final marks = widget.marks.where((mark) => mark.label != null).toList();

    return InheritedController(
      controller: widget.controller,
      child: _Slider(
        style: style,
        stateStyle: stateStyle,
        layout: widget.layout,
        marks: marks,
        mainAxisExtent: widget.mainAxisExtent,
        // DO NOT REORDER THE CHILDREN - _RenderSlider assumes this order.
        children: [
          Padding(
            padding: widget.layoutStyle.childPadding,
            child: const Track(),
          ),
          widget.label,
          widget.description,
          widget.error,
          for (final mark in marks)
            if (mark case FSliderMark(:final style, :final label?))
              DefaultTextStyle(
                style: (style ?? markStyle).labelTextStyle,
                child: label,
              ),
        ],
      ),
    );
  }
}

class _Slider extends MultiChildRenderObjectWidget {
  final FSliderStyle style;
  final FSliderStateStyle stateStyle;
  final Layout layout;
  final List<FSliderMark> marks;
  final double? mainAxisExtent;

  const _Slider({
    required this.style,
    required this.stateStyle,
    required this.layout,
    required this.marks,
    required this.mainAxisExtent,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderSlider(
        style,
        stateStyle,
        layout,
        marks,
        mainAxisExtent,
      );

  @override
  void updateRenderObject(BuildContext context, covariant _RenderSlider renderObject) {
    renderObject
      ..style = style
      ..stateStyle = stateStyle
      ..sliderLayout = layout
      ..marks = marks
      ..mainAxisExtent = mainAxisExtent;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('stateStyle', stateStyle))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(DoubleProperty('mainAxisExtent', mainAxisExtent));
  }
}

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

class _RenderSlider extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  FSliderStyle _style;
  FSliderStateStyle _stateStyle;
  Layout _layout;
  List<FSliderMark> _marks;
  double? _mainAxisExtent;

  _RenderSlider(this._style, this._stateStyle, this._layout, this._marks, this._mainAxisExtent);

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _Data();
  }

  @override
  void performLayout() {
    // There's probably a more efficient way to layout & position the slider's parts but I'm too dumb to figure it out.
    // Please do open an issue/reach out if you know of a better way to do this. - Matt
    final loosened = constraints.loosen();

    // Layout parts, assuming top-left corner of track/origin is (0, 0).
    final insets = _style.labelLayoutStyle.childPadding;
    final trackMainAxis = switch (_mainAxisExtent) {
      final extent? when _layout.vertical => loosened.copyWith(maxHeight: extent + insets.top + insets.bottom),
      final extent? when !_layout.vertical => loosened.copyWith(maxWidth: extent + insets.left + insets.right),
      _ => loosened,
    };

    final paddedTrack = firstChild!..layout(trackMainAxis, parentUsesSize: true);

    final label = childAfter(paddedTrack)!..layout(loosened, parentUsesSize: true);
    final description = childAfter(label)!..layout(loosened, parentUsesSize: true);
    final error = childAfter(description)!..layout(loosened, parentUsesSize: true);

    final (labels, sliderSize) = layoutMarks(loosened, paddedTrack, childAfter(error));

    // Calculate offset to move the top/left corner of track/origin from (0, 0), such that no part of the slider has a
    // negative offset.
    if (_layout.vertical) {
      final parts = [label, paddedTrack, description, error];
      final largest = parts.order(by: (box) => box.size.width).max!;
      parts.remove(largest);

      // Check whether the marks are larger than the largest label/description/error.
      final largestMiddleOffset = largest.size.bottomCenter(Offset.zero).dx;
      final marksOffset = labels.values.map((rect) => rect.left).where((x) => x.isNegative).min?.abs() ?? 0;

      final double middle;
      final double largestOffset;
      final Offset sliderOffset;
      if (largestMiddleOffset < marksOffset) {
        middle = marksOffset;
        sliderOffset = Offset(marksOffset, label.size.height);
        largestOffset = marksOffset + paddedTrack.size.width / 2;
      } else {
        middle = largestMiddleOffset;
        sliderOffset = Offset(middle - paddedTrack.size.width / 2, label.size.height);
        largestOffset = 0.0;
      }

      // Center align the slider's parts.
      (largest.parentData! as _Data).offset = Offset(max(largestOffset - largest.size.width / 2, 0), 0);
      for (final part in parts) {
        (part.parentData! as _Data).offset = Offset(middle - part.size.width / 2, 0);
      }

      (paddedTrack.parentData! as _Data).offset = sliderOffset;
      for (final MapEntry(key: label, value: rect) in labels.entries) {
        (label.parentData! as _Data).offset = rect.topLeft + sliderOffset;
      }

      (description.parentData! as _Data).offset = Offset(
        (description.parentData! as _Data).offset.dx,
        label.size.height + sliderSize.height,
      );

      (error.parentData! as _Data).offset = Offset(
        (error.parentData! as _Data).offset.dx,
        error.size.height + sliderSize.height + description.size.height,
      );

      final width = max(largest.size.width, (sliderOffset & sliderSize).right);
      final height = label.size.height + sliderSize.height + description.size.height + error.size.height;
      size = constraints.constrain(Size(width, height));
    } else {
      final sliderOffset = Offset(
        0,
        label.size.height + (labels.values.map((rect) => rect.top).where((y) => y.isNegative).min?.abs() ?? 0),
      );

      (paddedTrack.parentData! as _Data).offset = sliderOffset;

      for (final MapEntry(key: label, value: rect) in labels.entries) {
        (label.parentData! as _Data).offset = rect.topLeft + sliderOffset;
      }

      (description.parentData! as _Data).offset = Offset(
        0,
        label.size.height + sliderSize.height,
      );

      (error.parentData! as _Data).offset = Offset(
        0,
        error.size.height + sliderSize.height + description.size.height,
      );

      final width = [label.size, sliderSize, description.size, error.size].order(by: (size) => size.width).max!.width;
      final height = label.size.height + sliderSize.height + description.size.height + error.size.height;
      // size = constraints.constrain(Size(width, height));
      size = constraints.biggest;
    }
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

  FSliderStyle get style => _style;

  set style(FSliderStyle value) {
    if (_style == value) {
      return;
    }

    _style = value;
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
}

extension _Marks on _RenderSlider {
  (Map<RenderBox, Rect>, Size) layoutMarks(BoxConstraints constraints, RenderBox paddedTrack, RenderBox? label) {
    final marks = <RenderBox, Rect>{};
    final positionMark = this.positionMark;
    var minX = 0.0;
    var minY = 0.0;
    var maxX = paddedTrack.size.width;
    var maxY = paddedTrack.size.height;

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

  Rect Function(RenderBox, Size, FSliderMark, FSliderMarkStyle) get positionMark {
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
    final thumb = _stateStyle.thumbStyle.size;
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
}
