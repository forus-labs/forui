import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/track.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart' hide Offset;

import 'package:forui/src/widgets/slider/inherited_data.dart';

@internal
class SliderLayout extends StatefulWidget {
  final FSliderController controller;
  final Layout layout;
  final List<FSliderMark> marks;
  final BoxConstraints constraints;

  const SliderLayout({
    required this.controller,
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
    widget.controller.attach(mainAxisExtent, widget.marks);
  }


  @override
  void didUpdateWidget(covariant SliderLayout old) {
    super.didUpdateWidget(old);

    final mainAxisExtent = widget.layout.vertical ? widget.constraints.maxHeight : widget.constraints.maxWidth;
    final oldMainAxisExtent = old.layout.vertical ? old.constraints.maxHeight : old.constraints.maxWidth;

    if (widget.controller != old.controller || widget.layout != old.layout || mainAxisExtent != oldMainAxisExtent || !widget.marks.equals(old.marks)) {
      widget.controller.attach(mainAxisExtent, widget.marks);
    }
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(:style, :semanticFormatterCallback, :enabled) = InheritedData.of(context);
    final markStyle = widget.layout.vertical ? style.markStyles.vertical : style.markStyles.horizontal;

    return Semantics(
      slider: true,
      enabled: enabled,
      value: semanticFormatterCallback(widget.controller.selection),
      child: CustomMultiChildLayout(
        delegate: _SliderLayoutDelegate(),
        children: [
          // for (final mark in widget.marks)
            // if (mark case FSliderMark(:final style, :final label?))
            //   LayoutId(
            //     id: mark,
            //     child: DefaultTextStyle(
            //       style: (style ?? markStyle).labelTextStyle,
            //       child: label,
            //     ),
            //   ),
          LayoutId(
            id: _SliderLayoutDelegate._track,
            child: const Track(),
          ),
          // if (widget.controller.extendable.min)
          //   LayoutId(
          //     id: _SliderLayoutDelegate._minThumb,
          //     child: const Thumb(min: true),
          //   ),
          // if (widget.controller.extendable.max)
          //   LayoutId(
          //     id: _SliderLayoutDelegate._maxThumb,
          //     child: const Thumb(min: false),
          //   ),
        ],
      ),
    );
  }
}

class _SliderLayoutDelegate extends MultiChildLayoutDelegate {
  static const _track = Object();
  static const _minThumb = Object();
  static const _maxThumb = Object();

  @override
  void performLayout(Size size) {
    layoutChild(_track, BoxConstraints.loose(size));
    positionChild(_track, Offset.zero);
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}
