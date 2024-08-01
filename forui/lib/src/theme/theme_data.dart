import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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
  /// The color scheme. It is used to configure the color properties of Forui widgets.
  final FColorScheme colorScheme;

  /// The typography data. It is used to configure the [TextStyle]s of Forui widgets.
  final FTypography typography;

  /// The style. It is used to configure the miscellaneous properties, such as border radii, of Forui widgets.
  final FStyle style;

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

  /// The header styles.
  final FHeaderStyles headerStyle;

  /// The progress styles.
  final FProgressStyle progressStyle;

  /// The resizable style.
  final FResizableStyle resizableStyle;

  /// The tabs styles.
  final FTabsStyle tabsStyle;

  /// The text field style.
  final FTextFieldStyle textFieldStyle;

  /// The scaffold style.
  final FScaffoldStyle scaffoldStyle;

  /// The separator styles.
  final FSeparatorStyles separatorStyles;

  /// The switch style.
  final FSwitchStyle switchStyle;

  /// Creates a [FThemeData].
  ///
  /// **Note:**
  /// Unless you are creating a completely new theme, modifying [FThemes]' predefined themes is preferred.
  /// [FThemeData.inherit] can also be used as a simpler way to create a [FThemeData] without manually specifying the
  /// widget styles.
  FThemeData({
    required this.colorScheme,
    required this.alertStyles,
    required this.avatarStyle,
    required this.badgeStyles,
    required this.bottomNavigationBarStyle,
    required this.buttonStyles,
    required this.calendarStyle,
    required this.cardStyle,
    required this.checkboxStyle,
    required this.dialogStyle,
    required this.headerStyle,
    required this.progressStyle,
    required this.resizableStyle,
    required this.tabsStyle,
    required this.textFieldStyle,
    required this.scaffoldStyle,
    required this.separatorStyles,
    required this.switchStyle,
    this.typography = const FTypography(),
    this.style = const FStyle(),
  });

  /// Creates a [FThemeData] that configures the widget styles using the given properties.
  factory FThemeData.inherit({
    required FColorScheme colorScheme,
    FStyle style = const FStyle(),
    FTypography? typography,
  }) {
    typography ??= FTypography.inherit(colorScheme: colorScheme);

    return FThemeData(
      colorScheme: colorScheme,
      typography: typography,
      style: style,
      alertStyles: FAlertStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      avatarStyle: FAvatarStyle.inherit(colorScheme: colorScheme, typography: typography),
      badgeStyles: FBadgeStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      bottomNavigationBarStyle: FBottomNavigationBarStyle.inherit(colorScheme: colorScheme, typography: typography),
      buttonStyles: FButtonStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      calendarStyle: FCalendarStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      cardStyle: FCardStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      checkboxStyle: FCheckboxStyle.inherit(colorScheme: colorScheme),
      dialogStyle: FDialogStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      headerStyle: FHeaderStyles.inherit(colorScheme: colorScheme, typography: typography, style: style),
      progressStyle: FProgressStyle.inherit(colorScheme: colorScheme, style: style),
      resizableStyle: FResizableStyle.inherit(colorScheme: colorScheme),
      tabsStyle: FTabsStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      textFieldStyle: FTextFieldStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      scaffoldStyle: FScaffoldStyle.inherit(colorScheme: colorScheme, style: style),
      separatorStyles: FSeparatorStyles.inherit(colorScheme: colorScheme, style: style),
      switchStyle: FSwitchStyle.inherit(colorScheme: colorScheme),
    );
  }

  /// Returns a copy of this [FThemeData] with the given properties replaced.
  ///
  /// ```dart
  /// final foo = FTypography();
  /// final bar = FTypography();
  ///
  /// final theme = FThemeData.inherit(
  ///   colorScheme: FColorScheme(...),
  ///   typography: foo,
  /// );
  ///
  /// final copy = theme.copyWith(typography: bar);
  ///
  /// print(theme.colorScheme == copy.colorScheme); // true
  /// print(copy.typography); // bar
  /// ```
  @useResult
  FThemeData copyWith({
    FColorScheme? colorScheme,
    FTypography? typography,
    FStyle? style,
    FAlertStyles? alertStyles,
    FAvatarStyle? avatarStyle,
    FBadgeStyles? badgeStyles,
    FBottomNavigationBarStyle? bottomNavigationBarStyle,
    FButtonStyles? buttonStyles,
    FCalendarStyle? calendarStyle,
    FCardStyle? cardStyle,
    FCheckboxStyle? checkboxStyle,
    FDialogStyle? dialogStyle,
    FHeaderStyles? headerStyle,
    FProgressStyle? progressStyle,
    FResizableStyle? resizableStyle,
    FTabsStyle? tabsStyle,
    FTextFieldStyle? textFieldStyle,
    FScaffoldStyle? scaffoldStyle,
    FSeparatorStyles? separatorStyles,
    FSwitchStyle? switchStyle,
  }) =>
      FThemeData(
        colorScheme: colorScheme ?? this.colorScheme,
        typography: typography ?? this.typography,
        style: style ?? this.style,
        alertStyles: alertStyles ?? this.alertStyles,
        avatarStyle: avatarStyle ?? this.avatarStyle,
        badgeStyles: badgeStyles ?? this.badgeStyles,
        bottomNavigationBarStyle: bottomNavigationBarStyle ?? this.bottomNavigationBarStyle,
        buttonStyles: buttonStyles ?? this.buttonStyles,
        calendarStyle: calendarStyle ?? this.calendarStyle,
        cardStyle: cardStyle ?? this.cardStyle,
        checkboxStyle: checkboxStyle ?? this.checkboxStyle,
        dialogStyle: dialogStyle ?? this.dialogStyle,
        headerStyle: headerStyle ?? this.headerStyle,
        progressStyle: progressStyle ?? this.progressStyle,
        resizableStyle: resizableStyle ?? this.resizableStyle,
        tabsStyle: tabsStyle ?? this.tabsStyle,
        textFieldStyle: textFieldStyle ?? this.textFieldStyle,
        scaffoldStyle: scaffoldStyle ?? this.scaffoldStyle,
        separatorStyles: separatorStyles ?? this.separatorStyles,
        switchStyle: switchStyle ?? this.switchStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('colorScheme', colorScheme, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('typography', typography, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('alertStyles', alertStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('avatarStyle', avatarStyle))
      ..add(DiagnosticsProperty('badgeStyles', badgeStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bottomNavigationBarStyle', bottomNavigationBarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('buttonStyles', buttonStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('cardStyle', cardStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dialogStyle', dialogStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('headerStyle', headerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('progressStyle', progressStyle))
      ..add(DiagnosticsProperty('resizableStyle', resizableStyle))
      ..add(DiagnosticsProperty('tabsStyle', tabsStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scaffoldStyle', scaffoldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('separatorStyles', separatorStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('switchStyle', switchStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FThemeData &&
          runtimeType == other.runtimeType &&
          colorScheme == other.colorScheme &&
          typography == other.typography &&
          style == other.style &&
          alertStyles == other.alertStyles &&
          avatarStyle == other.avatarStyle &&
          badgeStyles == other.badgeStyles &&
          bottomNavigationBarStyle == other.bottomNavigationBarStyle &&
          buttonStyles == other.buttonStyles &&
          calendarStyle == other.calendarStyle &&
          cardStyle == other.cardStyle &&
          checkboxStyle == other.checkboxStyle &&
          dialogStyle == other.dialogStyle &&
          headerStyle == other.headerStyle &&
          progressStyle == other.progressStyle &&
          resizableStyle == other.resizableStyle &&
          tabsStyle == other.tabsStyle &&
          textFieldStyle == other.textFieldStyle &&
          scaffoldStyle == other.scaffoldStyle &&
          separatorStyles == other.separatorStyles &&
          switchStyle == other.switchStyle;

  @override
  int get hashCode =>
      colorScheme.hashCode ^
      typography.hashCode ^
      style.hashCode ^
      alertStyles.hashCode ^
      avatarStyle.hashCode ^
      badgeStyles.hashCode ^
      bottomNavigationBarStyle.hashCode ^
      buttonStyles.hashCode ^
      calendarStyle.hashCode ^
      cardStyle.hashCode ^
      checkboxStyle.hashCode ^
      dialogStyle.hashCode ^
      headerStyle.hashCode ^
      progressStyle.hashCode ^
      resizableStyle.hashCode ^
      tabsStyle.hashCode ^
      textFieldStyle.hashCode ^
      scaffoldStyle.hashCode ^
      separatorStyles.hashCode ^
      switchStyle.hashCode;
}
