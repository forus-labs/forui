import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tooltip.design.dart';

/// A controller that controls whether a [FTooltip] is shown or hidden.
final class FTooltipController extends FChangeNotifier {
  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final CurvedAnimation _curveFade;
  late final CurvedAnimation _curveScale;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FTooltipController] with the given [vsync] and [motion].
  FTooltipController({required TickerProvider vsync, FTooltipMotion motion = const FTooltipMotion()}) {
    _animation = AnimationController(
      vsync: vsync,
      duration: motion.entranceDuration,
      reverseDuration: motion.exitDuration,
    );
    _curveFade = CurvedAnimation(parent: _animation, curve: motion.fadeInCurve, reverseCurve: motion.fadeOutCurve);
    _curveScale = CurvedAnimation(parent: _animation, curve: motion.expandCurve, reverseCurve: motion.collapseCurve);
    _fade = motion.fadeTween.animate(_curveFade);
    _scale = motion.scaleTween.animate(_curveScale);
  }

  /// Convenience method for showing/hiding the tooltip.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle() async =>
      const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_animation.status) ? hide() : show();

  /// Shows the tooltip.
  ///
  /// If already shown, calling this method brings the tooltip to the top.
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
  /// widgets in the tooltip may lose their states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    await _animation.reverse();
    _overlay.hide();
    notifyListeners();
  }

  /// The current status.
  ///
  /// [AnimationStatus.dismissed] - The tooltip is hidden.
  /// [AnimationStatus.forward] - The tooltip is transitioning from hidden to shown.
  /// [AnimationStatus.completed] - The tooltip is shown.
  /// [AnimationStatus.reverse] - The tooltip is transitioning from shown to hidden.
  AnimationStatus get status => _animation.status;

  @override
  void dispose() {
    _curveFade.dispose();
    _curveScale.dispose();
    _animation.dispose();
    super.dispose();
  }
}

/// Motion-related properties for [FTooltip].
class FTooltipMotion with Diagnosticable, _$FTooltipMotionFunctions {
  /// A [FTooltipMotion] with no motion effects.
  static const FTooltipMotion none = FTooltipMotion(
    scaleTween: FImmutableTween(begin: 1, end: 1),
    fadeTween: FImmutableTween(begin: 1, end: 1),
  );

  /// The tooltip's entrance duration. Defaults to 100ms.
  @override
  final Duration entranceDuration;

  /// The tooltip's exit duration. Defaults to 100ms.
  @override
  final Duration exitDuration;

  /// The curve used for the tooltip's expansion animation when entering. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The curve used for the tooltip's collapse animation when exiting. Defaults to [Curves.easeOutCubic].
  @override
  final Curve collapseCurve;

  /// The curve used for the tooltip's fade-in animation when entering. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve used for the tooltip's fade-out animation when exiting. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// The tooltip's scale tween. Defaults to a tween from 0.93 to 1.
  @override
  final Animatable<double> scaleTween;

  /// The tooltip's fade tween. Defaults to a tween from 0 to 1.
  @override
  final Animatable<double> fadeTween;

  /// Creates a [FTooltipMotion].
  const FTooltipMotion({
    this.entranceDuration = const Duration(milliseconds: 100),
    this.exitDuration = const Duration(milliseconds: 100),
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeOutCubic,
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
    this.scaleTween = const FImmutableTween(begin: 0.93, end: 1),
    this.fadeTween = const FImmutableTween(begin: 0, end: 1),
  });
}

/// A tooltip displays information related to a widget when focused, hovered over, or long pressed.
///
/// **Note**:
/// The tooltip will not be shown when long pressed if the [child] contains a [GestureDetector] that has a long-press
/// callback.
///
/// See:
/// * https://forui.dev/docs/overlay/tooltip for working examples.
/// * [FTooltipController] for controlling a tooltip.
/// * [FTooltipStyle] for customizing a tooltip's appearance.
class FTooltip extends StatefulWidget {
  static Widget _builder(BuildContext _, FTooltipController _, Widget? child) => child!;

  /// The controller.
  final FTooltipController? controller;

  /// The tooltip's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tooltip
  /// ```
  final FTooltipStyle Function(FTooltipStyle style)? style;

