import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'theme_data.design.dart';

/// Defines the configuration of the overall visual [FTheme] for a widget subtree.
///
/// A [FThemeData] is composed of [colors], [typography], [style], widget styles, and [extensions].
///
/// * [colors] is a set of colors.
/// * [typography] contains font and typography information.
/// * [style] is a set of miscellaneous properties.
/// * widget styles are used to style individual Forui widgets.
/// * [extensions] are arbitrary additions to this theme. They are typically used to define properties specific to your
///   application.
///
/// Widget styles provide an `inherit(...)` constructor. The constructor configures the widget style using the defaults
/// provided by the [colors], [typography], and [style].
final class FThemeData with Diagnosticable, _$FThemeDataFunctions {
  /// A label that is used in the [toString] output. Intended to aid with identifying themes in debug output.
  @override
  final String? debugLabel;

  /// The responsive breakpoints.
  @override
  final FBreakpoints breakpoints;

  /// The color scheme. It is used to configure the colors of Forui widgets.
  @override
  final FColors colors;

  /// The typography data. It is used to configure the [TextStyle]s of Forui widgets.
  @override
  final FTypography typography;

  /// The style. It is used to configure the miscellaneous properties, such as border radii, of Forui widgets.
  @override
  final FStyle style;

  /// The accordion style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create accordion
  /// ```
  @override
  final FAccordionStyle accordionStyle;

  /// The autocomplete style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create autocomplete
  /// ```
  @override
  final FAutocompleteStyle autocompleteStyle;

  /// The alert styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create alerts
  /// ```
  @override
  final FAlertStyles alertStyles;

  /// The avatar style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create avatar
  /// ```
  @override
  final FAvatarStyle avatarStyle;

  /// The badge styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create badges
  /// ```
  @override
  final FBadgeStyles badgeStyles;

  /// The bottom navigation bar style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create bottom-navigation-bar
  /// ```
  @override
  final FBottomNavigationBarStyle bottomNavigationBarStyle;

  /// The breadcrumb style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create breadcrumb
  /// ```
  @override
  final FBreadcrumbStyle breadcrumbStyle;

  /// The button styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create buttons
  /// ```
  @override
  final FButtonStyles buttonStyles;

  /// The calendar style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create calendar
  /// ```
  @override
  final FCalendarStyle calendarStyle;

  /// The card style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create card
  /// ```
  @override
  final FCardStyle cardStyle;

  /// The checkbox style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create checkbox
  /// ```
  @override
  final FCheckboxStyle checkboxStyle;

  /// The circular progress style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create circular-progress
  /// ```
  @override
  final FCircularProgressStyle circularProgressStyle;

  /// The date field style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create date-field
  /// ```
  @override
  final FDateFieldStyle dateFieldStyle;

  /// The determinate progress style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create determinate-progress
  /// ```
  @override
  final FDeterminateProgressStyle determinateProgressStyle;

  /// The dialog route's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dialog-route
  /// ```
  @override
  final FDialogRouteStyle dialogRouteStyle;

  /// The dialog style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dialog
  /// ```
  @override
  final FDialogStyle dialogStyle;

  /// The divider styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create dividers
  /// ```
  @override
  final FDividerStyles dividerStyles;

  /// The header styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create headers
  /// ```
  @override
  final FHeaderStyles headerStyles;

  /// The item style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  /// ```shell
  /// dart run forui style create item
  /// ```
  @override
  final FItemStyle itemStyle;

  /// The item group style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  /// ```shell
  /// dart run forui style create item-group
  /// ```
  @override
  final FItemGroupStyle itemGroupStyle;

  /// The label styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create labels
  /// ```
  @override
  final FLabelStyles labelStyles;

  /// The line calendar style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create line-calendar
  /// ```
  @override
  final FLineCalendarStyle lineCalendarStyle;

  /// The multi-select style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  /// ```shell
  /// dart run forui style create multi-select
  /// ```
  @override
  final FMultiSelectStyle multiSelectStyle;

  /// The modal sheet style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create modal-sheet
  /// ```
  @override
  final FModalSheetStyle modalSheetStyle;

  /// The pagination style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create pagination
  /// ```
  @override
  final FPaginationStyle paginationStyle;

  /// The persistent sheet style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create persistent-sheet
  /// ```
  @override
  final FPersistentSheetStyle persistentSheetStyle;

  /// The picker's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create picker
  /// ```
  @override
  final FPickerStyle pickerStyle;

  /// The popover's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover
  /// ```
  @override
  final FPopoverStyle popoverStyle;

