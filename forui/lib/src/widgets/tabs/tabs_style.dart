part of 'tabs.dart';

/// Defines how the bounds of the selected tab indicator are computed.
enum FTabBarIndicatorSize {
  /// The tab indicator's bounds are as wide as the space occupied by the tab
  /// in the tab bar: from the right edge of the previous tab to the left edge
  /// of the next tab.
  tab(TabBarIndicatorSize.tab),

  /// The tab's bounds are only as wide as the (centered) tab widget itself.
  ///
  /// This value is used to align the tab's label, typically a [Tab]
  /// widget's text or icon, with the selected tab indicator.
  label(TabBarIndicatorSize.label);

  final TabBarIndicatorSize _value;

  const FTabBarIndicatorSize(this._value);
}

/// [FTabs]'s style.
final class FTabsStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding.
  final EdgeInsets padding;

  /// The [TextStyle] of the label.
  final TextStyle selectedLabelTextStyle;

  /// The [TextStyle] of the label.
  final TextStyle unselectedLabelTextStyle;

  /// The indicator.
  final BoxDecoration indicatorDecoration;

  /// The indicator size.
  final FTabBarIndicatorSize indicatorSize;

  /// The height.
  final double height;

  /// The spacing between the tab bar and the views.
  final double spacing;

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FTabsStyle].
  FTabsStyle({
    required this.decoration,
    required this.selectedLabelTextStyle,
    required this.unselectedLabelTextStyle,
    required this.indicatorDecoration,
    required this.focusedOutlineStyle,
    this.padding = const EdgeInsets.all(4),
    this.indicatorSize = FTabBarIndicatorSize.tab,
    this.height = 35,
    this.spacing = 10,
  });

  /// Creates a [FTabsStyle] that inherits its properties from [colorScheme].
  FTabsStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.muted),
            borderRadius: style.borderRadius,
            color: colorScheme.muted,
          ),
          selectedLabelTextStyle: typography.sm.copyWith(
            fontWeight: FontWeight.w500,
            fontFamily: typography.defaultFontFamily,
            color: colorScheme.foreground,
          ),
          unselectedLabelTextStyle: typography.sm.copyWith(
            fontWeight: FontWeight.w500,
            fontFamily: typography.defaultFontFamily,
            color: colorScheme.mutedForeground,
          ),
          indicatorDecoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
        );

  /// Creates a copy of this [FCardStyle] with the given properties replaced.
  @useResult
  FTabsStyle copyWith({
    EdgeInsets? padding,
    BoxDecoration? decoration,
    TextStyle? selectedLabelTextStyle,
    TextStyle? unselectedLabelTextStyle,
    BoxDecoration? indicatorDecoration,
    FTabBarIndicatorSize? indicatorSize,
    double? height,
    double? spacing,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) =>
      FTabsStyle(
        padding: padding ?? this.padding,
        decoration: decoration ?? this.decoration,
        selectedLabelTextStyle: selectedLabelTextStyle ?? this.selectedLabelTextStyle,
        unselectedLabelTextStyle: unselectedLabelTextStyle ?? this.unselectedLabelTextStyle,
        indicatorSize: indicatorSize ?? this.indicatorSize,
        indicatorDecoration: indicatorDecoration ?? this.indicatorDecoration,
        height: height ?? this.height,
        spacing: spacing ?? this.spacing,
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('selectedLabelTextStyle', selectedLabelTextStyle))
      ..add(DiagnosticsProperty('unselectedLabelTextStyle', unselectedLabelTextStyle))
      ..add(EnumProperty('indicatorSize', indicatorSize))
      ..add(DiagnosticsProperty('indicator', indicatorDecoration))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTabsStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          unselectedLabelTextStyle == other.unselectedLabelTextStyle &&
          selectedLabelTextStyle == other.selectedLabelTextStyle &&
          indicatorDecoration == other.indicatorDecoration &&
          indicatorSize == other.indicatorSize &&
          height == other.height &&
          spacing == other.spacing &&
          focusedOutlineStyle == other.focusedOutlineStyle;

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      unselectedLabelTextStyle.hashCode ^
      selectedLabelTextStyle.hashCode ^
      indicatorDecoration.hashCode ^
      indicatorSize.hashCode ^
      height.hashCode ^
      spacing.hashCode ^
      focusedOutlineStyle.hashCode;
}
