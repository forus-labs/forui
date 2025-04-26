## 0.11.0 (Next)
We are experimenting with a new changelog format which groups changes by feature.

### Styles
We added a CLI to generate styles for Forui widgets. See forui.dev/docs/cli for more information. 

We made several breaking changes to styles and widgets that rely on state styles to improve consistency and usability 
(too many to list sanely). Generally, all styles have been updated to use `WidgetState`s, becoming more customizable and 
concise.

* Add `FBottomNavigationItemStyle.spacing`.
* Add `FCardContentStyle.imageSpacing`.
* Add `FCardContentStyle.subtitleSpacing`.
* Add `FCheckboxStateStyle.size`.

* **Breaking** Rename `FThemeData.colorScheme` to `FThemeData.colors`.
* **Breaking** Rename all `F<Style>.inherit(colorScheme: ...)` to `F<Style>.inherit(color: ...)`.

* **Breaking** Rename `FAlertStyle` to `FBaseAlertStyle`.
* **Breaking** Rename `FAlertCustomStyle` to `FAlertStyle`.
* **Breaking** Move constants in `FBaseAlertStyle` to `FAlertStyle`.

* **Breaking** Move `FDialog.insetAnimationDuration` to `FDialogStyle.insetAnimationDuration`.
* **Breaking** Move `FDialog.insetAnimationCurve` to `FDialogStyle.insetAnimationCurve`.
* **Breaking** Combine `FDialogStyle.minWidth` and `FDialogStyle.maxWidth` into `FDialog.constraints.`.
* **Breaking** Combine `FDialogStyle.minWidth` and `FDialogStyle.maxWidth` to `FDialog.constraints.`.


### `FIcon`
`FIcon` has been removed in favor of Flutter's `Icon` class. `FIcon` was designed with only monochrome icons in mind
and is not able to support multicolored icons. This coincides with replacement of `FAssets` with `FIcons` and svg icons 
with font icons. In addition, all `iconColor` and `iconSize` style properties have been replaced with `IconThemeData`.

* **Breaking** Remove `FIcon` - use Flutter's `Icon`.
* **Breaking** Remove `FIconStyle` - use Flutter's `IconThemeData` instead.
* **Breaking** Replace `FAssets` with `FIcons`.
* **Breaking** Replace `FAccordionStyle` `iconColor` and `iconSize` with `iconStyle`.
* **Breaking** Replace `FBottomNavigationBarItemStyle ` `activeIconColor`, `inactiveIconColor` and `iconSize` with 
  `selectedIconStyle` and `unselectedIconStyle`.
* **Breaking** Replace `FBottomNavigationBarItemStyle` `activeTextStyle` and `inactiveTextStyle` with `selectedTextStyle` 
  and `unselectedTextStyle`.
* **Breaking** Replace `FButtonIconContentStyle` `enabledColor`, `disabledColor` and `iconSize` with `enabledStyle` and
  `disabledStyle`.
* **Breaking** Replace `FButtonContentStyle` `enabledIconColor`, `disabledIconColor` and `iconSize` with `enabledIconStyle` 
  and `disabledIconStyle`.
* **Breaking** Replace `FButtonIconContentStyle` `enabledColor`, `disabledColor` and `iconSize` with `enabledStyle` and
  `disabledStyle`.
* **Breaking** Remove `FCalendarHeaderStyle` `enabledIconColor` and `disabledIconColor` - configure 
  `buttonStyle.iconContentStyle` instead.
* **Breaking** Change `FDateFieldStyle.iconStyle` from `FIconStyle` to `IconThemeData`.
* **Breaking** Replace `FHeaderActionStyle` `enabledColor`, `disabledColor` and `size` with `enabledStyle` and 
  `disabledStyle`.
* **Breaking** Change `FPaginationStyle.iconStyle` from `FIconStyle` to `IconThemeData`.
* **Breaking** Change `FTileContentStateStyle.prefixIconStyle` from `FIconStyle` to `IconThemeData`.
* **Breaking** Change `FTileContentStateStyle.suffixIconStyle` from `FIconStyle` to `IconThemeData`.
* **Breaking** Change `FTimeFieldStyle.iconStyle` from `FIconStyle` to `IconThemeData`.
* **Breaking** Replace `FAlertCustomStyle` `iconColor` and `iconSize` with `iconStyle`.
* **Breaking** Change `FBreadcrumbStyle.iconStyle` from `FIconStyle` to `IconThemeData`.
* **Breaking** Replace `FCheckboxStateStyle` `iconColor` with `iconStyle`.

