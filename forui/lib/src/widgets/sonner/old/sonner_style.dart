import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// A sonner's style.
class FSonnerStyle with Diagnosticable {
  /// A factor by which a toast should be scaled. Defaults to 1.0 (no scaling).
  ///
  /// ## Contract
  /// Throws an [AssertionError] if scale < 0.
  final double scale;

  /// The toast's animation duration. Defaults to 150ms.
  final Duration animationDuration;

  /// The toast's animation curve. Defaults to [Curves.easeInOut].
  final Curve curve;

  /// The expanding/collapsing animation duration. Defaults to 500ms.
  final Duration expandingDuration;

  /// The expanding/collapsing animation curve. Defaults to [Curves.easeOutCubic].
  final Curve expandingCurve;

  /// A toast's initial opacity when expanding. Defaults to 0.
  ///
  /// Set this to 1 to remove the fade-in effect.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if opacity < 0.
  final double expandingOpacity;

  /// The vertical spacing between each toast when expanded. Defaults to 8.0.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if spacing < 0.
  final double expandedSpacing;

  /// A factor by which a collapsed toast should be scaled. Defaults to 0.9.
  ///
  /// This is proportional to the number of toasts in front of it, with each multiplied by [scale].
  /// 
  /// For example, if [collapsedScale] is 0.9 and there are 2 toasts with a [scale] of 3, the last toasts will be
  /// scaled by `3 * 0.9`.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if collapsedScale <= 0.
  final double collapsedScale;

  /// A collapsed toast's opacity. Defaults to 1.0.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if collapsed < 0.
  final double collapsedOpacity;

  /// Creates a [FSonnerStyle].
  FSonnerStyle({
    this.scale = 1,
    this.animationDuration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.expandingDuration = const Duration(milliseconds: 500),
    this.expandingCurve = Curves.easeOutCubic,
    this.expandingOpacity = 0,
    this.expandedSpacing = 8,
    this.collapsedScale = 0.9,
    this.collapsedOpacity = 1,
  });
}