  /// The anchor point on the tip used for positioning relative to the [childAnchor].
  ///
  /// For example, with `tipAnchor: Alignment.bottomCenter` and `childAnchor: Alignment.topCenter`,
  /// the tip's bottom edge will align with the child's top edge.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry tipAnchor;

  /// The anchor point on the [child] used for positioning relative to the [tipAnchor].
  ///
  /// For example, with `childAnchor: Alignment.topCenter` and `tipAnchor: Alignment.bottomCenter`,
  /// the child's top edge will align with the tip's bottom edge.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry childAnchor;

  /// The spacing between the [tipAnchor] and [childAnchor].
  ///
  /// Applied before [overflow].
  ///
  /// Defaults to `FPortalSpacing(4)`.
  final FPortalSpacing spacing;

  /// The callback used to shift a tooltip's tip when it overflows out of the viewport.
  ///
  /// Applied after [spacing].
  ///
  /// See [FPortalOverflow] for the different overflow strategies.
  ///
  /// Defaults to [FPortalOverflow.flip].
  final FPortalOverflow overflow;

  /// True if the tooltip should be shown when hovered over. Defaults to true.
  final bool hover;

  /// The duration to wait before showing the tooltip after the user hovers over the target. Defaults to 0.5 seconds.
  final Duration hoverEnterDuration;

  /// The duration to wait before hiding the tooltip after the user has stopped hovering over the target. Defaults to 0.
  final Duration hoverExitDuration;

  /// True if the tooltip should be shown when long pressed. Defaults to true.
  final bool longPress;

  /// The duration to wait before hiding the tooltip after the user has stopped pressing the target. Defaults to 1.5
  /// seconds.
  final Duration longPressExitDuration;

  /// The tip builder. The child passed to [tipBuilder] will always be null.
  final Widget Function(BuildContext context, FTooltipController controller) tipBuilder;

  /// An optional builder which returns the child widget that the tooltip is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [builder] builds does not require the controller.
  final ValueWidgetBuilder<FTooltipController> builder;

  /// The child to which the tip is aligned to.
  final Widget? child;