### `FSelect` (new)
A select displays a list of options for the user to pick from. It is searchable and supports both async & sync loading
of items.

* Add `FSelect`.
* Add `FSelectController`.

### `FPopover`
The traversal-edge behavior of `FPopover` and Forui widgets that depend on it have been fixed.

* Add `FPopover.traversalEdgeBehavior`.
* Add `traversalEdgeBehavior` to `FBreadcrumbItem.collapsed`.
* Add `traversalEdgeBehavior` to `FPopoverMenu`.
* Add `traversalEdgeBehavior` to `FSelectMenuTile`.
* **Breaking** Change `FPopover.focusNode` from `FocusNode` to `FocusScopeNode`.
* **Breaking** Change `focusNode` from `FocusNode` to `FocusScopeNode` in `FBreadcrumbItem.collapsed`.
* **Breaking** Change `focusNode` from `FocusNode` to `FocusScopeNode` in `FPopoverMenu`.
* **Breaking** Change `focusNode` from `FocusNode` to `FocusScopeNode` in `FSelectMenuTile`.


### `FHeader`

Several minor tweaks have been made to `FHeader` to improve usability and consistency.

* Change `FHeader(title: ...)` to be optional.
* Change `FHeader.nested(title: ...)` to be optional.
* **Breaking** Change `FHeader(actions: ...)` to `FHeader(suffixes: ...)`.
* **Breaking** Change `FHeader(prefixActions: ...)` to `FHeader(prefixes: ...)`.
* **Breaking** Change `FHeader(suffixActions: ...)` to `FHeader(suffixes: ...)`.


### `FProgress`
`FProgress` has been updated to support indeterminate progress and fix some longstanding issues.

* Add `FProgress.circularIcon`.
* **Breaking** Change `FProgressStyle` to `FLinearProgressStyle`.
* **Breaking** Remove `FButtonSpinner` - use `FProgress.circularIcon(...)` instead.

### `FSelectGroupController` & controller callbacks
`FSelectGroupController` has been replaced with `FMultiValueNotifier` to allow usage across other non-select group 
widgets. This applies to all Forui widgets that use `FSelectGroupController`. 

A new `onChange` and `onSelect` callback has been added to most Forui widgets.

* Add `FMultiValueNotifier`.
* Add `FSelectTileGroupController` typedef.
* Add `FSelectMenuTileController` typedef.
* Add `FSelectGroup.onChange`.
* Add `FSelectGroup.onSelect`.
* Add `FSelectTileGroup.onChange`.
* Add `FSelectTileGroup.onSelect`.
* Add `FSelectMenuTile.onChange`.
* Add `FSelectMenuTile.onSelect`.
* **Breaking** Replace `FSelectGroupController` with a typedef of `FMultiValueNotifier`.
* **Breaking** Remove `FMultiSelectGroupController` - use `FSelectGroupController(...)` instead.
* **Breaking** Remove `FRadioSelectGroupController` - use `FSelectGroupController.radio(...)` instead.
* **Breaking** Rename `FSelectTileGroup.groupController` to `FSelectTileGroup.selectController`.
* **Breaking** Rename `FSelectMenuTile.groupController` to `FSelectMenuTile.selectController`.
* **Breaking** Rename `FSelectMenuTile.menuTileBuilder` to `FSelectMenuTile.menuBuilder`.


### `FPortal`
`FPortal` has been reworked to fix a series of longstanding issues.

* Add `FPortal.useViewPadding`.
* Fix `FPortal` not positioning portals correctly when wrapped in a `RepaintBoundary`/`Padding`.
* Fix `FPortal` not updating portals when child's offset/size changes.
* Fix `FPortal` displaying portal when child is not rendered.


### `FTappable`
`FTappable` has been updated to support animations by default. This applies to all Forui widgets that use `FTappable`.
The `hovered` state has also been split into `hovered` and `pressed` states.

