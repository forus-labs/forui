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

  /// True if the item is initially expanded.
  final bool initiallyExpanded;

  /// The child.
  final Widget child;

  /// Creates an [FAccordionItem].
  const FAccordionItem({
    required this.title,
    required this.child,
    this.style,
    this.initiallyExpanded = false,
    super.key,
  });

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
  late Animation<double> _expand;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final data = FAccordionItemData.of(context);

    if (data.controller.removeItem(data.index)) {
      _controller.dispose();
    }

    _controller = AnimationController(vsync: this);
    _expand = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _controller,
      ),
    );
    await data.controller.addItem(data.index, _controller, _expand, initiallyExpanded: widget.initiallyExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final FAccordionItemData(:index, :controller) = FAccordionItemData.of(context);
    final style = widget.style ?? context.theme.accordionStyle;
    return AnimatedBuilder(
      animation: _expand,
      builder: (context, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FTappable(
            behavior: HitTestBehavior.translucent,
            onPress: () => controller.toggle(index),
            builder: (context, state, child) => Container(
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
                      style: style.titleTextStyle.copyWith(
                        decoration:
                            state.hovered || state.shortPressed ? TextDecoration.underline : TextDecoration.none,
                      ),
                      child: widget.title,
                    ),
                  ),
                  child!,
                ],
              ),
            ),
            child: Transform.rotate(
              angle: (_expand.value / 100 * -180 + 90) * math.pi / 180.0,
              child: style.icon,
            ),
          ),
          // We use a combination of a custom render box & clip rect to avoid visual oddities. This is caused by
          // RenderPaddings (created by Paddings in the child) shrinking the constraints by the given padding, causing the
          // child to layout at a smaller size while the amount of padding remains the same.
          _Expandable(
            percentage: _expand.value / 100,
            child: ClipRect(
              clipper: _Clipper(_expand.value / 100),
              child: Padding(
                padding: style.childPadding,
                child: DefaultTextStyle(style: style.childTextStyle, child: widget.child),
              ),
            ),
          ),
          FDivider(
            style: style.divider,
          ),
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
  final double _percentage;

  const _Expandable({
    required super.child,
    required double percentage,
  }) : _percentage = percentage;

  @override
  RenderObject createRenderObject(BuildContext context) => _ExpandableBox(_percentage);

  @override
  void updateRenderObject(BuildContext context, _ExpandableBox renderObject) => renderObject..percentage = _percentage;
}

class _ExpandableBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  double _percentage;

  _ExpandableBox(double percentage) : _percentage = percentage;

  @override
  void performLayout() {
    if (child case final child?) {
      child.layout(constraints.normalize(), parentUsesSize: true);
      size = Size(child.size.width, child.size.height * _percentage);
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

  double get percentage => _percentage;

  set percentage(double value) {
    if (_percentage == value) {
      return;
    }

    _percentage = value;
    markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('percentage', percentage));
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
