part of 'button.dart';

final class _FButtonContent extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget label;

  const _FButtonContent({
    required this.label,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final (:style, :enabled) = FButton._of(context);

    return Padding(
      padding: style.content.padding,
      child: DefaultTextStyle.merge(
        style: enabled ? style.content.enabledTextStyle : style.content.disabledTextStyle,
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
    );
  }
}

/// [FButton] content's style.
class FButtonContentStyle with Diagnosticable {
  /// The [TextStyle] when this button is enabled.
  final TextStyle enabledTextStyle;

  /// The [TextStyle] when this button is disabled.
  final TextStyle disabledTextStyle;

  /// The padding.
  final EdgeInsets padding;

  /// Creates a [FButtonContentStyle].
  FButtonContentStyle({
    required this.enabledTextStyle,
    required this.disabledTextStyle,
    required this.padding,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from the given [enabled] and [disabled].
  FButtonContentStyle.inherit({
    required FTypography typography,
    required Color enabled,
    required Color disabled,
  })  : padding = const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12.5,
        ),
        enabledTextStyle = typography.base.copyWith(
          color: enabled,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
        disabledTextStyle = typography.base.copyWith(
          color: disabled,
          fontWeight: FontWeight.w500,
          height: 1,
        );

  /// Returns a copy of this [FButtonContentStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FButtonContentStyle(
  ///   enabledTextStyle: ...,
  ///   disabledTextStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   disabledTextStyle: ...,
  /// );
  ///
  /// print(style.enabledTextStyle == copy.enabledTextStyle); // true
  /// print(style.disabledTextStyle == copy.disabledTextStyle); // false
  /// ```
  @useResult
  FButtonContentStyle copyWith({
    TextStyle? enabledTextStyle,
    TextStyle? disabledTextStyle,
    EdgeInsets? padding,
  }) =>
      FButtonContentStyle(
        enabledTextStyle: enabledTextStyle ?? this.enabledTextStyle,
        disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledTextStyle', enabledTextStyle))
      ..add(DiagnosticsProperty('disabledTextStyle', disabledTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonContentStyle &&
          runtimeType == other.runtimeType &&
          enabledTextStyle == other.enabledTextStyle &&
          disabledTextStyle == other.disabledTextStyle &&
          padding == other.padding;

  @override
  int get hashCode => enabledTextStyle.hashCode ^ disabledTextStyle.hashCode ^ padding.hashCode;
}
