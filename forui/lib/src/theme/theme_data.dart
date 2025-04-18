import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// Defines the configuration of the overall visual [FTheme] for a widget subtree.
///
/// A [FThemeData] is composed of [colors], [typography], [style], and widget styles.
///   * [colors] is a set of colors.
///   * [typography] contains font and typography information.
///   * [style] is a set of miscellaneous properties.
///   * widget styles are used to style individual Forui widgets.
///
/// Widget styles provide an `inherit(...)` constructor. The constructor configures the widget style using the defaults
/// provided by the [colors], [typography], and [style].
final class FThemeData with Diagnosticable, FTransformable {
  /// A label that is used in the [toString] output. Intended to aid with identifying themes in debug output.
  final String? debugLabel;

  /// The responsive breakpoints.
  final FBreakpoints breakpoints;

  /// The color scheme. It is used to configure the colors of Forui widgets.
  final FColors colors;

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

  /// The breadcrumb style.
  final FBreadcrumbStyle breadcrumbStyle;

  /// The button styles.
  final FButtonStyles buttonStyles;

  /// The calendar style.
  final FCalendarStyle calendarStyle;

  /// The card style.
  final FCardStyle cardStyle;

  /// The checkbox style.
  final FCheckboxStyle checkboxStyle;

  /// The date picker style.
  final FDateFieldStyle dateFieldStyle;

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

  /// The pagination style.
  final FPaginationStyle paginationStyle;

  /// The picker's style.
  final FPickerStyle pickerStyle;

  /// The popover's style.
  final FPopoverStyle popoverStyle;

  /// The popover menu's style.
  final FPopoverMenuStyle popoverMenuStyle;

  /// The progress styles.
  final FProgressStyles progressStyles;

  /// The radio style.
  final FRadioStyle radioStyle;

  /// The resizable style.
  final FResizableStyle resizableStyle;

  /// The scaffold style.
  final FScaffoldStyle scaffoldStyle;

  /// The select style.
  final FSelectStyle selectStyle;

  /// The select group style.
  final FSelectGroupStyle selectGroupStyle;

  /// The select menu tile style.
  final FSelectMenuTileStyle selectMenuTileStyle;

  /// The sheet style.
  final FSheetStyle sheetStyle;

  /// The slider styles.
  final FSliderStyles sliderStyles;

  /// The switch style.
  final FSwitchStyle switchStyle;

  /// The tabs styles.
  final FTabsStyle tabsStyle;

  /// The tappable style.
  final FTappableStyle tappableStyle;

  /// The text field style.
  final FTextFieldStyle textFieldStyle;

  /// The tile group's style.
  final FTileGroupStyle tileGroupStyle;

  /// The time field's style.
  final FTimeFieldStyle timeFieldStyle;

  /// The time picker style.
  final FTimePickerStyle timePickerStyle;

  /// The tooltip style.
  final FTooltipStyle tooltipStyle;

