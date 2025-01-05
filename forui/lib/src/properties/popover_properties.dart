import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

/// Properties for a popover.
class FPopoverProperties with Diagnosticable {
  /// The default popover and child alignments.
  static ({Alignment popover, Alignment child}) get defaultAlignment => Touch.primary
      ? (popover: Alignment.bottomCenter, child: Alignment.topCenter)
      : (popover: Alignment.topCenter, child: Alignment.bottomCenter);

  /// The point on the popover (floating content) that connects with the target, at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the popover will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  ///
  /// Defaults to [Alignment.bottomCenter] on Android and iOS, and [Alignment.topCenter] on all other platforms.
  final Alignment popoverAnchor;

  /// The point on the child widget that connections with the popover (floating content), at the popover's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the popover.
  /// See [popoverAnchor] for changing the popover's anchor.
  ///
  /// Defaults to [Alignment.topCenter] on Android and iOS, and [Alignment.bottomCenter] on all other platforms.
  final Alignment childAnchor;

  /// The shifting strategy used to shift a follower when it overflows out of the viewport. Defaults to
  /// [FPortalFollowerShift.flip].
  ///
  /// See [FPortalFollowerShift] for more information on the different shifting strategies.
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  /// True if the popover is hidden when tapped outside of it. Defaults to true.
  final bool hideOnTapOutside;

  /// True if the follower should include the cross-axis padding of the anchor when aligning to it. Defaults to false.
  ///
  /// Diagonal corners are ignored.
  final bool directionPadding;

  /// Creates a [FPopoverProperties]
  FPopoverProperties({
    Alignment? followerAnchor,
    Alignment? targetAnchor,
    this.shift = FPortalFollowerShift.flip,
    this.hideOnTapOutside = true,
    this.directionPadding = false,
  })  : popoverAnchor = followerAnchor ?? defaultAlignment.popover,
        childAnchor = targetAnchor ?? defaultAlignment.child;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverAnchor', popoverAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(FlagProperty('hideOnTapOutside', value: hideOnTapOutside))
      ..add(FlagProperty('directionPadding', value: directionPadding));
  }
}
