import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// [FSonner]'s style.
class FSonnerStyle {
  /// The maximum number of entries shown per [FSonnerAlignment]. Defaults to to 3.
  final double max;

  /// The sonner's padding. Defaults to `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`.
  final EdgeInsetsGeometry padding;

  /// The spacing below or above the toasts when they are expanded. Defaults to 16.0.
  final double expandStartSpacing;

  /// The spacing between the toasts when they are expanded. Defaults to 10.0.
  final double expandSpacing;

  /// The expanding/collapsing animation duration. Defaults to 500ms.
  final Duration expandDuration;

  /// The expanding/collapsing animation curve. Defaults to [Curves.easeInOutCubic].
  final Curve expandCurve;

  /// The protrusion of the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 12.0.
  final double collapsedProtrusion;

  /// The scaling factor pf the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 0.9.
  final double collapsedScale;

  /// The sonner toasts' style.
  final FToastStyle toastStyle;

  /// Creates a [FSonnerStyle].
  FSonnerStyle({
    required this.toastStyle,
    this.max = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.expandStartSpacing = 16,
    this.expandSpacing = 10,
    this.expandDuration = const Duration(milliseconds: 500),
    this.expandCurve = Curves.easeInOutCubic,
    this.collapsedProtrusion = 12,
    this.collapsedScale = 0.9,
  });

  /// Creates a [FSonnerStyle] that inherits its properties.
  FSonnerStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) : this(
    toastStyle: const FToastStyle(),
  );
}

/// The sonner toast's style.
class FToastStyle {
  /// The toast's entrance & exit animation duration. Defaults to 400ms.
  final Duration entranceExitDuration;

  /// The toast's entrance animation curve. Defaults to [Curves.easeOutCubic].
  final Curve entranceCurve;

  /// The toast's exit animation curve. Defaults to [Curves.easeOutCubic].
  final Curve exitCurve;

  /// The toast's initial opacity when it enters, and the target opacity when it exits.
  ///
  /// Defaults to 0. Set to 1.0 to remove the fade-in/out effect.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the value is not in `[0, 1]`.
  final double entranceExitOpacity;

  /// The toast's transition between indexes animation duration. Defaults to 400ms.
  final Duration transitionDuration;

  /// The toast's transition animation curve. Defaults to [Curves.easeInOutCubic].
  final Curve transitionCurve;

  /// Creates a [FToastStyle].
  const FToastStyle({
    this.entranceExitDuration = const Duration(milliseconds: 400),
    this.entranceCurve = Curves.easeOutCubic,
    this.exitCurve = Curves.easeOutCubic,
    this.entranceExitOpacity = 0.0,
    this.transitionDuration = const Duration(milliseconds: 400),
    this.transitionCurve = Curves.easeOutCubic,
  });
}
