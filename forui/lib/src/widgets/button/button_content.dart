import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

@internal
class Content extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget label;

  const Content({
    required this.label,
    this.prefix,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FButtonData(style: FButtonCustomStyle(:contentStyle), :enabled) = FButtonData.of(context);
    return Padding(
      padding: contentStyle.padding,
      child: DefaultTextStyle.merge(
        style: enabled ? contentStyle.enabledTextStyle : contentStyle.disabledTextStyle,
        child: FIconStyleData(
          style: FIconStyle(
            color: enabled ? contentStyle.enabledIconColor : contentStyle.disabledIconColor,
            size: contentStyle.iconSize,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: separate(
              [
                if (prefix != null) prefix!,
                label,
                if (suffix != null) suffix!,
              ],
              by: [
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@internal
class IconContent extends StatelessWidget {
  final Widget child;

  const IconContent({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final FButtonData(:style, :enabled) = FButtonData.of(context);

    return Padding(
      padding: style.iconContentStyle.padding,
      child: FIconStyleData(
        style: FIconStyle(
          color: enabled ? style.iconContentStyle.enabledColor : style.iconContentStyle.disabledColor,
          size: style.iconContentStyle.size,
        ),
        child: child,
      ),
    );
  }
}

/// [FButton] content's style.
final class FButtonContentStyle with Diagnosticable {
  /// The [TextStyle] when this button is enabled.
  final TextStyle enabledTextStyle;

  /// The [TextStyle] when this button is disabled.
  final TextStyle disabledTextStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 12.5)`.
  final EdgeInsets padding;

  /// The icon's color when this button is enabled.
  final Color enabledIconColor;

  /// The icon's color when this button is disabled.
  final Color disabledIconColor;

  /// The icon's size. Defaults to 20.
  final double iconSize;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledTextStyle,
    required this.disabledTextStyle,
    required this.enabledIconColor,
    required this.disabledIconColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
    this.iconSize = 20,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [enabled] and [disabled].
  FButtonContentStyle.inherit({
    required FTypography typography,
    required Color enabled,
    required Color disabled,
  }) : this(
          enabledTextStyle: typography.base.copyWith(
            color: enabled,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
          disabledTextStyle: typography.base.copyWith(
            color: disabled,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
          enabledIconColor: enabled,
          disabledIconColor: disabled,
        );

  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  @useResult
  FButtonContentStyle copyWith({
    TextStyle? enabledTextStyle,
    TextStyle? disabledTextStyle,
    EdgeInsets? padding,
    Color? enabledIconColor,
    Color? disabledIconColor,
    double? iconSize,
  }) =>
      FButtonContentStyle(
        enabledTextStyle: enabledTextStyle ?? this.enabledTextStyle,
        disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
        padding: padding ?? this.padding,
        enabledIconColor: enabledIconColor ?? this.enabledIconColor,
        disabledIconColor: disabledIconColor ?? this.disabledIconColor,
        iconSize: iconSize ?? this.iconSize,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledTextStyle', enabledTextStyle))
      ..add(DiagnosticsProperty('disabledTextStyle', disabledTextStyle))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ColorProperty('enabledColor', enabledIconColor))
      ..add(ColorProperty('disabledColor', disabledIconColor))
      ..add(DoubleProperty('size', iconSize, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonContentStyle &&
          runtimeType == other.runtimeType &&
          enabledTextStyle == other.enabledTextStyle &&
          disabledTextStyle == other.disabledTextStyle &&
          padding == other.padding &&
          enabledIconColor == other.enabledIconColor &&
          disabledIconColor == other.disabledIconColor &&
          iconSize == other.iconSize;

  @override
  int get hashCode =>
      enabledTextStyle.hashCode ^
      disabledTextStyle.hashCode ^
      padding.hashCode ^
      enabledIconColor.hashCode ^
      disabledIconColor.hashCode ^
      iconSize.hashCode;
}

/// [FButton] icon content's style.
final class FButtonIconContentStyle with Diagnosticable {
  /// The padding. Defaults to `EdgeInsets.all(7.5)`.
  final EdgeInsets padding;

  /// The icon's color when this button is enabled.
  final Color enabledColor;

  /// The icon's color when this button is disabled.
  final Color disabledColor;

  /// The icon's size. Defaults to 20.
  final double size;

  /// Creates a [FButtonIconContentStyle].
  const FButtonIconContentStyle({
    required this.enabledColor,
    required this.disabledColor,
    this.padding = const EdgeInsets.all(7.5),
    this.size = 20,
  });

  /// Returns a copy of this [FButtonIconContentStyle] with the given properties replaced.
  @useResult
  FButtonIconContentStyle copyWith({
    EdgeInsets? padding,
    Color? enabledColor,
    Color? disabledColor,
    double? size,
  }) =>
      FButtonIconContentStyle(
        padding: padding ?? this.padding,
        enabledColor: enabledColor ?? this.enabledColor,
        disabledColor: disabledColor ?? this.disabledColor,
        size: size ?? this.size,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ColorProperty('enabledColor', enabledColor))
      ..add(ColorProperty('disabledColor', disabledColor))
      ..add(DoubleProperty('size', size, defaultValue: 20));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonIconContentStyle &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          enabledColor == other.enabledColor &&
          disabledColor == other.disabledColor &&
          size == other.size;

  @override
  int get hashCode => padding.hashCode ^ enabledColor.hashCode ^ disabledColor.hashCode ^ size.hashCode;
}
