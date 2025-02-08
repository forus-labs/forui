# Forui Internal Gen

Forui's internal code generation tool. Not meant for end-users.

## Styles

The `styleBuilder` generates a mixin for a corresponding style class name. It generates the following functions:
  * `copyWith(...)`
  * `debugFillProperties(...)`
  * `operator==`
  * `hashCode`

It currently generates a copy of all fields. This will no longer be necessary once augmented classes are supported.

### Why not `freezed`?
Advantages:
* Generates `debugFillProperties`.
* Hides generated code from the end user's perspective.

Disadvantages:
* Weird field declaration syntax that forces developers to add comments on individual constructor parameters.
* Generated code messes up "jump to declaration".
* Generated `copyWith` doesn't handle (multiple) deeply nested properties gracefully.
* Generated `copyWith` doesn't handle nested Flutter types `TextStyle` gracefully.
* Generated `debugFillProperties` doesn't use specialized property subclasses and incorrectly handles records.
* Doesn't support inheritance.

### Why not `dart_mappable`?
Advantages:
* Supports inheritance. 

Disadvantages:
* Couldn't get it to work with Forui. It kept trying to (and failing to) generate a mappable for some packages in the cache.
* Greatly increases API surface area.
* Generated mixin is publicly visible to the end user.

In short, they're both decent libraries, but don't quite fit Forui's needs.