  /// Creates a [FThemeData] that configures the widget styles using the given properties if not given.
  factory FThemeData({
    required FColors colors,
    String? debugLabel,
    FBreakpoints breakpoints = const FBreakpoints(),
    FTypography? typography,
    FStyle? style,
    FAccordionStyle? accordionStyle,
    FAlertStyles? alertStyles,
    FAvatarStyle? avatarStyle,
    FBadgeStyles? badgeStyles,
    FBottomNavigationBarStyle? bottomNavigationBarStyle,
    FBreadcrumbStyle? breadcrumbStyle,
    FButtonStyles? buttonStyles,
    FCalendarStyle? calendarStyle,
    FCardStyle? cardStyle,
    FCheckboxStyle? checkboxStyle,
    FDateFieldStyle? dateFieldStyle,
    FDialogStyle? dialogStyle,
    FDividerStyles? dividerStyles,
    FHeaderStyles? headerStyle,
    FLabelStyles? labelStyles,
    FLineCalendarStyle? lineCalendarStyle,
    FPaginationStyle? paginationStyle,
    FPickerStyle? pickerStyle,
    FPopoverStyle? popoverStyle,
    FPopoverMenuStyle? popoverMenuStyle,
    FProgressStyles? progressStyles,
    FRadioStyle? radioStyle,
    FResizableStyle? resizableStyle,
    FScaffoldStyle? scaffoldStyle,
    FSelectStyle? selectStyle,
    FSelectGroupStyle? selectGroupStyle,
    FSelectMenuTileStyle? selectMenuTileStyle,
    FSheetStyle? sheetStyle,
    FSliderStyles? sliderStyles,
    FSwitchStyle? switchStyle,
    FTabsStyle? tabsStyle,
    FTappableStyle? tappableStyle,
    FTextFieldStyle? textFieldStyle,
    FTileGroupStyle? tileGroupStyle,
    FTimeFieldStyle? timeFieldStyle,
    FTimePickerStyle? timePickerStyle,
    FTooltipStyle? tooltipStyle,
  }) {
    typography = typography ?? FTypography.inherit(colors: colors);
    style = style ?? FStyle.inherit(colors: colors, typography: typography);
    return FThemeData._(
      debugLabel: debugLabel,
      breakpoints: breakpoints,
      colors: colors,
      typography: typography,
      style: style,
      accordionStyle: accordionStyle ?? FAccordionStyle.inherit(colors: colors, typography: typography, style: style),
      alertStyles: alertStyles ?? FAlertStyles.inherit(colors: colors, typography: typography, style: style),
      avatarStyle: avatarStyle ?? FAvatarStyle.inherit(colors: colors, typography: typography),
      badgeStyles: badgeStyles ?? FBadgeStyles.inherit(colors: colors, typography: typography, style: style),
      bottomNavigationBarStyle:
          bottomNavigationBarStyle ??
          FBottomNavigationBarStyle.inherit(colors: colors, typography: typography, style: style),
      breadcrumbStyle:
          breadcrumbStyle ?? FBreadcrumbStyle.inherit(colors: colors, typography: typography, style: style),
      buttonStyles: buttonStyles ?? FButtonStyles.inherit(colors: colors, typography: typography, style: style),
      calendarStyle: calendarStyle ?? FCalendarStyle.inherit(colors: colors, typography: typography, style: style),
      cardStyle: cardStyle ?? FCardStyle.inherit(colors: colors, typography: typography, style: style),
      checkboxStyle: checkboxStyle ?? FCheckboxStyle.inherit(colors: colors, style: style),
      dateFieldStyle: dateFieldStyle ?? FDateFieldStyle.inherit(colors: colors, typography: typography, style: style),
      dialogStyle: dialogStyle ?? FDialogStyle.inherit(colors: colors, typography: typography, style: style),
      dividerStyles: dividerStyles ?? FDividerStyles.inherit(colors: colors, style: style),
      headerStyle: headerStyle ?? FHeaderStyles.inherit(colors: colors, typography: typography, style: style),
      labelStyles: labelStyles ?? FLabelStyles.inherit(style: style),
      lineCalendarStyle:
          lineCalendarStyle ?? FLineCalendarStyle.inherit(colors: colors, typography: typography, style: style),
      paginationStyle:
          paginationStyle ?? FPaginationStyle.inherit(colors: colors, typography: typography, style: style),
      pickerStyle: pickerStyle ?? FPickerStyle.inherit(colors: colors, style: style, typography: typography),
      popoverStyle: popoverStyle ?? FPopoverStyle.inherit(colors: colors, style: style),
      popoverMenuStyle:
          popoverMenuStyle ?? FPopoverMenuStyle.inherit(colors: colors, style: style, typography: typography),
      progressStyles: progressStyles ?? FProgressStyles.inherit(colors: colors, style: style),
      radioStyle: radioStyle ?? FRadioStyle.inherit(colors: colors, style: style),
      resizableStyle: resizableStyle ?? FResizableStyle.inherit(colors: colors, style: style),
      scaffoldStyle: scaffoldStyle ?? FScaffoldStyle.inherit(colors: colors, style: style),
      selectStyle: selectStyle ?? FSelectStyle.inherit(colors: colors, typography: typography, style: style),
      selectGroupStyle:
          selectGroupStyle ?? FSelectGroupStyle.inherit(colors: colors, typography: typography, style: style),
      selectMenuTileStyle:
          selectMenuTileStyle ?? FSelectMenuTileStyle.inherit(colors: colors, typography: typography, style: style),
      sheetStyle: sheetStyle ?? FSheetStyle.inherit(colors: colors),
      sliderStyles: sliderStyles ?? FSliderStyles.inherit(colors: colors, typography: typography, style: style),
      switchStyle: switchStyle ?? FSwitchStyle.inherit(colors: colors, style: style),
      tabsStyle: tabsStyle ?? FTabsStyle.inherit(colors: colors, typography: typography, style: style),
      tappableStyle: tappableStyle ?? FTappableStyle(),
      textFieldStyle: textFieldStyle ?? FTextFieldStyle.inherit(colors: colors, typography: typography, style: style),
      tileGroupStyle: tileGroupStyle ?? FTileGroupStyle.inherit(colors: colors, typography: typography, style: style),
      timeFieldStyle: timeFieldStyle ?? FTimeFieldStyle.inherit(colors: colors, typography: typography, style: style),
      timePickerStyle:
          timePickerStyle ?? FTimePickerStyle.inherit(colors: colors, typography: typography, style: style),
      tooltipStyle: tooltipStyle ?? FTooltipStyle.inherit(colors: colors, typography: typography, style: style),
    );
  }

