import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'popover.design.dart';

/// A controller that controls whether a [FPopover] is shown or hidden.
final class FPopoverController extends FChangeNotifier {
  final OverlayPortalController _overlay = OverlayPortalController();
  late final AnimationController _animation;
  late final CurvedAnimation _curveScale;
  late final CurvedAnimation _curveFade;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  /// Creates a [FPopoverController] with the given [vsync] and [motion].
  FPopoverController({required TickerProvider vsync, FPopoverMotion motion = const FPopoverMotion()}) {
    _animation = AnimationController(
      vsync: vsync,
      duration: motion.entranceDuration,
      reverseDuration: motion.exitDuration,
    );
    _curveFade = CurvedAnimation(parent: _animation, curve: motion.fadeInCurve, reverseCurve: motion.fadeOutCurve);
    _curveScale = CurvedAnimation(parent: _animation, curve: motion.expandCurve, reverseCurve: motion.collapseCurve);
    _scale = motion.scaleTween.animate(_curveScale);
    _fade = motion.fadeTween.animate(_curveFade);
  }

  /// Convenience method for showing/hiding the popover.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> toggle() async =>
      const {AnimationStatus.completed, AnimationStatus.reverse}.contains(_animation.status) ? hide() : show();

  /// Shows the popover.
  ///
  /// If already shown, calling this method brings the popover to the top.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> show() async {
    _overlay.show();
    await _animation.forward();
    notifyListeners();
  }

  /// Hides the popover.
  ///
  /// Once hidden, the popover will be removed from the widget tree the next time the widget tree rebuilds, and stateful
  /// widgets in the popover may lose their states as a result.
  ///
  /// This method should typically not be called while the widget tree is being rebuilt.
  Future<void> hide() async {
    await _animation.reverse();
    _overlay.hide();
    notifyListeners();
  }

  /// The current status.
  ///
  /// [AnimationStatus.dismissed] - The popover is hidden.
  /// [AnimationStatus.forward] - The popover is transitioning from hidden to shown.
  /// [AnimationStatus.completed] - The popover is shown.
  /// [AnimationStatus.reverse] - The popover is transitioning from shown to hidden.
  AnimationStatus get status => _animation.status;

  @override
  void dispose() {
    _curveFade.dispose();
    _curveScale.dispose();
    _animation.dispose();
    super.dispose();
  }
}

/// Motion-related properties for [FPopover].
class FPopoverMotion with Diagnosticable, _$FPopoverMotionFunctions {
  /// A [FPopoverMotion] with no motion effects.
  static const FPopoverMotion none = FPopoverMotion(
    scaleTween: FImmutableTween(begin: 1, end: 1),
    fadeTween: FImmutableTween(begin: 1, end: 1),
  );

  /// The popover's entrance duration. Defaults to 120ms.
  @override
  final Duration entranceDuration;

  /// The popover's exit duration. Defaults to 100ms.
  @override
  final Duration exitDuration;

  /// The curve used for the popover's expansion animation when entering. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The curve used for the popover's collapse animation when exiting. Defaults to [Curves.easeInCubic].
  @override
  final Curve collapseCurve;

  /// The curve used for the popover's fade-in animation when entering. Defaults to [Curves.linear].
  @override
  final Curve fadeInCurve;

  /// The curve used for the popover's fade-out animation when exiting. Defaults to [Curves.linear].
  @override
  final Curve fadeOutCurve;

  /// The popover's scale tween. Defaults to a tween from 0.93 to 1.
  @override
  final Animatable<double> scaleTween;

  /// The popover's fade tween. Defaults to a tween from 0 to 1.
  @override
  final Animatable<double> fadeTween;

  /// Creates a [FPopoverMotion].
  const FPopoverMotion({
    this.entranceDuration = const Duration(milliseconds: 100),
    this.exitDuration = const Duration(milliseconds: 100),
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeInCubic,
    this.fadeInCurve = Curves.linear,
    this.fadeOutCurve = Curves.linear,
    this.scaleTween = const FImmutableTween(begin: 0.93, end: 1),
    this.fadeTween = const FImmutableTween(begin: 0, end: 1),
  });
}

/// The regions that can be tapped to hide a popover.
enum FPopoverHideRegion {
  /// Tapping anywhere outside the popover (including the child widget) will hide the popover.
  ///
  /// Use this when the child does not toggle the popover itself, such as when the child is a static element or label.
  anywhere,

