import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/platform.dart';
import 'package:meta/meta.dart';

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

/// A tooltip displays information related to a widget when focused, hovered over on desktop, and long pressed on
/// Android, Fuchsia and iOS.
///
/// **Note**:
/// On Android, Fuchsia and iOS, the tooltip will not be shown when long pressed if the [child] contains a
/// [GestureDetector] that has a long-press callback.
///
/// See:
/// * https://forui.dev/docs/tooltip for working examples.
/// * [FTooltipController] for controlling a tooltip.
/// * [FTooltipStyle] for customizing a tooltip's appearance.
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

  /// The duration to wait before showing the tooltip after the user hovers over the target. Defaults to 0.5 seconds.
  ///
  /// This duration only applies to hovering over the target. It has no affect on pressing the target on Android,
  /// Fuchsia and iOS.
  final Duration hoverEnterDuration;

  /// The duration to wait before hiding the tooltip after the user has stopped hovering over the target. Defaults to 0.
  ///
  /// This duration only applies to hovering over the target. It has no affect on pressing the target on Android,
  /// Fuchsia and iOS
  final Duration hoverExitDuration;

  /// The duration to wait before hiding the tooltip after the user has stopped pressing the target. Defaults to 1.5
  /// seconds.
  ///
  /// This duration only applies to presses on Android, Fuchsia and iOS. It has no affect on hovering over the target.
  final Duration pressExitDuration;

  /// The tip builder. The child passed to [tipBuilder] will always be null.
  final ValueWidgetBuilder<FTooltipStyle> tipBuilder;

  /// The child.
  final Widget child;

  /// Creates a tooltip that is automatically shown when hovered over on desktop, or long pressed on Android, Fuchsia
  /// and iOS.
  const FTooltip({
    required this.tipBuilder,
    required this.child,
    this.controller,
    this.style,
    this.tipAnchor = Alignment.bottomCenter,
    this.childAnchor = Alignment.topCenter,
    this.shift = FPortalFollowerShift.flip,
    this.hoverEnterDuration = const Duration(milliseconds: 500),
    this.hoverExitDuration = Duration.zero,
    this.pressExitDuration = const Duration(milliseconds: 1500),
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
  })  : manual = true,
        hoverEnterDuration = const Duration(milliseconds: 500),
        hoverExitDuration = Duration.zero,
        pressExitDuration = const Duration(milliseconds: 1500);

  @override
  State<FTooltip> createState() => _FTooltipState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('tipAnchor', tipAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('shift', shift))
      ..add(DiagnosticsProperty('manual', manual))
      ..add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration))
      ..add(DiagnosticsProperty('hoverExitDuration', hoverExitDuration))
      ..add(DiagnosticsProperty('pressExitDuration', pressExitDuration))
      ..add(DiagnosticsProperty('tipBuilder', tipBuilder));
  }
}

class _FTooltipState extends State<FTooltip> with SingleTickerProviderStateMixin {
  late FTooltipController _controller;
  Key _fencingToken = UniqueKey();

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
    final style = widget.style ?? context.theme.tooltipStyle;

    var child = widget.child;
    if (!widget.manual) {
      child = CallbackShortcuts(
        bindings: {
          LogicalKeySet(LogicalKeyboardKey.escape): _exit,
        },
        child: Focus(
          onFocusChange: (focused) async => focused ? _enter() : _exit(),
          child: child,
        ),
      );

      // TODO: haptic feedback.
      if (touchPlatforms.contains(defaultTargetPlatform)) {
        child = GestureDetector(
          onLongPressStart: (_) async {
            _fencingToken = UniqueKey();
            await _controller.show();
          },
          onLongPressEnd: (_) async {
            final fencingToken = _fencingToken = UniqueKey();
            await Future.delayed(widget.pressExitDuration);

            if (fencingToken == _fencingToken) {
              await _controller.hide();
            }
          },
          child: child,
        );
      } else {
        child = MouseRegion(
          onEnter: (_) => _enter(),
          onExit: (_) => _exit(),
          // We have to use a Listener as GestureDetector's arena implementation allows only 1 gesture to win. It is
          // problematic if the child is a button. See https://github.com/flutter/flutter/issues/92103.
          child: Listener(
            onPointerDown: (_) => _exit(),
            child: child,
          ),
        );
      }
    }

    return FPortal(
      controller: _controller._overlay,
      targetAnchor: widget.childAnchor,
      followerAnchor: widget.tipAnchor,
      shift: widget.shift,
      followerBuilder: (context) => Semantics(
        container: true,
        child: FadeTransition(
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
      ),
      child: child,
    );
  }

  Future<void> _enter() async {
    final fencingToken = _fencingToken = UniqueKey();
    await Future.delayed(widget.hoverEnterDuration);

    if (fencingToken == _fencingToken) {
      await _controller.show();
    }
  }

  Future<void> _exit() async {
    final fencingToken = _fencingToken = UniqueKey();
    await Future.delayed(widget.hoverExitDuration);

    if (fencingToken == _fencingToken) {
      await _controller.hide();
    }
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
  /// The tooltip's default shadow in [FTooltipStyle.inherit].
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

  /// Creates a [FTooltipStyle].
  const FTooltipStyle({
    required this.decoration,
    required this.textStyle,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  });

  /// Creates a [FTooltipStyle] that inherits its properties from the given [colorScheme], [typography], and [style].
  FTooltipStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
            border: Border.all(
              width: style.borderWidth,
              color: colorScheme.border,
            ),
            boxShadow: shadow,
          ),
          textStyle: typography.sm,
        );

  /// Returns a copy of this [FTooltipStyle] with the given properties replaced.
  @useResult
  FTooltipStyle copyWith({
    BoxDecoration? decoration,
    TextStyle? textStyle,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) =>
      FTooltipStyle(
        decoration: decoration ?? this.decoration,
        textStyle: textStyle ?? this.textStyle,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTooltipStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          margin == other.margin &&
          padding == other.padding &&
          textStyle == other.textStyle;

  @override
  int get hashCode => decoration.hashCode ^ margin.hashCode ^ padding.hashCode ^ textStyle.hashCode;
}
