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
  });

  /// Creates a [FTabsStyle] that inherits its properties from [colorScheme].
  FTabsStyle.inherit(
      {required FColorScheme colorScheme,
      required FTypography typography,
      required FStyle style})
      : decoration = BoxDecoration(
          border: Border.all(color: colorScheme.muted),
          borderRadius: style.borderRadius,
          color: colorScheme.muted,
        ),
        padding = const EdgeInsets.all(4),
        unselectedLabel = TextStyle(
          fontSize: typography.sm,
          fontWeight: FontWeight.w500,
          // required as material implementation of [Tab] uses DefaultTabStyle
          fontFamily: typography.defaultFontFamily,
          color: colorScheme.mutedForeground,
        ),
        selectedLabel = TextStyle(
          fontSize: typography.sm,
          fontWeight: FontWeight.w500,
          // required as material implementation of [Tab] uses DefaultTabStyle
          fontFamily: typography.defaultFontFamily,
          color: colorScheme.foreground,
        ),
        indicatorSize = TabBarIndicatorSize.tab,
        indicator = BoxDecoration(
          color: colorScheme.background,
          borderRadius: style.borderRadius,
        ),
        height = 35,
        spacing = 10;

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
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('unselectedLabel', unselectedLabel))
      ..add(DiagnosticsProperty('selectedLabel', selectedLabel))
      ..add(EnumProperty('indicatorSize', indicatorSize))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('spacing', spacing));
  }
}
