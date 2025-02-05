## 0.9.0 (Next)

### Additions

* Add `FDatePicker`.
* Add `FFormProperties`.
* Add `FPagination`.
* Add `FPicker`.
* Add `FPopoverTagRegion`.
* Add `FBreadcrumb`.
* Add `FTextField.builder`.
* Add `FTextField.onTap`.
* Add `FTextField.onTapOutside`.
* Add `FSelectGroupController.onUpdate`.
* Add `animationTween` to `FTappable.animated(...)`.
* Add `FValueNotifier.addValueListener(...)`.
* Add `FValueNotifier.removeValueListener(...)`.

### Changes

* **Breaking** Change `FPopover.hideOnTapOutside`'s type from `bool` to `FHidePopoverRegion`. The default behavior for hiding behavior for `FPopover()` has changed from excluding the target to not.
* **Breaking** Change `FPopoverStyle.shadow` to `FStyle.shadow`.
* **Breaking** Change `FPopoverMenu.tappable(...)` to `FPopoverMenu.automatic(...)`.
* **Breaking** Change `FPopover.controller(...)` to `FPopover.popoverController(...)`.
* **Breaking** Change `FPopover.tappable(...)` to `FPopover.automatic(...)`.
* **Breaking** Change `FPopover.followerAnchor` to `FPopover.popoverAnchor`.
* **Breaking** Change `FPopover.targetAnchor` to `FPopover.childAnchor`.
* **Breaking** Change `FPortal.followerAnchor` to `FPortal.portalAnchor`.
* **Breaking** Change `FPortal.targetAnchor` to `FPortal.childAnchor`.
* **Breaking** Change `FPortal.followerBuilder` to `FPortal.portalBuilder`.
* **Breaking** Change `FPortalFollowerShift` to `FPortalShift`.
* **Breaking** Remove `onChange` parameter from `FSelectTile`. This was accidentally include from early prototyping.
* **Breaking** Change `FSelectGroupController.select(...)` to `FSelectGroupController.update(...)`
* **Breaking** Change `FSelectGroupController` to be a `ValueNotifier`.
* **Breaking** Change `FTileGroup.prefix` from `Widget` to `ValueWidgetBuilder<FTextFieldStateStyle>`.
* **Breaking** Change `FTileGroup.suffix` from `Widget` to `ValueWidgetBuilder<FTextFieldStateStyle>`.
* **Breaking** Change `FTileGroup.controller` to `FTileGroup.scrollController`.

### Fixes

* Fix `FCalendar` rebuilding whenever the given `initialType` and/or `initialMonth` changes.
* Fix `FCalendar`'s day picker not updating when a new start and/or end date is given.
* Fix `FHeader.nested(...)` not rendering the title when no prefix and suffix actions are given.
* Fix `FPopover` not handling focus changes in popover properly.
* Fix `FTabs`'s scrollable alignment not being correct.
* Fix `FTappable` remaining in a hovered or touched state when its `onPress`/`onLongPress` callbacks were nulled after being non-null.
* Fix `FTextField` ignoring `enableInteractiveSelection` parameter.
* Fix `FTextField` ignoring `FTextFieldStyle.cursorColor`.


## 0.8.0

Bump minimum Flutter version to 3.27.0.

### Additions

* Add `showFSheet(...)`.

* Add `showFPersistentSheet(...)`.

* Add `FModalSheetRoute`.

* Add `FSheets`.

* Add `FSheets` internally to `FScaffold`.

* Add `truncateAndStripTimezone` to `FCalendarController.date(...)`.

* Add `truncateAndStripTimezone` to `FCalendarController.dates(...)`.

* Add `truncateAndStripTimezone` to `FCalendarController.range(...)`.

* Add `FCalendar.dayBuilder`.

* Add `FLineCalendar`.

* Add `FTileGroup.builder`.

* Add `FSelectTileGroup.builder`.

