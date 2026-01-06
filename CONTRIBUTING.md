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
* Relevant examples under the [docs_snippets](./docs_snippets) project. 
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


## Configuring the Development Environment

Bootstrap the project:
```shell
make bootstrap
make bs # shorthand
```

This installs dependencies and generates the required files.

Run `make help` to see all available commands.


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

### Avoid translucent colors

Translucent colors may not render as expected on different backgrounds. They are usually used as disabled and hovered
states. Instead, use the `FColorScheme.disable` and `FColorScheme.hover` functions to generate colors for disabled and
hovered states respectively.

Alternatively, use alpha-blending to generate an equivalent solid color.

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

### Extend `FChangeNotifier` instead of `ChangeNotifier`

This subclass have additional life-cycle tracking capabilities baked-in.

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

### Prefer `AlignmentGeometry`/`BorderRadiusGeometry`/`EdgeInsetsGeometry` over `Alignment`/`BorderRadius`/`EdgeInsets`

Prefer the `Geometry` variants when possible because they are more flexible.

### Widget Styles

```dart
part 'foo.style.dart'; // --- (1)

class FooStyle with Diagnosticable, _$FooStyleFunctions { // ---- (2) (3)
  
  final Color color;
  
  FooStyle({required this.color});
  
  FooStyle.inherit({FFont font, FColorScheme scheme}): color = scheme.primary; // ---- (4)
  
  FooStyle copyWith({Color? color}) => FooStyle( // ---- (5)
    color: color ?? this.color, 
  );
}
```

They should:
1. include a generated part file which includes `_$FooStyleFunctions`. To generate the file, run 
  `dart run build_runner build --delete-conflicting-outputs` in the forui/forui directory.