* Add `FTappableStyle`.
* Add `FAccordionStyle.tappableStyle`.
* Add `FBottomNavigationBarStyle.tappableStyle`.
* Add `FBreadcrumbStyle.tappableStyle`.
* Add `FButtonStyle.tappableStyle`.
* Add `FCalendarDayPickerStyle.tappableStyle`.
* Add `FCalendarEntryStyle.tappableStyle`.
* Add `FCalendarHeaderStyle.tappableStyle`.
* Add `FHeaderActionStyle.tappableStyle`.
* Add `FLineCalendarStyle.tappableStyle`.
* Add `FPaginationStyle.tappableStyle`.
* Add `FTileStyle.tappableStyle`.

* Add `FTappable.statesController`.
* Add `FTappableStyle.cursor`.
* **Breaking** Rename `FTappable` to `FTappable.static`.
* **Breaking** Rename `FTappable.animated` to `FTappable`.
* **Breaking** Split `FTappableData.hovered` into `FTappableData.hovered` and `FTappableData.pressed`.
* Fix `FTappable`'s animation sometimes being invoked after it is unmounted.


### Semantics Labels

We previously used both `semanticsLabel` and `semanticLabel` interchangeably throughout the library. All `semanticLabel`s
have been renamed to `semanticsLabel` for consistency.

* **Breaking** Rename `semanticLabel` to `semanticsLabel` in `FAvatar.new`.
* **Breaking** Rename `semanticLabel` to `semanticsLabel` in `FBreadcrumb.collapsed`.
* **Breaking** Rename `FCheckbox.semanticLabel` to `FCheckbox.semanticsLabel`.
* **Breaking** Rename `FDialog.semanticLabel` to `FDialog.semanticsLabel`.
* **Breaking** Rename `FHeaderAction.semanticLabel` to `FHeaderAction.semanticsLabel`.
* **Breaking** Rename `FPopover.semanticLabel` to `FPopover.semanticsLabel`.
* **Breaking** Rename `FPopoverMenu.semanticLabel` to `FPopoverMenu.semanticsLabel`.
* **Breaking** Rename `FRadio.semanticLabel` to `FRadio.semanticsLabel`.
* **Breaking** Rename `FSelectGroupItem.semanticLabel` to `FSelectGroupItem.semanticsLabel`.
* **Breaking** Rename `FSelectMenuTile.semanticLabel` to `FSelectMenuTile.semanticsLabel`.
* **Breaking** Rename `FSelectTile.semanticLabel` to `FSelectTile.semanticsLabel`.
* **Breaking** Rename `FSelectTileGroup.semanticLabel` to `FSelectTileGroup.semanticsLabel`.
* **Breaking** Rename `FSwitch.semanticLabel` to `FSwitch.semanticsLabel`.
* **Breaking** Rename `FTappable.semanticLabel` to `FTappable.semanticsLabel`.
* **Breaking** Rename `FTile.semanticLabel` to `FTile.semanticsLabel`.
* **Breaking** Rename `FTileGroup.semanticLabel` to `FTileGroup.semanticsLabel`.


### Others
* Add `FTextField.obscuringCharacter`. Thanks @MrHeer!
* Add `FTextField.filled` and `FTextField.fillColor`. Thanks @MrHeer!
* Add `FDateField.builder`.
* Add `FTimeField.builder`.
* Add `FLerpBorderRadius`.

* **Breaking** Change `FAccordion.items` to `FAccordion.children`.
* **Breaking** Change `FBadge(label: ...)` to `FBadge(child: ...)`.
* **Breaking** Change `FButton(label: ...)` to `FBadge(child: ...)`.
* **Breaking** Change `FSelectGroup(items: ...)` to `FBadge(children: ...)`.
* **Breaking** Change `FTabs(tabs: ...)` to `FTabs(children: ...)`.
* **Breaking** Change `FTabEntry(content: ...)` to `FTabEntry(child: ...)`.
* **Breaking** Change `FScaffold(content: ...)` to `FScaffold(child: ...)`.

* Replace `FSelectGroupItem` with `FCheckbox.grouped(...)` and `FRadio.grouped(...)`.

* Fix `FDialog` not handling infinitely sized body correctly.
* Fix `FHeader` spacing appearing in incorrect order.
* Fix `FResizable` not guarding against precision errors in assertions.
* Fix `FSelectGroup` not setting its `FormField`'s initial value.
* Fix `FSelectTileGroup` not setting its `FormField`'s initial value.
* Fix `FSlider` not setting its `FormField`'s initial value.
* Fix `FTextField` not setting its `FormField`'s initial value.


