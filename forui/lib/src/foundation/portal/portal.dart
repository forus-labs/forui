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

  /// The offset to adjust the [shift]ed portal by. Defaults to [Offset.zero].
  final Offset offset;

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

  /// The shifting strategy used to shift a portal when it overflows out of the viewport. Defaults to
  /// [FPortalShift.flip].
  ///
  /// See [FPortalShift] for the different shifting strategies.
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// Whether to avoid system intrusions. Defaults to true.
  final bool useViewPadding;

  /// The portal builder which returns the floating content.
  final WidgetBuilder portalBuilder;

  /// The child which the portal is aligned to.
  final Widget child;

  /// Creates a portal.
  const FPortal({
    required this.controller,
    required this.portalBuilder,
    required this.child,
    this.offset = Offset.zero,
    this.portalAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    this.useViewPadding = true,
    super.key,
  });

  @override
  State<FPortal> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(FlagProperty('useViewPadding', value: useViewPadding, ifTrue: 'uses view padding'))
      ..add(ObjectFlagProperty.has('portalBuilder', portalBuilder));
  }
}

class _State extends State<FPortal> {
  final _notifier = FChangeNotifier();
  final _link = ChildLayerLink();

  @override
  Widget build(BuildContext _) => RepaintBoundary(
    child: CompositedChild(
      notifier: _notifier,
      link: _link,
      child: OverlayPortal(
        controller: widget.controller,
        overlayChildBuilder: (context) {
          final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
          return CompositedPortal(
            notifier: _notifier,
            link: _link,
            offset: widget.offset,
            portalAnchor: widget.portalAnchor.resolve(direction),
            childAnchor: widget.childAnchor.resolve(direction),
            viewPadding: widget.useViewPadding ? MediaQuery.viewPaddingOf(context) : EdgeInsets.zero,
            shift: widget.shift,
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
