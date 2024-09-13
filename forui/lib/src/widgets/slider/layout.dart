import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/alignment.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:forui/src/widgets/slider/track.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/src/widgets/slider/inherited_data.dart';

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
    widget.controller.attach(mainAxisExtent - widget.style.thumbStyle.dimension, widget.marks);
  }

  @override
  void didUpdateWidget(covariant SliderLayout old) {
    super.didUpdateWidget(old);

    final mainAxisExtent = (widget.layout.vertical ? widget.constraints.maxHeight : widget.constraints.maxWidth) -
        widget.style.thumbStyle.dimension;
    final oldMainAxisExtent =
        (old.layout.vertical ? old.constraints.maxHeight : old.constraints.maxWidth) - old.style.thumbStyle.dimension;

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
    final markStyle = widget.layout.vertical ? style.markStyles.vertical : style.markStyles.horizontal;
    final marks = widget.marks.where((mark) => mark.label != null).toList();

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (_, child) => InheritedController(
        controller: widget.controller,
        child: child!,
      ),
      child: CustomMultiChildLayout(
        delegate: _SliderLayoutDelegate(widget.controller, widget.style, widget.layout, marks),
        children: [
          for (final mark in marks)
            if (mark case FSliderMark(:final style, :final label?))
              LayoutId(
                id: mark,
                child: DefaultTextStyle(
                  style: (style ?? markStyle).labelTextStyle,
                  child: label,
                ),
              ),
          LayoutId(
            id: _SliderLayoutDelegate._track,
            child: const Track(),
          ),
        ],
      ),
    );
  }
}

class _SliderLayoutDelegate extends MultiChildLayoutDelegate {
  static final _track = UniqueKey();

  final FSliderController controller;
  final FSliderStyle style;
  final Layout layout;
  final List<FSliderMark> marks;

  _SliderLayoutDelegate(this.controller, this.style, this.layout, this.marks);

  @override
  void performLayout(Size size) {
    final constraints = BoxConstraints.loose(size);
    final defaultMarkStyle = (layout.vertical ? style.markStyles.vertical : style.markStyles.horizontal);

    final Rect Function(FSliderMark, FSliderMarkStyle) position = switch (layout) {
      Layout.ltr => (mark, style) {
          final offset = _anchor(constraints.maxWidth, mark.offset, style);
          return _rect(constraints, mark, Offset(offset.$1, offset.$2), style);
        },
      Layout.rtl => (mark, style) {
          final offset = _anchor(constraints.maxWidth, 1 - mark.offset, style);
          return _rect(constraints, mark, Offset(offset.$1, offset.$2), style);
        },
      Layout.ttb => (mark, style) {
          final offset = _anchor(constraints.maxHeight, mark.offset, style);
          return _rect(constraints, mark, Offset(offset.$2, offset.$1), style);
        },
      Layout.btt => (mark, style) {
          final offset = _anchor(constraints.maxHeight, 1 - mark.offset, style);
          return _rect(constraints, mark, Offset(offset.$2, offset.$1), style);
        },
    };

    final rects = marks.map((mark) => (mark, position(mark, mark.style ?? defaultMarkStyle))).toList();
    final origin = switch (layout.vertical) {
      true => Offset(rects.map((offset) => offset.$2.left).where((x) => x.isNegative).min?.abs() ?? 0, 0),
      false => Offset(0, rects.map((offset) => offset.$2.top).where((x) => x.isNegative).min?.abs() ?? 0),
    };

    layoutChild(_track, constraints);
    positionChild(_track, origin);

    for (final (mark, rect) in rects) {
      positionChild(mark, rect.topLeft + origin);
    }
  }

  (double, double) _anchor(double extent, double offset, FSliderMarkStyle markStyle) {
    final thumb = style.thumbStyle.dimension;
    final trackMainAxis = (extent - thumb) * offset;
    final anchorMainAxis = (thumb / 2) + trackMainAxis;
    final anchorCrossAxis = markStyle.labelOffset + (markStyle.labelOffset < 0 ? 0.0 : style.crossAxisExtent * 2);

    return (anchorMainAxis, anchorCrossAxis);
  }

  Rect _rect(BoxConstraints constraints, FSliderMark mark, Offset anchor, FSliderMarkStyle markStyle) {
    print(mark);
    final size = layoutChild(mark, constraints);
    final rect = anchor & size;
    return rect.shift(anchor - markStyle.labelAnchor.relative(to: size, origin: anchor));
  }

  @override
  bool shouldRelayout(covariant _SliderLayoutDelegate old) => controller != old.controller || layout != old.layout;
}
