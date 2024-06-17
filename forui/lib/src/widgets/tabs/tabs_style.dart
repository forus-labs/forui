part of 'tabs.dart';

/// [FTabs]'s style.
final class FTabsStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding.
  final EdgeInsets padding;

  /// The [TextStyle] of the label
  final TextStyle unselectedLabel;

  /// The [TextStyle] of the label
  final TextStyle selectedLabel;

  /// The indicator.
  final BoxDecoration indicator;

  /// The indicator size.
  final TabBarIndicatorSize indicatorSize;

  /// The [FTabContent] style.
  final FTabContentStyle content;

  /// Creates a [FTabsStyle].
  FTabsStyle({
    required this.decoration,
    required this.padding,
    required this.unselectedLabel,
    required this.selectedLabel,
    required this.indicator,
    required this.indicatorSize,
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
          color: colorScheme.border,
        ),
        padding = const EdgeInsets.all(4),
        unselectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w600,
          color: colorScheme.mutedForeground,
        ),
        selectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
        indicatorSize = TabBarIndicatorSize.tab,
        indicator = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
        ),
        content = FTabContentStyle.inherit(
            colorScheme: colorScheme, font: font, style: style);

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  FTabsStyle copyWith({
    EdgeInsets? padding,
    BoxDecoration? decoration,
    TextStyle? selectedLabel,
    TextStyle? unselectedLabel,
    BoxDecoration? indicator,
    TabBarIndicatorSize? indicatorSize,
    FTabContentStyle? content,
  }) =>
      FTabsStyle(
        padding: padding ?? this.padding,
        decoration: decoration ?? this.decoration,
        selectedLabel: selectedLabel ?? this.selectedLabel,
        unselectedLabel: unselectedLabel ?? this.unselectedLabel,
        indicatorSize: indicatorSize ?? this.indicatorSize,
        indicator: indicator ?? this.indicator,
        content: content ?? this.content,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BoxDecoration>('decoration', decoration))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', padding))
      ..add(DiagnosticsProperty<TextStyle>('unselectedLabel', unselectedLabel))
      ..add(DiagnosticsProperty<TextStyle>('selectedLabel', selectedLabel))
      ..add(DiagnosticsProperty<BoxDecoration>('indicator', indicator))
      ..add(DiagnosticsProperty<FTabContentStyle>('content', content));
  }
}
