import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'badge_content.dart';
part 'badge_styles.dart';

/// A badge, or a component that looks like a badge.
class FBadge extends StatelessWidget {

  /// The design. Defaults to [FBadgeVariant.primary].
  final FBadgeDesign design;

  /// The builder.
  final Widget Function(BuildContext, FBadgeStyle) builder;

  /// Creates a [FBadge].
  FBadge({
    required String label,
    this.design = FBadgeVariant.primary,
    super.key,
  }) : builder = ((context, style) => FBadgeContent(label: label, style: style));

  /// Creates a [FBadge].
  const FBadge.raw({required this.design, required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    final style = switch (design) {
      final FBadgeStyle style => style,
      FBadgeVariant.primary => context.theme.badgeStyles.primary,
      FBadgeVariant.secondary => context.theme.badgeStyles.secondary,
      FBadgeVariant.outline => context.theme.badgeStyles.outline,
      FBadgeVariant.destructive => context.theme.badgeStyles.destructive,
    };

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: style.border,
              width: style.borderWidth,
            ),
            borderRadius: style.borderRadius,
            color: style.background,
          ),
          child: builder(context, style),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('design', design, defaultValue: FBadgeVariant.primary))
      ..add(DiagnosticsProperty('builder', builder, defaultValue: null));
  }

}

/// The badge design. Either a pre-defined [FBadgeVariant], or a custom [FBadgeStyle].
sealed class FBadgeDesign {}

/// A pre-defined badge variant.
enum FBadgeVariant implements FBadgeDesign {
  /// A primary-styled badge.
  primary,

  /// A secondary-styled badge.
  secondary,

  /// An outlined badge.
  outline,

  /// A destructive badge.
  destructive,
}

/// A [FBadge]'s style.
final class FBadgeStyle with Diagnosticable implements FBadgeDesign {

  /// The background color.
  final Color background;

  /// The border color.
  final Color border;

  /// The border radius.
  final BorderRadius borderRadius;

  /// The border width (thickness). Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `borderWidth` <= 0.0
  /// * `borderWidth` is Nan
  final double borderWidth;

  /// The button content's style.
  final FBadgeContentStyle content;

  /// Creates a [FBadgeStyle].
  FBadgeStyle({
    required this.background,
    required this.border,
    required this.borderRadius,
    required this.content,
    this.borderWidth = 1,
  }) : assert(0 < borderWidth, 'The borderWidth is $borderWidth, but it should be in the range "0 < borderWidth".');

  /// Creates a [FBadgeStyle] that inherits its properties from [style].
  FBadgeStyle.inherit({
    required FStyle style,
    required this.background,
    required this.border,
    required this.content,
  })  : borderRadius = BorderRadius.circular(100),
        borderWidth = style.borderWidth;

  /// Creates a copy of this [FBadgeStyle] with the given properties replaced.
  FBadgeStyle copyWith({
    Color? background,
    Color? border,
    BorderRadius? borderRadius,
    double? borderWidth,
    FBadgeContentStyle? content,
  }) =>
      FBadgeStyle(
        background: background ?? this.background,
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        content: content ?? this.content,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('border', border))
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius, defaultValue: BorderRadius.circular(100)))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty<FBadgeContentStyle>('content', content));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeStyle &&
          runtimeType == other.runtimeType &&
          background == other.background &&
          border == other.border &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          content == other.content;

  @override
  int get hashCode =>
      background.hashCode ^ border.hashCode ^ borderRadius.hashCode ^ borderWidth.hashCode ^ content.hashCode;

}
