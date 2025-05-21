import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sonner_style.style.dart';

/// [FSonner]'s style.
class FSonnerStyle with Diagnosticable, _$FSonnerStyleFunctions {
  /// The maximum number of entries shown per [FSonnerAlignment]. Defaults to to 3.
  @override
  final double max;

  /// The sonner's padding. Defaults to `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`.
  @override
  final EdgeInsetsGeometry padding;

  /// True if the toasts should expand when hovered or pressed. Defaults to true.
  @override
  final bool expandable;

  /// The duration to wait after entering the sonner before expanding the toasts. Defaults to 200ms.
  @override
  final Duration expandHoverEnterDuration;

  /// The duration to wait after exiting the sonner before collapsing the toasts. Defaults to 300ms.
  @override
  final Duration expandHoverExitDuration;

  /// The spacing below or above the toasts when they are expanded. Defaults to 16.0.
  @override
  final double expandStartSpacing;

  /// The spacing between the toasts when they are expanded. Defaults to 10.0.
  @override
  final double expandSpacing;

  /// The expanding/collapsing animation duration. Defaults to 500ms.
  @override
  final Duration expandDuration;

  /// The expanding/collapsing animation curve. Defaults to [Curves.easeInOutCubic].
  @override
  final Curve expandCurve;

  /// The protrusion of the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 12.0.
  @override
  final double collapsedProtrusion;

  /// The scaling factor pf the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 0.9.
  @override
  final double collapsedScale;

  /// The sonner toasts' style.
  @override
  final FToastStyle toastStyle;

  /// Creates a [FSonnerStyle].
  const FSonnerStyle({
    this.max = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.expandable = true,
    this.expandHoverEnterDuration = const Duration(milliseconds: 200),
    this.expandHoverExitDuration = const Duration(milliseconds: 300),
    this.expandStartSpacing = 16,
    this.expandSpacing = 10,
    this.expandDuration = const Duration(milliseconds: 500),
    this.expandCurve = Curves.easeInOutCubic,
    this.collapsedProtrusion = 12,
    this.collapsedScale = 0.9,
    this.toastStyle = const FToastStyle(),
  });
}

/// The sonner toast's style.
class FToastStyle with Diagnosticable, _$FToastStyleFunctions {
  /// The toast's entrance & exit animation duration. Defaults to 400ms.
  @override
  final Duration enterExitDuration;

  /// The toast's entrance animation curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve enterCurve;

  /// The toast's exit animation curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve exitCurve;

  /// The toast's initial opacity when it enters, and the target opacity when it exits.
  ///
  /// Defaults to 0. Set to 1.0 to remove the fade-in/out effect.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the value is not in `[0, 1]`.
  @override
  final double entranceExitOpacity;

  /// The toast's transition between indexes animation duration. Defaults to 400ms.
  @override
  final Duration transitionDuration;

  /// The toast's transition animation curve. Defaults to [Curves.easeInOutCubic].
  @override
  final Curve transitionCurve;

  /// The toast's constraints. Defaults to `BoxConstraints(maxHeight: 250, maxWidth: 400)`.
  @override
  final BoxConstraints constraints;

  /// Creates a [FToastStyle].
  const FToastStyle({
    this.enterExitDuration = const Duration(milliseconds: 400),
    this.enterCurve = Curves.easeOutCubic,
    this.exitCurve = Curves.easeOutCubic,
    this.entranceExitOpacity = 0.0,
    this.transitionDuration = const Duration(milliseconds: 400),
    this.transitionCurve = Curves.easeOutCubic,
    this.constraints = const BoxConstraints(maxHeight: 250, maxWidth: 400),
  });
}
