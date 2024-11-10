import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/theme/breakpoints.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar.dart';

/// Defines the configuration of the overall visual [FTheme] for a widget subtree.
///
/// A [FThemeData] is composed of [colorScheme], [typography], [style], and widget styles.
/// * [colorScheme] is a set of colors.
/// * [typography] contains font and typography information.
/// * [style] is a set of miscellaneous properties.
/// * widget styles are used to style individual Forui widgets.
///
/// [FThemeData] and widget styles provide an `inherit(...)` constructor. The constructor configures the theme data/
/// widget style using the defaults provided by the [colorScheme], [typography], and [style].
final class FThemeData with Diagnosticable {
  /// The responsive breakpoints.
  final FBreakpoints breakpoints;

  /// The color scheme. It is used to configure the color properties of Forui widgets.
  final FColorScheme colorScheme;

  /// The typography data. It is used to configure the [TextStyle]s of Forui widgets.
  final FTypography typography;

  /// The style. It is used to configure the miscellaneous properties, such as border radii, of Forui widgets.
  final FStyle style;

  /// The accordion style.
  final FAccordionStyle accordionStyle;

  /// The alert styles.
  final FAlertStyles alertStyles;

  /// The avatar style.
  final FAvatarStyle avatarStyle;

  /// The badge styles.
  final FBadgeStyles badgeStyles;

  /// The bottom navigation bar style.
  final FBottomNavigationBarStyle bottomNavigationBarStyle;

  /// The button styles.
  final FButtonStyles buttonStyles;

  /// The calendar style.
  final FCalendarStyle calendarStyle;

  /// The card style.
  final FCardStyle cardStyle;

  /// The checkbox style.
  final FCheckboxStyle checkboxStyle;

  /// The dialog style.
  final FDialogStyle dialogStyle;

  /// The divider styles.
  final FDividerStyles dividerStyles;

  /// The header styles.
  final FHeaderStyles headerStyle;

  /// The label styles.
  final FLabelStyles labelStyles;

  /// The line calendar style.
  final FLineCalendarStyle lineCalendarStyle;

  /// The popover's style.
  final FPopoverStyle popoverStyle;

  /// The popover menu's style.
  final FPopoverMenuStyle popoverMenuStyle;

  /// The progress styles.
  final FProgressStyle progressStyle;

  /// The radio style.
  final FRadioStyle radioStyle;

  /// The resizable style.
  final FResizableStyle resizableStyle;

  /// The scaffold style.
  final FScaffoldStyle scaffoldStyle;

  /// The select group style.
  final FSelectGroupStyle selectGroupStyle;

  /// The select menu tile style.
  final FSelectMenuTileStyle selectMenuTileStyle;

  /// The slider styles.
  final FSliderStyles sliderStyles;

  /// The switch style.
  final FSwitchStyle switchStyle;

  /// The tabs styles.
  final FTabsStyle tabsStyle;

  /// The text field style.
  final FTextFieldStyle textFieldStyle;

  /// The tile group's style.
  final FTileGroupStyle tileGroupStyle;

  /// The tooltip style.
  final FTooltipStyle tooltipStyle;

  /// Creates a [FThemeData].
  ///
  /// **Note:**
  /// Unless you are creating a completely new theme, modifying [FThemes]' predefined themes is preferred.
  /// [FThemeData.inherit] can also be used as a simpler way to create a [FThemeData] without manually specifying the
  /// widget styles.
  FThemeData({
    required this.colorScheme,
    required this.style,
    required this.accordionStyle,
    required this.alertStyles,
    required this.avatarStyle,
    required this.badgeStyles,
    required this.bottomNavigationBarStyle,
    required this.buttonStyles,
    required this.calendarStyle,
    required this.cardStyle,
    required this.checkboxStyle,
    required this.dialogStyle,
    required this.dividerStyles,
    required this.headerStyle,
    required this.labelStyles,
    required this.lineCalendarStyle,
    required this.popoverStyle,
    required this.popoverMenuStyle,
    required this.progressStyle,
    required this.radioStyle,
    required this.resizableStyle,
    required this.scaffoldStyle,
    required this.selectGroupStyle,
    required this.selectMenuTileStyle,
    required this.sliderStyles,
    required this.switchStyle,
    required this.tabsStyle,
    required this.textFieldStyle,
    required this.tooltipStyle,
    required this.tileGroupStyle,
    this.breakpoints = const FBreakpoints(),
    this.typography = const FTypography(),
  });

