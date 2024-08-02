## Next

### Additions
* Add `FAvatar`.
* **Breaking:** Add `FCalendarEntryStyle.focusedBorderColor`. This only affects users that customized `FCalendarEntryStyle`.
* Add `FResizable`.

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
* Fix `FCalendar` dates not being toggleable using `Enter` key.
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
