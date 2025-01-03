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
            controller: FMultiSelectGroupController(values: {Sidebar.recents}),
            label: const Text('Sidebar'),
            description: const Text('These will be shown in the sidebar.'),
            items: const [
              FSelectGroupItem.checkbox(
                value: Sidebar.recents,
                label: Text('Recents'),
              ),
              FSelectGroupItem.checkbox(
                value: Sidebar.home,
                label: Text('Home'),
              ),
              FSelectGroupItem.checkbox(
                value: Sidebar.applications,
                label: Text('Applications'),
              ),
            ],
          ),
        ],
      );
}

@RoutePage()
class SelectGroupCheckboxFormPage extends StatefulSample {
  SelectGroupCheckboxFormPage({
    @queryParam super.theme,
    super.maxWidth = 250,
  });

  @override
  State<SelectGroupCheckboxFormPage> createState() => _CheckboxFormState();
}

class _CheckboxFormState extends StatefulSampleState<SelectGroupCheckboxFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FMultiSelectGroupController<Language> controller;

  @override
  void initState() {
    super.initState();
    controller = FMultiSelectGroupController();
  }

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
          items: const [
            FSelectGroupItem.checkbox(
              value: Language.dart,
              label: Text('Dart'),
            ),
            FSelectGroupItem.checkbox(
              value: Language.java,
              label: Text('Java'),
            ),
            FSelectGroupItem.checkbox(
              value: Language.rust,
              label: Text('Rust'),
            ),
            FSelectGroupItem.checkbox(
              value: Language.python,
              label: Text('Python'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          label: const Text('Submit'),
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
  SelectGroupRadioFormPage({
    @queryParam super.theme,
    super.maxWidth = 320,
  });

  @override
  State<SelectGroupRadioFormPage> createState() => _RadioFormState();
}

class _RadioFormState extends StatefulSampleState<SelectGroupRadioFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FRadioSelectGroupController<Notification> controller;

  @override
  void initState() {
    super.initState();
    controller = FRadioSelectGroupController();
  }

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
          items: const [
            FSelectGroupItem.radio(
              value: Notification.all,
              label: Text('All new messages'),
            ),
            FSelectGroupItem.radio(
              value: Notification.direct,
              label: Text('Direct messages and mentions'),
            ),
            FSelectGroupItem.radio(
              value: Notification.nothing,
              label: Text('Nothing'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FButton(
          label: const Text('Save'),
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
