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
  final FSliderStyle style;
  final Layout layout;
  final List<FSliderMark> marks;
  final BoxConstraints constraints;

  const SliderLayout({
    required this.controller,
    required this.style,
    required this.layout,
    required this.marks,
    required this.constraints,
    super.key,
  });

  @override
  State<SliderLayout> createState() => _SliderLayoutState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks))
      ..add(DiagnosticsProperty('constraints', constraints));
  }
}

class _SliderLayoutState extends State<SliderLayout> {
  @override
  void initState() {
    super.initState();
    final mainAxisExtent = widget.layout.vertical ? widget.constraints.maxHeight : widget.constraints.maxWidth;
    widget.controller.attach(mainAxisExtent - widget.style.thumbStyle.size, widget.marks);
  }

  @override
  void didUpdateWidget(covariant SliderLayout old) {
    super.didUpdateWidget(old);
    final mainAxisExtent = (widget.layout.vertical ? widget.constraints.maxHeight : widget.constraints.maxWidth) -
        widget.style.thumbStyle.size;
    final oldMainAxisExtent =
        (old.layout.vertical ? old.constraints.maxHeight : old.constraints.maxWidth) - old.style.thumbStyle.size;

    if (widget.controller != old.controller ||
        widget.layout != old.layout ||
        mainAxisExtent != oldMainAxisExtent ||
        !widget.marks.equals(old.marks)) {
      widget.controller.attach(mainAxisExtent, widget.marks);
    }
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :semanticFormatterCallback, :enabled) = InheritedData.of(context);
    final markStyle = style.markStyle;
    final marks = widget.marks.where((mark) => mark.label != null).toList();

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (_, child) => InheritedController(
        controller: widget.controller,
        child: child!,
      ),
      child: _Slider(
        style: widget.style,
        layout: widget.layout,
        marks: marks,
        children: [
          const Track(),
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
  final Layout layout;
  final List<FSliderMark> marks;

  const _Slider({
    required this.style,
    required this.layout,
    required this.marks,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderSlider(style, layout, marks);

  @override
  void updateRenderObject(BuildContext context, covariant _RenderSlider renderObject) {
    renderObject
      ..style = style
      ..sliderLayout = layout
      ..marks = marks;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', layout))
      ..add(IterableProperty('marks', marks));
  }
}

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

class _RenderSlider extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  FSliderStyle _style;
  Layout _layout;
  List<FSliderMark> _marks;

  _RenderSlider(this._style, this._layout, this._marks);

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _Data();
  }

  @override
  void performLayout() {
    final loosened = constraints.loosen();
    final Rect Function(RenderBox, Size, FSliderMark, FSliderMarkStyle) position = switch (_layout) {
      Layout.ltr => (track, label, mark, style) {
          final offset = _anchor(track.size.width, mark.value, style);
          return _rect(label, mark, Offset(offset.$1, offset.$2), style);
        },
      Layout.rtl => (track, size, mark, style) {
          final offset = _anchor(track.size.width, 1 - mark.value, style);
          return _rect(size, mark, Offset(offset.$1, offset.$2), style);
        },
      Layout.ttb => (track, size, mark, style) {
          final offset = _anchor(track.size.height, mark.value, style);
          return _rect(size, mark, Offset(offset.$2, offset.$1), style);
        },
      Layout.btt => (track, size, mark, style) {
          final offset = _anchor(track.size.height, 1 - mark.value, style);
          return _rect(size, mark, Offset(offset.$2, offset.$1), style);
        },
    };

    final track = firstChild!..layout(loosened, parentUsesSize: true);

    final labels = <RenderBox, Rect>{};
    var label = childAfter(track);
    var minX = 0.0;
    var minY = 0.0;
    var maxX = track.size.width;
    var maxY = track.size.height;

    for (final mark in _marks) {
      if (label == null) {
        break;
      }

      label.layout(loosened, parentUsesSize: true);

      final rect = position(track, label.size, mark, mark.style ?? _style.markStyle);
      labels[label] = rect;

      minX = min(minX, rect.left);
      maxX = max(maxX, rect.right);
      minY = min(minY, rect.top);
      maxY = max(maxY, rect.bottom);

      label = childAfter(label);
    }

    final origin = switch (_layout.vertical) {
      true => Offset(labels.values.map((rect) => rect.left).where((x) => x.isNegative).min?.abs() ?? 0, 0),
      false => Offset(0, labels.values.map((rect) => rect.top).where((x) => x.isNegative).min?.abs() ?? 0),
    };

    (track.parentData! as _Data).offset = origin;

    for (final MapEntry(key: label, value: rect) in labels.entries) {
      (label.parentData! as _Data).offset = rect.topLeft + origin;
    }

    size = constraints.constrain(Size(maxX - minX, maxY - minY));
  }

  (double, double) _anchor(double extent, double offset, FSliderMarkStyle markStyle) {
    final thumb = _style.thumbStyle.size;
    final trackMainAxis = (extent - thumb) * offset;
    final anchorMainAxis = (thumb / 2) + trackMainAxis;

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

  FSliderStyle get style => _style;

  set style(FSliderStyle value) {
    if (_style == value) {
      return;
    }

    _style = value;
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('layout', sliderLayout))
      ..add(IterableProperty('marks', marks));
  }
}
