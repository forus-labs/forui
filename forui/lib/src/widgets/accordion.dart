import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:meta/meta.dart';

class FAccordion extends StatefulWidget {
  /// The divider's style. Defaults to the appropriate style in [FThemeData.dividerStyles].
  final FAccordionStyle? style;
  final String title;
  final bool initiallyExpanded;
  final VoidCallback onExpanded;
  final double childHeight;
  final double removeChildAnimationPercentage;
  final Widget child;

  const FAccordion({
    required this.child,
    required this.childHeight,
    required this.initiallyExpanded,
    required this.onExpanded,
    this.title = '',
    this.style,
    this.removeChildAnimationPercentage = 0,
    super.key,
  });

  @override
  _FAccordionState createState() => _FAccordionState();
}

class _FAccordionState extends State<FAccordion> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool _isExpanded = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: _isExpanded ? 1.0 : 0.0,
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: controller,
      ),
    )..addListener(() {
        setState(() {});
      });

    _isExpanded ? controller.forward() : controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.accordionStyle;
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: FTappable(
            onPress: () {
              if (_isExpanded) {
                controller.reverse();
              } else {
                controller.forward();
              }
              setState(() => _isExpanded = !_isExpanded);
              widget.onExpanded();
            },
            child: Container(
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
                      style: TextStyle(decoration: _hovered ? TextDecoration.underline : TextDecoration.none),
                      child: Text(
                        widget.title,
                        style: style.title,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: (animation.value / 100 * -180 + 90) * math.pi / 180.0,
                    child: FAssets.icons.chevronRight(
                      height: 20,
                      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
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
          percentage: animation.value / 100.0,
          child: ClipRect(
            clipper: _Clipper(percentage: animation.value / 100.0),
            child: Padding(
              padding: style.contentPadding,
              child: widget.child,
            ),
          ),
        ),
        FDivider(
          style: context.theme.dividerStyles.horizontal
              .copyWith(padding: EdgeInsets.zero, color: context.theme.colorScheme.border),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// The [FAccordion] styles.
final class FAccordionStyle with Diagnosticable {
  /// The title's text style.
  final TextStyle title;

  /// The padding of the title.
  final EdgeInsets titlePadding;

  /// The padding of the content.
  final EdgeInsets contentPadding;

  /// Creates a [FAccordionStyle].
  FAccordionStyle({required this.title, required this.titlePadding, required this.contentPadding});

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [style].
  FAccordionStyle.inherit({required FColorScheme colorScheme, required FStyle style, required FTypography typography})
      : title = typography.base.copyWith(
          fontWeight: FontWeight.w500,
        ),
        titlePadding = const EdgeInsets.symmetric(vertical: 15),
        contentPadding = const EdgeInsets.only(bottom: 15);

  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  @useResult
  FAccordionStyle copyWith({
    TextStyle? title,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
  }) =>
      FAccordionStyle(
        title: title ?? this.title,
        titlePadding: titlePadding ?? this.titlePadding,
        contentPadding: contentPadding ?? this.contentPadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('padding', titlePadding))
      ..add(DiagnosticsProperty('contentPadding', contentPadding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAccordionStyle &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          titlePadding == other.titlePadding &&
          contentPadding == other.contentPadding;

  @override
  int get hashCode => title.hashCode ^ titlePadding.hashCode ^ contentPadding.hashCode;
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
}

class _Clipper extends CustomClipper<Rect> {
  final double percentage;

  _Clipper({required this.percentage});

  @override
  Rect getClip(Size size) => Offset.zero & Size(size.width, size.height * percentage);

  @override
  bool shouldReclip(covariant _Clipper oldClipper) => oldClipper.percentage != percentage;
}