  /// The entire screen, excluding the child and popover.
  ///
  /// Use this when the child toggles the popover, such as when the child is a button or interactive element.
  excludeChild,

  /// Disables tapping outside of the popover to hide it.
  ///
  /// Use this when you want the popover to only be dismissed programmatically, such as via a close button inside the
  /// popover or a controller.
  none,
}

/// A popover displays rich content in a portal that is aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover for working examples.
/// * [FPopoverController] for controlling a popover.
/// * [FPopoverStyle] for customizing a popover's appearance.
class FPopover extends StatefulWidget {
  /// The platform-specific default popover and child anchors.
  static ({Alignment popover, Alignment child}) get defaultPlatform => FTouch.primary
      ? (popover: Alignment.bottomCenter, child: Alignment.topCenter)
      : (popover: Alignment.topCenter, child: Alignment.bottomCenter);

  static Widget _builder(BuildContext _, FPopoverController _, Widget? child) => child!;

  /// The controller.
  final FPopoverController? controller;

  /// The popover's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover
  /// ```
  final FPopoverStyle Function(FPopoverStyle style)? style;

  /// The popover's size constraints.
  final FPortalConstraints constraints;

  /// {@template forui.widgets.FPopover.popoverAnchor}
  /// The anchor point on the popover used for positioning relative to the [childAnchor].
  ///
  /// For example, with `popoverAnchor: Alignment.topCenter` and `childAnchor: Alignment.bottomCenter`,
  /// the popover's top edge will align with the child's bottom edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final AlignmentGeometry popoverAnchor;

  /// {@template forui.widgets.FPopover.childAnchor}
  /// The anchor point on the [child] used for positioning relative to the popover's anchor.
  ///
  /// For example, with `childAnchor: Alignment.bottomCenter` and `popoverAnchor: Alignment.topCenter`,
  /// the child's bottom edge will align with the popover's top edge.
  /// {@endtemplate}
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final AlignmentGeometry childAnchor;

  /// {@template forui.widgets.FPopover.spacing}
  /// The spacing between the popover and child anchors.
  ///
  /// Applied before [overflow].
  /// {@endtemplate}
  ///
  /// Defaults to `FPortalSpacing(4)`.
  final FPortalSpacing spacing;

  /// {@template forui.widgets.FPopover.overflow}
  /// The callback used to shift a popover when it overflows out of the viewport.
  ///
  /// Applied after [spacing] and before [offset].
  ///
  /// See [FPortalOverflow] for the different overflow strategies.
  /// {@endtemplate}
  ///
  /// Defaults to [FPortalOverflow.flip].
  final FPortalOverflow overflow;

  /// {@template forui.widgets.FPopover.offset}
  /// Additional translation to apply to the popover's position.
  ///
  /// Applied after [overflow].
  /// {@endtemplate}
  ///
  /// Defaults to [Offset.zero].
  final Offset offset;

  /// {@template forui.widgets.FPopover.groupId}
  /// An optional group ID that groups [TapRegion]s together so that they operate as one region. If a tap occurs outside
  /// of all group members, then group members that are shown will be hidden.
  ///
  /// If the group id is null, then only this region is hit tested.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the group id is not null and [hideRegion] is not set to
  /// [FPopoverHideRegion.excludeChild].
  /// {@endtemplate}
  final Object? groupId;

  /// {@template forui.widgets.FPopover.hideRegion}
  /// The region that can be tapped to hide the popover.
  /// {@endtemplate}
  ///
  /// Defaults to [FPopoverHideRegion.excludeChild].
  final FPopoverHideRegion hideRegion;

  /// {@template forui.widgets.FPopover.onTapHide}
  /// A callback that is called when the popover is hidden by tapping outside of it.
  /// {@endtemplate}
  ///
  /// This is only called if [hideRegion] is set to [FPopoverHideRegion.anywhere] or [FPopoverHideRegion.excludeChild].
  final VoidCallback? onTapHide;

