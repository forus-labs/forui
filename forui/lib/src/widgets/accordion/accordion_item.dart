import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';

import 'dart:math' as math;

/// An item that represents a header in a [FAccordion].
class FAccordionData extends InheritedWidget{
  /// The title.
  final Widget title;

  /// The child.
  final Widget child;

  /// Whether the item is initially expanded.
  final bool initiallyExpanded;

  /// Creates an [FAccordionItem].
  FAccordionItem({required this.title, required this.child, this.initiallyExpanded = false});
}

/// An interactive heading that reveals a section of content.
///
/// See:
/// * https://forui.dev/docs/accordion for working examples.
class FAccordionItem extends StatefulWidget {
  /// The accordion's style. Defaults to [FThemeData.accordionStyle].
  final FAccordionStyle style;

  /// The accordion's controller.
  final FAccordionController controller;

  final FAccordionItem item;

  final int index;

  /// Creates an [_Item].
  const _Item({
    required this.style,
    required this.index,
    required this.item,
    required this.controller,
  });

  @override
  State<_Item> createState() => _ItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('item', item))
      ..add(IntProperty('index', index));
  }
}

class _ItemState extends State<_Item> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expand;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.controller.animationDuration,
      value: widget.item.initiallyExpanded ? 1.0 : 0.0,
      vsync: this,
    );
    _expand = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _controller,
      ),
    );
    widget.controller.addItem(widget.index, _controller, _expand, widget.item.initiallyExpanded);
  }

  @override
  void didUpdateWidget(covariant _Item old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller = AnimationController(
        duration: widget.controller.animationDuration,
        value: widget.item.initiallyExpanded ? 1.0 : 0.0,
        vsync: this,
      );
      _expand = Tween<double>(
        begin: 0,
        end: 100,
      ).animate(
        CurvedAnimation(
          curve: Curves.ease,
          parent: _controller,
        ),
      );

      old.controller.removeItem(old.index);
      widget.controller.addItem(widget.index, _controller, _expand, widget.item.initiallyExpanded);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.controller.controllers[widget.index].animation,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FTappable(
              onPress: () => widget.controller.toggle(widget.index),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: Container(
                  padding: widget.style.titlePadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: merge(
                          // TODO: replace with DefaultTextStyle.merge when textHeightBehavior has been added.
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                            applyHeightToLastDescent: false,
                          ),
                          style: widget.style.titleTextStyle
                              .copyWith(decoration: _hovered ? TextDecoration.underline : TextDecoration.none),
                          child: widget.item.title,
                        ),
                      ),
                      Transform.rotate(
                        //TODO: Should I be getting the percentage value from the controller or from its local state?
                        angle: (_expand.value / 100 * -180 + 90) * math.pi / 180.0,

                        child: widget.style.icon,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // We use a combination of a custom render box & clip rect to avoid visual oddities. This is caused by
            // RenderPaddings (created by Paddings in the child) shrinking the constraints by the given padding, causing the
            // child to layout at a smaller size while the amount of padding remains the same.
            _Expandable(
              //TODO: Should I be getting the percentage value from the controller or from its local state?
              percentage: _expand.value / 100,
              child: ClipRect(
                //TODO: Should I be getting the percentage value from the controller or from its local state?
                clipper: _Clipper(percentage: _expand.value / 100),
                child: Padding(
                  padding: widget.style.contentPadding,
                  child: DefaultTextStyle(style: widget.style.childTextStyle, child: widget.item.child),
                ),
              ),
            ),
            FDivider(
              style: context.theme.dividerStyles.horizontal
                  .copyWith(padding: EdgeInsets.zero, color: widget.style.dividerColor),
            ),
          ],
        ),
      );
}

class _Expandable extends SingleChildRenderObjectWidget {
  final double _percentage;

  const _Expandable({
    required Widget child,
    required double percentage,
  })  : _percentage = percentage,
        super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => _ExpandableBox(percentage: _percentage);

  @override
  void updateRenderObject(BuildContext context, _ExpandableBox renderObject) {
    renderObject.percentage = _percentage;
  }
}

class _ExpandableBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  double _percentage;

  _ExpandableBox({
    required double percentage,
  }) : _percentage = percentage;

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

  _Clipper({required this.percentage});

  @override
  Rect getClip(Size size) => Offset.zero & Size(size.width, size.height * percentage);

  @override
  bool shouldReclip(covariant _Clipper oldClipper) => oldClipper.percentage != percentage;
}