2. mix-in [Diagnosticable](https://api.flutter.dev/flutter/foundation/Diagnosticable-mixin.html).
3. mix-in `_$FooStyleFunctions`, which contains several utility functions.
4. provide a primary constructor, and a named constructor, `inherit(...)` , that configures itself based on
   an ancestor `FTheme`.

Lastly, the order of the fields and methods should be as shown above.


### Widget Controls

Controls define how a widget is controlled. They follow a pattern using sealed classes with two variants:
* **Managed**: The widget manages its own controller internally while exposing parameters for common configurations.
* **Lifted**: The widget uses external state management, with the parent providing expanded/collapsed state and callbacks.

The control pattern is code-generated using `forui_internal_gen`. Files are organized as follows:
```
lib/src/widgets/my_widget/
├── my_widget_controller.dart          (Controller + Control definition)
├── my_widget_controller.control.dart  (GENERATED)
├── my_widget.dart                     (Widget + Style + Motion)
└── my_widget.design.dart              (GENERATED)
```

#### Proxy Controllers

Flutter is a controller-centric framework. Therefore, widgets that support lifted state require a proxy controller
that delegates operations to external callbacks given by the user instead of managing state internally.

For example, when a user expands an accordion item using `FAccordionControl.lifted(...)`, the proxy controller:
1. Receives the expansion request via the controller's public API (e.g., `expand(index)`)
2. Delegates to the parent's `onChange` callback instead of updating internal state
3. Reads current state from the parent's `expanded` predicate

```dart
@internal
class ProxyMyWidgetController extends FMyWidgetController {
  bool Function(int index) _supply;
  void Function(int index, bool value) _onChange;

  ProxyMyWidgetController(this._supply, this._onChange);

  void update(bool Function(int index) supply, void Function(int index, bool value) onChange) {
    _supply = supply;
    _onChange = onChange;
  }

  @override
  Future<bool> toggle(int index) async {
    _onChange(index, !_supply(index));
    return true;
  }
}
```

This allows the widget to use a consistent controller-based internal API regardless of whether state is managed
internally or lifted to a parent widget.

#### Control Sealed Class

The control sealed class should:
1. Mix in `Diagnosticable` and `_$FMyWidgetControlMixin` (generated).
2. Define `managed` and `lifted` factory constructors.
3. Define an `_update` method signature that returns `(FMyWidgetController, bool)`.

```dart
sealed class FMyWidgetControl with Diagnosticable, _$FMyWidgetControlMixin {
  const factory FMyWidgetControl.managed({
    FMyWidgetController? controller,
    // ... other managed parameters
  }) = FMyWidgetManagedControl;

  const factory FMyWidgetControl.lifted({
    // ... lifted state parameters
  }) = _Lifted;

  const FMyWidgetControl._();

  (FMyWidgetController, bool) _update(
    FMyWidgetControl old,
    FMyWidgetController controller,
    VoidCallback callback,
    // ... other parameters passed to createController
  );
}
```

#### Control Subclasses

The managed control should be a **public** class that mixes in the generated `_$FMyWidgetManagedControlMixin`:

```dart
class FMyWidgetManagedControl extends FMyWidgetControl with _$FMyWidgetManagedControlMixin {
  @override
  final FMyWidgetController? controller;
  // ... other @override fields

  const FMyWidgetManagedControl({this.controller, ...}) : super._();

  @override
  FMyWidgetController createController(/* parameters */) =>
    controller ?? FMyWidgetController(/* ... */);
}
```

The lifted control should be a **private** class that mixes in the generated `_$_LiftedMixin`:

```dart
class _Lifted extends FMyWidgetControl with _$_LiftedMixin {
  @override
  final /* lifted state fields */;

  const _Lifted({required /* ... */}) : super._();

  @override
  FMyWidgetController createController(/* parameters */) => /* ... */;

  @override
  void _updateController(FMyWidgetController controller, /* parameters */) { /* ... */ }
}
```

#### Using Control in Widget

Use the generated extension methods in your widget's `State`:

```dart
class _FMyWidgetState extends State<FMyWidget> {
  late FMyWidgetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleChange, /* ... */);
  }

  @override
  void didUpdateWidget(covariant FMyWidget old) {
    super.didUpdateWidget(old);
    final (controller, _) = widget.control.update(old.control, _controller, _handleChange, /* ... */);
    _controller = controller;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleChange);
    super.dispose();
  }
}
```

See [FAccordionController](https://github.com/forus-labs/forui/blob/main/forui/lib/src/widgets/accordion/accordion_controller.dart)
for a reference implementation.

### Hide, not Show

Prefer hiding internal members (blacklisting) rather than showing public members (whitelisting) in [barrel files](https://medium.com/@ugamakelechi501/barrel-files-in-dart-and-flutter-a-guide-to-simplifying-imports-9b245dbe516a).

✅ Prefer this:
```dart
library forui.widgets.calendar;

export '../src/widgets/calendar/calendar.dart';
export '../src/widgets/calendar/day/day_picker.dart' hide DayPicker;
export '../src/widgets/calendar/shared/entry.dart' hide Entry;
export '../src/widgets/calendar/shared/header.dart' hide Header, Navigation;
export '../src/widgets/calendar/calendar_controller.dart';
```

❌ Instead of:
```dart
export '../src/widgets/calendar/calendar.dart';
export '../src/widgets/calendar/day/day_picker.dart' show FCalendarDayPickerStyle;
export '../src/widgets/calendar/shared/entry.dart' show FCalendarDayData, FCalendarEntryStyle;
export '../src/widgets/calendar/shared/header.dart' show FCalendarHeaderStyle, FCalendarPickerType;
export '../src/widgets/calendar/calendar_controller.dart';
```

This prevents accidental omission of generated public members.


## Leak Tracking

To detect memory leaks, [`leak_tracker_flutter_testing`](https://github.com/dart-lang/leak_tracker/blob/main/doc/leak_tracking/DETECT.md)
is enabled by default in all tests. 

Leak tracking results currently are not shown when running tests via an IntelliJ run  configuration. As a workaround, 
run the tests via the terminal.

It is recommended to wrap disposable objects created in tests with `autoDispose(...)`, i.e. `final focus = autoDispose(FocusNode())`.

## Writing Golden Tests

Golden images are generated in the `test/golden` directory instead of relative to the test file.

Golden tests should follow these guidelines:
* Golden test files should be suffixed with `golden_test`, i.e. `button_golden_test.dart`.
* Widgets under test should be tested against all themes specified in `TestScaffold.themes`.
* Widgets under test should be wrapped in a `TestScaffold`.

See [button_golden_test.dart](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/forui/test/src/widgets/button/button_golden_test.dart).

The CI pipeline will automatically generate golden images for all golden tests on Windows & macOS. Contributors on Linux
should *not** commit locally generated golden images.

### Blue Screen Tests

Blue screen tests are a special type of golden tests. All widgets should have a blue screen test. It uses a special 
theme that is all blue. This allows us to verify that custom/inherited themes are being applied correctly. The resultant 
image should be completely blue if applied correctly, hence the name.

Example
```dart
testWidgets('blue screen', (tester) async {
  await tester.pumpWidget(
    TestScaffold.blue( // (1) Always use the TestScaffold.blue(...) constructor.
      child: FSelectGroup(
        style: TestScaffold.blueScreen.selectGroupStyle, // (2) Always use the TestScaffold.blueScreen theme.
        children: [
          FSelectGroupItem.checkbox(value: 1),
        ],
      ),
    ),
  );

  // (3) Always use expectBlueScreen.
  await expectBlueScreen(find.byType(TestScaffold));
});
```

## Writing Documentation

In addition to the [API reference](https://dart.dev/tools/dart-doc), you should also update [forui.dev/docs](https://forui.dev/docs)
if necessary.

[forui.dev](https://forui.dev/docs) is split into two parts:
* The [doc snippets website](./docs_snippets), which is a Flutter webapp that provides the example widgets & other code blocks.
* The [documentation website](./docs), which provides overviews and examples of widgets from the docs snippets website embedded 
  using `<Widget/>` components in MDX files.

We will use a secondary-styled button as an example in the following sections.
 

### Creating a Example

The [button's corresponding sample](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/samples/lib/widgets/button.dart#L15)
is:
```dart
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class ButtonTextPage extends Example { // - (1)
  final Variant variant;
  final String label;

  ButtonTextPage({
    @queryParam super.theme, // - (2)
  }) : variant = variants[style] ?? Variant.primary;

  @override
  Widget example(BuildContext context) => IntrinsicWidth(
        child: FButton(
          label: Text(label),
          style: variant,
          onPress: () {},
        ),
      );
}
```

1. Examples should extend `Example`/`StatefulExample` which centers and wraps the widget returned by the overridden 
  `example(...)`  method in a `FTheme`.
2. The current theme, provided as a URL query parameter.

The docs_snippets website uses `auto_route` to generate a route for each example. In general, each example has its own page and
URL. Generate the route by running `dart pub run build_runner build --delete-conflicting-outputs`. After which, 
register the route with [`_AppRouter` in main.dart](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/samples/lib/main.dart#L67).

A route's path should follow the format `/<widget-name>/<variant>` in kebab-case. In this case, the button route's path 
is `/button/text`. `<variant>` should default to `default` and never be empty.

See the snippet generator's [README](./docs_snippets/README.md) for more details.


### Creating a Documentation Page

Each widget should have its own MDX file in the documentation website's [docs folder](./docs/app/docs). 

The file should contain the following sections:
* A brief overview and minimal example.
* Usage section that details the various constructors and their parameters.
* Examples.

See `FButton`'s [mdx file](https://github.com/forus-labs/forui/blob/bb45cef78459a710824c299a192b5de59b61c9b3/docs/pages/docs/button.mdx?plain=1#L58).

Each example should be wrapped in a `<Tabs/>` component. It contains a `<Widget/>` component and a code block. The 
`<Widget/>` component is used to display a example widget hosted on the docs_snippets website, while the code block displays 
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

1. The name corresponds to a `<widget-name>` in the docs_snippets website's route paths.
2. The variant corresponds to a `<variant>` in the docs_snippets website's route paths. Defaults to `default` if not specified.
3. The query parameters to pass to the example widget.
4. The height of the `<Widget/>` component.
5. `{}` specifies the lines to highlight.

## Updating Localizations

In most cases, you will not need to update localizations. However, if you do, please read 
[Internationalizing Flutter apps](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization).
before continuing.

Each ARB file in the `lib/l10n` represents a localization for a specific language. We try to maintain parity with the 
languages Flutter natively supports. To add a missing language, run the `fetch_arb` script in the `tool` directory.

After adding the necessary localization messages, run the following command in the `forui` project directory which will
generate the localization files in `lib/src/localizations`:
```shell
flutter gen-l10n
```

Inside the generated `localizations.dart` file, change:
```dart
static FLocalizations of(BuildContext context) {
  return Localizations.of<FLocalizations>(context, FLocalizations);
}
```

To:
```dart
static FLocalizations of(BuildContext context) {
  return Localizations.of<FLocalizations>(context, FLocalizations) ?? DefaultLocalizations();
}
```
