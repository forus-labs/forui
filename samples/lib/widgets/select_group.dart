import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
class SelectGroupPage extends StatefulSample {
  SelectGroupPage({@queryParam super.theme, super.maxWidth = 250});

  @override
  State<SelectGroupPage> createState() => _SelectGroupPageState();
}

class _SelectGroupPageState extends StatefulSampleState<SelectGroupPage> {
  final _controller = FSelectGroupController(value: {Sidebar.recents});

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [
      FSelectGroup(
        control: .managed(controller: _controller),
        label: const Text('Sidebar'),
        description: const Text('These will be shown in the sidebar.'),
        children: [
          .checkbox(value: Sidebar.recents, label: const Text('Recents')),
          .checkbox(value: Sidebar.home, label: const Text('Home')),
          .checkbox(value: Sidebar.applications, label: const Text('Applications')),
        ],
      ),
    ],
  );
}

@RoutePage()
class SelectGroupCheckboxFormPage extends StatefulSample {
  SelectGroupCheckboxFormPage({@queryParam super.theme, super.maxWidth = 250});

  @override
  State<SelectGroupCheckboxFormPage> createState() => _SelectGroupCheckboxFormPageState();
}

class _SelectGroupCheckboxFormPageState extends StatefulSampleState<SelectGroupCheckboxFormPage> {
  final _key = GlobalKey<FormState>();
  final _controller = FSelectGroupController<Language>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        FSelectGroup(
          control: .managed(controller: _controller),
          label: const Text('Favorite Languages'),
          description: const Text('Your favorite language.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select at least one language.' : null,
          children: <FSelectGroupItemMixin<Language>>[
            .checkbox(value: .dart, label: const Text('Dart')),
            .checkbox(value: .java, label: const Text('Java')),
            .checkbox(value: .rust, label: const Text('Rust')),
            .checkbox(value: .python, label: const Text('Python')),
          ],
        ),
        const SizedBox(height: 20),
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
class SelectGroupRadioFormPage extends StatefulSample {
  SelectGroupRadioFormPage({@queryParam super.theme, super.maxWidth = 320});

  @override
  State<SelectGroupRadioFormPage> createState() => _SelectGroupRadioFormPageState();
}

class _SelectGroupRadioFormPageState extends StatefulSampleState<SelectGroupRadioFormPage> {
  final _key = GlobalKey<FormState>();
  final _controller = FSelectGroupController<Notification>.radio();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        FSelectGroup(
          control: .managed(controller: _controller),
          label: const Text('Notifications'),
          description: const Text('Select the notifications.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
          children: <FSelectGroupItemMixin<Notification>>[
            .radio(value: .all, label: const Text('All new messages')),
            .radio(value: .direct, label: const Text('Direct messages and mentions')),
            .radio(value: .nothing, label: const Text('Nothing')),
          ],
        ),
        const SizedBox(height: 20),
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
