part of 'tabs.dart';

/// [FTabs]'s style.
final class FTabsStyle with Diagnosticable {
  /// The color of the selected tabs.
  final Color selectedColor;

  /// The color of the unselected tabs.
  final Color unselectedColor;

  /// The padding.
  final EdgeInsets padding;

  /// The decoration.
  final BoxDecoration decoration;

  /// The [TextStyle] of the label
  final TextStyle selectedLabel;

  /// The [TextStyle] of the label
  final TextStyle unselectedLabel;

  /// The decoration.
  final BoxDecoration indicator;

  /// Creates a [FTabsStyle].
  const FTabsStyle({
    required this.selectedColor,
    required this.padding,
    required this.selectedLabel,
    required this.unselectedLabel,
    required this.indicator,
    required this.unselectedColor,
    required this.decoration,
  });

  /// Creates a [FBoxStyle] that inherits its properties from [colorScheme].
  FTabsStyle.inherit(
      {required FColorScheme colorScheme,
      required FFont font,
      required FStyle style})
      : selectedColor = colorScheme.background,
        unselectedColor = colorScheme.muted,
        padding = const EdgeInsets.all(5),
        decoration = BoxDecoration(
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
          color: colorScheme.background,
        ),
        selectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground,
        ),
        unselectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground.withOpacity(0.5),
        ),
        indicator = BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(50),
        );

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  FTabsStyle copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    EdgeInsets? padding,
    BoxDecoration? decoration,
    TextStyle? selectedLabel,
    TextStyle? unselectedLabel,
    BoxDecoration? indicator,
  }) =>
      FTabsStyle(
        selectedColor: selectedColor ?? this.selectedColor,
        unselectedColor: unselectedColor ?? this.unselectedColor,
        padding: padding ?? this.padding,
        decoration: decoration ?? this.decoration,
        selectedLabel: selectedLabel ?? this.selectedLabel,
        unselectedLabel: unselectedLabel ?? this.unselectedLabel,
        indicator: indicator ?? this.indicator,
      );
}
