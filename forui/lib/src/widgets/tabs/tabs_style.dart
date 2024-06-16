part of 'tabs.dart';

/// [FTabs]'s style.
final class FTabsStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding.
  final EdgeInsets padding;

  /// The color of the unselected tabs.
  final Color unselectedColor;

  /// The [TextStyle] of the label
  final TextStyle unselectedLabel;

  /// The color of the selected tabs.
  final Color selectedColor;

  /// The [TextStyle] of the label
  final TextStyle selectedLabel;

  /// The decoration.
  final BoxDecoration indicator;

  /// The [FTabContent] style.
  final FTabContentStyle content;

  /// Creates a [FTabsStyle].
  FTabsStyle({
    required this.decoration,
    required this.padding,
    required this.unselectedLabel,
    required this.unselectedColor,
    required this.selectedLabel,
    required this.selectedColor,
    required this.indicator,
    required this.content,
  });

  /// Creates a [FBoxStyle] that inherits its properties from [colorScheme].
  FTabsStyle.inherit(
      {required FColorScheme colorScheme,
      required FFont font,
      required FStyle style})
      : decoration = BoxDecoration(
          border: Border.all(color: colorScheme.border),
          borderRadius: style.borderRadius,
          color: colorScheme.background,
        ),
        padding = const EdgeInsets.all(5),
        unselectedColor = colorScheme.muted,
        unselectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground.withOpacity(0.5),
        ),
        selectedColor = colorScheme.background,
        selectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w600,
          color: colorScheme.foreground,
        ),
        indicator = BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        content =
            FTabContentStyle.inherit(colorScheme: colorScheme, font: font);

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  FTabsStyle copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    EdgeInsets? padding,
    BoxDecoration? decoration,
    TextStyle? selectedLabel,
    TextStyle? unselectedLabel,
    BoxDecoration? indicator,
    FTabContentStyle? content,
  }) =>
      FTabsStyle(
        selectedColor: selectedColor ?? this.selectedColor,
        unselectedColor: unselectedColor ?? this.unselectedColor,
        padding: padding ?? this.padding,
        decoration: decoration ?? this.decoration,
        selectedLabel: selectedLabel ?? this.selectedLabel,
        unselectedLabel: unselectedLabel ?? this.unselectedLabel,
        indicator: indicator ?? this.indicator,
        content: content ?? this.content,
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<BoxDecoration>('decoration', decoration))
    ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
    ..add(ColorProperty('unselectedColor', unselectedColor))
    ..add(DiagnosticsProperty<TextStyle>('unselectedLabel', unselectedLabel))
    ..add(ColorProperty('selectedColor', selectedColor))
    ..add(DiagnosticsProperty<TextStyle>('selectedLabel', selectedLabel))
    ..add(DiagnosticsProperty<BoxDecoration>('indicator', indicator))
    ..add(DiagnosticsProperty<FTabContentStyle>('content', content));
  }
}
