import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/portal/composited_child.dart';
import 'package:forui/src/foundation/portal/composited_portal.dart';
import 'package:forui/src/foundation/portal/layer.dart';

/// A portal renders a portal widget that "floats" on top of a child widget.
///
/// Similar to an [OverlayPortal], it requires an [Overlay] ancestor. Unlike an [OverlayPortal], the portal is aligned
/// relative to the child.
///
/// See:
/// * [FPortalShift] for shifting strategies when a portal overflows outside of the viewport.
/// * [OverlayPortalController] for controlling the portal's visibility.
/// * [OverlayPortal] for the underlying widget.
class FPortal extends StatefulWidget {
  static Widget _builder(BuildContext _, OverlayPortalController _, Widget? child) => child!;

  /// The controller that shows and hides the portal. It initially hides the portal.
  final OverlayPortalController? controller;

  /// The constraints.
  final FPortalConstraints constraints;

  /// The point on the portal (floating content) that connects with the child, at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the portal will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry portalAnchor;

  /// The point on the child widget that connects with the portal (floating content), at the portal's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the portal.
  /// See [portalAnchor] for changing the portal's anchor.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

  /// The spacing between the child's anchor and portal's anchor. Defaults to [FPortalSpacing.zero].
  ///
  /// It applied before [shift].
  final FPortalSpacing spacing;

  /// The shifting strategy used to shift a portal when it overflows out of the viewport. Defaults to
  /// [FPortalShift.flip].
  ///
  /// It is applied after [spacing] and before [offset].
  ///
  /// See [FPortalShift] for the different shifting strategies.
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// The offset to adjust the portal by. Defaults to [Offset.zero].
  ///
  /// It is applied after [shift].
  final Offset offset;

  /// The insets of the view. In other words, the minimum distance between the edges of the view and the edges of the
  /// portal. Defaults to [MediaQueryData.viewPadding].
  ///
  /// Set this to [EdgeInsets.zero] to disable the insets.
  final EdgeInsetsGeometry? viewInsets;

  /// An optional barrier widget that is displayed behind the portal.
  final Widget? barrier;

  /// The portal builder which returns the floating content.
  final Widget Function(BuildContext, OverlayPortalController) portalBuilder;

  /// An optional builder which returns the child widget that the portal is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [child] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [builder] builds doest not require the controller.
  final ValueWidgetBuilder<OverlayPortalController> builder;

  /// The child which the portal is aligned to.
  final Widget? child;

  /// Creates a portal.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [builder] and [child] are both null.
  const FPortal({
    required this.portalBuilder,
    this.controller,
    this.constraints = const FPortalConstraints(),
    this.portalAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.spacing = FPortalSpacing.zero,
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.viewInsets,
    this.barrier,
    this.builder = _builder,
    this.child,
    super.key,
  }): assert(builder != _builder || child != null, 'Either builder or child must be provided.');

  @override
  State<FPortal> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('viewInsets', viewInsets))
      ..add(ObjectFlagProperty.has('portalBuilder', portalBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _State extends State<FPortal> {
  final _notifier = FChangeNotifier();
  final _link = ChildLayerLink();
  late OverlayPortalController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OverlayPortalController();
  }

  @override
  void didUpdateWidget(covariant FPortal old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller = widget.controller ?? OverlayPortalController();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      RepaintBoundary(
        child: CompositedChild(
          notifier: _notifier,
          link: _link,
          child: OverlayPortal(
            controller: _controller,
            overlayChildBuilder: (context) {
              final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
              final portalAnchor = widget.portalAnchor.resolve(direction);
              final childAnchor = widget.childAnchor.resolve(direction);

              Widget portal = CompositedPortal(
                notifier: _notifier,
                link: _link,
                constraints: widget.constraints,
                portalAnchor: portalAnchor,
                childAnchor: childAnchor,
                viewInsets:
                    widget.viewInsets?.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr) ??
                    MediaQuery.viewPaddingOf(context),
                spacing: widget.spacing.resolve(childAnchor, portalAnchor),
                shift: widget.shift,
                offset: widget.offset,
                child: widget.portalBuilder(context, _controller),
              );

              if (widget.barrier case final barrier?) {
                portal = Stack(children: [barrier, portal]);
              }

              return portal;
            },
            child: RepaintBoundary(child: widget.builder(context, _controller, widget.child)),
          ),
        ),
      ),
    ],
  );

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}
