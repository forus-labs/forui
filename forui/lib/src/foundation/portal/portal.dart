import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/portal/composited_child.dart';
import 'package:forui/src/foundation/portal/composited_portal.dart';
import 'package:forui/src/foundation/portal/layer.dart';

/// A portal renders a portal widget that "floats" on top of a child widget.
///
/// Similar to an [OverlayPortal], it requires an [Overlay] ancestor. Unlike an [OverlayPortal], the Portal is aligned
/// relative to the child.
///
/// See:
/// * [FPortalShift] for shifting strategies when a portal overflows outside of the viewport.
/// * [OverlayPortalController] for controlling the portal's visibility.
/// * [OverlayPortal] for the underlying widget.
class FPortal extends StatefulWidget {
  /// The controller that shows and hides the portal. It initially hides the portal.
  final OverlayPortalController controller;

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

  /// The portal builder which returns the floating content.
  final WidgetBuilder portalBuilder;

  /// The child which the portal is aligned to.
  final Widget child;

  /// Creates a portal.
  const FPortal({
    required this.controller,
    required this.portalBuilder,
    required this.child,
    this.constraints = const FPortalConstraints(),
    this.portalAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.spacing = FPortalSpacing.zero,
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.viewInsets,
    super.key,
  });

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
      ..add(ObjectFlagProperty.has('portalBuilder', portalBuilder));
  }
}

class _State extends State<FPortal> {
  final _notifier = FChangeNotifier();
  final _link = ChildLayerLink();

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: CompositedChild(
      notifier: _notifier,
      link: _link,
      child: OverlayPortal(
        controller: widget.controller,
        overlayChildBuilder: (context) {
          final direction =
              Directionality.maybeOf(context) ?? TextDirection.ltr;
          final portalAnchor = widget.portalAnchor.resolve(direction);
          final childAnchor = widget.childAnchor.resolve(direction);

          return CompositedPortal(
            notifier: _notifier,
            link: _link,
            constraints: widget.constraints,
            portalAnchor: portalAnchor,
            childAnchor: childAnchor,
            viewInsets:
                widget.viewInsets?.resolve(
                  Directionality.maybeOf(context) ?? TextDirection.ltr,
                ) ??
                MediaQuery.viewPaddingOf(context),
            spacing: widget.spacing.resolve(childAnchor, portalAnchor),
            shift: widget.shift,
            offset: widget.offset,
            child: widget.portalBuilder(context),
          );
        },
        child: RepaintBoundary(child: widget.child),
      ),
    ),
  );

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}
