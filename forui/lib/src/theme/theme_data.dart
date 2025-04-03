import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// Defines the configuration of the overall visual [FTheme] for a widget subtree.
///
/// A [FThemeData] is composed of [color], [text], [style], and widget styles.
///   * [color] is a set of colors.
///   * [text] contains font and typography information.
///   * [style] is a set of miscellaneous properties.
///   * widget styles are used to style individual Forui widgets.
///
/// Widget styles provide an `inherit(...)` constructor. The constructor configures the widget style using the defaults
/// provided by the [color], [text], and [style].
final class FThemeData with Diagnosticable, FTransformable {
  /// A label that is used in the [toString] output. Intended to aid with identifying themes in debug output.
  final String? debugLabel;

  /// The responsive breakpoints.
  final FBreakpoints breakpoints;

  /// The color scheme. It is used to configure the colors of Forui widgets.
  final FColorScheme color;

  /// The typography data. It is used to configure the [TextStyle]s of Forui widgets.
  final FTypography text;

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
    required FColorScheme color,
    String? debugLabel,
    FBreakpoints breakpoints = const FBreakpoints(),
    FTypography? text,
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
    text = text ?? FTypography.inherit(color: color);
    style = style ?? FStyle.inherit(color: color, text: text);
    return FThemeData._(
      debugLabel: debugLabel,
      breakpoints: breakpoints,
      color: color,
      text: text,
      style: style,
      accordionStyle: accordionStyle ?? FAccordionStyle.inherit(color: color, text: text, style: style),
      alertStyles: alertStyles ?? FAlertStyles.inherit(color: color, text: text, style: style),
      avatarStyle: avatarStyle ?? FAvatarStyle.inherit(color: color, text: text),
      badgeStyles: badgeStyles ?? FBadgeStyles.inherit(color: color, text: text, style: style),
      bottomNavigationBarStyle:
          bottomNavigationBarStyle ?? FBottomNavigationBarStyle.inherit(color: color, text: text, style: style),
      breadcrumbStyle: breadcrumbStyle ?? FBreadcrumbStyle.inherit(color: color, text: text, style: style),
      buttonStyles: buttonStyles ?? FButtonStyles.inherit(color: color, text: text, style: style),
      calendarStyle: calendarStyle ?? FCalendarStyle.inherit(color: color, text: text, style: style),
      cardStyle: cardStyle ?? FCardStyle.inherit(color: color, text: text, style: style),
      checkboxStyle: checkboxStyle ?? FCheckboxStyle.inherit(color: color, style: style),
      dateFieldStyle: dateFieldStyle ?? FDateFieldStyle.inherit(color: color, text: text, style: style),
      dialogStyle: dialogStyle ?? FDialogStyle.inherit(color: color, text: text, style: style),
      dividerStyles: dividerStyles ?? FDividerStyles.inherit(color: color, style: style),
      headerStyle: headerStyle ?? FHeaderStyles.inherit(color: color, text: text, style: style),
      labelStyles: labelStyles ?? FLabelStyles.inherit(style: style),
      lineCalendarStyle: lineCalendarStyle ?? FLineCalendarStyle.inherit(color: color, text: text, style: style),
      paginationStyle: paginationStyle ?? FPaginationStyle.inherit(color: color, text: text, style: style),
      pickerStyle: pickerStyle ?? FPickerStyle.inherit(color: color, style: style, text: text),
      popoverStyle: popoverStyle ?? FPopoverStyle.inherit(color: color, style: style),
      popoverMenuStyle: popoverMenuStyle ?? FPopoverMenuStyle.inherit(color: color, style: style, text: text),
      progressStyles: progressStyles ?? FProgressStyles.inherit(color: color, style: style),
      radioStyle: radioStyle ?? FRadioStyle.inherit(color: color, style: style),
      resizableStyle: resizableStyle ?? FResizableStyle.inherit(color: color, style: style),
      scaffoldStyle: scaffoldStyle ?? FScaffoldStyle.inherit(color: color, style: style),
      selectStyle: selectStyle ?? FSelectStyle.inherit(color: color, text: text, style: style),
      selectGroupStyle: selectGroupStyle ?? FSelectGroupStyle.inherit(color: color, text: text, style: style),
      selectMenuTileStyle: selectMenuTileStyle ?? FSelectMenuTileStyle.inherit(color: color, text: text, style: style),
      sheetStyle: sheetStyle ?? FSheetStyle.inherit(color: color),
      sliderStyles: sliderStyles ?? FSliderStyles.inherit(color: color, text: text, style: style),
      switchStyle: switchStyle ?? FSwitchStyle.inherit(color: color, style: style),
      tabsStyle: tabsStyle ?? FTabsStyle.inherit(color: color, text: text, style: style),
      tappableStyle: tappableStyle ?? FTappableStyle(),
      textFieldStyle: textFieldStyle ?? FTextFieldStyle.inherit(color: color, text: text, style: style),
      tileGroupStyle: tileGroupStyle ?? FTileGroupStyle.inherit(color: color, text: text, style: style),
      timeFieldStyle: timeFieldStyle ?? FTimeFieldStyle.inherit(color: color, text: text, style: style),
      timePickerStyle: timePickerStyle ?? FTimePickerStyle.inherit(color: color, text: text, style: style),
      tooltipStyle: tooltipStyle ?? FTooltipStyle.inherit(color: color, text: text, style: style),
    );
  }

  FThemeData._({
    required this.debugLabel,
    required this.breakpoints,
    required this.color,
    required this.text,
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
      displayLarge: text.xl4.copyWith(height: 1, textBaseline: text.xl4.textBaseline ?? TextBaseline.alphabetic),
      displayMedium: text.xl3.copyWith(height: 1, textBaseline: text.xl3.textBaseline ?? TextBaseline.alphabetic),
      displaySmall: text.xl2.copyWith(height: 1, textBaseline: text.xl2.textBaseline ?? TextBaseline.alphabetic),
      headlineLarge: text.xl3.copyWith(height: 1, textBaseline: text.xl3.textBaseline ?? TextBaseline.alphabetic),
      headlineMedium: text.xl2.copyWith(height: 1, textBaseline: text.xl2.textBaseline ?? TextBaseline.alphabetic),
      headlineSmall: text.xl.copyWith(height: 1, textBaseline: text.xl.textBaseline ?? TextBaseline.alphabetic),
      titleLarge: text.lg.copyWith(height: 1, textBaseline: text.lg.textBaseline ?? TextBaseline.alphabetic),
      titleMedium: text.base.copyWith(height: 1, textBaseline: text.base.textBaseline ?? TextBaseline.alphabetic),
      titleSmall: text.sm.copyWith(height: 1, textBaseline: text.sm.textBaseline ?? TextBaseline.alphabetic),
      labelLarge: text.base.copyWith(height: 1, textBaseline: text.base.textBaseline ?? TextBaseline.alphabetic),
      labelMedium: text.sm.copyWith(height: 1, textBaseline: text.sm.textBaseline ?? TextBaseline.alphabetic),
      labelSmall: text.xs.copyWith(height: 1, textBaseline: text.xs.textBaseline ?? TextBaseline.alphabetic),
      bodyLarge: text.base.copyWith(height: 1, textBaseline: text.base.textBaseline ?? TextBaseline.alphabetic),
      bodyMedium: text.sm.copyWith(height: 1, textBaseline: text.sm.textBaseline ?? TextBaseline.alphabetic),
      bodySmall: text.xs.copyWith(height: 1, textBaseline: text.xs.textBaseline ?? TextBaseline.alphabetic),
    )..apply(fontFamily: text.defaultFontFamily, bodyColor: color.foreground, displayColor: color.foreground);

    return ThemeData(
      colorScheme: ColorScheme(
        brightness: color.brightness,
        primary: color.primary,
        onPrimary: color.primaryForeground,
        secondary: color.secondary,
        onSecondary: color.secondaryForeground,
        error: color.error,
        onError: color.errorForeground,
        surface: color.background,
        onSurface: color.foreground,
        secondaryContainer: color.secondary,
        onSecondaryContainer: color.secondaryForeground,
      ),
      fontFamily: text.defaultFontFamily,
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
          side: BorderSide(width: style.borderWidth, color: color.border),
        ),
      ),

      //// Chip
      chipTheme: ChipThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      //// Input
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: textFieldStyle.enabledStyle.unfocusedStyle.radius,
          borderSide: BorderSide(
            color: textFieldStyle.enabledStyle.unfocusedStyle.color,
            width: textFieldStyle.enabledStyle.unfocusedStyle.width,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: textFieldStyle.enabledStyle.unfocusedStyle.radius,
          borderSide: BorderSide(
            color: textFieldStyle.enabledStyle.unfocusedStyle.color,
            width: textFieldStyle.enabledStyle.unfocusedStyle.width,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: textFieldStyle.enabledStyle.focusedStyle.radius,
          borderSide: BorderSide(
            color: textFieldStyle.enabledStyle.focusedStyle.color,
            width: textFieldStyle.enabledStyle.focusedStyle.width,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: textFieldStyle.errorStyle.unfocusedStyle.radius,
          borderSide: BorderSide(
            color: textFieldStyle.errorStyle.unfocusedStyle.color,
            width: textFieldStyle.errorStyle.unfocusedStyle.width,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: textFieldStyle.errorStyle.focusedStyle.radius,
          borderSide: BorderSide(
            color: textFieldStyle.errorStyle.focusedStyle.color,
            width: textFieldStyle.errorStyle.focusedStyle.width,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: textFieldStyle.disabledStyle.unfocusedStyle.radius,
          borderSide: BorderSide(
            color: textFieldStyle.disabledStyle.unfocusedStyle.color,
            width: textFieldStyle.disabledStyle.unfocusedStyle.width,
          ),
        ),
        labelStyle: textFieldStyle.enabledStyle.descriptionTextStyle,
        floatingLabelStyle: textFieldStyle.enabledStyle.labelTextStyle,
        hintStyle: textFieldStyle.enabledStyle.hintTextStyle,
        errorStyle: textFieldStyle.errorStyle.errorTextStyle,
        helperStyle: textFieldStyle.enabledStyle.descriptionTextStyle,
        counterStyle: textFieldStyle.enabledStyle.counterTextStyle,
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
        hourMinuteTextColor: color.secondaryForeground,
        hourMinuteColor: color.secondary,
        hourMinuteShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
        dayPeriodTextColor: color.foreground,
        dayPeriodColor: color.secondary,
        dayPeriodBorderSide: BorderSide(color: color.border),
        dayPeriodShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
        dialBackgroundColor: color.secondary,
        shape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      /// Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: sliderStyles.horizontalStyle.enabledStyle.activeColor,
        inactiveTrackColor: sliderStyles.horizontalStyle.enabledStyle.inactiveColor,
        disabledActiveTrackColor: sliderStyles.horizontalStyle.disabledStyle.activeColor,
        disabledInactiveTrackColor: sliderStyles.horizontalStyle.disabledStyle.inactiveColor,
        activeTickMarkColor: sliderStyles.horizontalStyle.enabledStyle.markStyle.tickColor,
        inactiveTickMarkColor: sliderStyles.horizontalStyle.enabledStyle.markStyle.tickColor,
        disabledActiveTickMarkColor: sliderStyles.horizontalStyle.disabledStyle.markStyle.tickColor,
        disabledInactiveTickMarkColor: sliderStyles.horizontalStyle.disabledStyle.markStyle.tickColor,
        thumbColor: sliderStyles.horizontalStyle.enabledStyle.thumbStyle.borderColor,
        disabledThumbColor: sliderStyles.horizontalStyle.disabledStyle.thumbStyle.borderColor,
        valueIndicatorColor: sliderStyles.horizontalStyle.enabledStyle.tooltipStyle.decoration.color,
        valueIndicatorTextStyle: sliderStyles.horizontalStyle.enabledStyle.tooltipStyle.textStyle,
      ),

      //// Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateColor.fromMap({
          WidgetState.disabled: switchStyle.disabledStyle.thumbColor,
          WidgetState.any: switchStyle.enabledStyle.thumbColor,
        }),
        trackColor: WidgetStateColor.fromMap({
          WidgetState.disabled & WidgetState.selected: switchStyle.disabledStyle.checkedColor,
          WidgetState.disabled: switchStyle.disabledStyle.uncheckedColor,
          WidgetState.selected: switchStyle.enabledStyle.checkedColor,
          WidgetState.any: switchStyle.enabledStyle.uncheckedColor,
        }),
        trackOutlineColor: WidgetStateColor.fromMap({
          WidgetState.disabled & WidgetState.selected: switchStyle.disabledStyle.checkedColor,
          WidgetState.disabled: switchStyle.disabledStyle.uncheckedColor,
          WidgetState.selected: switchStyle.enabledStyle.checkedColor,
          WidgetState.any: switchStyle.enabledStyle.uncheckedColor,
        }),
      ),

      //// Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateTextStyle.fromMap({
            WidgetState.disabled: buttonStyles.secondary.contentStyle.disabledTextStyle,
            WidgetState.any: buttonStyles.secondary.contentStyle.enabledTextStyle,
          }),
          backgroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.secondary.disabledBoxDecoration.color,
            WidgetState.hovered: buttonStyles.secondary.enabledHoverBoxDecoration.color,
            WidgetState.any: buttonStyles.secondary.enabledBoxDecoration.color,
          }),
          foregroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.secondary.contentStyle.disabledTextStyle.color,
            WidgetState.any: buttonStyles.secondary.contentStyle.enabledTextStyle.color,
          }),
          padding: WidgetStateProperty.all(buttonStyles.secondary.contentStyle.padding),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateTextStyle.fromMap({
            WidgetState.disabled: buttonStyles.primary.contentStyle.disabledTextStyle,
            WidgetState.any: buttonStyles.primary.contentStyle.enabledTextStyle,
          }),
          backgroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.primary.disabledBoxDecoration.color,
            WidgetState.hovered: buttonStyles.primary.enabledHoverBoxDecoration.color,
            WidgetState.any: buttonStyles.primary.enabledBoxDecoration.color,
          }),
          foregroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.primary.contentStyle.disabledTextStyle.color,
            WidgetState.any: buttonStyles.primary.contentStyle.enabledTextStyle.color,
          }),
          padding: WidgetStateProperty.all(buttonStyles.primary.contentStyle.padding),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateTextStyle.fromMap({
            WidgetState.disabled: buttonStyles.outline.contentStyle.disabledTextStyle,
            ~WidgetState.disabled: buttonStyles.outline.contentStyle.enabledTextStyle,
          }),
          backgroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.outline.disabledBoxDecoration.color,
            WidgetState.hovered: buttonStyles.outline.enabledHoverBoxDecoration.color,
            WidgetState.any: buttonStyles.outline.enabledBoxDecoration.color,
          }),
          foregroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.outline.contentStyle.disabledTextStyle.color,
            WidgetState.any: buttonStyles.outline.contentStyle.enabledTextStyle.color,
          }),
          padding: WidgetStateProperty.all(buttonStyles.outline.contentStyle.padding),
          side: WidgetStateBorderSide.fromMap({
            WidgetState.disabled: BorderSide(
              color: buttonStyles.outline.disabledBoxDecoration.border?.top.color ?? color.disable(color.border),
              width: buttonStyles.outline.disabledBoxDecoration.border?.top.width ?? style.borderWidth,
            ),
            WidgetState.hovered: BorderSide(
              color: buttonStyles.outline.enabledHoverBoxDecoration.border?.top.color ?? color.hover(color.border),
              width: buttonStyles.outline.enabledHoverBoxDecoration.border?.top.width ?? style.borderWidth,
            ),
            WidgetState.any: BorderSide(
              color: buttonStyles.outline.enabledBoxDecoration.border?.top.color ?? color.border,
              width: buttonStyles.outline.enabledBoxDecoration.border?.top.width ?? style.borderWidth,
            ),
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: buttonStyles.outline.enabledBoxDecoration.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateTextStyle.fromMap({
            WidgetState.disabled: buttonStyles.ghost.contentStyle.disabledTextStyle,
            WidgetState.any: buttonStyles.ghost.contentStyle.enabledTextStyle,
          }),
          backgroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.ghost.disabledBoxDecoration.color,
            WidgetState.hovered: buttonStyles.ghost.enabledHoverBoxDecoration.color,
            WidgetState.any: buttonStyles.ghost.enabledBoxDecoration.color,
          }),
          foregroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.ghost.contentStyle.disabledTextStyle.color,
            WidgetState.any: buttonStyles.ghost.contentStyle.enabledTextStyle.color,
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: buttonStyles.ghost.enabledBoxDecoration.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: buttonStyles.primary.enabledBoxDecoration.color,
        foregroundColor: buttonStyles.primary.contentStyle.enabledTextStyle.color,
        hoverColor: buttonStyles.primary.enabledHoverBoxDecoration.color,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: buttonStyles.primary.enabledBoxDecoration.borderRadius ?? style.borderRadius,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.ghost.disabledBoxDecoration.color,
            WidgetState.hovered: buttonStyles.ghost.enabledHoverBoxDecoration.color,
            WidgetState.any: buttonStyles.ghost.enabledBoxDecoration.color,
          }),
          foregroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.ghost.contentStyle.disabledTextStyle.color,
            WidgetState.any: buttonStyles.ghost.contentStyle.enabledTextStyle.color,
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: buttonStyles.ghost.enabledBoxDecoration.borderRadius ?? style.borderRadius,
            ),
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateTextStyle.fromMap({
            WidgetState.disabled: buttonStyles.ghost.contentStyle.disabledTextStyle,
            WidgetState.any: buttonStyles.ghost.contentStyle.enabledTextStyle,
          }),
          backgroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.ghost.disabledBoxDecoration.color,
            WidgetState.hovered: buttonStyles.ghost.enabledHoverBoxDecoration.color,
            WidgetState.any: buttonStyles.ghost.enabledBoxDecoration.color,
          }),
          foregroundColor: WidgetStateMapper({
            WidgetState.disabled: buttonStyles.ghost.contentStyle.disabledTextStyle.color,
            WidgetState.any: buttonStyles.ghost.contentStyle.enabledTextStyle.color,
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: buttonStyles.ghost.enabledBoxDecoration.borderRadius ?? style.borderRadius,
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

      iconTheme: IconThemeData(color: color.primary, size: 20),
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
  /// To modify [color], [text], and/or [style], create a new `FThemeData` using [FThemeData] first.
  /// This allows the global theme data to propagate to widget-specific theme data.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   final theme = FThemeData(
  ///     color: FThemes.zinc.light.color.copyWith(
  ///       primary: const Color(0xFF0D47A1), // dark blue
  ///       primaryForeground: const Color(0xFFFFFFFF), // white
  ///     ),
  ///     text: FThemes.zinc.light.text.copyWith(
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
    color: color,
    text: text,
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
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('text', text))
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
          color == other.color &&
          text == other.text &&
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
      color.hashCode ^
      text.hashCode ^
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
