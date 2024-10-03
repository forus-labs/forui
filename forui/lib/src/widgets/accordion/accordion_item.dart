import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:forui/src/widgets/accordion/accordion.dart';

/// An interactive heading that reveals a section of content.
///
/// See:
/// * https://forui.dev/docs/accordion for working examples.
class FAccordionItem extends StatefulWidget {
  /// The accordion's style. Defaults to [FThemeData.accordionStyle].
  final FAccordionStyle? style;

  /// The title.
  final Widget title;

  /// The icon. Defaults to `FAssets.icons.chevronRight`.
  ///
  /// [icon] is wrapped in [FIconStyle], and therefore works with [FIcon]s.
  final Widget icon;

  /// True if the item is initially expanded.
  final bool initiallyExpanded;

  /// The child.
  final Widget child;

  /// Creates an [FAccordionItem].
  FAccordionItem({
    required this.title,
    required this.child,
    this.style,
    this.initiallyExpanded = false,
    super.key,
  }) : icon = FIcon(FAssets.icons.chevronRight);

  @override
  State<FAccordionItem> createState() => _FAccordionItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('initiallyExpanded', value: initiallyExpanded, ifTrue: 'Initially expanded'));
  }
}

class _FAccordionItemState extends State<FAccordionItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final FAccordionItemData(:index, :controller, :style) = FAccordionItemData.of(context);
    if (controller.removeItem(index)) {
      _controller.dispose();
    }

    _controller = AnimationController(vsync: this)
      ..value = widget.initiallyExpanded ? 1 : 0
      ..duration = style.animationDuration;
    _animation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(curve: Curves.ease, parent: _controller));

    if (!controller.addItem(index, _controller)) {
      throw StateError('Number of expanded items must be within the min and max.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final FAccordionItemData(:index, :controller, style: inheritedStyle) = FAccordionItemData.of(context);
    final style = widget.style ?? inheritedStyle;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FTappable(
            behavior: HitTestBehavior.translucent,
            onPress: () => controller.toggle(index),
            builder: (context, state, child) => Padding(
              padding: style.titlePadding,
              child: Row(
                children: [
                  Expanded(
                    child: merge(
                      // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      style: state.hovered || state.shortPressed
                          ? style.titleTextStyle.copyWith(decoration: TextDecoration.underline)
                          : style.titleTextStyle,
                      child: widget.title,
                    ),
                  ),
                  child!,
                ],
              ),
            ),
            child: Transform.rotate(
              angle: (_controller.value * -180 + 90) * math.pi / 180.0,
              child: FInheritedIconStyle(
                style: FIconStyle(color: style.iconColor, size: style.iconSize),
                child: widget.icon,
              ),
            ),
          ),
          // We use a combination of a custom render box & clip rect to avoid visual oddities. This is caused by
          // RenderPaddings (created by Paddings in the child) shrinking the constraints by the given padding, causing the
          // child to layout at a smaller size while the amount of padding remains the same.
          _Expandable(
            value: _controller.value,
            child: ClipRect(
              clipper: _Clipper(_controller.value),
              child: Padding(
                padding: style.childPadding,
                child: DefaultTextStyle(style: style.childTextStyle, child: widget.child),
              ),
            ),
          ),
          FDivider(style: style.dividerStyle),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _Expandable extends SingleChildRenderObjectWidget {
  final double value;

  const _Expandable({
    required this.value,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderExpandable(value);

  @override
  void updateRenderObject(BuildContext context, _RenderExpandable renderObject) => renderObject..value = value;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('value', value));
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
    properties.add(DoubleProperty('value', value));
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