  /// Creates a [FThemeData] that configures the widget styles using the given properties.
  factory FThemeData.inherit({
    required FColorScheme colorScheme,
    FStyle? style,
    FTypography? typography,
  }) {
    typography ??= FTypography.inherit(colorScheme: colorScheme);
    style ??= FStyle.inherit(colorScheme: colorScheme, typography: typography);
    return FThemeData(
      colorScheme: colorScheme,
      typography: typography,
      style: style,
      accordionStyle: FAccordionStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      alertStyles: FAlertStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      avatarStyle: FAvatarStyle.inherit(colorScheme: colorScheme, typography: typography),
      badgeStyles: FBadgeStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      bottomNavigationBarStyle: FBottomNavigationBarStyle.inherit(
        colorScheme: colorScheme,
        typography: typography,
        style: style,
      ),
      buttonStyles: FButtonStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      calendarStyle: FCalendarStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      cardStyle: FCardStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      checkboxStyle: FCheckboxStyle.inherit(colorScheme: colorScheme, style: style),
      dialogStyle: FDialogStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      dividerStyles: FDividerStyles.inherit(colorScheme: colorScheme, style: style),
      headerStyle: FHeaderStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      labelStyles: FLabelStyles.inherit(style: style),
      lineCalendarStyle: FLineCalendarStyle.inherit(colorScheme: colorScheme, style: style, typography: typography),
      popoverStyle: FPopoverStyle.inherit(colorScheme: colorScheme, style: style),
      popoverMenuStyle: FPopoverMenuStyle.inherit(colorScheme: colorScheme, style: style, typography: typography),
      progressStyle: FProgressStyle.inherit(colorScheme: colorScheme, style: style),
      radioStyle: FRadioStyle.inherit(colorScheme: colorScheme, style: style),
      resizableStyle: FResizableStyle.inherit(colorScheme: colorScheme),
      scaffoldStyle: FScaffoldStyle.inherit(colorScheme: colorScheme, style: style),
      selectGroupStyle: FSelectGroupStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      selectMenuTileStyle: FSelectMenuTileStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      sliderStyles: FSliderStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      switchStyle: FSwitchStyle.inherit(colorScheme: colorScheme, style: style),
      tabsStyle: FTabsStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      textFieldStyle: FTextFieldStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      tileGroupStyle: FTileGroupStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
    );
  }

