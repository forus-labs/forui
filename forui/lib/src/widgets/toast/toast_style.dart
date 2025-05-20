import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/toast/toaster_layer.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'toast_style.style.dart';

/// FToast's style.
final class FToastStyle with Diagnosticable, _$FToastStyleFunctions {
  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The toast's content style.
  @override
  final FToastContentStyle contentStyle;

  /// The maximum number of stacked entries. Defaults to 3.
  @override
  final int maxStackedEntries;

  /// The toast's general animation duration. Defaults to 500ms.
  @override
  final Duration transitionDuration;

  /// The toast's general animation curve. Defaults to [Curves.easeOutCubic].
  @override
  final Curve transitionCurve;

  /// The dismiss animation duration. Defaults to 150ms.
  @override
  final Duration dismissDuration;

  /// The dismiss curve. Defaults to [Curves.linear].
  @override
  final Curve dismissCurve;

  /// The expanding/collapsing animation duration. Defaults to 500ms.
  @override
  final Duration expandDuration;

  /// The expanding/collapsing animation duration. Defaults to 500ms.
  @override
  final Curve expandCurve;

  /// The spacing between each toast when it is expanded. Defaults to 8.0.
  @override
  final double spacing;

  /// The scaling factor for toast entries that are collapsed behind the top entry.
  @override
  final double collapsedScale;

  /// The opacity of the toast when it is collapsed. Defaults to 1.0.
  @override
  final double collapsedOpacity;

  /// The initial opacity of the toast when it begins to expand. Defaults to 0.0.
  /// To remove the fade-in effect, set this to 1.0.
  @override
  final double transitionOpacity;

  /// How the toast should be expanded.
  @override
  final ExpandMode expandMode;

  /// The toast's padding.
  @override
  final EdgeInsets padding;

  /// The toast's box constraints.
  @override
  final BoxConstraints toastConstraints;

  /// Defines the offset position and spacing between the top toast and the collapsed toasts stacked behind it.
  @override
  final Offset collapsedOffset;

  /// Creates a [FToastStyle].y
  FToastStyle({
    required this.decoration,
    required this.contentStyle,
    this.maxStackedEntries = 3,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.transitionCurve = Curves.easeOutCubic,
    this.dismissDuration = const Duration(milliseconds: 150),
    this.dismissCurve = Curves.linear,
    this.expandDuration = const Duration(milliseconds: 500),
    this.expandCurve = Curves.easeOutCubic,
    this.spacing = 8.0,
    this.collapsedScale = 0.9,
    this.collapsedOpacity = 1,
    this.transitionOpacity = 0,
    this.expandMode = ExpandMode.expandOnHover,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    BoxConstraints? toastConstraints,
    this.collapsedOffset = const Offset(0, 12),
  }) : toastConstraints = toastConstraints ?? const BoxConstraints.tightFor(width: 320);

  /// Creates a [FToastStyle] that inherits its properties.
  FToastStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: style.borderRadius,
          color: colors.background,
        ),
        contentStyle: FToastContentStyle(
          titleTextStyle: typography.xl2.copyWith(fontWeight: FontWeight.w600, color: colors.foreground, height: 1.5),
          subtitleTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
        ),
      );
}

/// [FToast] content's style.
final class FToastContentStyle with Diagnosticable, _$FToastContentStyleFunctions {
  /// The spacing between the title/subtitle and the child if an image is provided. Defaults to 8.
  @override
  final double subtitleSpacing;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  @override
  final TextStyle subtitleTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(16)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FToastContentStyle].
  const FToastContentStyle({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.subtitleSpacing = 8,
    this.padding = const EdgeInsets.all(16),
  });
}
