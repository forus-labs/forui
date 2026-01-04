import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TimeFieldPage extends Example {
  TimeFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) =>
      const FTimeField(label: Text('Appointment Time'), description: Text('Select a Time for your appointment.'));
}

@RoutePage()
class Hour24TimeFieldPage extends Example {
  Hour24TimeFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FTimeField(
    label: Text('Appointment Time'),
    description: Text('Select a Time for your appointment.'),
    // {@highlight}
    hour24: true,
    // {@endhighlight}
  );
}

@RoutePage()
class PickerTimeFieldPage extends Example {
  PickerTimeFieldPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 30);

  @override
  Widget example(BuildContext _) => const FTimeField.picker(
    label: Text('Appointment Time'),
    description: Text('Select a time for your appointment.'),
  );
}

@RoutePage()
class ValidatorTimeFieldPage extends Example {
  ValidatorTimeFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => FTimeField(
    // {@highlight}
    control: .managed(validator: (time) => time?.hour == 12 ? 'Time cannot be noon.' : null),
    // {@endhighlight}
    label: const Text('Appointment Time'),
    description: const Text('Select a time for your appointment.'),
  );
}

@RoutePage()
class FormTimeFieldPage extends StatefulExample {
  FormTimeFieldPage({@queryParam super.theme}) : super(top: 30);

  @override
  State<FormTimeFieldPage> createState() => _FormTimeFieldPageState();
}

class _FormTimeFieldPageState extends StatefulExampleState<FormTimeFieldPage> {
  final _key = GlobalKey<FormState>();
  late final _startController = FTimeFieldController(
    validator: (time) => switch (time) {
      null => 'Please select a start time.',
      _ when time < .now() => 'Start Time must be in the future.',
      _ => null,
    },
  );

  @override
  void dispose() {
    _startController.dispose();
    super.dispose();
  }

  @override
  Widget example(BuildContext _) => Form(
    key: _key,
    child: Column(
      children: [
        FTimeField(
          control: .managed(controller: _startController),
          label: const Text('Start Time'),
          description: const Text('Select a start time.'),
          autovalidateMode: .disabled,
        ),
        const SizedBox(height: 20),
        FTimeField(
          control: .managed(
            validator: (time) => switch (time) {
              null => 'Please select an end time.',
              _ when _startController.value != null && time < _startController.value! =>
                'End Time must be after start time.',
              _ => null,
            },
          ),
          label: const Text('End Time'),
          description: const Text('Select an end time.'),
          autovalidateMode: .disabled,
        ),
        const SizedBox(height: 25),
        FButton(
          child: const Text('Submit'),
          onPress: () {
            if (_key.currentState!.validate()) {
              // Form is valid, process the dates
            }
          },
        ),
      ],
    ),
  );
}
