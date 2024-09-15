import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/foundation/util.dart';
import 'package:meta/meta.dart';

/// A controller that stores the expanded state of an [FAccordion].
class FAccordionController extends ChangeNotifier {
  late final AnimationController _animation;
  late final Animation<double> _expand;

  /// Creates a [FAccordionController].
  FAccordionController({
    required TickerProvider vsync,
    duration = const Duration(milliseconds: 500),
    bool initiallyExpanded = true,
  }) {
    _animation = AnimationController(
      duration: duration,
      value: initiallyExpanded ? 1.0 : 0.0,
      vsync: vsync,
    );
    _expand = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _animation,
      ),
    )..addListener(notifyListeners);
  }

  /// Convenience method for toggling the current [expanded] status.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle() async => expanded ? close() : expand();

  /// Expands the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> expand() async {
    await _animation.forward();
    notifyListeners();
  }

  /// closes the accordion.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> close() async {
    await _animation.reverse();
    notifyListeners();
  }

  /// True if the accordion is expanded. False if it is closed.
  bool get expanded => _animation.value == 1.0;

  /// The animation value.
  double get value => _expand.value;

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

/// A vertically stacked set of interactive headings that each reveal a section of content.
///
/// See:
/// * https://forui.dev/docs/accordion for working examples.
class FAccordion extends StatefulWidget {
  /// The accordion's style. Defaults to the appropriate style in [FThemeData.accordionStyle].
  final FAccordionStyle? style;

  /// The title.
  final String title;

  /// The accordion's controller.
  final FAccordionController? controller;

  /// Whether the accordion is initially expanded. Defaults to true.
  final bool initiallyExpanded;

  /// The child.
  final Widget child;

  /// Creates an [FAccordion].
  const FAccordion({
    required this.child,
    this.style,
    this.title = '',
    this.controller,
    this.initiallyExpanded = true,
    super.key,
  });

  @override
  //ignore:library_private_types_in_public_api
  _FAccordionState createState() => _FAccordionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('initiallyExpanded', initiallyExpanded));
  }
}

class _FAccordionState extends State<FAccordion> with SingleTickerProviderStateMixin {
  late FAccordionController _controller;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        FAccordionController(
          vsync: this,
          initiallyExpanded: widget.initiallyExpanded,
        );
  }

  @override
  void didUpdateWidget(covariant FAccordion old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? FAccordionController(vsync: this);
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
              onPress: () => _controller.toggle(),
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
                          style: style.titleTextStyle,
                        ),
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
                child: DefaultTextStyle(style: style.childTextStyle, child: widget.child),
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
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', _controller));
  }
}

/// The [FAccordion] styles.
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
