## 0.16.0 (Next)

### Better Generated Documentation

We've improved the styles' generated documentation. They should be much easier to navigate and understand.


### `FAccordion`
* Add `FAccordionMotion`.

* **Breaking** Move animation related fields from `FAccordionStyle` to `FAccordionMoton`.


### `FAutocomplete`
* Add `FAutocomplete.onReset`.
* Add `FAutocompletController(popoverMotion: ...)`.

* **Breaking** Change `FAutocompleteContentStyle.loadingIndicatorStyle` to `FAutocompleteContentStyle.progressStyle`.


### `FCheckbox`
* Add `FCheckboxMotion`.

* **Breaking** Move animation related fields from `FCheckboxStyle` to `FCheckboxMotion`.
* Fix `FCheckbox` flickering when rapidly hovering.


### `FDateField`
* Add `FDateField.onReset`.

* **Breaking** Replace `FDateFieldController(animationDuration: ...)` with `FDateFieldController(popoverMotion: ...)`.


### `FDialog`
* Add `FDialogRouteStyle`.
* Add `FDialogRouteMotion`.
* Add `showFDialog(routeStyle: ...)`.
* Add `FDialogMotion`.

* **Breaking** Move barrier related fields from `FDialogStyle` to `FDialogRouteStyle`.
* **Breaking** Move animation related fields from `FDialogStyle` to `FDialogMotion`.

* Fix `FDialog.body` not allowing `ScrollView`s.  


### `FFormField`
* **Breaking** Add `FFormField(onReset: ...)`.
* **Breaking** Add `FFormFieldProperties(onReset: ...)`.


### `FHeader`

* Fix `FHeader(...)` not vertically centering title.
* Fix `FHeader(...)` not respecting RTL locales.
* Fix `FHeader.nested(...)` not vertically centering title.
* Fix `FHeader.nested(...)` not respecting RTL locales.


### `FItem`

* Fix `GestureDetector` being absorbed in focused `FItem`s.


### `FPopover` & `FPopoverMenu`
* Add `FPopoverMotion`.

* Change default animations to be more subtle.
* **Breaking** Replace `FPopoverController(animationDuration: ...)` with `FPopoverController(motion: ...)`.
* **Breaking** Change `FPopoverMenu.hideRegion`'s default value from `FHidePopoverRegion.anywhere` to `FHidePopoverRegion.excludeChild`.


### `FProgress`
We've reworked `FProgress` to be more customizable and easier to use.

* Add `FCircularProgress` which represents indeterminate circular progress.
* Add `FCircularProgressStyle`.
* Add `FInheritedCircularProgressStyle`.
* Add `FDeterminateProgress` which represents determinate linear progress.
* Add `FDeterminateProgressStyle`.

* **Breaking** Change `FProgress` to represent indeterminate linear progress.
* **Breaking** Remove `FProgressStyles`.


### `FRadio`
* Add `FRadioMotion`.

* **Breaking** Move animation related fields from `FRadioStyle` to `FRadioMotion`.


### `FSelect` & `FMultiSelect`
* Add `FSelect.onReset`.
* Add `FMultiSelect.onReset`.

* **Breaking** Rename `FSelectSearchStyle.loadingIndicatorStyle` to `FSelectSearchStyle.progressStyle`.
* **Breaking** Replace `FSelectController(animationDuration: ...)` with `FSelectController(popoverMotion: ...)`.
* **Breaking** Replace `FMultiSelectController(animationDuration: ...)` with `FMultiSelectController(popoverMotion: ...)`.


### `FSelectGroup`
* Add `FSelectGroup.onReset`.


### `FSelectMenuTile`
* Add `FSelectMenuTile.onReset`.


### `FSelectTileGroup`
* Add `FSelectTileGroup.onReset`.


### `FSheet`
* Add `FModalSheetStyle`.
* Add `FPersistentSheetStyle`.
* Add `FSheetMotion`.
* Add `FModalSheetMotion`.
* Add `FPersistentSheetMotion`.
* Add `FModalSheet(onClosing: ...)`.
* Add `FPersistentSheet(onClosing: ...)`.

* **Breaking** Split `FSheetStyle` into `FModalSheetStyle` and `FPersistentSheetStyle`.
* **Breaking** Move animation related fields from `FSheetStyle` to `FSheetMotion`.


### `FSidebar`
* Add `FSidebarItemMotion`.

* **Breaking** Move animation related fields from `FSiderbarItemStyle` to `FSiderbarItemMotion`.


### `FSlider`
* Add `FSlider.onReset`.
* Add `FSliderStyle.tooltipMotion`.


### `FTab`
* Add `FTabMotion`.
* **Breaking** Replace `FTabController(animationDuration: ...)` with `FTabController(motion: ...)`.


### `FTappable`
* Add `FTappableMotion`.

* **Breaking** Move animation related fields from `FTappableStyle` to `FTappableMotion`.


### `FTextField` & `FTextFormField`
We've added a password visibility toggle to password fields.

* Add password visibility toggle to `FTextField.password(...)`.
* Add password visibility toggle to `FTextFormField.password(...)`.
* Add `FTextFormField.onReset`.


### `FThemeData`
We've added support for animated theme transitions. This should make transitions between themes gradual instead of abrupt.

* Add `FThemeData.lerp(...)`.

* Change `FThemeData.copyWith(...)` to accept style builder functions.


### `FTimeField`
* Add `FTimeField.onReset`.

* **Breaking** Replace `FTimeFieldController(animationDuration: ...)` with `FTimeFieldController(popoverMotion: ...)`.


### `FToast`
* Add `FToastMotion`.
* Add `FToasterMotion`.

* Change animation to be more subtle.
* **Breaking** Move animation related fields from `FToastStyle` to `FToastMotion`.
* **Breaking** Move animation related fields from `FToasterStyle` to `FToasterMotion`.

* Remove no-op `FToast.onDismiss` parameter that was accidentally included.


### `FTooltip`
* Add `FTooltipMotion`.

* **Breaking** Replace `FTooltipController(animationDuration: ...)` with `FTooltipController(motion: ...)`.


### `FWidgetStateMap`
* Add `FWidgetStateMap.lerpBoxDecoration(...)`.
* Add `FWidgetStateMap.lerpColor(...)`.
* Add `FWidgetStateMap.lerpIconThemeData(...)`.
* Add `FWidgetStateMap.lerpTextStyle(...)`.
* Add `FWidgetStateMap.lerpWhere(...)`.


