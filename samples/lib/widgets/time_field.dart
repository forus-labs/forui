import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TimeFieldPage extends Sample {
  final bool hour24;

  TimeFieldPage({@queryParam super.theme, @queryParam String hour24 = 'false'})
    : hour24 = bool.tryParse(hour24) ?? false;

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
    padding: EdgeInsets.only(top: 30),
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
  late final FTimeFieldController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FTimeFieldController(vsync: this, validator: _validate);
  }

  String? _validate(FTime? time) => time?.hour == 12 ? 'Time cannot be noon.' : null;

  @override
  Widget sample(BuildContext context) => FTimeField(
    controller: _controller,
    label: const Text('Appointment Time'),
    description: const Text('Select a time for your appointment.'),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class FormTimeFieldPage extends StatefulSample {
  FormTimeFieldPage({@queryParam super.theme});

  @override
  State<FormTimeFieldPage> createState() => _FormTimePickerPageState();
}

class _FormTimePickerPageState extends StatefulSampleState<FormTimeFieldPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FTimeFieldController _startTimeController;
  late final FTimeFieldController _endTimeController;

  @override
  void initState() {
    super.initState();
    _startTimeController = FTimeFieldController(vsync: this, validator: _validateStartTime);
    _endTimeController = FTimeFieldController(vsync: this, validator: _validateEndTime);
  }

  String? _validateStartTime(FTime? time) {
    if (time == null) {
      return 'Please select a start time.';
    }
    if (time < FTime.now()) {
      return 'Start Time must be in the future.';
    }
    return null;
  }

  String? _validateEndTime(FTime? time) {
    if (time == null) {
      return 'Please select an end time.';
    }
    if (_startTimeController.value != null && time < _startTimeController.value!) {
      return 'End Time must be after start time.';
    }
    return null;
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.all(30.0),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          FTimeField(
            controller: _startTimeController,
            label: const Text('Start Time'),
            description: const Text('Select a start time.'),
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(height: 20),
          FTimeField(
            controller: _endTimeController,
            label: const Text('End Time'),
            description: const Text('Select an end time.'),
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(height: 25),
          FButton(
            label: const Text('Submit'),
            onPress: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, process the dates
              }
            },
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }
}
