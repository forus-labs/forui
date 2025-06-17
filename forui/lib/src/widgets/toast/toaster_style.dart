import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'toaster_style.style.dart';

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

  /// The duration to wait after exiting the toaster before collapsing the toasts. Defaults to 300ms.
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
    this.expandHoverExitDuration = const Duration(milliseconds: 300),
    this.expandStartSpacing = 16,
    this.expandSpacing = 10,
    this.expandDuration = const Duration(milliseconds: 500),
    this.expandCurve = Curves.easeInOutCubic,
    this.collapsedProtrusion = 12,
    this.collapsedScale = 0.9,
  });

  /// Creates a [FToasterStyle] that inherits its properties.
  FToasterStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        toastStyle: FToastStyle.inherit(colors: colors, typography: typography, style: style),
      );
}

/// The toast's style.
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

  /// The toast's swipe completion animation duration. Defaults to 150ms.
  @override
  final Duration swipeCompletionDuration;

  /// The toast's swipe completion animation curve. Defaults to [Curves.easeInCubic].
  @override
  final Curve swipeCompletionCurve;

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

  /// Creates a [FToastStyle].
  FToastStyle({
    required this.decoration,
    required this.iconStyle,
    required this.titleTextStyle,
    required this.descriptionTextStyle,
    this.enterExitDuration = const Duration(milliseconds: 400),
    this.enterCurve = Curves.easeOutCubic,
    this.exitCurve = Curves.easeOutCubic,
    this.entranceExitOpacity = 0.0,
    this.transitionDuration = const Duration(milliseconds: 400),
    this.transitionCurve = Curves.easeOutCubic,
    this.swipeCompletionDuration = const Duration(milliseconds: 150),
    this.swipeCompletionCurve = Curves.easeInCubic,
    this.constraints = const BoxConstraints(maxHeight: 250, maxWidth: 400),
    this.padding = const EdgeInsets.all(16),
    this.backgroundFilter,
    this.iconSpacing = 10,
    this.titleSpacing = 1,
    this.suffixSpacing = 12,
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
