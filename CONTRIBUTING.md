# Contributing to Forui

This document outlines how to contribute code to Forui. It assumes that you're familiar with [Flutter](https://docs.flutter.dev/),
[writing golden tests](https://medium.com/flutter-community/flutter-golden-tests-compare-widgets-with-snapshots-27f83f266cea),
[MDX](https://mdxjs.com/docs/),
and [Trunk-Based Development](https://trunkbaseddevelopment.com/).

There are many ways to contribute beyond writing code. For example, you can [report bugs](https://github.com/forus-labs/forui/issues/new?assignees=&labels=type%3A+bug&projects=&template=bug_report.md),
provide [feedback](https://github.com/forus-labs/forui/issues/new?assignees=&labels=type%3A+ehancement&projects=&template=feature_request.md),
and enhance existing documentation.

In general, contributing code involves the adding/updating of:
* Widgets.
* Relevant unit/golden tests.
* Relevant sample under the [samples](./samples) project. 
* Relevant documentation under the [docs](./docs) project.
* [CHANGELOG.md](./forui/CHANGELOG.md).


## Before You Contribute

Before starting work on a PR, please check if a similar [issue](https://github.com/forus-labs/forui/issues)/
[PR](https://github.com/forus-labs/forui/pulls) exists. We recommend that first time contributors start with 
[existing issues that are labelled with `difficulty: easy` and/or `duration: tiny`](https://github.com/forus-labs/forui/issues?q=is%3Aopen+is%3Aissue+label%3A%22difficulty%3A+easy%22%2C%22duration%3A+tiny%22+).

If an issue doesn't exist, create one to discuss the proposed changes. After which, please comment on the issue to 
indicate that you're working on it.

This helps to:
* Avoid duplicate efforts by informing other contributors about ongoing work.
* Ensure that the proposed changes align with the project's goals and direction.
* Provide a platform for maintainers and the community to offer feedback and suggestions.

If you're stuck or unsure about anything, feel free to ask for help in our [discord](https://discord.gg/UEky7WkXd6).


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

* Format all Dart code with 120 characters line limit, i.e. `dart format . --line-length=120`.

* Prefix all publicly exported widgets and styles with `F`, i.e. `FScaffold`.


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
  final int _someKnobWeDontKnowIfUsefulToUsers = 42;
  
  const Foo() {}
  
  @override
  void build(BuildContext context) {
    return Placeholder();
  }
}
```

❌ Instead of:
```dart
class Foo extends StatelessWidget {
  final int someKnobWeDontKnowIfUsefulToUsers = 42;
  
  const Foo(this.someKnobWeDontKnowIfUsefulToUsers) {}
  
  @override
  void build(BuildContext context) {
    return Placeholder();
  }
}
```


### Mark widgets as final when sensible

Subclasses can interact with Forui in unforeseen ways, and cause potential issues. It is not breaking to initially mark
classes as `final`, and subsequently unmark it. The inverse isn't true. Favor composition over inheritance.


### Minimize dependency on Cupertino/Material

Cupertino and Material specific widgets should be avoided when possible.

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

Lastly, the order of the fields and methods should be as shown above.

## Writing Golden Tests

Golden images are generated in the `test/golden` directory instead of relative to the test file. 

Only the `Inter` font is loaded by default.

### Configuring Golden Test Threshold

By default, `matchesGoldenFile(...)` has a 0.5% threshold. In other words, images that differ by 0.5% or less will be 
considered a match. Due to how different platforms render the images differently, this threshold may need to be adjusted.

To adjust the threshold, move the golden test file into a nested folder if it is in `test/src/widgets/` and place a 
`flutter_test_config.dart` file beside the golden test file.

Copy the following code into the `flutter_test_config.dart` file:
```dart
import 'dart:async';

import '../../flutter_test_config.dart'; // Adjust path based on the location of the `test/flutter_test_config.dart`. 

const _kGoldenTestsThreshold = 7 / 100; // Adjust the threshold as necessary, i.e. 7%.

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await configureGoldenTests(_kGoldenTestsThreshold);
  await testMain();
}
```

Golden tests should follow these guidelines:
* Golden test files should be suffixed with `golden_test`, i.e. `button_golden_test.dart`. 
* Golden tests should be annotated with `@Tags(['golden'])`.
* Widgets under test should be tested against all themes specified in `TestScaffold.themes`.
* Widgets under test should be wrapped in a `TestScaffold`.

See [button_golden_test.dart](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/forui/test/src/widgets/button/button_golden_test.dart).


## Writing Documentation

In addition to the [API reference](https://dart.dev/tools/dart-doc), you should also update [forui.dev/docs](https://forui.dev/docs)
if necessary.

[forui.dev](https://forui.dev/docs) is split into two parts:
* The [samples website](./samples), which is a Flutter webapp that provides the example widgets.
* The [documentation website](./docs), which provides overviews and examples of widgets from the samples website embedded 
  using `<Widget/>` components in MDX files.

We will use a secondary-styled button as an example in the following sections.
 

### Creating a Sample

The [button's corresponding sample](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/samples/lib/widgets/button.dart#L15)
is:
```dart
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';

import 'package:forui_samples/sample_scaffold.dart';

final variants = {
  for (final value in Variant.values) value.name: value,
};

@RoutePage()
class ButtonTextPage extends SampleScaffold { // - (1)
  final Variant variant;
  final String label;

  ButtonTextPage({
    @queryParam super.theme, // - (2)
    @queryParam String style = 'primary',
    @queryParam this.label = 'Button',
  }) : variant = variants[style] ?? Variant.primary;

  @override
  Widget child(BuildContext context) => IntrinsicWidth(
        child: FButton(
          label: Text(label),
          style: variant,
          onPress: () {},
        ),
      );
}
```

1. Samples should extend `SampleScaffold` which centers and wraps the widget returned by the overridden `child(...)` 
   method in a `FTheme`.
2. The current theme, provided as a URL query parameter.

The samples website uses `auto_route` to generate a route for each sample. In general, each sample has its own page and
URL. Generate the route by running `dart pub run build_runner build --delete-conflicting-outputs`. After which, 
register the route with [`_AppRouter` in main.dart](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/samples/lib/main.dart#L67).

A route's path should follow the format `/<widget-name>/<variant>` in kebab-case. In this case, the button route's path 
is `/button/text`. `<variant>` should default to `default` and never be empty.


### Creating a Documentation Page

Each widget should have its own MDX file in the documentation website's [docs folder](./docs/pages/docs). 

The file should contain the following sections:
* A brief overview and minimal example.
* Usage section that details the various constructors and their parameters.
* Examples.

See `FButton`'s [mdx file](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/docs/pages/docs/button.mdx?plain=1#L58).

Each example should be wrapped in a `<Tabs/>` component. It contains a `<Widget/>` component and a code block. The 
`<Widget/>` component is used to display a sample widget hosted on the samples website, while the code block displays 
the corresponding Dart code.

```mdx
<Tabs items={['Preview', 'Code']}>
  <Tabs.Tab>
    <Widget 
      name='button' <!-- (1) -->
      variant='text' <!-- (2) -->
      query={{style: 'secondary'}} <!-- (3) -->
      height={500} <!-- (4) -->
    />
  </Tabs.Tab>
  <Tabs.Tab>
    ```dart {3} <!-- (5) -->
    FButton(
      label: const Text('Button'),
      style: FButtonStyle.secondary,
      onPress: () {},
    );
    ```
  </Tabs.Tab>
</Tabs>
```

1. The name corresponds to a `<widget-name>` in the samples website's route paths.
2. The variant corresponds to a `<variant>` in the samples website's route paths. Defaults to `default` if not specified.
3. The query parameters to pass to the sample widget.
4. The height of the `<Widget/>` component.
5. `{}` specifies the lines to highlight.
