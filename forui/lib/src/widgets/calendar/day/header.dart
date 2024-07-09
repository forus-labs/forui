part of '../calendar.dart';

@internal
class Header extends StatelessWidget {
  final FCalendarHeaderStyle style;
  final LocalDate month;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const Header({
    required this.style,
    required this.month,
    required this.onPrevious,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = context.theme.buttonStyles.outline;
    final effectiveButtonStyle = buttonStyle.copyWith(
      enabledBoxDecoration: buttonStyle.enabledBoxDecoration.copyWith(borderRadius: BorderRadius.circular(4)),
      disabledBoxDecoration: buttonStyle.disabledBoxDecoration.copyWith(borderRadius: BorderRadius.circular(4)),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: FButton.raw(
              // TODO: Replace with FButton.icon.
              style: effectiveButtonStyle,
              onPress: onPrevious,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: FAssets.icons.chevronLeft(
                  height: 17,
                  colorFilter: ColorFilter.mode(
                    style.iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Text('${month.month} ${month.year}', style: style.headerTextStyle), // TODO: Localization
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: FButton.raw(
              // TODO: Replace with FButton.icon.
              style: effectiveButtonStyle,
              onPress: onNext,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: FAssets.icons.chevronRight(
                  height: 17,
                  colorFilter: ColorFilter.mode(
                    style.iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('onPrevious', onPrevious))
      ..add(DiagnosticsProperty('onNext', onNext));
  }
}

/// The calendar header's style.
final class FCalendarHeaderStyle {
  /// The header's text style.
  final TextStyle headerTextStyle;

  /// The unfocused header icons' color.
  final Color iconColor;

  /// Creates a [FCalendarHeaderStyle].
  FCalendarHeaderStyle({
    required this.headerTextStyle,
    required this.iconColor,
  });

  /// Creates a [FCalendarHeaderStyle] that inherits its values from the given [colorScheme] and [typography].
  FCalendarHeaderStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          headerTextStyle: typography.sm.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          iconColor: colorScheme.mutedForeground,
        );

  /// Creates a copy of this but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FCalendarHeaderStyle(
  ///   headerTextStyle: ...,
  ///   iconColor:...,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(
  ///   iconColor: ...,
  /// );
  ///
  /// print(style.headerTextStyle == copy.headerTextStyle); // true
  /// print(style.iconColor == copy.iconColor); // false
  /// ```
  FCalendarHeaderStyle copyWith({
    TextStyle? headerTextStyle,
    Color? iconColor,
  }) =>
      FCalendarHeaderStyle(
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        iconColor: iconColor ?? this.iconColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarHeaderStyle &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          iconColor == other.iconColor;

  @override
  int get hashCode => headerTextStyle.hashCode ^ iconColor.hashCode;
}
