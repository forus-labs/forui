import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TimeFieldPage extends Sample {
  final bool hour24;

  TimeFieldPage({@queryParam this.hour24 = false, @queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTimeField(
    hour24: hour24,
    label: const Text('Appointment Time'),
    description: const Text('Select a Time for your appointment.'),
  );
}

@RoutePage()
class PickerTimeFieldPage extends Sample {
  PickerTimeFieldPage({@queryParam super.theme}): super(alignment: .topCenter, top: 30);

  @override
  Widget sample(BuildContext _) => const FTimeField.picker(
    label: Text('Appointment Time'),
    description: Text('Select a time for your appointment.'),
  );
}

@RoutePage()
class ValidatorTimeFieldPage extends Sample {
  ValidatorTimeFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTimeField(
    control: .managed(validator: (time) => time?.hour == 12 ? 'Time cannot be noon.' : null),
    label: const Text('Appointment Time'),
    description: const Text('Select a time for your appointment.'),
  );
}

@RoutePage()
class FormTimeFieldPage extends StatefulSample {
  FormTimeFieldPage({@queryParam super.theme}): super(top: 30);

  @override
  State<FormTimeFieldPage> createState() => _FormTimeFieldPageState();
}

class _FormTimeFieldPageState extends StatefulSampleState<FormTimeFieldPage> {
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
  Widget sample(BuildContext _) => Form(
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