  FThemeData._({
    required this.debugLabel,
    required this.breakpoints,
    required this.colors,
    required this.typography,
    required this.style,
    required this.accordionStyle,
    required this.alertStyles,
    required this.avatarStyle,
    required this.badgeStyles,
    required this.bottomNavigationBarStyle,
    required this.breadcrumbStyle,
    required this.buttonStyles,
    required this.calendarStyle,
    required this.cardStyle,
    required this.checkboxStyle,
    required this.dateFieldStyle,
    required this.dialogStyle,
    required this.dividerStyles,
    required this.headerStyle,
    required this.labelStyles,
    required this.lineCalendarStyle,
    required this.paginationStyle,
    required this.pickerStyle,
    required this.popoverStyle,
    required this.popoverMenuStyle,
    required this.progressStyles,
    required this.radioStyle,
    required this.resizableStyle,
    required this.scaffoldStyle,
    required this.selectStyle,
    required this.selectGroupStyle,
    required this.selectMenuTileStyle,
    required this.sheetStyle,
    required this.sliderStyles,
    required this.switchStyle,
    required this.tabsStyle,
    required this.tappableStyle,
    required this.textFieldStyle,
    required this.tileGroupStyle,
    required this.timeFieldStyle,
    required this.timePickerStyle,
    required this.tooltipStyle,
  });