### `FToaster`
* Add `FToaster.of(...)`.

* Make `FToasterState.show(context: ...)` optional.


## Others
* Add `FImmutableTween`.
* Add `FLabel.expands`.

* Fix `FTextField.expands` causing a render error.


## 0.15.1
* Fix CLI generating incorrect icon mappings.
* Fix CLI generating theme that references private constant.


## 0.15.0

### Cursors
We've changed the default cursor for many widgets from `MouseCursor.click` to `MouseCursor.defer`. This is in line with 
[native desktop behavior](https://medium.com/simple-human/buttons-shouldnt-have-a-hand-cursor-b11e99ca374b) and [W3C User Interface guidelines](https://www.w3.org/TR/css-ui-3/#valdef-cursor-pointer).


### `FThemeData`
Hover colors now use lightness-based adjustments rather than alpha blending, providing better visual feedback across all 
color variants, especially `FColors.secondary`.

We've also added support for theme extensions. This allows you to add custom application-specific properties to the theme 
without having to manage them around separately.

* Add `FThemeData.extension()`.
* Add `FThemeData.extensions`.

* Remove `foreground` parameter from `FColors.hover(...)`.


### `FAccordion`
* Add `FAccordionItem.onHoverChange`
* Add `FAccordionItem.onStateChange`

* **Breaking** Make `FAccordionController.controllers` private.
* **Breaking** Change `FAccordionItem.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.
* **Breaking** Remove `FAccordionController.radio(...)` - use `FAccrdionController(max: 1)` instead.
* **Breaking** Remove `FAccordionController.validate(...)`.


### `FAutocomplete` (new)
* Add `FAutocomplete`.
* Add `FAutocompleteController`.
* Add `FAutocompleteStyle`.
* Add `FAutocompleteSection`.
* Add `FAutocompleteItem`.


### `FBottomNavigationBar`
* **Breaking** Change `FBottomNavigationBarItem.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FButton`
* **Breaking** Change `FButton.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FBreadcrumb`
* Add `onTapHide` to `FBreadcrumb.collapsed(...)`.

* **Breaking** Change `FBreadcrumb.hideOnTapOutside` to `FBreadcrumb.hideRegion`.


### `FDateField`
* Add `onTapHide` to `FDateField.calendar(...)`.
* Add `FDateFieldCalendarProperties.onTapHide`.

* **Breaking** Change `FDateField.hideOnTapOutside` to `FDateField.hideRegion`.
* **Breaking** Change `FDateField.builder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldBuilder<FDateFieldStyle>`.
* **Breaking** Change `FDateField.prefixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FDateFieldStyle>`.
* **Breaking** Change `FDateField.suffixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FDateFieldStyle>`.


### `FHeader`
* **Breaking** Change `FHeaderAction.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FItem`
* **Breaking** Change `FItem.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.



### `FMultiSelect` (new)
* Add `FMultiSelect`.
* Add `FMultiSelectController`.
* Add `FMultiSelectStyle`.
* Add `FMultiSelectTag`.


### `FPopover` & `FPopoverMenu`
* Add `FPopover.onTapHide`.
* Add `FPopoverMenu.onTapHide`.

* **Breaking** Change `FPopover.hideOnTapOutside` to `FPopover.hideRegion`.
* **Breaking** Change `FPopoverMenu.hideOnTapOutside` to `FPopoverMenu.hideRegion`.
* **Breaking** Change `FHidePopoverRegion` to `FPopoverHideRegion`.
* **Breaking** Change `FHidePopoverRegion.excludeTarget` to `FHidePopoverRegion.excludeChild`.


### `FSelect`
We've done an overhaul of `FSelect` to make it more consistent and easier to use.

* Add `FSelect.contentEmptyBuilder`.
* Add `FSelectItem.raw(...)`

* Change `FSelect`'s vertical padding for default loading and empty indicators to be the same height.
* **Breaking** Rename `FSelect.divider` to `FSelect.contentDivider`.
* **Breaking** Replace `FSelect.hideOnTapOutside` with `FSelect.hideRegion`.
* **Breaking** Change `FSelect.builder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldBuilder<FTextFieldStyle>`.
* **Breaking** Change `FSelect.prefixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> prefixBuilder`.
* **Breaking** Change `FSelect.suffixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> suffixBuilder`.
* **Breaking** Change `FSelectSearchFieldProperties.builder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldBuilder<FTextFieldStyle>`.
* **Breaking** Change `FSelectSearchFieldProperties.prefixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> prefixBuilder`.
* **Breaking** Change `FSelectSearchFieldProperties.suffixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> suffixBuilder`.
* Change `FSelectSearchContentBuilder` from `List<FSelectItemMixin> Function(BuildContext context, FSelectSearchData<T> data);`
  to `List<FSelectItemMixin> Function(BuildContext context, String query, Iterable<T> values)`.
* **Breaking** Remove `FSelectSearchFilter<T>` typedef - use the literal function signature instead.
* **Breaking** Remove `FSelectSearchData<T>` typedef.
* **Breaking** Replace `FSelect.emptyBuilder` with `FSelect.contentEmptyBuilder`.
* **Breaking** Replace `FSelect.searchLoadingBuilder` with `FSelect.contentLoadingBuilder`.
* **Breaking** Replace `FSelect.searchErrorBuilder` with `FSelect.contentErrorBuilder`.
* **Breaking** Replace `FSelect.defaultEmptyBuilder` with `FSelect.defaultContentEmptyBuilder`.
* **Breaking** Replace `FSelect.defaultSearchLoadingBuilder` with `FSelect.defaultContentLoadingBuilder`.
* **Breaking** Replace `FSelect.fromMap(...)` with `FSelectSection.new(...)`.
* **Breaking** Replace `FSelect(...)` with `FSelectSection.rich(...)`.
* **Breaking** Replace `FSelect.searchFromMap(...)` with `FSelectSection.search(...)`.
* **Breaking** Replace `FSelect.search(...)` with `FSelectSection.searchBuilder(...)`.
* **Breaking** Replace `FSelectSection.new(...)` with `FSelectSection.rich(...)`
* **Breaking** Replace `FSelectSection.fromMap(...)` with `FSelectSection.new(...)`.
* **Breaking** Change `FSelectItem(...)`'s parameters to no longer accept string parameter.
* **Breaking** Change `FSelectItem.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.
* **Breaking** Replace `FSelectItemStyle` with underlying `FItemStyle`.

* Fix first focused item not unfocusing when other items are pressed on touch devices.


### `FSelectMenuTile`
* Add `FSelectMenuTile.onTapHide`.

* **Breaking** Change `FSelectMenuTile.hideOnTapOutside` to `FSelectMenuTile.hideRegion`.


### `FSelectTileGroup`
* **Breaking** Change `FSelectTile.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FSidebar`
* **Breaking** Change `FSidebarGroup.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.
* **Breaking** Change `FSidebarItem.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FTappable`
* **Breaking** Change `FTappable.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FTextField` & `FTextFormField`
* Add `FFieldBuilder.`
* Add `FFieldIconBuilder.
* Add `FTextField.selectAllOnFocus`.
* Add `FTextFormField.selectAllOnFocus`.

* **Breaking** Change `FTextField.builder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to 
  `FFieldBuilder<FTextFieldStyle>`.
* **Breaking** Change `FTextField.prefixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> prefixBuilder`.
* **Breaking** Change `FTextField.suffixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> suffixBuilder`.
* **Breaking** Change `FTextFormField.builder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldBuilder<FTextFieldStyle>`.
* **Breaking** Change `FTextFormField.prefixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> prefixBuilder`.
* **Breaking** Change `FTextFormField.suffixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FTextFieldStyle> suffixBuilder`.


### `FTile`
* **Breaking** Change `FTile.onStateChange` from `ValueChanged<Set<WidgetState>>` to `ValueChanged<FWidgetStatesDelta>`.


### `FTimeField`
* Add `onTapHide` to `FTimeField.picker(...)`.

* **Breaking** Change `FTimeField.hideOnTapOutside` to `FTimeField.hideRegion`.
* **Breaking** Change `FTimeField.builder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldBuilder<FDateFieldStyle>`.
* **Breaking** Change `FTimeField.prefixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FDateFieldStyle>`.
* **Breaking** Change `FTimeField.suffixBuilder` from `ValueWidgetBuilder<(FTextFieldStyle, Set<WidgetState>)>` to
  `FFieldIconBuilder<FDateFieldStyle>`.

* Fix regression in Flutter 3.35.2 by reducing `FTextFieldStyle.contentPadding` from `EdgeInsets.symmetric(horizontal: 14, vertical: 10)` 
  to `EdgeInsets.symmetric(horizontal: 10, vertical: 10)`.


### Others
* Add `FSelectMenuTile.onTapHide`.
* Add `FTypeaheadController`.
* Add `FWidgetStatesDelta`.

* Change `FMultiValueNotifier` to be non-abstract.
* **Breaking** Change `FMultiValueNotifier.radio({T? value})` to `FMultiValueNotifier.radio([T? value])`.
* **Breaking** Change `ValueWidgetBuilder<FToasterEntry>? suffixBuilder` to `Widget Function(BuildContext, FToasterEntry)? suffixBuilder` 
  in `showFToast(...)`.

* Fix `FProgress.circularIcon()` using incorrect color.
* Fix `FScaffold` not propagating `IconTheme` from `FStyle.iconStyle`.
* Fix `FSelectGroup` throwing a duplicate error when rapidly hovering over several `FCheckbox`es. 
* Fix `FTabs` throwing an assertion error if `FTabController` is provided with a `initialIndex` > 0.


## 0.14.1
* Fix `FToaster`sometimes crashing due to an incorrect update of a late final variable.


## 0.14.0

### `FButton`
* Add `FButton.onSecondaryPress`.
* Add `FButton.onSecondaryLongPress`.


### `FHeaderAction`
* Add `FHeaderAction.onSecondaryPress`.
* Add `FHeaderAction.onSecondaryLongPress`.
* Add `FHeaderAction.actions`.
* Add `FHeaderAction.shortcuts`.


### `FItemData` 

* **Breaking** Change `FItemData` to store fields in separate data class instead of directly in an inherited widget.
* **Breaking** Rename `FItemData` to `FInheritedItemData`.


### `FPopover`
* **Breaking** Change `FPopoverController.shown` to `FPopoverController.status`.

* Fix `FPopover` not respecting `FPopover.traversalEdgeBehavior`.


### `FSelect`
* Change `FSelect`'s default popover animation duration from `50ms` to `100ms`.
* Change `FSelect.anchor`'s default value from `Alignment.topLeft` to `AlignmentDirectional.topStart`.
* Change `FSelect.fieldAnchor`'s default value from `Alignment.bottomLeft` to `AlignmentDirectional.bottomStart`.

* Fix `FSelect` flickering when selecting an item on desktop.
* Fix `FSelect` not scrolling to selected item when opened if the item is really far down the list.
* Fix `FSelect` layout shifting when scrolling through a long list of items.


### `FSelectMenuTile`
* Add `FSelectMenuTile.fromMap(...)`.

* Fix `FSelectMenuTile` throwing an error when wrapped in a `FTileGroup`.


### `FSidebar`
* Add `FSidebar.focusNode`.
* Add `FSidebar.traversalEdgeBehavior`.

* Change `FSidebarItemStyle.focusedOutlineStyle.spacing` from 3 to 0.

* Fix `FSidebar`'s focus traversal behavior.


### `FTappable`
* Add `FTappable.onSecondaryPress`.
* Add `FTappable.onSecondaryLongPress`.


### `FTile`
* Add `FTile.onSecondaryPress`.
* Add `FTile.onSecondaryLongPress`.


### Others
* Add `FToasterStyle.toastAlignment`.

* Change default `hideOnTapOutside` in `FDateField.calendar(...)` from `FHidePopoverRegion.anywhere` to `FHidePopoverRegion.excludeTarget`.
* Change default `hideOnTapOutside` in `FTimeField.picker(...)` from `FHidePopoverRegion.anywhere` to `FHidePopoverRegion.excludeTarget`.
* **Breaking** Change `FPersistentSheetController.shown` to `FPersistentSheetController.status`.
* **Breaking** Change `FTooltipController.shown` to `FTooltipController.status`.

* Fix `FPopoverMenu` throwing an error when wrapped in a `FTileGroup`.
* Fix `FTextField` applying different padding on mobile & desktop.


## 0.13.1

* Fix `FSelectTile` mixing in `FItemMixin` instead of `FTileMixin`.
* Fix `FSelectMenuTile` mixing in `FItemMixin` instead of `FTileMixin`.


## 0.13.0
This update focuses on polishing & improving the usability of existing widgets.

### Animations
We've updated the animations in Forui to feel more nature and be origin aware. This should make the animations feel more
polished.

### Blur & glassmorphic support
We've updated most overlay widgets to support background blur & glassmorphic styles. This is disabled by default. It can
be enabled by setting a `barrierFilter` & `backgroundFilter` in the widget's style.

### Styles
We've updated styles to be easier to configure and use without the CLI. All widgets now accept a style builder function
rather than a style object. Similarly, all nested styles inside styles have been replaced with style builder functions.
This makes it easier to customize styles based on the existing styles.

Previously:
```dart
FFCheckbox(
  style: context.theme.checkBoxStyle.copyWith(
    tappableStyle: context.theme.checkBoxStyle.copyWith(...),
  ),
);
```

Now:
```dart
FFCheckbox(
  style: (style) => style.copyWith(
    tappableStyle: (style) => style.copyWith(...),
  ),
);
```

In most cases, this is **not** a breaking change. Styles have been updated to implement the `call` function. This means
that you can still pass in a style object as before.
```dart
// Long-form
FFCheckbox(
  style: (style) => FCheckBoxStyle(...),
);

// Short-form
FFCheckbox(
  style: FCheckBoxStyle(...),
);
```


### `FThemeData`
* Add `FColors.systemOverlayStyle`.


### `FAccordion`
* Add `FAccordionItemStyle.expandDuration`.
* Add `FAccordionItemStyle.expandCurve`.
* Add `FAccordionItemStyle.collapseDuration`.
* Add `FAccordionItemStyle.collapseCurve`.

* Refine `FAccordion`'s collapsible animation.
* **Breaking** Change `FAccordionStyle.iconStyle`'s default icon color from `primary` to `mutedForeground`.
* **Breaking** Remove `FAccordionItemStyle.animationDuration` - use `FAccordionItemStyle.expandDuration` instead.


### `FAlert`
* **Breaking** Change `FAlertStyle.primary`'s signature - pass `FAlertStyle.primary()` instead of `FAlert.primary` to `FAlert`.
* **Breaking** Change `FAlertStyle.destructive`'s signature - pass `FAlertStyle.destructive()` instead of `FAlert.destructive` to `FAlert`.


### `FBadge`
* **Breaking** Change `FBadgeStyle.primary`'s signature - pass `FBadgeStyle.primary()` instead of `FBadgeStyle.primary` to `FBadgeStyle`.
* **Breaking** Change `FBadgeStyle.secondary`'s signature - pass `FBadgeStyle.secondary()` instead of `FBadgeStyle.secondary` to `FBadgeStyle`.
* **Breaking** Change `FBadgeStyle.destructive`'s signature - pass `FBadgeStyle.destructive()` instead of `FBadgeStyle.destructive` to `FBadgeStyle`.
* **Breaking** Change `FBadgeStyle.outline`'s signature - pass `FBadgeStyle.outline()` instead of `FBadgeStyle.outline` to `FBadgeStyle`.


### `FBottomNavigationBar`
* Add `FBottomNavigationBarStyle.backgroundFilter`.


### `FBreadcrumb`
We've added support for an alternative popover menu which uses `FItem` and more closely resembles Shadcn/ui's popover
menu suited for desktop.

* Add `FBreadcrumbItem.collapsedTiles(...)`.

* **Breaking** Change `FBreadcrumbItem.collapsed` to use `FItem` instead of `FTile` - use `FBreadcrumb.collapsedTiles(...)`
  instead.


### `FButton`
* Add `FButton.actions`.
* Add `FButton.shortcuts`.
* Add `mainAxisAlignment` to `FButton(...)`.
* Add `crossAxisAlignment` to `FButton(...)`.
* Add `textBaseline` to `FButton(...)`.
* Add `FButtonContentStyle.spacing`.

* **Breaking** Change `instrinicWidth` in `FButton(...)` to `mainAxisSize`.
* **Breaking** Change `FButtonStyle.primary`'s signature - pass `FButtonStyle.primary()` instead of `FButtonStyle.primary` to `FButtonStyle`.
* **Breaking** Change `FButtonStyle.secondary`'s signature - pass `FButtonStyle.secondary()` instead of `FButtonStyle.secondary` to `FButtonStyle`.
* **Breaking** Change `FButtonStyle.destructive`'s signature - pass `FButtonStyle.destructive()` instead of `FButtonStyle.destructive` to `FButtonStyle`.
* **Breaking** Change `FButtonStyle.outline`'s signature - pass `FButtonStyle.outline()` instead of `FButtonStyle.outline` to `FButtonStyle`.
* **Breaking** Change `FButtonStyle.ghost`'s signature - pass `FButtonStyle.ghost()` instead of `FButtonStyle.ghost` to `FButtonStyle`.


### `FDialog`
* Add `showFDialog`.
* Add `FDialog.animation`.
* Add `FDialogRoute`.
* Add `FDialogStyle.barrierFilter`.
* Add `FDialogStyle.backgroundFilter`.
* Add `FDialogStyle.entranceExitDuration`.
* Add `FDialogStyle.entranceCurve`.
* Add `FDialogStyle.exitCurve`.
* Add `FDialogStyle.fadeTween`.
* Add `FDialogStyle.scaleTween`.


### `FHeader`
* Add `FHeaderStyle.backgroundFilter`.
* Add `FHeaderStyle.decoration`.


### `FItem` (new)
An `FItem` is typically used to group related information together. It is a more generic version of `FTile` that is used
to build more complex widgets.

* Add `FItem`.
* Add `FItemData`.
* Add `FItemDivider`.
* Add `FItemGroup`.
* Add `FItemStyle`.
* Add `FItemContentStyle`.


### `FPopover`
* Add `FPopover.barrierSemanticsLabel`.
* Add `FPopover.barrierSemanticsDismissible`.
* Add `FPopover.builder`.
* Add `FPopoverStyle.barrierFilter`.
* Add `FPopoverStyle.backgroundFilter`.

* Change `FPopover`'s animation to be origin aware.
* Change `FPopover(...)`'s `controller` to be optional.
* **Breaking** Change `FPopover.hideOnTapOutside` default value from `FHidePopoverRegion.anywhere` to 
  `FHidePopoverRegion.excludeTarget`.
* **Breaking** Change `FPopover.popoverBuilder`'s signature from `ValueWidgetBuilder<FPopoverStyle>` to 
  `Widget Function(BuildContext, FPopoverController)`.
* **Breaking** Remove `FPopover.automatic` - This was a bad abstraction in hindsight, use `FPopover.new` instead.


### `FPopoverMenu`
We've added support for an alternative popover menu which uses `FItem` and more closely resembles Shadcn/ui's popover
menu suited for desktop.

* Add `FPopoverMenu.tiles(...)`
* Add `FPopoverMenu.barrierSemanticsLabel`.
* Add `FPopoverMenu.barrierSemanticsDismissible`.
* Add `FPopoverMenu.builder`.
* Add `FPopoverMenu.menuBuilder`.

* Change `FPopoverMenu`'s animation to be origin aware.
* Change `FPopoverMenu(...)`'s `controller` to be optional.
* **Breaking** Remove `FPopoverMenu.automatic` - This was a bad abstraction in hindsight, use `FPopoverMenu.new` instead.
* **Breaking** Change `FPopoverMenu(...)` to use `FItem`s instead of `FTile`s - use `FPopoverMenu.tiles(...)` instead.


### `FPortal`
* Add `FPortal.barrier`.
* Add `FPortal.builder(...)`.

* Change `FPortal.controller` to be optional.
* **Breaking** Change `FPortal.portalBuilder`'s signature from `WidgetBuilder` to 
  `Widget Function(BuildContext, FPortalController)`.

### `FSelect`
We've updated `FSelect` to support dividers & `FSelectItem` to support prefixes & subtitles.

* Add `FSelect.divider`.
* Add `FSelectSection.divider`.
* Add `FSelectItem.prefix`.
* Add `FSelectItem.subtitle`.
* Add `FSelectItemStyle.prefixIconStyle`.
* Add `FSelectItemStyle.prefixIconSpacing`.
* Add `FSelectItemStyle.titleSpacing`
* Add `FSelectItemStyle.subtitleStyle`.

* **Breaking** Rename `FSelectItem.child` to `FSelectItem.title`.
* **Breaking** Rename `FSelectItemStyle.textStyle` to `FSelectItem.titleTextStyle`.
* **Breaking** Rename `FSelectItemStyle.iconStyle` to `FSelectItem.suffixIconStyle`.

* Fix `FSelect.search(...)` always focusing on 1st item even when there is a selected item.
* Fix `FSelect.search(...)` expanding items unnecessarily.


### `FSelectMenuTile`
* Add `FSelectMenuTile.actions`.
* Add `FSelectMenuTile.barrierSemanticsLabel`.
* Add `FSelectMenuTile.barrierSemanticsDismissible`.
* Add `FSelectMenuTile.detailsBuilder`.
* Add `FSelectMenuTile.shortcuts`.

* Change `FSelectMenuTile.selectController` to be optional.


### `FSheet`
* Change `FSSheet`'s transition animation.
* **Breaking** Change `FSheetStyle.barrierColor` to `FSheetStyle.barrierFilter`.
* **Breaking** Remove `FSheetStyle.backgroundColor`.


### `FSidebar`
* Add `FSidebarStyle.backgroundFilter`.
* Add `FSidebarStyle.decoration`.
* Add `FSidebarItemStyle.expandDuration`.
* Add `FSidebarItemStyle.expandCurve`.
* Add `FSidebarItemStyle.collapseDuration`.
* Add `FSidebarItemStyle.collapseCurve`.

* Refine `FSidebar`'s collapsible animation.
* **Breaking** Change `FSidebar` to not bounce.
* **Breaking** Change `FSidebar.child` to be non-nullable.
* **Breaking** Change `FSidebarStyle.width` to `FSidebarStyle.constraints`.
* **Breaking** Remove `FSidebarStyle.bordeColor` - use `FSidebarStyle.decoration` instead.
* **Breaking** Remove `FSidebarStyle.bordeWidth` - use `FSidebarStyle.decoration` instead.
* **Breaking** Remove `FSidebarItemStyle.collapsibleAnimationDuration` - use `FSidebarItemStyle.expandDuration` instead.

* Fix `FSidebarItem`'s style not updating when passed in style changes.


### `FTappable`
* Add `FTappable.actions`.
* Add `FTappable.shortcuts`.
* Add `FTappableStyle.bounceDuration`.
* Add `FTappableStyle.bounceDownCurve`.
* Add `FTappableStyle.bounceUpCurve`.

* **Breaking** Rename `FTappableStyle.animationTween` to `FTappableStyle.bounceTween`.
* **Breaking** Remove `FTappableAnimations` - use `FTappableStyle.defaultBounceTween` and `FTappableStyle.noBounceTween`
  instead.


### `FTile`
We have refactored `FTile`'s implementation to be simpler & its styling to be easier to understand & use. It now uses
`FItem` internally.

* Add `FTile.actions`.
* Add `FTile.shortcuts`.
* Add `FTile.raw(...)`.
* Add `FTileGroupStyle.border`.
* Add `FTileGroupStyle.divierColor`.
* Add `FTileGroupStyle.dividerWidth`.

* **Breaking** Change `FTileGroup` to render the border even if it contains no groups/tiles - while this isn't desirable
  this allows us to draw the border in a single pass rather than having each tile draw its part of the border and stitching
  the results.
* **Breaking** Change `FTile` to default to `FThemeData.tileStyle` instead of `FThemeData.tileGroupStyle.tileStyle` when
  `FTile` is not inside a `FTileGroup`.
* **Breaking** Remove `FTileGroupStyle.borderColor` - use `FTileGroupStyle.border` instead.
* **Breaking** Remove `FTileGroupStyle.borderWidth` - use `FTileGroupStyle.border` instead.
* **Breaking** Change `prefixIcon` to `prefix` in FTile(...)`.
* **Breaking** Change `suffixIcon` to `suffix` in FTile(...)`.
* **Breaking** Change `FTile` to ignore `WidgetState`s when neither `onPress` nor `orLongPress` is given.
* Change `FTile`'s focused outline to be a rounded rectangle even if the tile is inside a `FTileGroup`.
* Change `FTile` to no longer wrap its content inside a `FTileData` if it is not part of a `FTileGroup`.
* **Breaking** Remove `FTileDivider` - use `FItemDivider` instead.
* **Breaking** Remove `FTileData` - use `FItemData` instead.
* **Breaking** Remove `FTileGroupData` - use `FItemData`s instead.
* **Breaking** Change `FTileStyle` to extend `FItemStyle`.
* **Breaking** Remove `FTileStateStyle`.
* **Breaking** Remove `FTileStateStyle.backgroundColor` - use `FTileStyle.decoration` instead.
* **Breaking** Remove `FTileStateStyle.borderColor` - use `FTileStyle.decoration` instead.
* **Breaking** Remove `FTileStateStyle.borderRadius` - use `FTileStyle.decoration` instead.

* Fix `FTileGroup.merge(...)` ignoring `physics` property.
* Fix `FTile`'s focused outline being drawn even when explicitly disabled.


### `FToast`
We've made toasts dismissable by swiping.

* Add `swipeToDismiss` to `showFToast(...)`.
* Add `swipeToDismiss` to `showRawFToast(...)`.
* Add `FToastStyle.backgroundFilter`.
* Add `FToasterStyle.swipeCompletionDuration`.
* Add `FToasterStyle.swipeCompletionCurve`.

* Fix `FToaster` auto-dismissing when hovering over non-first toast when expanded.
* Fix `FToaster` expanded state persisting after all toasts has been dismissed on touch devices.
* Fix `showFToast` & `showRawFToast` not using custom style passed to `FToaster`.


### `FTooltip`
* Add `FTooltip.builder`.
* Add `FTooltipStyle.backgroundFilter`.

* **Breaking** Replace `FTooltipStyle.margin` with `FTooltip.spacing`.
* **Breaking** Change `FTooltip.tipBuilder`'s signature from `ValueWidgetBuilder<FTooltipStyle>` to
  `Widget Function(BuildContext, FTooltipController)`.
* Change `FTooltip`'s animation to be origin aware.


### `FScaffold`
* Add `FScaffold.toasterSwipeToDismiss`.
* Add `FScaffold.systemOverlayStyle`.


### `FSelectMenuTile`
* **Breaking** Change `FSelectMenuTile.prefixIcon` to `FSelectMenuTile.suffix`.
* **Breaking** Change `FSelectMenuTile.suffixIcon` to `FSelectMenuTile.suffix`.


### `FSelectTile`
* **Breaking** Change `prefixIcon` to `prefix` in FSelectTile.suffix(...)`.
* **Breaking** Change `suffixIcon` to `suffix` in FSelectTile(...)`.


### Others
* Add `FAnimatedModalBarrier`.
* Add `FModalBarrier`.
* Add `FPaginationStyle.focusedOutlineStyle`.
* Add `FLocalizations.popoverSemanticsLabel`.
* Add `FSelectTile.actions`.
* Add `FSelectTile.shortcuts`.

* **Breaking** Remove `defaultFontFamily` from `FTypography.copyWith(...)`.
* **Breaking** Change `FSelectTileGroup.divider` from `FTileDivider` to `FItemDivider`.
* **Breaking** Change `FSelectMenuTile.autoHide` default value from `false` to `true`.
* **Breaking** Change `FSelectMenuTile.divider` from `FTileDivider` to `FItemDivider`.
* **Breaking** Remove `FTransformable`.

* Fix `FTappable` persisting pressed effect even after pointer is moved outside the widget.
* Fix `FTextFormField` not passing correct value to validator when no controller is provided.


## 0.12.0

Bumps minimum Flutter SDK version to 3.32.0.

### CLI

* Add `icon-mapping` snippet.

* **Breaking** Improve how style aliases are generated - Certain style aliases may be removed or renamed.

* Fix style suggestions always displaying actual style name instead of alias.


### `FCollapsible` (new)
A widget that collapses and expands its child.

* Add `FCollapsible`.


### `FDateField`

* Enhance `FDateField.calendar`'s focus management.

* Fix `FDateField` not closing calendar popover when enter is pressed.


### `FScaffold`

* Add `FScaffold.sidebar`.
* add `FScaffold.toasterSwipeToDismiss`.
* Add `FScaffoldStyle.sidebarBackgroundColor`.


### `FSelect`

* Add `FSelect.searchFromMap(...)`.
* Add `FSelectItem.raw(...)`.
* Add `FSelectSection.fromMap(...)`.

* **Breaking** Change `format` in `FSelect.new(...)` to be required. 
* **Breaking** Change `format` in `FSelect.search(...)` to be required.
* **Breaking** Remove `FSelect.defaultFormat`.
* **Breaking** Change `FSelectItem(...)` to require a String text instead of Widget child.


### `FSidebar` (new)
A sidebar widget that usually resides on the side of the screen for navigation.

* Add `FSidebar`.
* Add `FSidebarGroup`.
* Add `FSidebarItem`.


### `FTextField` & `FTextFormField`

* Add `FTextField.onTapOutside`.
* Add `FTextFormField.onTapOutside`.


### `FToast` & `FToaster` (new)
An optional toast.

* Add `showFToast(...)`.
* Add `showRawFToast(...)`.
* Add `FToast`.
* Add `FToastStyle`.
* Add `FToaster`.
* Add `FToasterEntry`.
* Add `FToasterExpandBehavior`.
* Add `FToasterStyle`.


### Others

* Add `toggleable` parameter to `FCalendarController.date(...)`.
* Add `toggleable` parameter to `FLineCalendar(...)`.
* Add `FPopover.shortcuts`.
* Add `FTabs.onPress`.

* **Breaking** Change `FLineCalendar` to be un-toggleable by default.
* **Breaking** Change `FThemeData.headerStyle` to `FThemeData.headerStyles`.
* Enhance `FSelect`'s focus management.
* Enhance `FTimeField.picker`'s focus management.


## 0.11.1

* Add optional named parameters with their default values to CLI generated styles. 
* Fix `FTileStyle.pressable` not changing background color on press & hold.
* Fix typo in CLI generated styles' documentation.


## 0.11.0

### Styles
We added a CLI to generate styles for Forui widgets. See forui.dev/docs/cli for more information. 

We made several breaking changes to styles and widgets that rely on state styles to improve consistency and usability 
(too many to list sanely). Generally, all styles have been updated to use `WidgetState`s, becoming more customizable and 
concise.

* **Breaking** Rename `FThemeData.colorScheme` to `FThemeData.colors`.
* **Breaking** Rename all `F<Style>.inherit(colorScheme: ...)` to `F<Style>.inherit(colors: ...)`.


### Semantics Labels

Both `semanticsLabel` and `semanticLabel` were used interchangeably throughout the library. All `semanticLabel`s
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


### `FAccordion`

* Add `FAccordionItemMixin`.

* **Breaking** Change `FAccordion.items` to `FAccordion.children`.
* Change `FAccordion.children` from `List<FAccordionItem>` to `List<FAccordionIteMixin`.


### `FBottomNavigationBar`

The tappable logic has been moved from `FBottomNavigationBar` to `FBottomNavigationBarItem` to improve
`FBottomNavigationBarItem`'s usability. Unfortunately, this means that custom navigation items have to implement
`FTappable` on their own moving forward.

* Add `FBottomNavigationBarItem.autofocus`.
* Add `FBottomNavigationBarItem.focusNode`.
* Add `FBottomNavigationBarItem.onFocusChange`.
* Add `FBottomNavigationBarItem.onHoverChange`.
* Add `FBottomNavigationBarItem.onStateChange`.
* Add `FBottomNavigationItemStyle.spacing`.

* **Breaking** Move `FBottomNavigationBarStyle.tappableStyle` to `FBottomNavigationBarItemStyle.tappableStyle`.
* **Breaking** Move `FBottomNavigationBarStyle.focusedOutlineStyle` to `FBottomNavigationBarItemStyle.focusedOutlineStyle`.


### `FButton`

* Add `FButton.onChange`.
* Add `FButton.onHoverChange`.
* Add `FButton.selected`.
* Add `intrinsicWidth` to `FButton(...)`.

* **Breaking** Change `FButton(label: ...)` to `FBadge(child: ...)`.


### `FBreadcrumb`

* Add `traversalEdgeBehavior` to `FBreadcrumbItem.collapsed`.
* Add `autofocus` to `FBreadcrumbItem(...)`.
* Add `focusNode` to `FBreadcrumbItem(...)`.
* Add `onFocusChange` to `FBreadcrumbItem(...)`.
* Add `onHoverChange` to `FBreadcrumbItem(...)`.
* Add `onStateChange` to `FBreadcrumbItem(...)`.
* Add `spacing` to `FBreadcrumbItem.collapsed(...)`. 
* Add `offset` to `FBreadcrumbItem.collapsed(...)`.
* Add `onHoverChange` to `FBreadcrumbItem.collapsed(...)`.
* Add `onStateChange` to `FBreadcrumbItem.collapsed(...)`.
* Add `FBreadcrumbStyle.focusedOutlineStyle`.

* **Breaking** Change `focusNode` from `FocusNode` to `FocusScopeNode` in `FBreadcrumbItem.collapsed`.
* **Breaking** Remove `directionPadding` from `FBreadcrumbItem.collapsed(...)`.


### `FDateField`

* Add `FDateField.builder`.
* Add `FDateField.initialDate`.
* Add `FDateField.onChange`.
* Add `spacing` to `FDateField.calendar(...)`.
* Add `offset` to `FDateField.calendar(...)`.
* Add `spacing` to `FDateField(...)`.
* Add `offset` to `FDateField(...)`.

* **Breaking** Remove `directionalPadding` from `FDateField.calendar(...)`.
* **Breaking** Remove `directionalPadding` from `FDateField(...)`.


### `FDialog`

* **Breaking** Change `FDialog` to not automatically wrap actions in `InstrinicWidth`.
* **Breaking** Change `FDialog` to not automatically wrap body in `IntrinsicWidth`.
* **Breaking** Move `FDialog.insetAnimationDuration` to `FDialogStyle.insetAnimationDuration`.
* **Breaking** Move `FDialog.insetAnimationCurve` to `FDialogStyle.insetAnimationCurve`.
* **Breaking** Combine `FDialogStyle.minWidth` and `FDialogStyle.maxWidth` into `FDialog.constraints.`.
* **Breaking** Combine `FDialogStyle.minWidth` and `FDialogStyle.maxWidth` to `FDialog.constraints.`.

* * Fix `FDialog` not handling infinitely sized body correctly.


### `FHeader`

* Add `FHeaderAction.onHoverChange`.
* Add `FHeaderAction.onStateChange`.
* Add `FHeaderAction.selected`.
* Add `titleAlignment` to `FHeader.nested(...)`. Thanks @a-man-called-q!

* Change `FHeader(title: ...)` to be optional.
* Change `FHeader.nested(title: ...)` to be optional.
* **Breaking** Change `FHeader(actions: ...)` to `FHeader(suffixes: ...)`.
* **Breaking** Change `FHeader(prefixActions: ...)` to `FHeader(prefixes: ...)`.
* **Breaking** Change `FHeader(suffixActions: ...)` to `FHeader(suffixes: ...)`.

* Fix `FHeader` spacing appearing in incorrect order.


### `FIcon` (removed)

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


### `FLineCalendar`

* Add `FLineCalendar.onChange`.
* Add `FLineCalendar.initialSelection`.
* Add `FLineCalendar.physics`.
* Add `FLineCalendar.keyboardDismissBehavior`.
* Change `FLineCalendar.controller` to be optional.
* **Breaking** Rename `FLineCalendar.initialDateAlignment` to `FLineCalendar.initialScrollAlignment`.
* **Breaking** Rename `FLineCalendar.initial` to `FLineCalendar.initialScroll`.


### `FPagination`

* Add `FPagination.initialPage`.
* Add `FPagination.pages`.

* Change `FPagination.controller` to be optional.
* Change `FPagination.onChange` from `VoidCallback?` to `ValueChanged<int>?`
* **Breaking** Change `FPaginationController` to require `pages` parameter.


### `FPopover` & `FPopoverMenu`.
The traversal-edge behavior of `FPopover` and Forui widgets that depend on it have been fixed.

* Add `FPopover.traversalEdgeBehavior`.
* Add `traversalEdgeBehavior` to `FPopoverMenu`.
* Add `FPopover.constraints`.
* Add `FPopover.spacing`.
* Add `FPopover.offset`.
* Add `FPopover.groupId`.
* Add `FPopoverMenu.spacing`.
* Add `FPopoverMenu.offset`.
* Add `FPopoverMenu.groupId`.

* **Breaking** Change `FPopover.focusNode` from `FocusNode` to `FocusScopeNode`.
* **Breaking** Change `FPopoverMenu.focusNode` from `FocusNode` to `FocusScopeNode`.
* **Breaking** Remove `FPopover.directionPadding`.
* **Breaking** Remove `FPopoverMenu.directionPadding`.

* Fix `FPopover` unconditionally calling `FPopoverController.hide()` when tapping outside a `FPopover`.


### `FPortal`
`FPortal` has been re-implemented to support size alignment, directional spacing & fix a series of longstanding issues.

* Add `FPortal.viewInsets`.
* Add `FPortal.spacing`.
* Add `FPortalConstraints`.
* Add `FPortalSpacing`.
* Fix `FPortal` not positioning portals correctly when wrapped in a `RepaintBoundary`/`Padding`.
* Fix `FPortal` not updating portals when child's offset/size changes.
* Fix `FPortal` displaying portal when child is not rendered.


### `FProgress`
`FProgress` has been updated to support indeterminate progress and fix some longstanding issues.

* Add `FProgress.circularIcon`.
* **Breaking** Change `FProgressStyle` to `FLinearProgressStyle`.
* **Breaking** Remove `FButtonSpinner` - use `FProgress.circularIcon(...)` instead.


### `FSelect` (new)
A select displays a list of options for the user to pick from. It is searchable and supports both async & sync loading
of items.

* Add `FSelect`.
* Add `FSelectController`.


### `FSelectGroup`, `FSelectGroupController` & controller callbacks
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

* **Breaking** Change `FSelectGroup(items: ...)` to `FBadge(children: ...)`.
* **Breaking** Replace `FSelectGroupItem` with `FCheckbox.grouped(...)` and `FRadio.grouped(...)`.
* **Breaking** Replace `FSelectGroupController` with a typedef of `FMultiValueNotifier`.
* **Breaking** Remove `FMultiSelectGroupController` - use `FSelectGroupController(...)` instead.
* **Breaking** Remove `FRadioSelectGroupController` - use `FSelectGroupController.radio(...)` instead.
* **Breaking** Rename `FSelectTileGroup.groupController` to `FSelectTileGroup.selectController`.
* **Breaking** Rename `FSelectMenuTile.groupController` to `FSelectMenuTile.selectController`.
* **Breaking** Rename `FSelectMenuTile.menuTileBuilder` to `FSelectMenuTile.menuBuilder`.

* Fix `FSelectGroup` not setting its `FormField`'s initial value.


### `FSelectMenuTile`

* Add `FSelectMenuTile.traversalEdgeBehavior`.
* Add `FSelectMenuTile.spacing`.
* Add `FSelectMenuTile.offset`.

* **Breaking** Change `focusNode` from `FocusNode` to `FocusScopeNode` in `FSelectMenuTile`.
* **Breaking** Remove `FSelectMenuTile.directionalPadding`.


### `FSelectTile` & `FSelectTileGroup`

* Add `FSelectTile.onHoverChange`.
* Add `FSelectTile.onStatesChange`.

* Fix `FSelectTileGroup` not setting its `FormField`'s initial value.


### `FSlider`

* Add `FSlider.initialSelection`.
* Add `FSlider.onChange`.

* Change `FSlider.controller` to be optional.

* Fix `FSlider` not setting its `FormField`'s initial value.


### `FTabs`

* Add `FTabs.physics`.

* **Breaking** Change `FTabs(tabs: ...)` to `FTabs(children: ...)`.
* **Breaking** Rename `FTabs.onPress` to `FTabs.onChange` to better reflect its purpose.
* **Breaking** Change `FTabEntry(content: ...)` to `FTabEntry(child: ...)`.


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

* Add `FTappable.onStateChange`.
* Add `FTappable.onHoverChange`.
* Add `FTappableStyle.cursor`.
* **Breaking** Replace `FTappable.semanticsSelected` with `FTappable.selected`.
* **Breaking** Rename `FTappable` to `FTappable.static`.
* **Breaking** Rename `FTappable.animated` to `FTappable`.
* **Breaking** Split `FTappableData.hovered` into `FTappableData.hovered` and `FTappableData.pressed`.
* Fix `FTappable`'s animation sometimes being invoked after it is unmounted.


### `FTextField` & `FTextFormField` (new)
We've split `FTextField` into `FTextField` and `FTextFormField`. This change was necessary to allow `FTextField` to be 
used in other widgets and allowing those widgets to properly implement `FormField`.

* Add `FTextField.groupId`.
* Add `FTextField.obscuringCharacter`. Thanks @MrHeer!
* Add `FTextField.filled` and `FTextField.fillColor`. Thanks @MrHeer!
* Add `FTextFormField`.

* **Breaking** Change `FTextField` to not support form-related operations. Use `FTextFormField` instead.

* Fix `FTextField` not setting its `FormField`'s initial value.
* Fix `FTextField(...)` not setting the max lines to 1 default.


### `FTile`

* Add `FTile.onHoverChange`.
* Add `FTile.onStateChange`.
* Add `FTile.selected`.


### `FTimeField`

* Add `FTimeField.builder`.
* Add `FTimeField.initialTime`.
* Add `FTimeField.onChange`.
* Add `spacing` to `FTimeField.picker(...)`.
* Add `offset` to `FTimeField.picker(...)`.

* **Breaking** Remove `directionalPadding` from `FTimeField.picker(...)`.


### Others
* **Breaking** Rename `FAlertStyle` to `FBaseAlertStyle`.
* **Breaking** Rename `FAlertCustomStyle` to `FAlertStyle`.
* **Breaking** Move constants in `FBaseAlertStyle` to `FAlertStyle`.

* **Breaking** Change `FBadge(label: ...)` to `FBadge(child: ...)`.

* Add `FCardContentStyle.imageSpacing`.
* Add `FCardContentStyle.subtitleSpacing`.

* Add `FLerpBorderRadius`.

* Add `FPicker.onChange`.

* Add `FResizable.onChange`.
* Fix `FResizable` not guarding against precision errors in assertions.

* **Breaking** Change `FScaffold(content: ...)` to `FScaffold(child: ...)`.

* Add `FTimePicker.onChange`.


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
