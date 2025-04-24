# What is this?

This file contains pointers and guidelines for working on specific parts of Forui. It is meant for contributors, not
end users.

## Problem with Properties
The consistent field naming isn't actually a good idea in practice. I think the popover made that clear, the composing 
widget might want a different/more specific name that is better suited to describe its particular usecase, i.e. 
popoverAnchor in FPopover becomes menuAnchor in FPopoverMenu & FSelectMenuTile. And because we implement the properties 
interface, we will be forced to make the name more generic which isn't great.

The only properties class that have avoided all of these so far is FFormFieldProperties, which I think is an exception 
rather than the norm. Even then, we had to remove a few fields such as restorationId (as not all form fields can support 
that), and initialValue (form fields with controllers generally do no support that)

So in general, we wanted to group properties tgt and expose a set of them through an interface. But grouping more than 
required makes API bloated and suprisingly since not all fields might be supported. Grouping too little makes the 
grouping not useful.

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