  /// The popover menu's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover-menu
  /// ```
  @override
  final FPopoverMenuStyle popoverMenuStyle;

  /// The progress style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create progress
  /// ```
  @override
  final FProgressStyle progressStyle;

  /// The radio style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create radio
  /// ```
  @override
  final FRadioStyle radioStyle;

  /// The resizable style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create resizable
  /// ```
  @override
  final FResizableStyle resizableStyle;

  /// The scaffold style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create scaffold
  /// ```
  @override
  final FScaffoldStyle scaffoldStyle;

  /// The select style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select
  /// ```
  @override
  final FSelectStyle selectStyle;

  /// The select group style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-group
  /// ```
  @override
  final FSelectGroupStyle selectGroupStyle;

  /// The select menu tile style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-menu-tile
  /// ```
  @override
  final FSelectMenuTileStyle selectMenuTileStyle;

  /// The sidebar style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  @override
  final FSidebarStyle sidebarStyle;

  /// The slider styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sliders
  /// ```
  @override
  final FSliderStyles sliderStyles;

  /// The toaster style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create toaster
  /// ```
  @override
  final FToasterStyle toasterStyle;

  /// The switch style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create switch
  /// ```
  @override
  final FSwitchStyle switchStyle;

  /// The tabs styles.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tabs
  /// ```
  @override
  final FTabsStyle tabsStyle;

  /// The tappable style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tappable
  /// ```
  @override
  final FTappableStyle tappableStyle;

  /// The text field style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create text-field
  /// ```
  @override
  final FTextFieldStyle textFieldStyle;

  /// The tile's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile
  /// ```
  @override
  final FTileStyle tileStyle;

  /// The tile group's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile-group
  /// ```
  @override
  final FTileGroupStyle tileGroupStyle;

  /// The time field's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create time-field
  /// ```
  @override
  final FTimeFieldStyle timeFieldStyle;

  /// The time picker style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create time-picker
  /// ```
  @override
  final FTimePickerStyle timePickerStyle;

  /// The tooltip style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tooltip
  /// ```
  @override
  final FTooltipStyle tooltipStyle;

  final Map<Object, ThemeExtension<dynamic>> _extensions;