* Add `FSelectMenuTile.builder`.

* Add `FScaffold.resizeToAvoidBottomInset`.

* Add `FThemeData.debugLabel`.

### Changes

* Change `FCalendarController.date(...)` to automatically strip and truncate all DateTimes to dates in UTC timezone.

* Change `FCalendarController.dates(...)` to automatically strip and truncate all DateTimes to dates in UTC timezone.

* Change `FCalendarController.ranges(...)` to automatically strip and truncate all DateTimes to dates in UTC timezone.

* Change `FCalendar.start` to be optional and default to 1st January 1900.

* Change `FCalendar.end` to be optional and default to 1st January 2100.

* Change `FTheme` to internally extend `InheritedTheme`.

* Change `FTileGroup` to be scrollable.

* Change `FPopoverMenu` to be scrollable.

* Change `FSelectTileGroup` to be scrollable.

* Change `FSelectMenuTile` to be scrollable.

* Change `ThemeBuildContext` to `FThemeBuildContext`.

* **Breaking** Change `Layout` to `FLayout`.

* **Breaking**  Change `FLocalizations.of(...)` to return `FLocalizations?` instead of `FLocalizations` - do `FLocalizations.of(...) ?? FDefaultLocalizations()`.
  This change is sadly needed as Flutter now forcefully regenerates `FLocalizations` each time `flutter pub get` is called.

* **Breaking** Change `FTileData.index` to `FTileData.last`.

* **Breaking** Change `FPopoverMenu.controller` to `FPopoverMenu.popoverController`.

* **Breaking** Change `FSelectTileGroup.controller` to `FSelectTileGroup.groupController`.

* **Breaking** Change `FPopoverController.duration` to `FPopoverController.animationDuration`.

* **Breaking** Change `FTooltipController.duration` to `FTooltipController.animationDuration`.

* **Breaking** Change `FTabController.ignoreDirectionalPadding` to `FTabController.directionPadding`.

* **Breaking** Change `FPopover.ignoreDirectionalPadding` to `FPopover.directionPadding` - the value should be inverted.*

* **Breaking** Change `FPopoverMenu.ignoreDirectionalPadding` to `FPopoverMenu.directionPadding` - the value should be inverted.

* **Breaking** Change `FSelectMenuTile.ignoreDirectionalPadding` to `FSelectMenuTile.directionPadding` - the value should be inverted.

### Fixes

* Resolved an issue where `FLabel` exhibited incorrect padding when used with `Axis.horizontal` and RTL layouts.

## 0.7.0

This update adds responsive breakpoints, focused outlines & localization! It also introduces several new tile widgets.

### Additions

* Add `FButtonSpinner`.

* Add `FBreakpoints`.

* Add `FIcon.empty()`.

* Add `FTappable`.

* Add `FTile`.

* Add `FTileGroup`.

* Add `FSelectMenuTile`.

* Add `FSelectTile`.

* Add `FSelectTileGroup`.

* Add `FCalendarDayPickerStyle.tileSize`.

* Add `FPopover.ignoreDirectionalPadding`.

* Add `FPopover.tappable(...)`.

* Add `FPopoverMenu`.

* Add `FPortal.offset`.

* Add `FLocalizations`.

* Add `FFocusedOutline`.

* Add `FDialog.adaptive(...)`.