## 0.10.0+1

Fix bad build caused by generated files not being published.


## 0.10.0

### Additions

* Add `FTextField.counterBuilder`.
* Add `FTransformable`.
* Add `FTransformables`.
* Add `FTextField.clearable`.
* Add `FTextField.stylusHandwritingEnabled`.
* Add `FPickerWheelMixin`.
* Add `FTimeField`.
* Add `FTimeFieldController`.
* Add `FTimeFieldProperties`.
* Add `FThemeData.toApproximateMaterialTheme()`.
* Add `FTimePicker`.
* Add `FTimePickerStyle`.
* Add `FPickerStyle.selectionHeightAdjustment`.
* Add `FDateField.clearable`.
* Add `FTileGroup.physics`.
* Add `FSelectTileGroup.physics`.
* Add `FSelectMenuTile.physics`.
* Add `FPagination`.

### Changes

* Change all widget styles to use code generated functions.
* Change spacing between `FDateField`'s default prefix icon and content.
* Change most occurrences of `Alignment` to `AlignmentGeometry`.
* Change most occurrences of `BorderRadius` to `BorderRadiusGeometry`.
* Change most occurrences of `EdgeInsets` to `EdgeInsetsGeometry`.
* **Breaking** Rename `FDatePicker` to `FDateField`.
* **Breaking** Rename `FDatePickerController` to `FDateFieldController`.
* **Breaking** Rename `FDatePickerController.calendar` to `FDateFieldController.popover`.
* **Breaking** Rename `FDatePickerCalendarProperties` to `FDateFieldCalendarProperties`.
* **Breaking** Rename `FLocalizations.datePickerHint` to `FLocalizations.dateFieldHint`.
* **Breaking** Rename `FLocalizations.datePickerInvalidDateError` to `FLocalizations.dateFieldInvalidDateError`.
* **Breaking** Change `FThemeData(...)` to automatically configure styles not passed in.
* **Breaking** Remove `FThemeData.inherit`. Use `FThemeData(...)` instead.
* **Breaking** Remove FTextField.scribbleEnabled. Use `stylusHandwritingEnabled` instead.
* **Breaking** Change `FDialogContentStyle.actionPadding` to `FDialogContentStyle.actionSpacing`.
* **Breaking** Change default `FPickerStyle.textStyle` size from `lg` to `base`.
* **Breaking** Change `FTimePicker` to use `FTimePickerStyle` instead of `FPickerStyle`.
* **Breaking** Rename `FLocalizations.sheetLabel` to `FLocalizations.sheetSemanticsLabel`.
* **Breaking** Rename `FBadgeStyle` to `FBaseBadgeStyle`.
* **Breaking** Rename `FBadgeCustomStyle` to `FBadgeStyle`.
* **Breaking** Move constants in `FBaseBadgeStyle` to `FBadgeStyle`.
* **Breaking** Rename `FButtonStyle` to `FBaseButtonStyle`.
* **Breaking** Rename `FButtonCustomStyle` to `FButtonStyle`.
* **Breaking** Move constants in `FBaseButtonStyle` to `FButtonStyle`.


### Fixes
* Fix `FDateField.input` to show default icon.
* Fix `FTab` not updating when using controller to switch tabs.
* Fix `FPicker` incorrectly detecting number of wheels when controller is not given and placeholder is used.
* Fix `FDateField` not handling `bg`, `en`, `sr`, `sr_Latn` and `zu` locales properly.
* Fix `FDateField` not updating when locale changes.
* Fix `FHeader` not respecting `FHeaderStyle.actionSpacing`.


## 0.9.1+1
Fix documentation not publishing.


## 0.9.1

### Changes
* Bump Sugar from 3.1.0 to 4.0.0.

### Fixes
* Fix `FAccordion` disposing passed in controllers.
* Fix `FPicker` incorrectly handling widget updates.
* Fix `FPopover` incorrectly handling widget updates.


## 0.9.0

### Additions

* Add `FDatePicker`.
* Add `FFormProperties`.
* Add `FPagination`.
* Add `FPicker`.
* Add `FPopoverTagRegion`.
* Add `FBreadcrumb`.
* Add `FTextField.builder`.
* Add `FTextField.onTap`.
* Add `FTextField.onTapAlwaysCalled`.
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