  /// Creates a [FThemeData] that configures the widget styles using the given properties if not given.
  factory FThemeData({
    required FColors colors,
    String? debugLabel,
    FBreakpoints breakpoints = const FBreakpoints(),
    FTypography? typography,
    FStyle? style,
    FAccordionStyle? accordionStyle,
    FAutocompleteStyle? autocompleteStyle,
    FAlertStyles? alertStyles,
    FAvatarStyle? avatarStyle,
    FBadgeStyles? badgeStyles,
    FBottomNavigationBarStyle? bottomNavigationBarStyle,
    FBreadcrumbStyle? breadcrumbStyle,
    FButtonStyles? buttonStyles,
    FCalendarStyle? calendarStyle,
    FCardStyle? cardStyle,
    FCheckboxStyle? checkboxStyle,
    FCircularProgressStyle? circularProgressStyle,
    FDateFieldStyle? dateFieldStyle,
    FDeterminateProgressStyle? determinateProgressStyle,
    FDialogRouteStyle? dialogRouteStyle,
    FDialogStyle? dialogStyle,
    FDividerStyles? dividerStyles,
    FHeaderStyles? headerStyles,
    FItemStyle? itemStyle,
    FItemGroupStyle? itemGroupStyle,
    FLabelStyles? labelStyles,
    FLineCalendarStyle? lineCalendarStyle,
    FMultiSelectStyle? multiSelectStyle,
    FModalSheetStyle? modalSheetStyle,
    FPaginationStyle? paginationStyle,
    FPersistentSheetStyle? persistentSheetStyle,
    FPickerStyle? pickerStyle,
    FPopoverStyle? popoverStyle,
    FPopoverMenuStyle? popoverMenuStyle,
    FProgressStyle? progressStyle,
    FRadioStyle? radioStyle,
    FResizableStyle? resizableStyle,
    FScaffoldStyle? scaffoldStyle,
    FSelectStyle? selectStyle,
    FSelectGroupStyle? selectGroupStyle,
    FSelectMenuTileStyle? selectMenuTileStyle,
    FSidebarStyle? sidebarStyle,
    FSliderStyles? sliderStyles,
    FToasterStyle? toasterStyle,
    FSwitchStyle? switchStyle,
    FTabsStyle? tabsStyle,
    FTappableStyle? tappableStyle,
    FTextFieldStyle? textFieldStyle,
    FTileStyle? tileStyle,
    FTileGroupStyle? tileGroupStyle,
    FTimeFieldStyle? timeFieldStyle,
    FTimePickerStyle? timePickerStyle,
    FTooltipStyle? tooltipStyle,
    Iterable<ThemeExtension<dynamic>> extensions = const [],
  }) {
    typography ??= .inherit(colors: colors);
    style ??= .inherit(colors: colors, typography: typography);
    return ._(
      debugLabel: debugLabel,
      breakpoints: breakpoints,
      colors: colors,
      typography: typography,
      style: style,
      accordionStyle: accordionStyle ?? .inherit(colors: colors, typography: typography, style: style),
      autocompleteStyle: autocompleteStyle ?? .inherit(colors: colors, typography: typography, style: style),
      alertStyles: alertStyles ?? .inherit(colors: colors, typography: typography, style: style),
      avatarStyle: avatarStyle ?? .inherit(colors: colors, typography: typography),
      badgeStyles: badgeStyles ?? .inherit(colors: colors, typography: typography, style: style),
      bottomNavigationBarStyle:
          bottomNavigationBarStyle ?? .inherit(colors: colors, typography: typography, style: style),
      breadcrumbStyle: breadcrumbStyle ?? .inherit(colors: colors, typography: typography, style: style),
      buttonStyles: buttonStyles ?? .inherit(colors: colors, typography: typography, style: style),
      calendarStyle: calendarStyle ?? .inherit(colors: colors, typography: typography, style: style),
      cardStyle: cardStyle ?? .inherit(colors: colors, typography: typography, style: style),
      checkboxStyle: checkboxStyle ?? .inherit(colors: colors, style: style),
      circularProgressStyle: circularProgressStyle ?? .inherit(colors: colors),
      dateFieldStyle: dateFieldStyle ?? .inherit(colors: colors, typography: typography, style: style),
      determinateProgressStyle: determinateProgressStyle ?? .inherit(colors: colors, style: style),
      dialogRouteStyle: dialogRouteStyle ?? .inherit(colors: colors),
      dialogStyle: dialogStyle ?? .inherit(colors: colors, typography: typography, style: style),
      dividerStyles: dividerStyles ?? .inherit(colors: colors, style: style),
      headerStyles: headerStyles ?? .inherit(colors: colors, typography: typography, style: style),
      itemStyle: itemStyle ?? .inherit(colors: colors, typography: typography, style: style),
      itemGroupStyle: itemGroupStyle ?? .inherit(colors: colors, typography: typography, style: style),
      labelStyles: labelStyles ?? .inherit(style: style),
      lineCalendarStyle: lineCalendarStyle ?? .inherit(colors: colors, typography: typography, style: style),
      multiSelectStyle: multiSelectStyle ?? .inherit(colors: colors, typography: typography, style: style),
      modalSheetStyle: modalSheetStyle ?? .inherit(colors: colors),
      paginationStyle: paginationStyle ?? .inherit(colors: colors, typography: typography, style: style),
      persistentSheetStyle: persistentSheetStyle ?? const FPersistentSheetStyle(),
      pickerStyle: pickerStyle ?? .inherit(colors: colors, style: style, typography: typography),
      popoverStyle: popoverStyle ?? .inherit(colors: colors, style: style),
      popoverMenuStyle: popoverMenuStyle ?? .inherit(colors: colors, style: style, typography: typography),
      progressStyle: progressStyle ?? .inherit(colors: colors, style: style),
      radioStyle: radioStyle ?? .inherit(colors: colors, style: style),
      resizableStyle: resizableStyle ?? .inherit(colors: colors, style: style),
      scaffoldStyle: scaffoldStyle ?? .inherit(colors: colors, style: style),
      selectStyle: selectStyle ?? .inherit(colors: colors, typography: typography, style: style),
      selectGroupStyle: selectGroupStyle ?? .inherit(colors: colors, typography: typography, style: style),
      selectMenuTileStyle: selectMenuTileStyle ?? .inherit(colors: colors, typography: typography, style: style),
      sidebarStyle: sidebarStyle ?? .inherit(colors: colors, typography: typography, style: style),
      sliderStyles: sliderStyles ?? .inherit(colors: colors, typography: typography, style: style),
      toasterStyle: toasterStyle ?? .inherit(colors: colors, typography: typography, style: style),
      switchStyle: switchStyle ?? .inherit(colors: colors, style: style),
      tabsStyle: tabsStyle ?? .inherit(colors: colors, typography: typography, style: style),
      tappableStyle: tappableStyle ?? FTappableStyle(),
      textFieldStyle: textFieldStyle ?? .inherit(colors: colors, typography: typography, style: style),
      tileStyle: tileStyle ?? .inherit(colors: colors, typography: typography, style: style),
      tileGroupStyle: tileGroupStyle ?? .inherit(colors: colors, typography: typography, style: style),
      timeFieldStyle: timeFieldStyle ?? .inherit(colors: colors, typography: typography, style: style),
      timePickerStyle: timePickerStyle ?? .inherit(colors: colors, typography: typography, style: style),
      tooltipStyle: tooltipStyle ?? .inherit(colors: colors, typography: typography, style: style),
      extensions: .unmodifiable({for (final extension in extensions) extension.type: extension}),
    );
  }