* **Breaking** Add `focusedOutlineStyle` to `FAccordionStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FBottomNavigationBar` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FButtonStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FHeaderActionStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FResizableDividerStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FCheckboxStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FRadioStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedBorder` to `FTileStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedDividerStyle` to `FTileStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FTabsStyle` - this only affect users which use the primary constructor.

* **Breaking** Add `focusedOutlineStyle` to `FSliderThumbStyle` - this only affect users which use the primary constructor.

### Changes

* **Breaking** Change `FPopover()` to not automatically wrap a target in a `GestureDetector` - use `FPopover.tappable(...)`
  instead.

* **Breaking** Change `FSlider` to default to the current text direction instead of `Layout.ltr`. 

* Change `FCalendar` to support localization.

### Fixes

* Change FButton's animation to only start on mouse down and up.

* Fix `FLabel` not showing error message if label and description are null.

* Fix `FSelectGroup` not properly disposing callbacks.


## 0.6.1

* Fix range slider not displaying tooltip for minimum thumb.


## 0.6.0

### Additions

* Add `FAccordion`.

* Add `FSlider`.

* Add `FButtonStyles.ghost`.

* Add `FButtonCustomStyle.enabledHoverBoxDecoration`.

* Add `FTextField.contentInsertionConfiguration`.

* Add `FTextField.mouseCursor`.

* Add `FTextField.forceErrorText`.

* Add `FIcon`.

* Add `FColorScheme.disable(...)`.

* Add `FColorScheme.disableOpacity`.

* Add `FColorScheme.hover(...)`.

* Add `FColorScheme.enabledHoveredOpacity`.

* Add `FChangeNotifier`.

* Add `FValueNotifier`.

### Changes

* Change button to change color when hovering over it.

* Change `FCalendar` year picker to update the header whenever a year is selected.

* Increase `FCalendar`'s default text size from `FTypography.sm` to `FTypography.base`.

* **Breaking** Change `FBottomNavigationBarItem.label` from `String` to `Widget`.

* **Breaking** Split `FCalendarHeaderStyle.iconColor` into `FCalendarHeaderStyle.enabledIconColor` and
  `FCalendarHeaderStyle.disabledIconColor`.

* **Breaking** Change `FTextField` to use `FLabel`.

* **Breaking** Remove `FTextFieldErrorStyle.animatioDuration`.

* **Breaking** Rename `FLabelStateStyle` to `FLabelStateStyles`.

* **Breaking** Rename `FTextField.onSave` to `FTextField.onSaved`.

* **Breaking** Remove FAlertIcon & FAlertIconStyle - use `FIcon` instead.

* **Breaking** Remove FButtonIcon & FAlertIconStyle - use `FIcon` instead.

* **Breaking** Change FButtonCustomStyle to better represent the style's layout - this will only affect users that
  create a custom `FButtonCustomStyle`.

* **Breaking** Change `FBottomNavigationBarItem.icon` from `SvgAsset` to `Widget` - wrap the asset in ` FIcon` instead.

* **Breaking** Change `FHeaderAction.icon` from `SvgAsset` to `Widget` - wrap the asset in ` FIcon` instead.

* **Breaking** Change `FSelectGroup.builder` parameters.

* **Breaking** Change `FBadgeCustomStyle.content` to `FBadgeCustomStyle.contentStyle`.

* **Breaking** Change `FAvatarStyle.text` to `FAvatarStyle.textStyle`.

* **Breaking** Change `FDialogStyle.horizontal` to `FDialogStyle.horizontalStyle`.

* **Breaking** Change `FDialogStyle.selectedLabel` to `FDialogStyle.selectedLabelTextStyle`.

* **Breaking** Change `FDialogStyle.unselectedLabel` to `FDialogStyle.unselectedLabelTextStyle`.

* **Breaking** Change `FDividerStyle.horizontal` to `FDividerStyle.horizontalStyle`.

* **Breaking** Change `FDividerStyle.vertical` to `FDividerStyle.verticalStyle`.

* **Breaking** Change `FDialogStyle.indicator` to `FDialogStyle.indicatorDecoration`.

* **Breaking** Change `FHeader.leftActions` to `FHeader.prefixActions`.

* **Breaking** Change `FHeader.rightActions` to `FHeader.suffixActions`.

* **Breaking** Change `FLabelStyle.horizontal` to `FLabelStyle.horizontalStyle`.

* **Breaking** Change `FLabelStyle.vertical` to `FLabelStyle.verticalStyle`.

* **Breaking** Change `FButtonStyles.outline`'s background to transparent.

### Fixes

* Fix `FBottomNavigationBar` items hit region being smaller than intended.

* Fix `FCalendar` showing focused outline when pressing and long pressing a date.

* Fix `FCalendar` year and month picker applying incorrect initial top padding.

* Fix `FCalendar` year and month picker incorrectly calculating start and end dates.

* Fix `FTextfield` being vertically larger than intended.

* Fix `FTextfield` description text's odd transition animation whenever an error occurs.

* Fix `FSwitch` not using correct label style.

* Fix `FCheckbox`, `FRadio`, `FSelectGroup`, `FSwitch` and `FTextField` styles causing the widget inspector to crash.

* Fix `FSelectGroup` not applying correct style if a custom widget-specific style is given.

## 0.5.1

###

* Fix `FTabs` not showing correct tab entry when switching tabs.
  [Issue #203](https://github.com/forus-labs/forui/issues/203).

## 0.5.0

The minimum Flutter version has been increased from `3.19.0` to `3.24.0`.

### Additions

* Add `FButton.icon(...)`.

* Add `FBottomNavigationBarData`.

* Add `FButtonData`.

* Add `FCalendarHeaderStyle.buttonStyle`.

* Add `FFormFieldStyle`.

* Add `FHeaderData`.

* Add `FResizable.semanticFormatterCallback`.

* Add `FLabel`.

* Add label and description to `FCheckbox`.

* Add label and description to `FSwitch`.

* Add `FPortal`.

* Add `FPopover`.

* Add `FTooltip`.

* Add `FSelectGroup`.

* Add `FRadio`.

### Changes

* **Breaking:** Change `FAlertIconStyle.height` to `FAlertIconStyle.size`.

* **Breaking:** Rename `FBottomNavigationBar.items` to `FBottomNavigationBar.children`.

* **Breaking:** Remove `FBottomNavigationBar.raw(...)` - use the default constructor instead.

* **Breaking:** Rename `FButtonIconStyle.height` to `FButtonIconStyle.size`.

* **Breaking:** Change `FDivider.vertical` to `FDivider.axis`.

* Change `FResizable` to resize by `FResizable.resizePercentage` when using a keyboard.

* **Breaking:** Change `FResiableDividerStyle.thickness` to `FResizableDividerStyle.width`.

* Change `FTextFieldStyle` to inherit from `FFormFieldStyle`.

* Change `FTextField` to display error under description instead of replacing it.

* **Breaking:** Change `FTextField.help` to `FTextField.description`.

* **Breaking:** Change how `FTextFieldStyle` stores various state-dependent styles.

* **Breaking:** Remove `FTextField.error` - use `FTextField.forceErrorText` instead.

* Change `FTabController` to implement `ChangeNotifier` instead of `Listenable`.

* **Breaking:** Flattened `FStyle.formFieldStyle` - use `FStyle.enabledFormFieldStyle`, `FStyle.disabledFormFieldStyle`,
  and`FStyle.errorFormFieldStyle`.

* Improve platform detection for web when initializing platform-specific variables.

* **Breaking:** `FCheckbox` and `FSwitch` no longer wraps `FormField` - consider wrapping them in a `FormField` if
  required.

* **Breaking:** Require `FTheme` to be wrapped in a `CupertinoApp`, `MaterialApp` or `WidgetsApp`.

### Fixes

* Fix `FResizable` not rendering properly in an expanded widget when its crossAxisExtent is null.

* Fix `FTextField` not changing error text color when an error occurs.

* Fix `FTextField` error message replacing the description text.

* Fix `FCheckboxStyle.inherit(...)` icon color inheriting from the wrong color.

* Fix `FTabs` not handling indexes properly.

## 0.4.0

### Additions

* Add `FAvatar`.

* **Breaking:** Add `FCalendarEntryStyle.focusedBorderColor`. This only affects users that
  customized `FCalendarEntryStyle`.

* Add `FResizable`.

* Add `image` parameter to `FCard`.

### Changes

* Change number of years displayed per page in `FCalendar` from 12 to 15.

* **Breaking:** Move `FCalendar.enabled` to `FCalendarController.selectable(...)`.

* **Breaking:** Rename `FCalendarController.contains(...)` to `FCalendarController.selected(...)`.

* **Breaking:** Rename `FCalendarController.onPress(...)` to `FCalendarController.select(...)`.

* **Breaking:** Rename `FCalendarEntryStyle.focusedBackgroundColor` to `FCalendarEntryStyle.hoveredBackgroundColor`.
  This only affects users that customized `FCalendarEntryStyle`.

* **Breaking:** Rename `FCalendarEntryStyle.focusedTextStyle` to `FCalendarEntryStyle.hoveredTextStyle`.
  This only affects users that customized `FCalendarEntryStyle`.

* **Breaking:** Move `FCalendarSingleValueController` to `FCalendarController.date(...)`.

* **Breaking:** Move `FCalendarMultiValueController` to `FCalendarController.dates(...)`.

* **Breaking:** Rename `FCalendarSingleRangeController` to `FCalendarRangeController.range(...)`.

* **Breaking:** Rename `FSeparator` to `FDivider`.

* **Breaking:** Remove `colorScheme`, `typography` and `style` parameters from `FThemeData.copyWith(...)`.
  The problem was widget-specific styles not being re-created after the removed parameters were updated.
  This led to unintuitive behavior where the style of a widget was not updated when the `FThemeData` was updated.
  This should only affect people that customize `FThemeData`. Use the `FThemeData.inherit(...)` constructor instead.

### Fixes

* Fix `FCalendar` dates & `FButton`s not being toggleable using `Enter` key.

* Fix `FCalendar` dates sometimes not being navigable using arrow keys.

## 0.3.0

### Additions

* Add `FAlert`

* Add `FCalendar`

* Add `FBottomNavigationBar`

### Enhancements

* **Breaking** Change `FSwitch` to be usable in `Form`s.

* **Breaking** Rename `FThemeData.checkBoxStyle` to `FThemeData.checkboxStyle` for consistency.

### Fixes

* Fix missing `style` parameter for `FCheckbox`.

## 0.2.0+3

### Fixes

* Fix broken images in README.md (yet again).

## 0.2.0+2

### Fixes

* Fix broken images in README.md.

## 0.2.0+1

### Fixes

* Fix broken images in README.md.

## 0.2.0

### Additions

* Add `FCheckbox`.

* Add `FHeader.nested`.

* Add `FProgress`.

### Enhancements

* **Breaking** Move `FHeaderStyle` to `FHeaderStyles.rootStyle`.

* **Breaking** Move `FHeaderActionStyle.padding` to `FRootHeaderStyle.actionSpacing`.

* **Breaking** Suffix style parameters with `Style`, i.e. `FRootHeaderStyle.action` has been renamed to
  `FRootHeaderStyle.actionStyle`.

* **Breaking** Raw fields have been removed, wrap strings with the Text() widget. E.g. `FButton(label: 'Hello')` or
  `FButton(rawLabel: 'Hello')` should be replaced with `FButton(label: Text('Hello'))`.

* Change `FTextField` to be usable in `Form`s.

* Change `FTextFieldStyle`'s default vertical content padding from `5` to `15`.

* Split exports in `forui.dart` into sub-libraries.

### Fixes

* Fix missing `key` parameter in `FTextField` constructors.

* **Breaking** `FButton.prefixIcon` and `FButton.suffixIcon` have been renamed to `FButton.prefix` and `FButton.suffix`.

* Fix padding inconsistencies in `FCard` and `FDialog`.

## 0.1.0

* Initial release! 🚀
