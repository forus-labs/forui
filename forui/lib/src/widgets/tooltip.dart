import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tooltip.style.dart';

/// A controller that controls whether a [FTooltip] is shown or hidden.
class FTooltipController extends FChangeNotifier {
  static final _fadeTween = Tween<double>(begin: 0, end: 1);
  static final _scaleTween = Tween<double>(begin: 0.95, end: 1);

  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final CurvedAnimation _curveFade;
  late final CurvedAnimation _curveScale;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  /// Creates a [FTooltipController] with the given [vsync] and animation [animationDuration].
  FTooltipController({required TickerProvider vsync, Duration animationDuration = const Duration(milliseconds: 100)}) {
    _animation = AnimationController(vsync: vsync, duration: animationDuration);
    _curveFade = CurvedAnimation(parent: _animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeOutCubic);
    _curveScale = CurvedAnimation(parent: _animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeOutCubic);
    _fade = _fadeTween.animate(_curveFade);
    _scale = _scaleTween.animate(_curveScale);
  }

  /// Convenience method for toggling the current [shown] status.
  ///
  /// This method should typically not be called while the widget tree is being
  /// rebuilt.
  Future<void> toggle() async => shown ? hide() : show();

  /// Shows the tooltip.
  ///
  /// If [shown] is already true, calling this method brings the tooltip to the top.
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

  /// True if the tooltip is currently being shown. False if it is hidden.
  bool get shown => _overlay.isShowing;

  @override
  void dispose() {
    _curveFade.dispose();
    _curveScale.dispose();
    _animation.dispose();
    super.dispose();
  }
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

  /// The tooltip's controller.
  final FTooltipController? controller;

  /// The tooltip's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tooltip
  /// ```
  final FTooltipStyle? style;

  /// The anchor of the follower to which the [childAnchor] is aligned. Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry tipAnchor;

  /// The anchor of the target to which the [tipAnchor] is aligned. Defaults to [Alignment.topCenter].
  final AlignmentGeometry childAnchor;

  /// The spacing between the child's anchor and tooltip's anchor. Defaults to `FPortalSpacing(4)`.
  ///
  /// It applied before [shift].
  final FPortalSpacing spacing;

  /// The shifting strategy used to shift a tooltip's tip when it overflows out of the viewport. Defaults to
  /// [FPortalShift.flip].
  ///
  /// See [FPortalShift] for more information on the different shifting strategies.
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

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
  final Widget Function(BuildContext, FTooltipController) tipBuilder;

  /// An optional builder which returns the child widget that the tooltip is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [builder] builds doest not require the controller.
  final ValueWidgetBuilder<FTooltipController> builder;

  /// The child tp which the tip is aligned to.
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
    this.shift = FPortalShift.flip,
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
      ..add(ObjectFlagProperty.has('shift', shift))
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.tooltipStyle;
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;

    var child = widget.builder(context, _controller, widget.child);
    if (widget.hover || widget.longPress) {
      child = CallbackShortcuts(
        bindings: {const SingleActivator(LogicalKeyboardKey.escape): _exit},
        child: Focus(onFocusChange: (focused) async => focused ? _enter() : _exit(), child: child),
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
        shift: widget.shift,
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
