# Contributing to Forui

## Design Guidelines

### Be agnostic about state management

There is a wide variety of competing state management packages. Picking one may discourage users of the other packages 
from adopting Forui. Use `InheritedWidget` instead.

### Be conservative when exposing configuration knobs

Additional knobs can always be introduced later if there's sufficient demand. Changing these knobs is time-consuming and
constitute a breaking change.

✅ Prefer this:
```dart
class Foo extends StatelessWidget {
  final int _someKnobWeDontKnowIfUsefulToUsers = ...;
  
  const Foo() {}
  
  @override
  void build(BuildContext context) {
    ...
  }
}
```

❌ Instead of:
```dart
class Foo extends StatelessWidget {
  final int someKnobWeDontKnowIfUsefulToUsers = ...;
  
  const Foo(this.someKnobWeDontKnowIfUsefulToUsers) {}
  
  @override
  void build(BuildContext context) {
    ...
  }
}
```

### Mark widgets as final when sensible

Subclasses can interact with Forui in unforeseen ways, and cause potential issues. It is not breaking to initially mark 
classes as `final`, and subsequently unmark it. The inverse isn't true. Favor composition over inheritance.

### Minimize dependency on 3rd party packages

3rd party packages introduce uncertainty. It is difficult to predict whether a package will be maintained in the future.
Furthermore, if a new major version of a 3rd party package is released, applications that depend on both Forui and the 
3rd party package may be forced into dependency hell. 

In some situations, it is unrealistic to implement things ourselves. In these cases, we should prefer packages that:
* Are authored by Forus Labs.
* [Are maintained by a group/community rather than an individual](https://en.wikipedia.org/wiki/Bus_factor).
* Have a "pulse", i.e. maintainers responding to issues in the past month at the time of introduction.

Lastly, types from 3rd party packages should not be publicly exported by Forui.


## Conventions

* Prefix all publicly exported widgets and styles with `F`, i.e. `FScaffold`.

## Widget Styles

Widget styles, i.e. `CardStyle`, should mix-in [Diagnosticable](https://api.flutter.dev/flutter/foundation/Diagnosticable-mixin.html).
It should override the [debugFillProperties](https://api.flutter.dev/flutter/foundation/Diagnosticable/debugFillProperties.html)
method to include all fields in the style.

Widget styles, i.e. `CardStyle`, should provide:
* a primary constructor
* a named constructor, `inherit(...)` , that configures itself based on an ancestor `FTheme`.

Widget styles, i.e. `CardStyle`, should override the hashCode and equality operator (==).

Do not scale `TextStyles` inside a widget style during its initialization. Instead, scale the `TextStyle`s inside a
widget's build method. This avoids confusion on whether `TextStyle`s are automatically scaled inside widget styles.
