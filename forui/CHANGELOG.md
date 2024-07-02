## Next

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
