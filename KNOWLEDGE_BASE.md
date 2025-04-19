# What is this?

This file contains pointers and guidelines for working on specific parts of Forui. It is meant for contributors, not
end users.

## Calculations
* Always use `Doubles.lessOrAround`/`Doubles.greaterOrAround` when comparing doubles. This is important when calculating
  areas/lengths of widget, as floating point precision errors are a thing.

## Styles
* Don't mark style classes as final. We originally recommended marking them as final but this turned out to be an
  unnecessary restriction.

## Form fields
* Remember to provide an initial value to a `FormField`'s super constructor, typically using the passed in controller's
  value. Also remember to add tests. See FSelectGroupTile's test for an example.

## Stateful widgets with controllers
It is really easy to mess up the lifecycle of a stateful widget's controller. We recommend using IntelliJ live templates
or whatever IDE's template feature to generate the boilerplate code. Don't forget to write tests.

* `initState()` is pretty straightforward.
* `didUpdateWidget`:
  ```dart
  if (widget.controller != old.controller) {
    if (old.controller == null) {
    _controller.dispose();
   } else {
    // TODO: remove listeners
   }
   _controller = widget.controller ?? newController();
   // TODO: add listeners
  }
  ```
* `dispose()` - Don't unconditionally dispose a controller. Ensure that it wasn't passed in first.
  ```dart
  if (widget.controller == null) {
    _controller.dispose();
  } else {
    // TODO: remove listeners
  }
  ```