  /// Returns a copy of this [FThemeData] with the given properties replaced.
  ///
  /// ```dart
  /// final theme = FThemeData(
  ///   alertStyles: ...,
  ///   avatarStyle: ...,
  /// );
  ///
  /// final copy = theme.copyWith(avatarStyle: bar);
  ///
  /// print(theme.alertStyles == copy.alertStyles); // true
  /// print(theme.avatarStyle == copy.avatarStyle); // false
  /// ```
  ///
  /// To modify [colorScheme], [typography], and/or [style], create a new `FThemeData` using [FThemeData.inherit] first.
  /// This allows the global theme data to propagate to widget-specific theme data.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   final theme = FThemeData.inherit(
  ///     colorScheme: FThemes.zinc.light.colorScheme.copyWith(
  ///       primary: const Color(0xFF0D47A1), // dark blue
  ///       primaryForeground: const Color(0xFFFFFFFF), // white
  ///     ),
  ///     typography: FThemes.zinc.light.typography.copyWith(
  ///       defaultFontFamily: 'Roboto',
  ///     ).scale(sizeScalar: 0.8),
  ///     style: FThemes.zinc.light.style.copyWith(
  ///       borderRadius: BorderRadius.zero,
  ///     ),
  ///   );
  ///
  ///   return FTheme(
  ///     data: theme.copyWith(
  ///       cardStyle: theme.cardStyle.copyWith(
  ///         decoration: theme.cardStyle.decoration.copyWith(
  ///           borderRadius: const BorderRadius.all(Radius.circular(8)),
  ///         ),
  ///       ),
  ///     ),
  ///     child: const FScaffold(...),
  ///   );
  /// }
  ///```
  @useResult
  FThemeData copyWith({
    FAccordionStyle? accordionStyle,
    FAlertStyles? alertStyles,
    FAvatarStyle? avatarStyle,
    FBadgeStyles? badgeStyles,
    FBottomNavigationBarStyle? bottomNavigationBarStyle,
    FButtonStyles? buttonStyles,
    FCalendarStyle? calendarStyle,
    FCardStyle? cardStyle,
    FCheckboxStyle? checkboxStyle,
    FDialogStyle? dialogStyle,
    FDividerStyles? dividerStyles,
    FHeaderStyles? headerStyle,
    FLabelStyles? labelStyles,
    FLineCalendarStyle? lineCalendarStyle,
    FPopoverStyle? popoverStyle,
    FPopoverMenuStyle? popoverMenuStyle,
    FProgressStyle? progressStyle,
    FRadioStyle? radioStyle,
    FResizableStyle? resizableStyle,
    FScaffoldStyle? scaffoldStyle,
    FSelectGroupStyle? selectGroupStyle,
    FSelectMenuTileStyle? selectMenuTileStyle,
    FSliderStyles? sliderStyles,
    FSwitchStyle? switchStyle,
    FTabsStyle? tabsStyle,
    FTextFieldStyle? textFieldStyle,
    FTileGroupStyle? tileGroupStyle,
    FTooltipStyle? tooltipStyle,
  }) =>
      FThemeData(
        colorScheme: colorScheme,
        typography: typography,
        style: style,
        accordionStyle: accordionStyle ?? this.accordionStyle,
        alertStyles: alertStyles ?? this.alertStyles,
        avatarStyle: avatarStyle ?? this.avatarStyle,
        badgeStyles: badgeStyles ?? this.badgeStyles,
        bottomNavigationBarStyle: bottomNavigationBarStyle ?? this.bottomNavigationBarStyle,
        buttonStyles: buttonStyles ?? this.buttonStyles,
        calendarStyle: calendarStyle ?? this.calendarStyle,
        cardStyle: cardStyle ?? this.cardStyle,
        checkboxStyle: checkboxStyle ?? this.checkboxStyle,
        dialogStyle: dialogStyle ?? this.dialogStyle,
        dividerStyles: dividerStyles ?? this.dividerStyles,
        headerStyle: headerStyle ?? this.headerStyle,
        labelStyles: labelStyles ?? this.labelStyles,
        lineCalendarStyle: lineCalendarStyle ?? this.lineCalendarStyle,
        popoverStyle: popoverStyle ?? this.popoverStyle,
        popoverMenuStyle: popoverMenuStyle ?? this.popoverMenuStyle,
        progressStyle: progressStyle ?? this.progressStyle,
        radioStyle: radioStyle ?? this.radioStyle,
        resizableStyle: resizableStyle ?? this.resizableStyle,
        scaffoldStyle: scaffoldStyle ?? this.scaffoldStyle,
        selectGroupStyle: selectGroupStyle ?? this.selectGroupStyle,
        selectMenuTileStyle: selectMenuTileStyle ?? this.selectMenuTileStyle,
        sliderStyles: sliderStyles ?? this.sliderStyles,
        switchStyle: switchStyle ?? this.switchStyle,
        tabsStyle: tabsStyle ?? this.tabsStyle,
        textFieldStyle: textFieldStyle ?? this.textFieldStyle,
        tileGroupStyle: tileGroupStyle ?? this.tileGroupStyle,
        tooltipStyle: tooltipStyle ?? this.tooltipStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('breakpoints', breakpoints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('colorScheme', colorScheme, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('typography', typography, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('accordionStyle', accordionStyle))
      ..add(DiagnosticsProperty('alertStyles', alertStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('avatarStyle', avatarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('badgeStyles', badgeStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bottomNavigationBarStyle', bottomNavigationBarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('buttonStyles', buttonStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('cardStyle', cardStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dialogStyle', dialogStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerStyles', dividerStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('headerStyle', headerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelStyles', labelStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('lineCalendarStyle', lineCalendarStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverMenuStyle', popoverMenuStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('radioStyle', radioStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('resizableStyle', resizableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scaffoldStyle', scaffoldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectGroupStyle', selectGroupStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectMenuTileStyle', selectMenuTileStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('sliderStyles', sliderStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('switchStyle', switchStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tabsStyle', tabsStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FThemeData &&
          runtimeType == other.runtimeType &&
          breakpoints == other.breakpoints &&
          colorScheme == other.colorScheme &&
          typography == other.typography &&
          style == other.style &&
          accordionStyle == other.accordionStyle &&
          alertStyles == other.alertStyles &&
          avatarStyle == other.avatarStyle &&
          badgeStyles == other.badgeStyles &&
          bottomNavigationBarStyle == other.bottomNavigationBarStyle &&
          buttonStyles == other.buttonStyles &&
          calendarStyle == other.calendarStyle &&
          cardStyle == other.cardStyle &&
          checkboxStyle == other.checkboxStyle &&
          dialogStyle == other.dialogStyle &&
          dividerStyles == other.dividerStyles &&
          headerStyle == other.headerStyle &&
          labelStyles == other.labelStyles &&
          lineCalendarStyle == other.lineCalendarStyle &&
          popoverStyle == other.popoverStyle &&
          popoverMenuStyle == other.popoverMenuStyle &&
          progressStyle == other.progressStyle &&
          radioStyle == other.radioStyle &&
          resizableStyle == other.resizableStyle &&
          scaffoldStyle == other.scaffoldStyle &&
          selectGroupStyle == other.selectGroupStyle &&
          selectMenuTileStyle == other.selectMenuTileStyle &&
          sliderStyles == other.sliderStyles &&
          switchStyle == other.switchStyle &&
          tabsStyle == other.tabsStyle &&
          textFieldStyle == other.textFieldStyle &&
          tileGroupStyle == other.tileGroupStyle &&
          tooltipStyle == other.tooltipStyle;

  @override
  int get hashCode =>
      breakpoints.hashCode ^
      colorScheme.hashCode ^
      typography.hashCode ^
      style.hashCode ^
      accordionStyle.hashCode ^
      alertStyles.hashCode ^
      avatarStyle.hashCode ^
      badgeStyles.hashCode ^
      bottomNavigationBarStyle.hashCode ^
      buttonStyles.hashCode ^
      calendarStyle.hashCode ^
      cardStyle.hashCode ^
      checkboxStyle.hashCode ^
      dialogStyle.hashCode ^
      dividerStyles.hashCode ^
      headerStyle.hashCode ^
      labelStyles.hashCode ^
      lineCalendarStyle.hashCode ^
      popoverStyle.hashCode ^
      popoverMenuStyle.hashCode ^
      progressStyle.hashCode ^
      radioStyle.hashCode ^
      resizableStyle.hashCode ^
      scaffoldStyle.hashCode ^
      selectGroupStyle.hashCode ^
      selectMenuTileStyle.hashCode ^
      sliderStyles.hashCode ^
      switchStyle.hashCode ^
      tabsStyle.hashCode ^
      textFieldStyle.hashCode ^
      tileGroupStyle.hashCode ^
      tooltipStyle.hashCode;
}
