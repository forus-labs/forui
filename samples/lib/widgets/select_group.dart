import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

enum Sidebar { recents, home, applications }

enum Language { dart, java, rust, python }

enum Notification { all, direct, nothing }

@RoutePage()
class SelectGroupPage extends Sample {
  SelectGroupPage({@queryParam super.theme, super.maxWidth = 250});

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FSelectGroup(
        controller: FSelectGroupController(values: {Sidebar.recents}),
        label: const Text('Sidebar'),
        description: const Text('These will be shown in the sidebar.'),
        children: [
          FCheckbox.grouped(value: Sidebar.recents, label: const Text('Recents')),
          FCheckbox.grouped(value: Sidebar.home, label: const Text('Home')),
          FCheckbox.grouped(value: Sidebar.applications, label: const Text('Applications')),
        ],
      ),
    ],
  );
}

@RoutePage()
class SelectGroupCheckboxFormPage extends StatefulSample {
  SelectGroupCheckboxFormPage({@queryParam super.theme, super.maxWidth = 250});

  @override
  State<SelectGroupCheckboxFormPage> createState() => _CheckboxFormState();
}

class _CheckboxFormState extends StatefulSampleState<SelectGroupCheckboxFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final controller = FSelectGroupController<Language>();

  @override
  Widget sample(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FSelectGroup(
          controller: controller,
          label: const Text('Favorite Languages'),
          description: const Text('Your favorite language.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select at least one language.' : null,
          children: [
            FCheckbox.grouped(value: Language.dart, label: const Text('Dart')),
            FCheckbox.grouped(value: Language.java, label: const Text('Java')),
            FCheckbox.grouped(value: Language.rust, label: const Text('Rust')),
            FCheckbox.grouped(value: Language.python, label: const Text('Python')),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          child: const Text('Submit'),
          onPress: () {
            if (!_formKey.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _formKey.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class SelectGroupRadioFormPage extends StatefulSample {
  SelectGroupRadioFormPage({@queryParam super.theme, super.maxWidth = 320});

  @override
  State<SelectGroupRadioFormPage> createState() => _RadioFormState();
}

class _RadioFormState extends StatefulSampleState<SelectGroupRadioFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final controller = FSelectGroupController<Notification>.radio();

  @override
  Widget sample(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FSelectGroup(
          controller: controller,
          label: const Text('Notifications'),
          description: const Text('Select the notifications.'),
          validator: (values) => values?.isEmpty ?? true ? 'Please select a value.' : null,
          children: [
            FRadio.grouped(value: Notification.all, label: const Text('All new messages')),
            FRadio.grouped(value: Notification.direct, label: const Text('Direct messages and mentions')),
            FRadio.grouped(value: Notification.nothing, label: const Text('Nothing')),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          child: const Text('Save'),
          onPress: () {
            if (!_formKey.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _formKey.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