  /// Creates a linear interpolation between two [FThemeData] using the given factor [t].
  factory FThemeData.lerp(FThemeData a, FThemeData b, double t) => .new(
    debugLabel: t < 0.5 ? a.debugLabel : b.debugLabel,
    breakpoints: t < 0.5 ? a.breakpoints : b.breakpoints,
    colors: .lerp(a.colors, b.colors, t),
    typography: .lerp(a.typography, b.typography, t),
    style: a.style.lerp(b.style, t),
    accordionStyle: a.accordionStyle.lerp(b.accordionStyle, t),
    autocompleteStyle: a.autocompleteStyle.lerp(b.autocompleteStyle, t),
    alertStyles: a.alertStyles.lerp(b.alertStyles, t),
    avatarStyle: a.avatarStyle.lerp(b.avatarStyle, t),
    badgeStyles: a.badgeStyles.lerp(b.badgeStyles, t),
    bottomNavigationBarStyle: a.bottomNavigationBarStyle.lerp(b.bottomNavigationBarStyle, t),
    breadcrumbStyle: a.breadcrumbStyle.lerp(b.breadcrumbStyle, t),
    buttonStyles: a.buttonStyles.lerp(b.buttonStyles, t),
    calendarStyle: a.calendarStyle.lerp(b.calendarStyle, t),
    cardStyle: a.cardStyle.lerp(b.cardStyle, t),
    checkboxStyle: a.checkboxStyle.lerp(b.checkboxStyle, t),
    circularProgressStyle: a.circularProgressStyle.lerp(b.circularProgressStyle, t),
    dateFieldStyle: a.dateFieldStyle.lerp(b.dateFieldStyle, t),
    determinateProgressStyle: a.determinateProgressStyle.lerp(b.determinateProgressStyle, t),
    dialogRouteStyle: a.dialogRouteStyle.lerp(b.dialogRouteStyle, t),
    dialogStyle: a.dialogStyle.lerp(b.dialogStyle, t),
    dividerStyles: a.dividerStyles.lerp(b.dividerStyles, t),
    headerStyles: a.headerStyles.lerp(b.headerStyles, t),
    itemStyle: a.itemStyle.lerp(b.itemStyle, t),
    itemGroupStyle: a.itemGroupStyle.lerp(b.itemGroupStyle, t),
    labelStyles: a.labelStyles.lerp(b.labelStyles, t),
    lineCalendarStyle: a.lineCalendarStyle.lerp(b.lineCalendarStyle, t),
    multiSelectStyle: a.multiSelectStyle.lerp(b.multiSelectStyle, t),
    modalSheetStyle: a.modalSheetStyle.lerp(b.modalSheetStyle, t),
    paginationStyle: a.paginationStyle.lerp(b.paginationStyle, t),
    persistentSheetStyle: a.persistentSheetStyle.lerp(b.persistentSheetStyle, t),
    pickerStyle: a.pickerStyle.lerp(b.pickerStyle, t),
    popoverStyle: a.popoverStyle.lerp(b.popoverStyle, t),
    popoverMenuStyle: a.popoverMenuStyle.lerp(b.popoverMenuStyle, t),
    progressStyle: a.progressStyle.lerp(b.progressStyle, t),
    radioStyle: a.radioStyle.lerp(b.radioStyle, t),
    resizableStyle: a.resizableStyle.lerp(b.resizableStyle, t),
    scaffoldStyle: a.scaffoldStyle.lerp(b.scaffoldStyle, t),
    selectStyle: a.selectStyle.lerp(b.selectStyle, t),
    selectGroupStyle: a.selectGroupStyle.lerp(b.selectGroupStyle, t),
    selectMenuTileStyle: a.selectMenuTileStyle.lerp(b.selectMenuTileStyle, t),
    sidebarStyle: a.sidebarStyle.lerp(b.sidebarStyle, t),
    sliderStyles: a.sliderStyles.lerp(b.sliderStyles, t),
    toasterStyle: a.toasterStyle.lerp(b.toasterStyle, t),
    switchStyle: a.switchStyle.lerp(b.switchStyle, t),
    tabsStyle: a.tabsStyle.lerp(b.tabsStyle, t),
    tappableStyle: a.tappableStyle.lerp(b.tappableStyle, t),
    textFieldStyle: a.textFieldStyle.lerp(b.textFieldStyle, t),
    tileStyle: a.tileStyle.lerp(b.tileStyle, t),
    tileGroupStyle: a.tileGroupStyle.lerp(b.tileGroupStyle, t),
    timeFieldStyle: a.timeFieldStyle.lerp(b.timeFieldStyle, t),
    timePickerStyle: a.timePickerStyle.lerp(b.timePickerStyle, t),
    tooltipStyle: a.tooltipStyle.lerp(b.tooltipStyle, t),
    // Copied from Flutter's [ThemeData].
    extensions: (a._extensions.map(
      (id, extensionA) => MapEntry(id, extensionA.lerp(b._extensions[id], t)),
    )..addEntries(b._extensions.entries.where((entry) => !a._extensions.containsKey(entry.key)))).values,
  );

