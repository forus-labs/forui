import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
@Options(include: [Sidebar])
class SelectGroupPage extends Example {
  SelectGroupPage({@queryParam super.theme}) : super(maxWidth: 250);

  @override
  Widget example(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [
      FSelectGroup<Sidebar>(
        control: const .managed(initial: {.recents}),
        label: const Text('Sidebar'),
        description: const Text('These will be shown in the sidebar.'),
        children: [
          .checkbox(value: .recents, label: const Text('Recents')),
          .checkbox(value: .home, label: const Text('Home')),
          .checkbox(value: .applications, label: const Text('Applications')),
        ],
      ),
    ],
  );
}

@RoutePage()
@Options(include: [Language])
class SelectGroupCheckboxFormPage extends StatefulExample {
  SelectGroupCheckboxFormPage({@queryParam super.theme}) : super(maxWidth: 250);

  @override
  State<SelectGroupCheckboxFormPage> createState() => _SelectGroupCheckboxFormPageState();
}

class _SelectGroupCheckboxFormPageState extends StatefulExampleState<SelectGroupCheckboxFormPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      spacing: 20,
      children: [
        FSelectGroup<Language>(
          label: const Text('Favorite Languages'),
          description: const Text('Your favorite language.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select at least one language.' : null,
          children: [
            .checkbox(value: .dart, label: const Text('Dart')),
            .checkbox(value: .java, label: const Text('Java')),
            .checkbox(value: .rust, label: const Text('Rust')),
            .checkbox(value: .python, label: const Text('Python')),
          ],
        ),
        FButton(
          child: const Text('Submit'),
          onPress: () {
            if (!_key.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _key.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );
}

@RoutePage()
@Options(include: [Notification])
class SelectGroupRadioFormPage extends StatefulExample {
  SelectGroupRadioFormPage({@queryParam super.theme}) : super(maxWidth: 320);

  @override
  State<SelectGroupRadioFormPage> createState() => _SelectGroupRadioFormPageState();
}

class _SelectGroupRadioFormPageState extends StatefulExampleState<SelectGroupRadioFormPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      spacing: 20,
      children: [
        FSelectGroup<Notification>(
          // {@highlight}
          control: const .managedRadio(),
          // {@endhighlight}
          label: const Text('Notifications'),
          description: const Text('Select the notifications.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
          children: [
            .radio(value: .all, label: const Text('All new messages')),
            .radio(value: .direct, label: const Text('Direct messages and mentions')),
            .radio(value: .nothing, label: const Text('Nothing')),
          ],
        ),
        FButton(
          child: const Text('Save'),
          onPress: () {
            if (!_key.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _key.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );
}
