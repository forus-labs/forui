import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';

/// A controller that stores the expanded state of an [_Item].
interface class FAccordionController extends ChangeNotifier {
  final Duration duration;
  final List<(AnimationController, Animation)> _controllers;
  final int _min;
  final int? _max;

  /// Creates a [FAccordionController].
  ///
  /// The [min] and [max] values are the minimum and maximum number of selections allowed. Defaults to no minimum or maximum.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [min] < 0.
  /// * Throws [AssertionError] if [max] < 0.
  /// * Throws [AssertionError] if [min] > [max].
  FAccordionController({
    int min = 0,
    int? max,
    this.duration = const Duration(milliseconds: 500),
  })  : _min = min,
        _max = max,
        _controllers = [],
        assert(min >= 0, 'The min value must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max value must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max value must be greater than or equal to the min value.');

  void addItem(int index, AnimationController controller, Animation expand) {
    _controllers[index] = (controller, expand);
  }

  void removeItem(int index) => _controllers.remove(index);

  /// Convenience method for toggling the current [expanded] status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle(int index) async {}

  /// Shows the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> expand(int index) async {}

  /// Hides the content in the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> collapse(int index) async {}
}

// class RadioAccordionController implements FAccordionController {
//   final Duration duration;
//   final List<(AnimationController, Animation)> _controllers;
//   final int? min;
//   final int? max;
//
//   RadioAccordionController({
//     this.duration = const Duration(milliseconds: 500),
//   }) : super(duration: duration);
//
//   @override
//   void addItem(int index, AnimationController controller, Animation expand) {
//     _controllers[index] = (controller, expand);
//   }
//
//   @override
//   void removeItem(int index) => _controllers.remove(index);
//
//   @override
//   Future<void> toggle(int index) async {
//     final controller = _controllers[index].item;
//     controller.isCompleted ? controller.reverse() : controller.forward();
//   }
//
//   @override
//   Future<void> expand(int index) async {
//     final controller = _controllers[index].item;
//     controller.forward();
//   }
//
//   @override
//   Future<void> collapse(int index) async {
//     final controller = _controllers[index].item1;
//     controller.reverse();
//   }
// }

class FAccordion extends StatefulWidget {
  final FAccordionController? controller;
  final List<FAccordionItem> items;
  final FAccordionStyle? style;

  const FAccordion({
    required this.items,
    this.controller,
    this.style,
    super.key,
  });

  @override
  State<FAccordion> createState() => _FAccordionState();
}

class _FAccordionState extends State<FAccordion> {
  late final FAccordionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FAccordionController();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.accordionStyle;
    return Column(
      children: [
        for (var i = 0; i < widget.items.length; i++)
          _Item(
            style: style,
            index: i,
            item: widget.items[i],
            controller: _controller,
          ),
      ],
    );
  }
}

class FAccordionItem {
  /// The title.
  final Widget title;

  /// The child.
  final Widget child;

  /// Whether the item is initially expanded.
  final bool initiallyExpanded;

  FAccordionItem({required this.title, required this.child, this.initiallyExpanded = false});
}

/// An interactive heading that reveals a section of content.
///
/// See:
/// * https://forui.dev/docs/accordion for working examples.
class _Item extends StatefulWidget {
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
      ..add(DiagnosticsProperty('controller', controller));
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
      duration: _controller.duration,
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
    widget.controller.addItem(widget.index, _controller, _expand);
  }

  @override
  void didUpdateWidget(covariant _Item old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller = AnimationController(
        duration: _controller.duration,
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
      widget.controller.addItem(widget.index, _controller, _expand);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.accordionStyle;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Column(
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: FTappable(
              onPress: () {
                if (_controller.value == 1) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
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
                        style: style.titleTextStyle
                            .copyWith(decoration: _hovered ? TextDecoration.underline : TextDecoration.none),
                        child: widget.item.title,
                      ),
                    ),
                    Transform.rotate(
                      angle: (_controller.value / 100 * -180 + 90) * math.pi / 180.0,
                      child: style.icon,
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
            percentage: _controller.value / 100.0,
            child: ClipRect(
              clipper: _Clipper(percentage: _controller.value / 100.0),
              child: Padding(
                padding: style.contentPadding,
                child: DefaultTextStyle(style: style.childTextStyle, child: widget.item.child),
              ),
            ),
          ),
          FDivider(
            style: context.theme.dividerStyles.horizontal.copyWith(padding: EdgeInsets.zero, color: style.dividerColor),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
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

/// The [_Item] styles.
final class FAccordionStyle with Diagnosticable {
  /// The title's text style.
  final TextStyle titleTextStyle;

  /// The child's default text style.
  final TextStyle childTextStyle;

  /// The padding of the title.
  final EdgeInsets titlePadding;

  /// The padding of the content.
  final EdgeInsets contentPadding;

  /// The icon.
  final SvgPicture icon;

  /// The divider's color.
  final Color dividerColor;

  /// Creates a [FAccordionStyle].
  FAccordionStyle({
    required this.titleTextStyle,
    required this.childTextStyle,
    required this.titlePadding,
    required this.contentPadding,
    required this.icon,
    required this.dividerColor,
  });

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme].
  FAccordionStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : titleTextStyle = typography.base.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.foreground,
        ),
        childTextStyle = typography.sm.copyWith(
          color: colorScheme.foreground,
        ),
        titlePadding = const EdgeInsets.symmetric(vertical: 15),
        contentPadding = const EdgeInsets.only(bottom: 15),
        icon = FAssets.icons.chevronRight(
          height: 20,
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),
        dividerColor = colorScheme.border;

  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  @useResult
  FAccordionStyle copyWith({
    TextStyle? titleTextStyle,
    TextStyle? childTextStyle,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    SvgPicture? icon,
    Color? dividerColor,
  }) =>
      FAccordionStyle(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        childTextStyle: childTextStyle ?? this.childTextStyle,
        titlePadding: titlePadding ?? this.titlePadding,
        contentPadding: contentPadding ?? this.contentPadding,
        icon: icon ?? this.icon,
        dividerColor: dividerColor ?? this.dividerColor,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('title', titleTextStyle))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle))
      ..add(DiagnosticsProperty('padding', titlePadding))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(ColorProperty('dividerColor', dividerColor));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAccordionStyle &&
          runtimeType == other.runtimeType &&
          titleTextStyle == other.titleTextStyle &&
          childTextStyle == other.childTextStyle &&
          titlePadding == other.titlePadding &&
          contentPadding == other.contentPadding &&
          icon == other.icon &&
          dividerColor == other.dividerColor;

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      childTextStyle.hashCode ^
      titlePadding.hashCode ^
      contentPadding.hashCode ^
      icon.hashCode ^
      dividerColor.hashCode;
}
