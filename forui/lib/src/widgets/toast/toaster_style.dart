import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'toaster_style.design.dart';

/// A toaster's expansion behavior.
enum FToasterExpandBehavior {
  /// The toasts are always expanded.
  always,

  /// The toasts are expanded when the toaster is hovered or pressed.
  hoverOrPress,

  /// The toasts are never expanded.
  disabled,
}

/// [FToaster]'s style.
class FToasterStyle with Diagnosticable, _$FToasterStyleFunctions {
  /// The maximum number of entries shown per [FToastAlignment]. Defaults to to 3.
  @override
  final double max;

  /// The toaster's padding. Defaults to `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The toaster's expansion behavior. Defaults to [FToasterExpandBehavior.hoverOrPress].
  @override
  final FToasterExpandBehavior expandBehavior;

  /// The duration to wait after entering the toaster before expanding the toasts. Defaults to 200ms.
  @override
  final Duration expandHoverEnterDuration;

  /// The duration to wait after exiting the toaster before collapsing the toasts. Defaults to 200ms.
  @override
  final Duration expandHoverExitDuration;

  /// The spacing below or above the toasts when they are expanded. Defaults to 0.
  @override
  final double expandStartSpacing;

  /// The spacing between the toasts when they are expanded. Defaults to 10.0.
  @override
  final double expandSpacing;

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

  /// The motion-related properties.
  @override
  final FToasterMotion motion;

  /// The toast's alignment relative to a [FToaster]. Defaults to [FToastAlignment.bottomEnd].
  @override
  final FToastAlignment toastAlignment;

  /// The contained toasts' style.
  @override
  final FToastStyle toastStyle;

  /// Creates a [FToasterStyle].
  const FToasterStyle({
    required this.toastStyle,
    this.max = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.expandBehavior = FToasterExpandBehavior.hoverOrPress,
    this.expandHoverEnterDuration = const Duration(milliseconds: 200),
    this.expandHoverExitDuration = const Duration(milliseconds: 200),
    this.expandStartSpacing = 0,
    this.expandSpacing = 10,
    this.collapsedProtrusion = 12,
    this.collapsedScale = 0.9,
    this.motion = const FToasterMotion(),
    this.toastAlignment = FToastAlignment.bottomEnd,
  });

  /// Creates a [FToasterStyle] that inherits its properties.
  FToasterStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        toastStyle: FToastStyle.inherit(colors: colors, typography: typography, style: style),
      );
}

/// The motion-related properties for [FToaster] that affect all toasts.
class FToasterMotion with Diagnosticable, _$FToasterMotionFunctions {
  /// The duration of the toasts' expansion. Defaults to 400ms.
  @override
  final Duration expandDuration;

  /// The duration of the toasts' collapsing. Defaults to 300ms.
  @override
  final Duration collapseDuration;

  /// The animation curve for the toasts' expansion and collapsing. Defaults to [Curves.easeOutCubic].
  @override
  final Curve expandCurve;

  /// The animation curve for the toasts' collapsing. Defaults to [Curves.easeOutCubic].
  @override
  final Curve collapseCurve;

  /// Creates a [FToasterMotion].
  const FToasterMotion({
    this.expandDuration = const Duration(milliseconds: 400),
    this.collapseDuration = const Duration(milliseconds: 300),
    this.expandCurve = Curves.easeOutCubic,
    this.collapseCurve = Curves.easeOutCubic,
  });
}

/// The toast's style.
class FToastStyle with Diagnosticable, _$FToastStyleFunctions {
  /// The toast's constraints. Defaults to `BoxConstraints(maxHeight: 250, maxWidth: 400)`.
  @override
  final BoxConstraints constraints;

  /// The toast's decoration.
  @override
  final BoxDecoration decoration;

  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// There will be a flicker after the toast's fade-in entrance when a blur background filter is applied. This is due to
  /// https://github.com/flutter/flutter/issues/31706.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  @override
  final ImageFilter? backgroundFilter;

  /// The toast content's padding. Defaults to `EdgeInsets.all(16)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The style of the toast's prefix icon.
  @override
  final IconThemeData iconStyle;

