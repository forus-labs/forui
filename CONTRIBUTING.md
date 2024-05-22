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

### Widget Styles

```dart
class FooStyle with Diagnosticable { // ---- (1)
  
  final Color color;
  
  FooStyle({required this.color}); // ---- (2)
  
  FooStyle.inherit({FFont font, FColorScheme scheme}): color = scheme.primary; // ---- (2)
  
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) { // ---- (3)
    super.debugFillProperties(properties);
    properties.add(ColorProperty<BorderRadius>('color', color));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FStyle && color == other.color; // ---- (4)

  @override
  int get hashCode => color.hashCode; // ---- (4)
  
}
```

1. They should mix-in [Diagnosticable](https://api.flutter.dev/flutter/foundation/Diagnosticable-mixin.html).
2. They should provide a primary constructor, and a named constructor, `inherit(...)` , that configures itself based on 
   an ancestor `FTheme`.
3. They should override [debugFillProperties](https://api.flutter.dev/flutter/foundation/Diagnosticable/debugFillProperties.html).
4. They should implement `operator ==` and `hashCode`.


Widget should not scale `TextStyle`S during initialization. `TextStyle`s should be scaled in a widget's build method instead.
This avoids confusion about whether `TextStyle`s are automatically scaled inside widget styles.

✅ Prefer this:
```dart
class FooStyle {
  final TextStyle text;
  
  FooStyle.inherit({FFont font, FColorScheme scheme}): text = const TextStyle(size: 1);
}

class Foo extends StatelessWidget {
  final FooStyle style;
  
  @overrride
  Widget build(BuildContext context) => Text('Hi', style: style.text.withFont(context.theme.font));
}
```

❌ Instead of:
```dart
class FooStyle {
  final TextStyle text;

  FooStyle.inherit({FFont font, FColorScheme scheme}): text = const TextStyle(size: 1).withFont(font);
}

class Foo extends StatelessWidget {
  final FooStyle style;

  @overrride
  Widget build(BuildContext context) => Text('Hi', style: style.text);
}
```


## Conventions

* Prefix all publicly exported widgets and styles with `F`, i.e. `FScaffold`.