  /// Creates a tooltip.
  ///
  /// ## Contract
  /// Throws [AssertionError] if neither [builder] nor [child] is both provided.
  const FTooltip({
    required this.tipBuilder,
    this.controller,
    this.style,
    this.tipAnchor = Alignment.bottomCenter,
    this.childAnchor = Alignment.topCenter,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.hover = true,
    this.hoverEnterDuration = const Duration(milliseconds: 500),
    this.hoverExitDuration = Duration.zero,
    this.longPress = true,
    this.longPressExitDuration = const Duration(milliseconds: 1500),
    this.builder = _builder,
    this.child,
    super.key,
  }) : assert(builder != _builder || child != null, 'Either builder or child must be provided.');

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
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(FlagProperty('hover', value: hover, ifTrue: 'hover'))
      ..add(DiagnosticsProperty('hoverEnterDuration', hoverEnterDuration))
      ..add(DiagnosticsProperty('hoverExitDuration', hoverExitDuration))
      ..add(FlagProperty('longPress', value: longPress, ifTrue: 'longPress'))
      ..add(DiagnosticsProperty('longPressExitDuration', longPressExitDuration))
      ..add(ObjectFlagProperty.has('tipBuilder', tipBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _FTooltipState extends State<FTooltip> with SingleTickerProviderStateMixin {
  final FocusNode _focus = FocusNode(debugLabel: 'FTooltip', canRequestFocus: false, skipTraversal: true);
  late FTooltipController _controller = widget.controller ?? FTooltipController(vsync: this);
  int _monotonic = 0;

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
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.tooltipStyle) ?? context.theme.tooltipStyle;
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;

    var child = widget.builder(context, _controller, widget.child);
    if (widget.hover || widget.longPress) {
      child = CallbackShortcuts(
        bindings: {const SingleActivator(LogicalKeyboardKey.escape): _exit},
        child: Focus(
          // This is required as onFocusChange is not called when focus is shifted from a child to a nested child.
          onKeyEvent: (_, event) {
            _toggle(_focus.hasFocus);
            return KeyEventResult.ignored;
          },
          focusNode: _focus,
          onFocusChange: _toggle,
          child: child,
        ),
      );
    }

    if (widget.hover) {
      child = MouseRegion(
        onEnter: (_) => _enter(),
        onExit: (_) => _exit(),
        // We have to use a Listener as GestureDetector's arena implementation allows only 1 gesture to win. It is
        // problematic if the child is a button. See https://github.com/flutter/flutter/issues/92103.
        child: Listener(onPointerDown: (_) => _exit(), child: child),
      );
    }

    // TODO: haptic feedback.
    if (widget.longPress) {
      child = GestureDetector(
        onLongPressStart: (_) async {
          _monotonic++;
          await _controller.show();
        },
        onLongPressEnd: (_) async {
          final count = ++_monotonic;
          await Future.delayed(widget.longPressExitDuration);

          if (count == _monotonic && !_controller.disposed) {
            await _controller.hide();
          }
        },
        child: child,
      );
    }

    return BackdropGroup(
      child: FPortal(
        controller: _controller._overlay,
        spacing: widget.spacing,
        childAnchor: widget.childAnchor,
        portalAnchor: widget.tipAnchor,
        overflow: widget.overflow,
        portalBuilder: (context, _) {
          Widget tooltip = Semantics(
            container: true,
            child: FadeTransition(
              opacity: _controller._fade,
              child: ScaleTransition(
                alignment: widget.tipAnchor.resolve(direction),
                scale: _controller._scale,
                child: DecoratedBox(
                  decoration: style.decoration,
                  child: Padding(
                    padding: style.padding,
                    child: DefaultTextStyle(style: style.textStyle, child: widget.tipBuilder(context, _controller)),
                  ),
                ),
              ),
            ),
          );

          // The background filter cannot be nested in a FadeTransition because of https://github.com/flutter/flutter/issues/31706.
          if (style.backgroundFilter case final background?) {
            tooltip = Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(filter: background, child: Container()),
                  ),
                ),
                tooltip,
              ],
            );
          }

          return tooltip;
        },
        child: child,
      ),
    );
  }

  Future<void> _toggle(bool focused) {
    if (!focused) {
      return _exit();
    }

    final descendants = Queue.of(_focus.children);
    while (descendants.isNotEmpty) {
      final current = descendants.removeFirst();
      if (current.hasPrimaryFocus) {
        return _enter();
      }

      if (!current.canRequestFocus) {
        descendants.addAll(current.children);
      }
    }

    return _exit();
  }

  Future<void> _enter() async {
    final fencingToken = ++_monotonic;
    await Future.delayed(widget.hoverEnterDuration);

    if (fencingToken == _monotonic && !_controller.disposed) {
      await _controller.show();
    }
  }

  Future<void> _exit() async {
    final count = ++_monotonic;
    await Future.delayed(widget.hoverExitDuration);

    if (count == _monotonic && !_controller.disposed) {
      await _controller.hide();
    }
  }
}

/// A [FTooltip]'s style.
class FTooltipStyle with Diagnosticable, _$FTooltipStyleFunctions {
  /// The tooltip's default shadow in [FTooltipStyle.inherit].
  static const shadow = [
    BoxShadow(color: Color(0x1a000000), offset: Offset(0, 4), blurRadius: 6, spreadRadius: -1),
    BoxShadow(color: Color(0x1a000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: -2),
  ];

  /// The box decoration.
  @override
  final BoxDecoration decoration;

  /// An optional background filter applied to the tooltip.
  ///
  /// This is typically combined with a translucent background in [decoration] to create a glassmorphic effect.
  @override
  final ImageFilter? backgroundFilter;

  /// The padding surrounding the tooltip's text.
  @override
  final EdgeInsets padding;

  /// The tooltip's default text style.
  @override
  final TextStyle textStyle;

  /// Creates a [FTooltipStyle].
  const FTooltipStyle({
    required this.decoration,
    required this.textStyle,
    this.backgroundFilter,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  });

  /// Creates a [FTooltipStyle] that inherits its properties.
  FTooltipStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: style.borderRadius,
          border: Border.all(width: style.borderWidth, color: colors.border),
          boxShadow: FTooltipStyle.shadow,
        ),
        textStyle: typography.sm,
      );
}
