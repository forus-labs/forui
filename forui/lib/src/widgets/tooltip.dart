import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
final class FTooltipController extends ChangeNotifier {
  static final _fadeTween = Tween<double>(begin: 0, end: 1);
  static final _scaleTween = Tween<double>(begin: 0.95, end: 1);

  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FTooltipController] with the given [vsync] and animation [duration].
  FTooltipController({required TickerProvider vsync, duration = const Duration(milliseconds: 100)}) {
    _animation = AnimationController(vsync: vsync, duration: duration);
    _fade = _fadeTween.animate(_animation);
    _scale = _scaleTween.animate(_animation);
  }

  /// Convenience method for toggling the current [shown] status.
  ///
  /// This method should typically not be called while the widget tree is being
  /// rebuilt.
  Future<void> toggle() async => shown ? hide() : show();

  /// Shows the tooltip.
  ///
  /// If [shown] is already true, calling this method brings the tooltip it controls to the top.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> show() async {
    _overlay.show();
    await _animation.forward();
    notifyListeners();
  }

  /// Hides the tooltip.
  ///
  /// Once hidden, the tooltip will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the tooltip may lose states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    await _animation.reverse();
    _overlay.hide();
    notifyListeners();
  }

  /// True if the tooltip is currently being shown. False if it is hidden.
  bool get shown => _overlay.isShowing;

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class FTooltip extends StatefulWidget {
  /// The tooltip's controller.
  final FTooltipController? controller;

  /// The tooltip's style.
  final FTooltipStyle? style;

  /// The anchor of the follower to which the [childAnchor] is aligned to. Defaults to [Alignment.bottomCenter].
  final Alignment tipAnchor;

  /// The anchor of the target to which the [tipAnchor] is aligned to. Defaults to [Alignment.topCenter].
  final Alignment childAnchor;

  /// The shifting strategy used to shift a tooltip's tip when it overflows out of the viewport. Defaults to
  /// [FPortalFollowerShift.flip].
  ///
  /// See [FPortalFollowerShift] for more information on the different shifting strategies.
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  /// True if the tooltip can only be shown manually by calling [FTooltipController.show].
  final bool manual;

  /// The tip builder. The child passed to [tipBuilder] will always be null.
  final ValueWidgetBuilder<FTooltipStyle> tipBuilder;

  /// The child.
  final Widget child;

  /// Creates a tooltip that is automatically shown when hovered over on desktop, or long pressed on Android and iOS.
  const FTooltip({
    required this.tipBuilder,
    required this.child,
    this.controller,
    this.style,
    this.tipAnchor = Alignment.bottomCenter,
    this.childAnchor = Alignment.topCenter,
    this.shift = FPortalFollowerShift.flip,
    super.key,
  }) : manual = false;

  /// Creates a tooltip that is manually shown only through its controller.
  const FTooltip.manual({
    required this.tipBuilder,
    required this.child,
    required FTooltipController this.controller,
    this.style,
    this.tipAnchor = Alignment.bottomCenter,
    this.childAnchor = Alignment.topCenter,
    this.shift = FPortalFollowerShift.flip,
    super.key,
  })  : manual = true;

  @override
  State<FTooltip> createState() => _FTooltipState();
}

class _FTooltipState extends State<FTooltip> with SingleTickerProviderStateMixin {
  late FTooltipController _controller;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FTooltipController(vsync: this);
  }


  @override
  void didUpdateWidget(covariant FTooltip old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }

      _controller = widget.controller ?? FTooltipController(vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style!; // TODO: get style from context.

    var child = widget.child;
    if (!widget.manual) {
      child = MouseRegion(
        onEnter: (_) async {
          _hovered = true;
          // TODO: waitDuration and showDuration
          await _controller.show();
        },
        onExit: (_) async {
          _hovered = false;
          // TODO: exitDuration
          await _controller.hide();
        },
        child: GestureDetector( // TODO: haptic feedback.
          child: widget.child,
        ),
      );
    }

    return FPortal(
      controller: _controller._overlay,
      targetAnchor: widget.childAnchor,
      followerAnchor: widget.tipAnchor,
      shift: widget.shift,
      followerBuilder: (context) => FadeTransition(
        opacity: _controller._fade,
        child: ScaleTransition(
          scale: _controller._scale,
          child: Padding(
            padding: style.margin,
            child: DecoratedBox(
              decoration: style.decoration,
              child: Padding(
                padding: style.padding,
                child: DefaultTextStyle(
                  style: style.textStyle,
                  child: widget.tipBuilder(context, style, null),
                ),
              ),
            ),
          ),
        ),
      ),
      child: child,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// A [FTooltip]'s style.
final class FTooltipStyle with Diagnosticable {
  /// The tooltip's default shadow in [FTooltip.inherit].
  static const shadow = [
    BoxShadow(
      color: Color(0x1a000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x1a000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  /// The box decoration.
  final BoxDecoration decoration;

  /// The margin surrounding the tooltip.
  final EdgeInsets margin;

  /// The padding surrounding the tooltip's text.
  final EdgeInsets padding;

  /// The tooltip's default text style.
  final TextStyle textStyle;
}
