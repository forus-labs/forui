import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'divider.design.dart';

/// A visual separator used to create division between content.
///
/// Dividers are horizontal lines that group content in lists and separate content in layouts.
/// They can be used to establish visual hierarchy and organize content into distinct sections.
///
/// See:
/// * https://forui.dev/docs/layout/divider for working examples.
/// * [FDividerStyle] for customizing a divider's appearance.
class FDivider extends StatelessWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dividers
  /// ```
  final FDividerStyle Function(FDividerStyle style)? style;

  /// The axis along which the divider is drawn. Defaults to horizontal.
  final Axis axis;

  /// Creates a [FDivider].
  const FDivider({this.style, this.axis = Axis.horizontal, super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedStyle = switch (axis) {
      Axis.horizontal => context.theme.dividerStyles.horizontalStyle,
      Axis.vertical => context.theme.dividerStyles.verticalStyle,
    };
    final style = this.style?.call(inheritedStyle) ?? inheritedStyle;

    return Container(
      margin: style.padding,
      color: style.color,
      height: axis == Axis.horizontal ? style.width : null,
      width: axis == Axis.horizontal ? null : style.width,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('axis', axis));
  }
}

/// The [FDivider] styles.
class FDividerStyles with Diagnosticable, _$FDividerStylesFunctions {
  /// The horizontal divider's style.
  @override
  final FDividerStyle horizontalStyle;

  /// The vertical divider's style.
  @override
  final FDividerStyle verticalStyle;

  /// Creates a [FDividerStyles].
  FDividerStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FDividerStyles] that inherits its properties.
  FDividerStyles.inherit({required FColors colors, required FStyle style})
    : this(
        horizontalStyle: FDividerStyle(
          color: colors.secondary,
          padding: FDividerStyle.defaultPadding.horizontalStyle,
          width: style.borderWidth,
        ),
        verticalStyle: FDividerStyle(
          color: colors.secondary,
          padding: FDividerStyle.defaultPadding.verticalStyle,
          width: style.borderWidth,
        ),
      );
}

/// The divider style.
///
/// The [padding] property can be used to indent the start and end of the separating line.
class FDividerStyle with Diagnosticable, _$FDividerStyleFunctions {
  /// The default padding for horizontal and vertical dividers.
  static const defaultPadding = (
    horizontalStyle: EdgeInsets.symmetric(vertical: 20),
    verticalStyle: EdgeInsets.symmetric(horizontal: 20),
  );

  /// The color of the separating line.
  @override
  final Color color;

  /// The padding surrounding the separating line. Defaults to the appropriate padding in [defaultPadding].
  ///
  /// This property can be used to indent the start and end of the separating line.
  @override
  final EdgeInsetsGeometry padding;

  /// The width (thickness) of the separating line. Defaults to 1.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `width` <= 0.0
  /// * `width` is Nan
  @override
  final double width;

  /// Creates a [FDividerStyle].
  FDividerStyle({required this.color, required this.padding, this.width = 1})
    : assert(0 < width, 'width ($width) must be > 0');
}