  /// Converts this [FThemeData] to a Material [ThemeData] on a best-effort basis.
  ///
  /// This method enables interoperability between Forui and Material Design widgets by mapping
  /// Forui's theme properties to their closest Material equivalents. Use this when you need to:
  ///
  /// * Use Material widgets within a Forui application
  /// * Apply your Forui theme consistently to both Forui and Material widgets
  /// * Create a gradual migration path from Material Design to Forui
  ///
  /// Note that this conversion is approximate and experimental. Some styling properties may not map
  /// perfectly between the two design systems, and the resulting Material theme might not capture
  /// all the nuances of your Forui theme.
  ///
  /// ```dart
  /// // Apply a Forui theme to Material widgets
  /// MaterialApp(
  ///   theme: FThemes.zinc.light.toApproximateMaterialTheme(),
  ///   // ...
  /// )
  /// ```
  @experimental
  ThemeData toApproximateMaterialTheme() {
    // Material requires height to be 1, certain widgets will overflow without it.
    // TextBaseline.alphabetic is required as TextField requires it.
    final textTheme = TextTheme(
      displayLarge: typography.xl4.copyWith(
        height: 1,
        textBaseline: typography.xl4.textBaseline ?? TextBaseline.alphabetic,
      ),
      displayMedium: typography.xl3.copyWith(
        height: 1,
        textBaseline: typography.xl3.textBaseline ?? TextBaseline.alphabetic,
      ),
      displaySmall: typography.xl2.copyWith(
        height: 1,
        textBaseline: typography.xl2.textBaseline ?? TextBaseline.alphabetic,
      ),
      headlineLarge: typography.xl3.copyWith(
        height: 1,
        textBaseline: typography.xl3.textBaseline ?? TextBaseline.alphabetic,
      ),
      headlineMedium: typography.xl2.copyWith(
        height: 1,
        textBaseline: typography.xl2.textBaseline ?? TextBaseline.alphabetic,
      ),
      headlineSmall: typography.xl.copyWith(
        height: 1,
        textBaseline: typography.xl.textBaseline ?? TextBaseline.alphabetic,
      ),
      titleLarge: typography.lg.copyWith(
        height: 1,
        textBaseline: typography.lg.textBaseline ?? TextBaseline.alphabetic,
      ),
      titleMedium: typography.base.copyWith(
        height: 1,
        textBaseline: typography.base.textBaseline ?? TextBaseline.alphabetic,
      ),
      titleSmall: typography.sm.copyWith(
        height: 1,
        textBaseline: typography.sm.textBaseline ?? TextBaseline.alphabetic,
      ),
      labelLarge: typography.base.copyWith(
        height: 1,
        textBaseline: typography.base.textBaseline ?? TextBaseline.alphabetic,
      ),
      labelMedium: typography.sm.copyWith(
        height: 1,
        textBaseline: typography.sm.textBaseline ?? TextBaseline.alphabetic,
      ),
      labelSmall: typography.xs.copyWith(
        height: 1,
        textBaseline: typography.xs.textBaseline ?? TextBaseline.alphabetic,
      ),
      bodyLarge: typography.base.copyWith(
        height: 1,
        textBaseline: typography.base.textBaseline ?? TextBaseline.alphabetic,
      ),
      bodyMedium: typography.sm.copyWith(
        height: 1,
        textBaseline: typography.sm.textBaseline ?? TextBaseline.alphabetic,
      ),
      bodySmall: typography.xs.copyWith(height: 1, textBaseline: typography.xs.textBaseline ?? TextBaseline.alphabetic),
    )..apply(fontFamily: typography.defaultFontFamily, bodyColor: colors.foreground, displayColor: colors.foreground);

    return ThemeData(
      colorScheme: ColorScheme(
        brightness: colors.brightness,
        primary: colors.primary,
        onPrimary: colors.primaryForeground,
        secondary: colors.secondary,
        onSecondary: colors.secondaryForeground,
        error: colors.error,
        onError: colors.errorForeground,
        surface: colors.background,
        onSurface: colors.foreground,
        secondaryContainer: colors.secondary,
        onSecondaryContainer: colors.secondaryForeground,
      ),
      fontFamily: typography.defaultFontFamily,
      typography: Typography(
        black: textTheme,
        white: textTheme,
        englishLike: textTheme,
        dense: textTheme,
        tall: textTheme,
      ),
      textTheme: textTheme,
      splashFactory: NoSplash.splashFactory,
      useMaterial3: true,

      //// Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      //// Navigation Drawer
      navigationDrawerTheme: NavigationDrawerThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      //// Navigation Rail
      navigationRailTheme: NavigationRailThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      //// Card
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: style.borderRadius,
          side: BorderSide(width: style.borderWidth, color: colors.border),
        ),
      ),

      //// Chip
      chipTheme: ChipThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      //// Input
      inputDecorationTheme: InputDecorationTheme(
        border: WidgetStateInputBorder.resolveWith(textFieldStyle.border.resolve),
        labelStyle: textFieldStyle.descriptionTextStyle.maybeResolve({}),
        floatingLabelStyle: textFieldStyle.labelTextStyle.maybeResolve({}),
        hintStyle: textFieldStyle.hintTextStyle.maybeResolve({}),
        errorStyle: textFieldStyle.errorTextStyle,
        helperStyle: textFieldStyle.descriptionTextStyle.maybeResolve({}),
        counterStyle: textFieldStyle.counterTextStyle.maybeResolve({}),
        contentPadding: textFieldStyle.contentPadding,
      ),

