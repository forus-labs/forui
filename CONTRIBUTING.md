# Contributing to Forui

Before starting work on a pull request, please check if a similar issue already exists, or create one to discuss the 
proposed changes. After which, please leave a comment on the issue to indicate that you're working on it.

This helps to:

* Ensure that the proposed changes align with the project's goals and direction.
* Avoid duplicate efforts by informing other contributors about ongoing work.
* Provide a platform for maintainers and the community to offer feedback and suggestions.

Doing so saves time and effort by identifying potential problems early in the development process.

If you're stuck or unsure about anything, feel free to ask for help in our [discord](https://discord.gg/UEky7WkXd6) server.

## First Time Contributors

We recommend that first time contributors start with [issues that are labelled with `difficulty: easy` and/or `duration: tiny`](https://github.com/forus-labs/forui/issues?q=is%3Aopen+is%3Aissue+label%3A%22difficulty%3A+easy%22%2C%22duration%3A+tiny%22+).

## Submitting a Pull Request

If your submitted pull request contains new widgets/changes to existing widgets, please:
* Include a brief description of the changes.
* Add/update the unit and/or golden tests if relevant.
* Add/update the corresponding sample under the [samples](./samples) project.
* Add/update the corresponding documentation under the [docs](./docs) project.

Dart format & linting is enforced by the CI pipeline. You don't have to manually format your code.

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

### Widget Styles

```dart
class FooStyle with Diagnosticable { // ---- (1)
  
  final Color color;
  
  FooStyle({required this.color}); // ---- (2)
  
  FooStyle.inherit({FFont font, FColorScheme scheme}): color = scheme.primary; // ---- (2)
  
  FooStyle copyWith({Color? color}) => FooStyle( // ---- (3)
    color: color ?? this.color, 
  );
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) { // ---- (4)
    super.debugFillProperties(properties);
    properties.add(ColorProperty<BorderRadius>('color', color));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FStyle && color == other.color; // ---- (5)

  @override
  int get hashCode => color.hashCode; // ---- (5)
  
}
```

They should:
1. mix-in [Diagnosticable](https://api.flutter.dev/flutter/foundation/Diagnosticable-mixin.html).
2. provide a primary constructor, and a named constructor, `inherit(...)` , that configures itself based on 
   an ancestor `FTheme`.
3. provide a `copyWith(...)` method.
4. override [debugFillProperties](https://api.flutter.dev/flutter/foundation/Diagnosticable/debugFillProperties.html).
5. implement `operator ==` and `hashCode`.


## Conventions

* Avoid [double negatives](https://en.wikipedia.org/wiki/Double_negative) when naming things, i.e. a boolean field should
  be named `enabled` instead of `disabled`.

* Avoid past tense when naming callbacks, prefer present tense instead.

  ✅ Prefer this:
  ```dart
  final VoidCallback onPress;
  ```

  ❌ Instead of:
  ```dart
  final VoidCallback onPressed;
  ```


* Prefix all publicly exported widgets and styles with `F`, i.e. `FScaffold`.
