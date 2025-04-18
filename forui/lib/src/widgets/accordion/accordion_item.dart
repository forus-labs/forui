import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/accordion/accordion.dart';
import 'package:forui/src/widgets/accordion/accordion_controller.dart';

/// An interactive heading that reveals a section of content.
///
/// See:
/// * https://forui.dev/docs/data/accordion for working examples.
class FAccordionItem extends StatefulWidget {
  /// The accordion's style. Defaults to [FThemeData.accordionStyle].
  final FAccordionStyle? style;

  /// The title.
  final Widget title;

  /// The icon, wrapped in a [IconTheme]. Defaults to `Icon(FIcons.chevronRight)`.
  final Widget icon;

  /// True if the item is initially expanded.
  final bool initiallyExpanded;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// The child.
  final Widget child;

  /// Creates an [FAccordionItem].
  const FAccordionItem({
    required this.title,
    required this.child,
    this.style,
    this.icon = const Icon(FIcons.chevronRight),
    this.initiallyExpanded = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  State<FAccordionItem> createState() => _FAccordionItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('initiallyExpanded', value: initiallyExpanded, ifTrue: 'Initially expanded'))
      ..add(FlagProperty('autofocus', value: autofocus, defaultValue: false, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange));
  }
}

class _FAccordionItemState extends State<FAccordionItem> with TickerProviderStateMixin {
  AnimationController? _controller;
  CurvedAnimation? _curved;
  late Animation<double> _animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final FAccordionItemData(:index, :controller, :style) = FAccordionItemData.of(context);
    controller.removeItem(index);

    _controller?.dispose();
    _controller =
        AnimationController(vsync: this)
          ..value = widget.initiallyExpanded ? 1 : 0
          ..duration = style.animationDuration;

    _curved?.dispose();
    _curved = CurvedAnimation(curve: Curves.ease, parent: _controller!);

    _animation = Tween<double>(begin: 0, end: 100).animate(_curved!);

    if (!controller.addItem(index, _controller!)) {
      throw StateError('Number of expanded items must be within the min and max.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final FAccordionItemData(:index, :controller, style: inheritedStyle) = FAccordionItemData.of(context);
    final style = widget.style ?? inheritedStyle;
    final angle = ((Directionality.maybeOf(context) ?? TextDirection.ltr) == TextDirection.ltr) ? -180 : 180;
    return AnimatedBuilder(
      animation: _animation,
      builder:
          (_, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FTappable(
                style: style.tappableStyle,
                autofocus: widget.autofocus,
                focusNode: widget.focusNode,
                onFocusChange: widget.onFocusChange,
                onPress: () => controller.toggle(index),
                builder:
                    (_, states, _) => Padding(
                      padding: style.titlePadding,
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultTextStyle.merge(
                              textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false,
                                applyHeightToLastDescent: false,
                              ),
                              style: style.titleTextStyle.resolve(states),
                              child: widget.title,
                            ),
                          ),
                          FFocusedOutline(
                            style: style.focusedOutlineStyle,
                            focused: states.contains(WidgetState.focused),
                            child: Transform.rotate(
                              angle: (_controller!.value * angle + 90) * math.pi / 180.0,
                              child: IconTheme(data: style.iconStyle.resolve(states), child: widget.icon),
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
              // We use a combination of a custom render box & clip rect to avoid visual oddities. This is caused by
              // RenderPaddings (created by Paddings in the child) shrinking the constraints by the given padding, causing the
              // child to layout at a smaller size while the amount of padding remains the same.
              _Expandable(
                value: _controller!.value,
                child: ClipRect(
                  clipper: _Clipper(_controller!.value),
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
    _curved?.dispose();
    _controller?.dispose();
    super.dispose();
  }
}

class _Expandable extends SingleChildRenderObjectWidget {
  final double value;

  const _Expandable({required this.value, required super.child});

  @override
  RenderObject createRenderObject(BuildContext _) => _RenderExpandable(value);

  @override
  void updateRenderObject(BuildContext context, _RenderExpandable renderObject) => renderObject..value = value;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value));
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
    properties.add(PercentProperty('value', value));
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
