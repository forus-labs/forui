## Next

### Changes
* Add `FHeader.nested` widget.
* Add `FProgress` widget.
* **Breaking** Move `FHeaderStyle` to `FHeaderStyles.rootStyle`.
* **Breaking** Move `FHeaderActionStyle.padding` to `FRootHeaderStyle.actionSpacing`.
* **Breaking** Suffix style parameters with `Style`, i.e. `FRootHeaderStyle.action` has been renamed to `FRootHeaderStyle.actionStyle`.
* **Breaking** Raw fields have been removed, wrap strings with the Text() widget. Eg. `Button(label: 'Hello')` or `Button(rawLabel: 'Hello')` should be replaced with `Button(label: Text('Hello'))`.
* Change `FTextField` to be usable in `Form`s. 
* Change `FTextFieldStyle`'s default vertical content padding from `5` to `15`.
* Fix missing `key` parameter in `FTextField` constructors.
* **Breaking** `FButton.prefixIcon` and `FButton.suffixIcon` have been renamed to `FButton.prefix` and `FButton.suffix`.
* Split exports in `forui.dart` into sub-libraries.

## 0.1.0

* Initial release! 🚀
