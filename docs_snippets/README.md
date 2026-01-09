# Docs Snippets

This project contains the following used in [forui.dev](https://forui.dev):
* A Flutter web application for running the examples.
* Dart files which are transformed by [snippet generator](./tool/snippet_generator) into JSON files which are then consumed  by the site to 
  produce interactive code blocks.

It is not expected to be consumed directly by users.

## Using Snippet Generator

This section is for contributors who want to add or modify code snippets.

To run the generator (from the repository root):
```shell
dart run docs_snippets/tool/snippet_generator/bin/snippet_generator.dart
```

There are **3** types of snippets. All of them support `// {@hhighlight}` and `// {@endhighlight}` markers to highlight 
specific line ranges.

### Usages (`lib/usages/`)

Typically used in a widget page's usage section. 

Show widget constructor usage with selectable categories. A category
is a group of related parameters, e.g. accessibility, control and core. Each category can have multiple variants. For
example, the control category can have a `.managed()` and a `.lifted()` variant which each describe a mutually exclusive
way to configure the control behavior.

**Example:**
```dart
final constructor = FAccordion(
  // {@category "core"}
  style: FThemes.zinc.light.accordionStyle,
  children: const [],
  // {@endcategory}
  // {@category "control"}
  control: const .managed(min: 1, max: 2),
  // {@endcategory}
);

// {@category "control" ".lifted()"}
/// Description shown in UI.
final FAccordionControl lifted = .lifted(expanded: (index) => true, onChange: (index, expanded) {});
```

**Syntax:**
- Variant declaration: `// {@category "category" "variant-name"}` before a variable declares a variant.
- Inline category: `// {@category "name"}...// {@endcategory}` wraps constructor arguments to form a category.
  The wrapped argument value is discarded if there are multiple variants for that category. For example, 
  `const .managed(min: 1, max: 2)` is not used in the final code snippet as there is already a `.lifted()` variant.

### Examples (`lib/examples/`)

Typically used in a widget page's examples section, demonstrating various use cases.

Full runnable Flutter widgets displayed in an interactive preview. 

An example:
- must extend `StatelessWidget`,`StatefulWidget`, `StatelessExample` or `StatefulExample`.
- must also be annotated with `@RoutePage()`, and included in `main.dart`'s `routes`.
- may only use `@queryParam` for the `theme` constructor parameter.

Examples also support the `@Options` annotation to control what additional code is included in the generated snippet.

**Example:**
```dart
const fruits = ['Apple', 'Banana', 'Blueberry'];

@RoutePage()
@Options(include: [fruits])  // fruits will be included in generated snippet
class CollapsiblePage extends StatefulExample {
  CollapsiblePage({@queryParam super.theme});

  @override
  State<CollapsiblePage> createState() => _State();
}

class _State extends StatefulExampleState<CollapsiblePage> {
  @override
  Widget example(BuildContext _) => FButton(onPress: () {}, child: Text('Click'));
}

@RoutePage()
@Options(inline: _Accordion)  // _Accordion's build method will be shown
class AccordionPage extends Example {
  @override
  Widget example(BuildContext _) => const _Accordion();
}

class _Accordion extends StatelessWidget {
  @override
  Widget build(BuildContext _) => FAccordion(...);  // This is what gets shown
}
```

### Snippets (`lib/snippets/`)

Typically used in general documentation pages.

Code fragments for documentation. Wrap the displayed portion with `// {@snippet}...// {@endsnippet}`. Code outside the
markers provides context (imports, helper classes) but isn't shown. The entire file is show if there are no markers.

**Example:**
```dart
import 'package:forui/forui.dart';

class HelperWidget extends StatelessWidget { ... }

// {@snippet}
@override
Widget build(BuildContext context) {
  return switch (MediaQuery.sizeOf(context).width) {
    _ when width < breakpoints.sm => const MobileWidget(),
    _ => const DesktopWidget(),
  };
}
// {@endsnippet}
```