  /// The spacing between the icon and the title. Defaults to 10.0.
  @override
  final double iconSpacing;

  /// The title's text style.
  @override
  final TextStyle titleTextStyle;

  /// The spacing between the title and description Defaults to 5.0.
  @override
  final double titleSpacing;

  /// The description's text style.
  @override
  final TextStyle descriptionTextStyle;

  /// The spacing between the icon and the title. Defaults to 12.0.
  @override
  final double suffixSpacing;

  /// The motion-related properties.
  @override
  final FToastMotion motion;

  /// Creates a [FToastStyle].
  FToastStyle({
    required this.decoration,
    required this.iconStyle,
    required this.titleTextStyle,
    required this.descriptionTextStyle,
    this.constraints = const BoxConstraints(maxHeight: 250, maxWidth: 400),
    this.padding = const EdgeInsets.all(16),
    this.backgroundFilter,
    this.iconSpacing = 10,
    this.titleSpacing = 1,
    this.suffixSpacing = 12,
    this.motion = const FToastMotion(),
  });

  /// Creates a [FToastStyle] that inherits its properties.
  FToastStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: style.borderRadius,
          color: colors.background,
        ),
        iconStyle: IconThemeData(color: colors.primary, size: 18),
        titleTextStyle: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
        titleSpacing: 5,
        descriptionTextStyle: typography.sm.copyWith(color: colors.mutedForeground, overflow: TextOverflow.ellipsis),
      );
}

/// The motion-related properties for [FToaster] that affect individual toasts.
class FToastMotion with Diagnosticable, _$FToastMotionFunctions {
  /// The duration of the toast's entrance when it is initially added to to toaster. Defaults to 400ms.
  @override
  final Duration entranceDuration;

  /// The duration of the toast's exit animation when it is dismissed. Defaults to 300ms.
  @override
  final Duration dismissDuration;

  /// The duration of the toast's transition between places in the toaster. Defaults to 400ms.
  @override
  final Duration transitionDuration;

  /// The duration of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the
  /// toaster. Defaults to 400ms.
  @override
  final Duration reentranceDuration;

  /// The duration of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed
  /// and this toast is hidden. Defaults to 400ms.
  @override
  final Duration exitDuration;

  /// The toast's swipe completion animation duration. Defaults to 150ms.
  @override
  final Duration swipeCompletionDuration;

  /// The toast's initial entrance animation curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve entranceCurve;

  /// The toast's exit animation curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve dismissCurve;

  /// The toast's transition animation curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve transitionCurve;

  /// The curve of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the
  /// toaster. Defaults to [Curves.easeOutCubic].
  @override
  final Curve reentranceCurve;

  /// The curve of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed
  /// and this toast is hidden. Defaults to [Curves.easeOutCubic].
  @override
  final Curve exitCurve;

  /// The toast's swipe completion animation curve. Defaults to [Curves.easeInCubic].
  @override
  final Curve swipeCompletionCurve;

  /// The toast's initial entrance's opacity and dismiss's fade tween. Defaults to `[0, 1]`.
  ///
  /// Set to `[1, 1]` to disable the fade-in/out effect.
  @override
  final Animatable<double> entranceDismissFadeTween;

  /// Creates a [FToastMotion].
  const FToastMotion({
    this.entranceDuration = const Duration(milliseconds: 400),
    this.dismissDuration = const Duration(milliseconds: 300),
    this.transitionDuration = const Duration(milliseconds: 400),
    this.reentranceDuration = const Duration(milliseconds: 400),
    this.exitDuration = const Duration(milliseconds: 400),
    this.swipeCompletionDuration = const Duration(milliseconds: 150),
    this.entranceCurve = Curves.easeOutCubic,
    this.dismissCurve = Curves.easeOutCubic,
    this.transitionCurve = Curves.easeOutCubic,
    this.reentranceCurve = Curves.easeOutCubic,
    this.exitCurve = Curves.easeOutCubic,
    this.swipeCompletionCurve = Curves.easeInCubic,
    this.entranceDismissFadeTween = const FImmutableTween(begin: 0.0, end: 1.0),
  });
}
