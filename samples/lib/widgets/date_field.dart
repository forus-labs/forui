import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class DateFieldPage extends Sample {
  DateFieldPage({@queryParam super.theme, super.alignment = .topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .only(top: 30),
    child: FDateField(
      label: const Text('Appointment Date'),
      description: const Text('Select a date for your appointment'),
    ),
  );
}

@RoutePage()
class CalendarDateFieldPage extends Sample {
  CalendarDateFieldPage({@queryParam super.theme, super.alignment = .topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .only(top: 30),
    child: FDateField.calendar(
      label: const Text('Appointment Date'),
      description: const Text('Select a date for your appointment'),
    ),
  );
}

@RoutePage()
class InputDateFieldPage extends Sample {
  InputDateFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FDateField.input(
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class ClearableDateFieldPage extends StatefulSample {
  ClearableDateFieldPage({@queryParam super.theme, super.alignment = .topCenter});

  @override
  State<ClearableDateFieldPage> createState() => _ClearableDateFieldPageState();
}

class _ClearableDateFieldPageState extends StatefulSampleState<ClearableDateFieldPage>
    with SingleTickerProviderStateMixin {
  late final _controller = FDateFieldController(vsync: this, initialDate: .now());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .only(top: 30),
    child: FDateField(
      controller: _controller,
      label: const Text('Appointment Date'),
      description: const Text('Select a date for your appointment'),
      clearable: true,
    ),
  );
}

@RoutePage()
class ValidatorDateFieldPage extends StatefulSample {
  ValidatorDateFieldPage({@queryParam super.theme, super.alignment = .topCenter});

  @override
  State<ValidatorDateFieldPage> createState() => _ValidatorDateFieldPageState();
}

class _ValidatorDateFieldPageState extends StatefulSampleState<ValidatorDateFieldPage> with SingleTickerProviderStateMixin {
  late final _controller = FDateFieldController(vsync: this, validator: _validate);

  String? _validate(DateTime? date) => date?.weekday == 6 || date?.weekday == 7 ? 'Date cannot be a weekend.' : null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .only(top: 30),
    child: FDateField(
      controller: _controller,
      label: const Text('Appointment Date'),
      description: const Text('Select a date for your appointment'),
    ),
  );
}

@RoutePage()
class FormDateFieldPage extends StatefulSample {
  FormDateFieldPage({@queryParam super.theme, super.alignment = .topCenter});

  @override
  State<FormDateFieldPage> createState() => _FormDateFieldPageState();
}

class _FormDateFieldPageState extends StatefulSampleState<FormDateFieldPage> with TickerProviderStateMixin {
  final _key = GlobalKey<FormState>();
  late final _startDateController = FDateFieldController(vsync: this, validator: _validateStartDate);
  late final _endDateController = FDateFieldController(vsync: this, validator: _validateEndDate);

  String? _validateStartDate(DateTime? date) => switch (date) {
    null => 'Please select a start date',
    final date when date.isBefore(.now()) => 'Start date must be in the future',
    _ => null,
  };

  String? _validateEndDate(DateTime? date) => switch (date) {
    null => 'Please select an end date',
    final date when _startDateController.value != null && date.isBefore(_startDateController.value!) =>
      'Start date must be in the future',
    _ => null,
  };

  @override
  void dispose() {
    _endDateController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .all(30.0),
    child: Form(
      key: _key,
      child: Column(
        children: [
          FDateField(
            controller: _startDateController,
            label: const Text('Start Date'),
            description: const Text('Select a start date'),
            autovalidateMode: .disabled,
          ),
          const SizedBox(height: 20),
          FDateField(
            controller: _endDateController,
            label: const Text('End Date'),
            description: const Text('Select an end date'),
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
