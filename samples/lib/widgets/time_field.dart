import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TimeFieldPage extends Sample {
  final bool hour24;

  TimeFieldPage({@queryParam this.hour24 = false, @queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FTimeField(
    hour24: hour24,
    label: const Text('Appointment Time'),
    description: const Text('Select a Time for your appointment.'),
  );
}

@RoutePage()
class PickerTimeFieldPage extends Sample {
  PickerTimeFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => const Padding(
    padding: .only(top: 30),
    child: FTimeField.picker(label: Text('Appointment Time'), description: Text('Select a time for your appointment.')),
  );
}

@RoutePage()
class ValidatorTimeFieldPage extends StatefulSample {
  ValidatorTimeFieldPage({@queryParam super.theme});

  @override
  State<ValidatorTimeFieldPage> createState() => _ValidationTimePickerPageState();
}

class _ValidationTimePickerPageState extends StatefulSampleState<ValidatorTimeFieldPage>
    with SingleTickerProviderStateMixin {
  late final _controller = FTimeFieldController(vsync: this, validator: _validate);

  String? _validate(FTime? time) => time?.hour == 12 ? 'Time cannot be noon.' : null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FTimeField(
    control: .managed(controller: _controller),
    label: const Text('Appointment Time'),
    description: const Text('Select a time for your appointment.'),
  );
}

@RoutePage()
class FormTimeFieldPage extends StatefulSample {
  FormTimeFieldPage({@queryParam super.theme});

  @override
  State<FormTimeFieldPage> createState() => _FormTimeFieldPageState();
}

class _FormTimeFieldPageState extends StatefulSampleState<FormTimeFieldPage> with TickerProviderStateMixin {
  final _key = GlobalKey<FormState>();
  late final _startTimeController = FTimeFieldController(vsync: this, validator: _validateStartTime);
  late final _endTimeController = FTimeFieldController(vsync: this, validator: _validateEndTime);

  String? _validateStartTime(FTime? time) => switch (time) {
    null => 'Please select a start time.',
    _ when time < .now() => 'Start Time must be in the future.',
    _ => null,
  };

  String? _validateEndTime(FTime? time) => switch (time) {
    null => 'Please select an end time.',
    _ when _startTimeController.value != null && time < _startTimeController.value! =>
      'End Time must be after start time.',
    _ => null,
  };

  @override
  void dispose() {
    _endTimeController.dispose();
    _startTimeController.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .all(30.0),
    child: Form(
      key: _key,
      child: Column(
        children: [
          FTimeField(
            control: .managed(controller: _startTimeController),
            label: const Text('Start Time'),
            description: const Text('Select a start time.'),
            autovalidateMode: .disabled,
          ),
          const SizedBox(height: 20),
          FTimeField(
            control: .managed(controller: _endTimeController),
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
    ),
  );
}