  /// {@macro forui.foundation.doc_templates.autofocus}
  ///
  /// Auto-focuses if [autofocus] is null and a barrier is provided.
  final bool? autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@template forui.widgets.FPopover.traversalEdgeBehavior}
  /// Controls the transfer of focus beyond the first and the last items in a popover. Defaults to
  /// [TraversalEdgeBehavior.closedLoop].
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [focusNode] and [traversalEdgeBehavior] are not null.
  /// {@endtemplate}
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@template forui.widgets.FPopover.barrierSemanticsLabel}
  /// The popover's barrier label used by accessibility frameworks.
  ///
  /// Ignored if no barrier is provided.
  /// {@endtemplate}
  final String? barrierSemanticsLabel;

  /// {@template forui.widgets.FPopover.barrierSemanticsDismissible}
  /// Whether the barrier semantics are included in the semantics tree. Defaults to true.
  ///
  /// Ignored if no barrier is provided.
  /// {@endtemplate}
  final bool barrierSemanticsDismissible;

  /// The popover's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// The shortcuts and the associated actions.
  ///
  /// Defaults to closing the popover when the escape key is pressed.
  final Map<ShortcutActivator, VoidCallback>? shortcuts;

  /// The popover builder.
  final Widget Function(BuildContext context, FPopoverController controller) popoverBuilder;

  /// {@template forui.widgets.FPopover.builder}
  /// An optional builder which returns the child widget that the popover is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [builder] builds does not require the controller.
  /// {@endtemplate}
  final ValueWidgetBuilder<FPopoverController> builder;

  /// The child which the popover is aligned to.
  final Widget? child;

  /// Creates a popover that only shows the popover when the controller is manually toggled.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if:
  /// * [groupId] is not null and [hideRegion] is not set to [FPopoverHideRegion.excludeChild].
  /// * neither [builder] nor [child] is provided.
  FPopover({
    required this.popoverBuilder,
    this.controller,
    this.style,
    this.constraints = const FPortalConstraints(),
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.groupId,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.semanticsLabel,
    this.shortcuts,
    this.builder = _builder,
    this.child,
    AlignmentGeometry? popoverAnchor,
    AlignmentGeometry? childAnchor,
    super.key,
  }) : assert(
         groupId == null || hideRegion == FPopoverHideRegion.excludeChild,
         'groupId can only be used with FPopoverHideRegion.excludeChild',
       ),
       assert(
         focusNode == null || traversalEdgeBehavior == null,
         'Cannot provide both focusNode and traversalEdgeBehavior',
       ),
       assert(builder != _builder || child != null, 'Either builder or child must be provided'),
       popoverAnchor = popoverAnchor ?? defaultPlatform.popover,
       childAnchor = childAnchor ?? defaultPlatform.child;

  @override
  State<FPopover> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('popoverAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(StringProperty('barrierSemanticsLabel', barrierSemanticsLabel))
      ..add(
        FlagProperty(
          'barrierSemanticsDismissible',
          value: barrierSemanticsDismissible,
          ifTrue: 'barrier semantics dismissible',
        ),
      )
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(ObjectFlagProperty.has('popoverBuilder', popoverBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FPopover> with SingleTickerProviderStateMixin {
  late Object? _groupId = widget.groupId ?? UniqueKey();
  late FPopoverController _controller = widget.controller ?? FPopoverController(vsync: this);
  FocusScopeNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode =
        widget.focusNode ??
        FocusScopeNode(
          debugLabel: 'FPopover',
          traversalEdgeBehavior: widget.traversalEdgeBehavior ?? TraversalEdgeBehavior.closedLoop,
        );
  }

  @override
  void didUpdateWidget(covariant FPopover old) {
    super.didUpdateWidget(old);
    if (widget.groupId != old.groupId) {
      _groupId = widget.groupId ?? UniqueKey();
    }

    if (widget.focusNode != old.focusNode || widget.traversalEdgeBehavior != old.traversalEdgeBehavior) {
      if (old.focusNode == null) {
        _focusNode?.dispose();
      }

      _focusNode =
          widget.focusNode ??
          FocusScopeNode(
            debugLabel: 'FPopover',
            traversalEdgeBehavior: widget.traversalEdgeBehavior ?? TraversalEdgeBehavior.closedLoop,
          );
    }

    if (widget.controller != old.controller) {
      if (old.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? FPopoverController(vsync: this);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }

    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.popoverStyle) ?? context.theme.popoverStyle;
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final localizations = FLocalizations.of(context) ?? FDefaultLocalizations();

    var child = widget.builder(context, _controller, widget.child);

    if (widget.hideRegion == FPopoverHideRegion.excludeChild) {
      child = TapRegion(groupId: _groupId, onTapOutside: (_) => _hide(), child: child);
    }

    return BackdropGroup(
      child: FPortal(
        controller: _controller._overlay,
        constraints: widget.constraints,
        portalAnchor: widget.popoverAnchor,
        childAnchor: widget.childAnchor,
        viewInsets: MediaQuery.viewPaddingOf(context) + style.viewInsets.resolve(direction),
        spacing: widget.spacing,
        overflow: widget.overflow,
        offset: widget.offset,
        barrier: style.barrierFilter == null
            ? null
            : FAnimatedModalBarrier(
                animation: _controller._fade,
                filter: style.barrierFilter!,
                semanticsLabel: widget.barrierSemanticsLabel ?? localizations.barrierLabel,
                barrierSemanticsDismissible: widget.barrierSemanticsDismissible,
                semanticsOnTapHint: localizations.barrierOnTapHint(localizations.popoverSemanticsLabel),
                // The actual dismissal logic is handled in the TapRegion below.
                onDismiss: widget.hideRegion == FPopoverHideRegion.none ? null : () {},
              ),
        portalBuilder: (context, _) {
          Widget popover = ScaleTransition(
            alignment: widget.popoverAnchor.resolve(direction),
            scale: _controller._scale,
            child: FadeTransition(
              opacity: _controller._fade,
              child: Semantics(
                label: widget.semanticsLabel,
                container: true,
                child: FocusScope(
                  autofocus: widget.autofocus ?? (style.barrierFilter != null),
                  node: _focusNode,
                  onFocusChange: widget.onFocusChange,
                  child: TapRegion(
                    groupId: _groupId,
                    onTapOutside: widget.hideRegion == FPopoverHideRegion.none ? null : (_) => _hide(),
                    child: DecoratedBox(
                      decoration: style.decoration,
                      child: widget.popoverBuilder(context, _controller),
                    ),
                  ),
                ),
              ),
            ),
          );

          // The background filter cannot be nested in a FadeTransition because of https://github.com/flutter/flutter/issues/31706.
          if (style.backgroundFilter case final filter?) {
            popover = Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: AnimatedBuilder(
                      animation: _controller._fade,
                      builder: (_, _) => BackdropFilter(filter: filter(_controller._fade.value), child: Container()),
                    ),
                  ),
                ),
                popover,
              ],
            );
          }

          return CallbackShortcuts(
            bindings: widget.shortcuts ?? {const SingleActivator(LogicalKeyboardKey.escape): _hide},
            child: popover,
          );
        },
        child: child,
      ),
    );
  }

  void _hide() {
    // We need to check if it is shown first, otherwise it will fire even when hidden. This messes with the focus
    // when there are multiple FSelects/other widgets.
    if (_controller.status.isForwardOrCompleted) {
      _controller.hide();
      widget.onTapHide?.call();
    }
  }
}

/// A [FPopover]'s style.
class FPopoverStyle with Diagnosticable, _$FPopoverStyleFunctions {
  /// The popover's decoration.
  @override
  final BoxDecoration decoration;

  /// {@template forui.widgets.FPopoverStyle.barrierFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the barrier. Defaults to null.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  @override
  final ImageFilter Function(double animation)? barrierFilter;

  /// {@template forui.widgets.FPopoverStyle.backgroundFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the background. Defaults to null.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  @override
  final ImageFilter Function(double animation)? backgroundFilter;

  /// The additional insets of the view. In other words, the minimum distance between the edges of the view and the
  /// edges of the popover. This applied in addition to the insets provided by [MediaQueryData.viewPadding].
  ///
  /// Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry viewInsets;

  /// Creates a [FPopoverStyle].
  const FPopoverStyle({
    required this.decoration,
    this.barrierFilter,
    this.backgroundFilter,
    this.viewInsets = const EdgeInsets.all(5),
  });

  /// Creates a [FPopoverStyle] that inherits its properties.
  FPopoverStyle.inherit({required FColors colors, required FStyle style})
    : this(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: style.borderRadius,
          border: Border.all(width: style.borderWidth, color: colors.border),
          boxShadow: style.shadow,
        ),
      );
}