  FThemeData._({
    required this.debugLabel,
    required this.breakpoints,
    required this.colors,
    required this.typography,
    required this.style,
    required this.accordionStyle,
    required this.autocompleteStyle,
    required this.alertStyles,
    required this.avatarStyle,
    required this.badgeStyles,
    required this.bottomNavigationBarStyle,
    required this.breadcrumbStyle,
    required this.buttonStyles,
    required this.calendarStyle,
    required this.cardStyle,
    required this.checkboxStyle,
    required this.circularProgressStyle,
    required this.dateFieldStyle,
    required this.determinateProgressStyle,
    required this.dialogRouteStyle,
    required this.dialogStyle,
    required this.dividerStyles,
    required this.headerStyles,
    required this.itemStyle,
    required this.itemGroupStyle,
    required this.labelStyles,
    required this.lineCalendarStyle,
    required this.multiSelectStyle,
    required this.modalSheetStyle,
    required this.paginationStyle,
    required this.persistentSheetStyle,
    required this.pickerStyle,
    required this.popoverStyle,
    required this.popoverMenuStyle,
    required this.progressStyle,
    required this.radioStyle,
    required this.resizableStyle,
    required this.scaffoldStyle,
    required this.selectStyle,
    required this.selectGroupStyle,
    required this.selectMenuTileStyle,
    required this.sidebarStyle,
    required this.sliderStyles,
    required this.toasterStyle,
    required this.switchStyle,
    required this.tabsStyle,
    required this.tappableStyle,
    required this.textFieldStyle,
    required this.tileStyle,
    required this.tileGroupStyle,
    required this.timeFieldStyle,
    required this.timePickerStyle,
    required this.tooltipStyle,
    required Map<Object, ThemeExtension<dynamic>> extensions,
  }) : _extensions = extensions;

  /// Obtains a particular [ThemeExtension].
  ///
  /// {@template forui.theme.FThemeData.extension}
  /// ## Creating and passing a [ThemeExtension] to [FThemeData]
  /// ```dart
  /// class BrandColor extends ThemeExtension<BrandColor> {
  ///   final Color color;
  ///
  ///   BrandColor(this.color);
  ///
  ///   @override
  ///   BrandColor copyWith({Color? color}) => BrandColor(color ?? this.color);
  ///
  ///   @override
  ///   BrandColor lerp(BrandColor? other, double t) {
  ///     if (other is! BrandColor) return this;
  ///
  ///    return BrandColor(Color.lerp(color, other.color, t)!);
  ///   }
  /// }
  /// ```
  ///
  /// Passing it via constructor:
  /// ```dart
  /// final theme = FThemeData(
  ///   extensions: [BrandColor(Colors.blue)],
  ///   ... // other fields omitted for brevity
  /// );
  /// ```
  ///
  /// Passing it via [copyWith]:
  /// ```dart
  /// theme.copyWith(extensions: [BrandColor(Colors.blue)]);
  /// ```
  ///
  /// ## Accessing the extension
  /// ```dart
  /// final brandColor = context.theme.extension<BrandColor>();
  /// ```
  ///
  /// It is recommended to define a getter for your [ThemeExtension]:
  /// ```extension FThemeDataBrandColor on FThemeData {
  ///  BrandColor get brandColor => extension<BrandColor>();
  ///  }
  ///  ```
  /// {@endtemplate}
  T extension<T extends Object>() => _extensions[T]! as T;

