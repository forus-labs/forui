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

  /// The height.
  final double height;

  /// The spacing between the tab bar and the views.
  final double spacing;

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
    required this.height,
    required this.spacing,
    required this.content,
  });

  /// Creates a [FBoxStyle] that inherits its properties from [colorScheme].
  FTabsStyle.inherit({required FColorScheme colorScheme, required FFont font, required FStyle style})
      : decoration = BoxDecoration(
          border: Border.all(color: colorScheme.muted),
          borderRadius: style.borderRadius,
          color: colorScheme.muted,
        ),
        padding = const EdgeInsets.all(4),
        unselectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w500,
          color: colorScheme.mutedForeground,
        ),
        selectedLabel = TextStyle(
          fontSize: font.sm,
          fontWeight: FontWeight.w500,
          color: colorScheme.foreground,
        ),
        indicatorSize = TabBarIndicatorSize.tab,
        indicator = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
        ),
        height = 35,
        spacing = 10,
        content = FTabContentStyle.inherit(colorScheme: colorScheme, font: font, style: style);

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  FTabsStyle copyWith({
    EdgeInsets? padding,
    BoxDecoration? decoration,
    TextStyle? selectedLabel,
    TextStyle? unselectedLabel,
    BoxDecoration? indicator,
    TabBarIndicatorSize? indicatorSize,
    double? height,
    double? spacing,
    FTabContentStyle? content,
  }) =>
      FTabsStyle(
        padding: padding ?? this.padding,
        decoration: decoration ?? this.decoration,
        selectedLabel: selectedLabel ?? this.selectedLabel,
        unselectedLabel: unselectedLabel ?? this.unselectedLabel,
        indicatorSize: indicatorSize ?? this.indicatorSize,
        indicator: indicator ?? this.indicator,
        height: height ?? this.height,
        spacing: spacing ?? this.spacing,
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
      ..add(EnumProperty<TabBarIndicatorSize>('indicatorSize', indicatorSize))
      ..add(DiagnosticsProperty<BoxDecoration>('indicator', indicator))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty<FTabContentStyle>('content', content));
  }
}