      //// Date Picker
      datePickerTheme: DatePickerThemeData(
        shape: RoundedRectangleBorder(borderRadius: style.borderRadius),
        dayShape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
        rangePickerShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      //// Time Picker
      timePickerTheme: TimePickerThemeData(
        hourMinuteTextColor: colors.secondaryForeground,
        hourMinuteColor: colors.secondary,
        hourMinuteShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
        dayPeriodTextColor: colors.foreground,
        dayPeriodColor: colors.secondary,
        dayPeriodBorderSide: BorderSide(color: colors.border),
        dayPeriodShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
        dialBackgroundColor: colors.secondary,
        shape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      /// Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: sliderStyles.horizontalStyle.activeColor.maybeResolve({}),
        inactiveTrackColor: sliderStyles.horizontalStyle.inactiveColor.maybeResolve({}),
        disabledActiveTrackColor: sliderStyles.horizontalStyle.activeColor.maybeResolve({WidgetState.disabled}),
        disabledInactiveTrackColor: sliderStyles.horizontalStyle.inactiveColor.maybeResolve({WidgetState.disabled}),
        activeTickMarkColor: sliderStyles.horizontalStyle.markStyle.tickColor.maybeResolve({}),
        inactiveTickMarkColor: sliderStyles.horizontalStyle.markStyle.tickColor.maybeResolve({}),
        disabledActiveTickMarkColor: sliderStyles.horizontalStyle.markStyle.tickColor.maybeResolve({
          WidgetState.disabled,
        }),
        disabledInactiveTickMarkColor: sliderStyles.horizontalStyle.markStyle.tickColor.maybeResolve({
          WidgetState.disabled,
        }),
        thumbColor: sliderStyles.horizontalStyle.thumbStyle.borderColor.maybeResolve({}),
        disabledThumbColor: sliderStyles.horizontalStyle.thumbStyle.borderColor.maybeResolve({WidgetState.disabled}),
        valueIndicatorColor: sliderStyles.horizontalStyle.tooltipStyle.decoration.color,
        valueIndicatorTextStyle: sliderStyles.horizontalStyle.tooltipStyle.textStyle,
      ),

      //// Switch
      switchTheme: SwitchThemeData(
        thumbColor: switchStyle.thumbColor,
        trackColor: switchStyle.trackColor,
        trackOutlineColor: switchStyle.trackColor,
      ),

      //// Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: buttonStyles.secondary.contentStyle.textStyle,
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.secondary.decoration.maybeResolve(states)?.color ?? colors.secondary,
          ),
          foregroundColor: WidgetStateColor.resolveWith(
            (states) =>
                buttonStyles.secondary.contentStyle.textStyle.maybeResolve(states)?.color ?? colors.secondaryForeground,
          ),
          padding: WidgetStateProperty.all(buttonStyles.secondary.contentStyle.padding),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          textStyle: buttonStyles.primary.contentStyle.textStyle,
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.primary.decoration.maybeResolve(states)?.color ?? colors.secondary,
          ),
          foregroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.secondary.decoration.maybeResolve(states)?.color ?? colors.secondaryForeground,
          ),
          padding: WidgetStateProperty.all(buttonStyles.primary.contentStyle.padding),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: buttonStyles.outline.contentStyle.textStyle,
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.outline.decoration.maybeResolve(states)?.color ?? Colors.transparent,
          ),
          foregroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.outline.decoration.maybeResolve(states)?.color ?? Colors.transparent,
          ),
          padding: WidgetStateProperty.all(buttonStyles.outline.contentStyle.padding),
          side: WidgetStateBorderSide.resolveWith((states) {
            final border = buttonStyles.outline.decoration.maybeResolve(states)?.border;
            return BorderSide(
              color:
                  border?.top.color ??
                  switch (states) {
                    _ when states.contains(WidgetState.disabled) => colors.disable(colors.border),
                    _ when states.contains(WidgetState.hovered) => colors.hover(colors.border),
                    _ => colors.border,
                  },
              width: border?.top.width ?? style.borderWidth,
            );
          }),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: buttonStyles.outline.decoration.maybeResolve(states)?.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: buttonStyles.ghost.contentStyle.textStyle,
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.ghost.decoration.maybeResolve(states)?.color ?? Colors.transparent,
          ),
          foregroundColor: WidgetStateColor.resolveWith(
            (states) =>
                buttonStyles.ghost.contentStyle.textStyle.maybeResolve(states)?.color ?? colors.secondaryForeground,
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: buttonStyles.ghost.decoration.maybeResolve(states)?.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: buttonStyles.primary.decoration.maybeResolve(const {})?.color,
        foregroundColor: buttonStyles.primary.contentStyle.textStyle.maybeResolve(const {})?.color,
        hoverColor: buttonStyles.primary.decoration.maybeResolve(const {WidgetState.hovered})?.color,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: buttonStyles.primary.decoration.maybeResolve(const {})?.borderRadius ?? style.borderRadius,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.ghost.decoration.maybeResolve(states)?.color ?? Colors.transparent,
          ),
          foregroundColor: WidgetStateColor.resolveWith(
            (states) =>
                buttonStyles.ghost.contentStyle.textStyle.maybeResolve(states)?.color ?? colors.secondaryForeground,
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: buttonStyles.ghost.decoration.maybeResolve(states)?.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: buttonStyles.ghost.contentStyle.textStyle,
          backgroundColor: WidgetStateColor.resolveWith(
            (states) => buttonStyles.ghost.decoration.maybeResolve(states)?.color ?? Colors.transparent,
          ),
          foregroundColor: WidgetStateColor.resolveWith(
            (states) =>
                buttonStyles.ghost.contentStyle.textStyle.maybeResolve(states)?.color ?? colors.secondaryForeground,
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: buttonStyles.ghost.decoration.maybeResolve(states)?.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),

      /// Dialog
      dialogTheme: DialogTheme(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      /// Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      /// Snack Bar
      snackBarTheme: SnackBarThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      /// List Tile
      listTileTheme: ListTileThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      /// Divider
      dividerTheme: DividerThemeData(
        color: dividerStyles.horizontalStyle.color,
        thickness: dividerStyles.horizontalStyle.width,
      ),

      iconTheme: IconThemeData(color: colors.primary, size: 20),
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
  /// To modify [colors], [typography], and/or [style], create a new `FThemeData` using [FThemeData] first.
  /// This allows the global theme data to propagate to widget-specific theme data.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   final theme = FThemeData(
  ///     color: FThemes.zinc.light.colors.copyWith(
  ///       primary: const Color(0xFF0D47A1), // dark blue
  ///       primaryForeground: const Color(0xFFFFFFFF), // white
  ///     ),
  ///     text: FThemes.zinc.light.typography.copyWith(
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
  ///
  /// Alternatively, consider using the [CLI](forui.dev/docs/cli).
  ///```
  @useResult
  FThemeData copyWith({
    FAccordionStyle? accordionStyle,
    FAlertStyles? alertStyles,
    FAvatarStyle? avatarStyle,
    FBadgeStyles? badgeStyles,
    FBottomNavigationBarStyle? bottomNavigationBarStyle,
    FBreadcrumbStyle? breadcrumbStyle,
    FButtonStyles? buttonStyles,
    FCalendarStyle? calendarStyle,
    FCardStyle? cardStyle,
    FCheckboxStyle? checkboxStyle,
    FDateFieldStyle? dateFieldStyle,
    FDialogStyle? dialogStyle,
    FDividerStyles? dividerStyles,
    FHeaderStyles? headerStyle,
    FLabelStyles? labelStyles,
    FLineCalendarStyle? lineCalendarStyle,
    FPaginationStyle? paginationStyle,
    FPickerStyle? pickerStyle,
    FPopoverStyle? popoverStyle,
    FPopoverMenuStyle? popoverMenuStyle,
    FProgressStyles? progressStyles,
    FRadioStyle? radioStyle,
    FResizableStyle? resizableStyle,
    FScaffoldStyle? scaffoldStyle,
    FSelectStyle? selectStyle,
    FSelectGroupStyle? selectGroupStyle,
    FSelectMenuTileStyle? selectMenuTileStyle,
    FSheetStyle? sheetStyle,
    FSliderStyles? sliderStyles,
    FSwitchStyle? switchStyle,
    FTabsStyle? tabsStyle,
    FTappableStyle? tappableStyle,
    FTextFieldStyle? textFieldStyle,
    FTileGroupStyle? tileGroupStyle,
    FTimeFieldStyle? timeFieldStyle,
    FTooltipStyle? tooltipStyle,
  }) => FThemeData(
    colors: colors,
    typography: typography,
    style: style,
    accordionStyle: accordionStyle ?? this.accordionStyle,
    alertStyles: alertStyles ?? this.alertStyles,
    avatarStyle: avatarStyle ?? this.avatarStyle,
    badgeStyles: badgeStyles ?? this.badgeStyles,
    bottomNavigationBarStyle: bottomNavigationBarStyle ?? this.bottomNavigationBarStyle,
    breadcrumbStyle: breadcrumbStyle ?? this.breadcrumbStyle,
    buttonStyles: buttonStyles ?? this.buttonStyles,
    calendarStyle: calendarStyle ?? this.calendarStyle,
    cardStyle: cardStyle ?? this.cardStyle,
    checkboxStyle: checkboxStyle ?? this.checkboxStyle,
    dateFieldStyle: dateFieldStyle ?? this.dateFieldStyle,
    dialogStyle: dialogStyle ?? this.dialogStyle,
    dividerStyles: dividerStyles ?? this.dividerStyles,
    headerStyle: headerStyle ?? this.headerStyle,
    labelStyles: labelStyles ?? this.labelStyles,
    lineCalendarStyle: lineCalendarStyle ?? this.lineCalendarStyle,
    paginationStyle: paginationStyle ?? this.paginationStyle,
    pickerStyle: pickerStyle ?? this.pickerStyle,
    popoverStyle: popoverStyle ?? this.popoverStyle,
    popoverMenuStyle: popoverMenuStyle ?? this.popoverMenuStyle,
    progressStyles: progressStyles ?? this.progressStyles,
    radioStyle: radioStyle ?? this.radioStyle,
    resizableStyle: resizableStyle ?? this.resizableStyle,
    scaffoldStyle: scaffoldStyle ?? this.scaffoldStyle,
    selectStyle: selectStyle ?? this.selectStyle,
    selectGroupStyle: selectGroupStyle ?? this.selectGroupStyle,
    selectMenuTileStyle: selectMenuTileStyle ?? this.selectMenuTileStyle,
    sheetStyle: sheetStyle ?? this.sheetStyle,
    sliderStyles: sliderStyles ?? this.sliderStyles,
    switchStyle: switchStyle ?? this.switchStyle,
    tabsStyle: tabsStyle ?? this.tabsStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
    textFieldStyle: textFieldStyle ?? this.textFieldStyle,
    tileGroupStyle: tileGroupStyle ?? this.tileGroupStyle,
    timeFieldStyle: timeFieldStyle ?? this.timeFieldStyle,
    tooltipStyle: tooltipStyle ?? this.tooltipStyle,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('debugLabel', debugLabel, showName: false))
      ..add(DiagnosticsProperty('breakpoints', breakpoints))
      ..add(DiagnosticsProperty('color', colors))
      ..add(DiagnosticsProperty('text', typography))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('accordionStyle', accordionStyle))
      ..add(DiagnosticsProperty('alertStyles', alertStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('avatarStyle', avatarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('badgeStyles', badgeStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bottomNavigationBarStyle', bottomNavigationBarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('breadcrumbStyle', breadcrumbStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('buttonStyles', buttonStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('cardStyle', cardStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dateFieldStyle', dateFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dialogStyle', dialogStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerStyles', dividerStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('headerStyle', headerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelStyles', labelStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('lineCalendarStyle', lineCalendarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('paginationStyle', paginationStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('pickerStyle', pickerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverMenuStyle', popoverMenuStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('progressStyles', progressStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('radioStyle', radioStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('resizableStyle', resizableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scaffoldStyle', scaffoldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectStyle', selectStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectGroupStyle', selectGroupStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectMenuTileStyle', selectMenuTileStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('sheetStyle', sheetStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('sliderStyles', sliderStyles, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('switchStyle', switchStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tabsStyle', tabsStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('timeFieldStyle', timeFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('timePickerStyle', timePickerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FThemeData &&
          runtimeType == other.runtimeType &&
          breakpoints == other.breakpoints &&
          colors == other.colors &&
          typography == other.typography &&
          style == other.style &&
          accordionStyle == other.accordionStyle &&
          alertStyles == other.alertStyles &&
          avatarStyle == other.avatarStyle &&
          badgeStyles == other.badgeStyles &&
          bottomNavigationBarStyle == other.bottomNavigationBarStyle &&
          breadcrumbStyle == other.breadcrumbStyle &&
          buttonStyles == other.buttonStyles &&
          calendarStyle == other.calendarStyle &&
          cardStyle == other.cardStyle &&
          checkboxStyle == other.checkboxStyle &&
          dateFieldStyle == other.dateFieldStyle &&
          dialogStyle == other.dialogStyle &&
          dividerStyles == other.dividerStyles &&
          headerStyle == other.headerStyle &&
          labelStyles == other.labelStyles &&
          lineCalendarStyle == other.lineCalendarStyle &&
          paginationStyle == other.paginationStyle &&
          pickerStyle == other.pickerStyle &&
          popoverStyle == other.popoverStyle &&
          popoverMenuStyle == other.popoverMenuStyle &&
          progressStyles == other.progressStyles &&
          radioStyle == other.radioStyle &&
          resizableStyle == other.resizableStyle &&
          scaffoldStyle == other.scaffoldStyle &&
          selectStyle == other.selectStyle &&
          selectGroupStyle == other.selectGroupStyle &&
          selectMenuTileStyle == other.selectMenuTileStyle &&
          sheetStyle == other.sheetStyle &&
          sliderStyles == other.sliderStyles &&
          switchStyle == other.switchStyle &&
          tabsStyle == other.tabsStyle &&
          tappableStyle == other.tappableStyle &&
          textFieldStyle == other.textFieldStyle &&
          tileGroupStyle == other.tileGroupStyle &&
          timeFieldStyle == other.timeFieldStyle &&
          timePickerStyle == other.timePickerStyle &&
          tooltipStyle == other.tooltipStyle;

  @override
  int get hashCode =>
      breakpoints.hashCode ^
      colors.hashCode ^
      typography.hashCode ^
      style.hashCode ^
      accordionStyle.hashCode ^
      alertStyles.hashCode ^
      avatarStyle.hashCode ^
      badgeStyles.hashCode ^
      bottomNavigationBarStyle.hashCode ^
      breadcrumbStyle.hashCode ^
      buttonStyles.hashCode ^
      calendarStyle.hashCode ^
      cardStyle.hashCode ^
      checkboxStyle.hashCode ^
      dateFieldStyle.hashCode ^
      dialogStyle.hashCode ^
      dividerStyles.hashCode ^
      headerStyle.hashCode ^
      labelStyles.hashCode ^
      lineCalendarStyle.hashCode ^
      paginationStyle.hashCode ^
      pickerStyle.hashCode ^
      popoverStyle.hashCode ^
      popoverMenuStyle.hashCode ^
      progressStyles.hashCode ^
      radioStyle.hashCode ^
      resizableStyle.hashCode ^
      scaffoldStyle.hashCode ^
      selectStyle.hashCode ^
      selectGroupStyle.hashCode ^
      selectMenuTileStyle.hashCode ^
      sheetStyle.hashCode ^
      sliderStyles.hashCode ^
      switchStyle.hashCode ^
      tabsStyle.hashCode ^
      tappableStyle.hashCode ^
      textFieldStyle.hashCode ^
      tileGroupStyle.hashCode ^
      timeFieldStyle.hashCode ^
      timePickerStyle.hashCode ^
      tooltipStyle.hashCode;
}