  /// All [ThemeExtension]s defined in this theme.
  ///
  /// {@macro forui.theme.FThemeData.extension}
  @override
  Set<ThemeExtension<dynamic>> get extensions => _extensions.values.toSet();

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
  ///
  /// This method can be generated inside projects and directly modified by running:
  /// ```shell
  /// dart run forui snippet create material-mapping
  /// ```
  @experimental
  ThemeData toApproximateMaterialTheme() {
    // Material requires height to be 1, certain widgets will overflow without it.
    // TextBaseline.alphabetic is required as TextField requires it.
    final textTheme = TextTheme(
      displayLarge: typography.xl4.copyWith(height: 1, textBaseline: typography.xl4.textBaseline ?? .alphabetic),
      displayMedium: typography.xl3.copyWith(height: 1, textBaseline: typography.xl3.textBaseline ?? .alphabetic),
      displaySmall: typography.xl2.copyWith(height: 1, textBaseline: typography.xl2.textBaseline ?? .alphabetic),
      headlineLarge: typography.xl3.copyWith(height: 1, textBaseline: typography.xl3.textBaseline ?? .alphabetic),
      headlineMedium: typography.xl2.copyWith(height: 1, textBaseline: typography.xl2.textBaseline ?? .alphabetic),
      headlineSmall: typography.xl.copyWith(height: 1, textBaseline: typography.xl.textBaseline ?? .alphabetic),
      titleLarge: typography.lg.copyWith(height: 1, textBaseline: typography.lg.textBaseline ?? .alphabetic),
      titleMedium: typography.base.copyWith(height: 1, textBaseline: typography.base.textBaseline ?? .alphabetic),
      titleSmall: typography.sm.copyWith(height: 1, textBaseline: typography.sm.textBaseline ?? .alphabetic),
      labelLarge: typography.base.copyWith(height: 1, textBaseline: typography.base.textBaseline ?? .alphabetic),
      labelMedium: typography.sm.copyWith(height: 1, textBaseline: typography.sm.textBaseline ?? .alphabetic),
      labelSmall: typography.xs.copyWith(height: 1, textBaseline: typography.xs.textBaseline ?? .alphabetic),
      bodyLarge: typography.base.copyWith(height: 1, textBaseline: typography.base.textBaseline ?? .alphabetic),
      bodyMedium: typography.sm.copyWith(height: 1, textBaseline: typography.sm.textBaseline ?? .alphabetic),
      bodySmall: typography.xs.copyWith(height: 1, textBaseline: typography.xs.textBaseline ?? .alphabetic),
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

      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      // Navigation Drawer
      navigationDrawerTheme: NavigationDrawerThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      // Navigation Rail
      navigationRailTheme: NavigationRailThemeData(
        indicatorShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: style.borderRadius,
          side: BorderSide(width: style.borderWidth, color: colors.border),
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

      // Input
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

      // Date Picker
      datePickerTheme: DatePickerThemeData(
        shape: RoundedRectangleBorder(borderRadius: style.borderRadius),
        dayShape: .all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
        rangePickerShape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      ),

      // Time Picker
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

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: switchStyle.thumbColor,
        trackColor: switchStyle.trackColor,
        trackOutlineColor: switchStyle.trackColor,
      ),

      // Buttons
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
          padding: .all(buttonStyles.secondary.contentStyle.padding),
          shape: .all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
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
          padding: .all(buttonStyles.primary.contentStyle.padding),
          shape: .all(RoundedRectangleBorder(borderRadius: style.borderRadius)),
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
          padding: .all(buttonStyles.outline.contentStyle.padding),
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
      dialogTheme: DialogThemeData(shape: RoundedRectangleBorder(borderRadius: style.borderRadius)),

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
    String? debugLabel,
    FBreakpoints? breakpoints,
    FColors? colors,
    FTypography? typography,
    FStyle Function(FStyle style)? style,
    FAccordionStyle Function(FAccordionStyle style)? accordionStyle,
    FAutocompleteStyle Function(FAutocompleteStyle style)? autocompleteStyle,
    FAlertStyles Function(FAlertStyles style)? alertStyles,
    FAvatarStyle Function(FAvatarStyle style)? avatarStyle,
    FBadgeStyles Function(FBadgeStyles style)? badgeStyles,
    FBottomNavigationBarStyle Function(FBottomNavigationBarStyle style)? bottomNavigationBarStyle,
    FBreadcrumbStyle Function(FBreadcrumbStyle style)? breadcrumbStyle,
    FButtonStyles Function(FButtonStyles style)? buttonStyles,
    FCalendarStyle Function(FCalendarStyle style)? calendarStyle,
    FCardStyle Function(FCardStyle style)? cardStyle,
    FCheckboxStyle Function(FCheckboxStyle style)? checkboxStyle,
    FCircularProgressStyle Function(FCircularProgressStyle style)? circularProgressStyle,
    FDateFieldStyle Function(FDateFieldStyle style)? dateFieldStyle,
    FDeterminateProgressStyle Function(FDeterminateProgressStyle style)? determinateProgressStyle,
    FDialogRouteStyle Function(FDialogRouteStyle style)? dialogRouteStyle,
    FDialogStyle Function(FDialogStyle style)? dialogStyle,
    FDividerStyles Function(FDividerStyles style)? dividerStyles,
    FHeaderStyles Function(FHeaderStyles style)? headerStyles,
    FItemStyle Function(FItemStyle style)? itemStyle,
    FItemGroupStyle Function(FItemGroupStyle style)? itemGroupStyle,
    FLabelStyles Function(FLabelStyles style)? labelStyles,
    FLineCalendarStyle Function(FLineCalendarStyle style)? lineCalendarStyle,
    FMultiSelectStyle Function(FMultiSelectStyle style)? multiSelectStyle,
    FModalSheetStyle Function(FModalSheetStyle style)? modalSheetStyle,
    FPaginationStyle Function(FPaginationStyle style)? paginationStyle,
    FPersistentSheetStyle Function(FPersistentSheetStyle style)? persistentSheetStyle,
    FPickerStyle Function(FPickerStyle style)? pickerStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FPopoverMenuStyle Function(FPopoverMenuStyle style)? popoverMenuStyle,
    FProgressStyle Function(FProgressStyle style)? progressStyle,
    FRadioStyle Function(FRadioStyle style)? radioStyle,
    FResizableStyle Function(FResizableStyle style)? resizableStyle,
    FScaffoldStyle Function(FScaffoldStyle style)? scaffoldStyle,
    FSelectStyle Function(FSelectStyle style)? selectStyle,
    FSelectGroupStyle Function(FSelectGroupStyle style)? selectGroupStyle,
    FSelectMenuTileStyle Function(FSelectMenuTileStyle style)? selectMenuTileStyle,
    FSidebarStyle Function(FSidebarStyle style)? sidebarStyle,
    FSliderStyles Function(FSliderStyles style)? sliderStyles,
    FToasterStyle Function(FToasterStyle style)? toasterStyle,
    FSwitchStyle Function(FSwitchStyle style)? switchStyle,
    FTabsStyle Function(FTabsStyle style)? tabsStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FTextFieldStyle Function(FTextFieldStyle style)? textFieldStyle,
    FTileStyle Function(FTileStyle style)? tileStyle,
    FTileGroupStyle Function(FTileGroupStyle style)? tileGroupStyle,
    FTimeFieldStyle Function(FTimeFieldStyle style)? timeFieldStyle,
    FTimePickerStyle Function(FTimePickerStyle style)? timePickerStyle,
    FTooltipStyle Function(FTooltipStyle style)? tooltipStyle,
    Iterable<ThemeExtension<dynamic>>? extensions,
  }) => FThemeData(
    debugLabel: debugLabel ?? this.debugLabel,
    breakpoints: breakpoints ?? this.breakpoints,
    colors: colors ?? this.colors,
    typography: typography ?? this.typography,
    style: style != null ? style(this.style) : this.style,
    accordionStyle: accordionStyle != null ? accordionStyle(this.accordionStyle) : this.accordionStyle,
    autocompleteStyle: autocompleteStyle != null ? autocompleteStyle(this.autocompleteStyle) : this.autocompleteStyle,
    alertStyles: alertStyles != null ? alertStyles(this.alertStyles) : this.alertStyles,
    avatarStyle: avatarStyle != null ? avatarStyle(this.avatarStyle) : this.avatarStyle,
    badgeStyles: badgeStyles != null ? badgeStyles(this.badgeStyles) : this.badgeStyles,
    bottomNavigationBarStyle: bottomNavigationBarStyle != null
        ? bottomNavigationBarStyle(this.bottomNavigationBarStyle)
        : this.bottomNavigationBarStyle,
    breadcrumbStyle: breadcrumbStyle != null ? breadcrumbStyle(this.breadcrumbStyle) : this.breadcrumbStyle,
    buttonStyles: buttonStyles != null ? buttonStyles(this.buttonStyles) : this.buttonStyles,
    calendarStyle: calendarStyle != null ? calendarStyle(this.calendarStyle) : this.calendarStyle,
    cardStyle: cardStyle != null ? cardStyle(this.cardStyle) : this.cardStyle,
    checkboxStyle: checkboxStyle != null ? checkboxStyle(this.checkboxStyle) : this.checkboxStyle,
    circularProgressStyle: circularProgressStyle != null
        ? circularProgressStyle(this.circularProgressStyle)
        : this.circularProgressStyle,
    dateFieldStyle: dateFieldStyle != null ? dateFieldStyle(this.dateFieldStyle) : this.dateFieldStyle,
    determinateProgressStyle: determinateProgressStyle != null
        ? determinateProgressStyle(this.determinateProgressStyle)
        : this.determinateProgressStyle,
    dialogRouteStyle: dialogRouteStyle != null ? dialogRouteStyle(this.dialogRouteStyle) : this.dialogRouteStyle,
    dialogStyle: dialogStyle != null ? dialogStyle(this.dialogStyle) : this.dialogStyle,
    dividerStyles: dividerStyles != null ? dividerStyles(this.dividerStyles) : this.dividerStyles,
    headerStyles: headerStyles != null ? headerStyles(this.headerStyles) : this.headerStyles,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
    itemGroupStyle: itemGroupStyle != null ? itemGroupStyle(this.itemGroupStyle) : this.itemGroupStyle,
    labelStyles: labelStyles != null ? labelStyles(this.labelStyles) : this.labelStyles,
    lineCalendarStyle: lineCalendarStyle != null ? lineCalendarStyle(this.lineCalendarStyle) : this.lineCalendarStyle,
    multiSelectStyle: multiSelectStyle != null ? multiSelectStyle(this.multiSelectStyle) : this.multiSelectStyle,
    modalSheetStyle: modalSheetStyle != null ? modalSheetStyle(this.modalSheetStyle) : this.modalSheetStyle,
    paginationStyle: paginationStyle != null ? paginationStyle(this.paginationStyle) : this.paginationStyle,
    persistentSheetStyle: persistentSheetStyle != null
        ? persistentSheetStyle(this.persistentSheetStyle)
        : this.persistentSheetStyle,
    pickerStyle: pickerStyle != null ? pickerStyle(this.pickerStyle) : this.pickerStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    popoverMenuStyle: popoverMenuStyle != null ? popoverMenuStyle(this.popoverMenuStyle) : this.popoverMenuStyle,
    progressStyle: progressStyle != null ? progressStyle(this.progressStyle) : this.progressStyle,
    radioStyle: radioStyle != null ? radioStyle(this.radioStyle) : this.radioStyle,
    resizableStyle: resizableStyle != null ? resizableStyle(this.resizableStyle) : this.resizableStyle,
    scaffoldStyle: scaffoldStyle != null ? scaffoldStyle(this.scaffoldStyle) : this.scaffoldStyle,
    selectStyle: selectStyle != null ? selectStyle(this.selectStyle) : this.selectStyle,
    selectGroupStyle: selectGroupStyle != null ? selectGroupStyle(this.selectGroupStyle) : this.selectGroupStyle,
    selectMenuTileStyle: selectMenuTileStyle != null
        ? selectMenuTileStyle(this.selectMenuTileStyle)
        : this.selectMenuTileStyle,
    sidebarStyle: sidebarStyle != null ? sidebarStyle(this.sidebarStyle) : this.sidebarStyle,
    sliderStyles: sliderStyles != null ? sliderStyles(this.sliderStyles) : this.sliderStyles,
    toasterStyle: toasterStyle != null ? toasterStyle(this.toasterStyle) : this.toasterStyle,
    switchStyle: switchStyle != null ? switchStyle(this.switchStyle) : this.switchStyle,
    tabsStyle: tabsStyle != null ? tabsStyle(this.tabsStyle) : this.tabsStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    tileStyle: tileStyle != null ? tileStyle(this.tileStyle) : this.tileStyle,
    tileGroupStyle: tileGroupStyle != null ? tileGroupStyle(this.tileGroupStyle) : this.tileGroupStyle,
    timeFieldStyle: timeFieldStyle != null ? timeFieldStyle(this.timeFieldStyle) : this.timeFieldStyle,
    timePickerStyle: timePickerStyle != null ? timePickerStyle(this.timePickerStyle) : this.timePickerStyle,
    tooltipStyle: tooltipStyle != null ? tooltipStyle(this.tooltipStyle) : this.tooltipStyle,
    extensions: extensions ?? this.extensions,
  );
}
