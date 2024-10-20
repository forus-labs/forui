import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

enum Sidebar { recents, home, applications }

@RoutePage()
class SelectGroupPage extends SampleScaffold {
  SelectGroupPage({@queryParam super.theme});

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: FSelectGroup(
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
          ),
        ],
      );
}

@RoutePage()
class SelectGroupCheckboxFormPage extends SampleScaffold {
  SelectGroupCheckboxFormPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: const CheckboxForm(),
      );
}

enum Language { dart, java, rust, python }

class CheckboxForm extends StatefulWidget {
  const CheckboxForm({super.key});

  @override
  State<CheckboxForm> createState() => CheckboxFormState();
}

class CheckboxFormState extends State<CheckboxForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FSelectGroup<Language>(
              controller: FMultiSelectGroupController(),
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
}

@RoutePage()
class SelectGroupRadioFormPage extends SampleScaffold {
  SelectGroupRadioFormPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: const RadioForm(),
      );
}

enum Notification { all, direct, nothing }

class RadioForm extends StatefulWidget {
  const RadioForm({super.key});

  @override
  State<RadioForm> createState() => RadioFormState();
}

class RadioFormState extends State<RadioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FSelectGroup<Notification>(
              controller: FRadioSelectGroupController(),
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
}
