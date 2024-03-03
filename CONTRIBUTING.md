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

* Bundle assets in `forui_assets`, see https://github.com/flutter/flutter/issues/106782.
* Make all widgets accessible in the showcase project.
* Prefix all publicly exported widgets with `Fui`, i.e. `FuiScaffold`.
