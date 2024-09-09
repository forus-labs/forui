import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/track.dart';
import 'package:forui/src/widgets/slider/thumb.dart';
import 'package:meta/meta.dart';

class FSlider extends StatefulWidget {
  static String _percentages(FSliderData data) => '${data.offsetPercentage.min}% - ${data.offsetPercentage.max}%';

  /// The controller.
  final FSliderController controller;

  /// The style.
  final FSliderStyle? style;

  /// The layout. Defaults to [Layout.ltr].
  final Layout layout;

  /// True if this slider is enabled. Defaults to true.
  final bool enabled;

  /// A callback that formats the semantic label for the slider. Defaults to announcing the percentages of the filled
  /// region.
  final String Function(FSliderData) semanticFormatterCallback;

  /// Creates a [FSlider].
  const FSlider({
    required this.controller,
    this.style,
    this.layout = Layout.ltr,
    this.enabled = true,
    this.semanticFormatterCallback = _percentages,
    super.key,
  });

  @override
  State<FSlider> createState() => _FSliderState();
}

class _FSliderState extends State<FSlider> {
  @override
  Widget build(BuildContext context) {
    final styles = context.theme.sliderStyles;
    final style = widget.style ?? (widget.enabled ? styles.enabledStyle : styles.disabledStyle);
    final markStyle = widget.layout.vertical ? style.markStyles.vertical : style.markStyles.horizontal;

    return InheritedData(
      controller: widget.controller,
      style: style,
      layout: widget.layout,
      enabled: widget.enabled,
      child: LayoutBuilder(
        builder: (context, constraints) => Semantics(
          slider: true,
          value: widget.semanticFormatterCallback(widget.controller.data),
          child: CustomMultiChildLayout(
            delegate: _SliderLayoutDelegate(),
            children: [
              for (final mark in widget.controller.marks)
                if (mark case FSliderMark(:final style, :final label?))
                  LayoutId(
                    id: mark,
                    child: DefaultTextStyle(
                      style: (style ?? markStyle).labelTextStyle,
                      child: label,
                    ),
                  ),
              LayoutId(
                id: _SliderLayoutDelegate._bar,
                child: const Track(),
              ),
              if (widget.controller.growable.min)
                LayoutId(
                  id: _SliderLayoutDelegate._minThumb,
                  child: const Thumb(
                    min: true,
                  ),
                ),
              if (widget.controller.growable.max)
                LayoutId(
                  id: _SliderLayoutDelegate._maxThumb,
                  child: const Thumb(
                    min: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderLayoutDelegate extends MultiChildLayoutDelegate {
  static const _bar = Object();
  static const _minThumb = Object();
  static const _maxThumb = Object();

  @override
  void performLayout(Size size) {
    final bar = layoutChild(_bar, BoxConstraints.tight(size));
    positionChild(_bar, Offset.zero);

    final minThumb = layoutChild(_minThumb, BoxConstraints.loose(size));
    positionChild(_minThumb, Offset(0, size.height / 2 - minThumb.height / 2));

    final maxThumb = layoutChild(_maxThumb, BoxConstraints.loose(size));
    positionChild(_maxThumb, Offset(size.width - maxThumb.width, size.height / 2 - maxThumb.height / 2));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    throw UnimplementedError();
  }
}