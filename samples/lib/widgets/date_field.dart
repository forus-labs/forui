import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class DateFieldPage extends Sample {
  DateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: FDateField(label: const Text('Appointment Date'), description: const Text('Select a date for your appointment')),
  );
}

@RoutePage()
class CalendarDateFieldPage extends Sample {
  CalendarDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30),
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
  ClearableDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  State<ClearableDateFieldPage> createState() => _ClearableDateFieldPageState();
}

class _ClearableDateFieldPageState extends StatefulSampleState<ClearableDateFieldPage>
    with SingleTickerProviderStateMixin {
  late final FDateFieldController _controller = FDateFieldController(vsync: this, initialDate: DateTime.now());

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: FDateField(
      controller: _controller,
      label: const Text('Appointment Date'),
      description: const Text('Select a date for your appointment'),
      clearable: true,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class ValidatorDateFieldPage extends StatefulSample {
  ValidatorDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  State<ValidatorDateFieldPage> createState() => _ValidationDatePickerPageState();
}

class _ValidationDatePickerPageState extends StatefulSampleState<ValidatorDateFieldPage>
    with SingleTickerProviderStateMixin {
  late final FDateFieldController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FDateFieldController(vsync: this, validator: _validate);
  }

  String? _validate(DateTime? date) => date?.weekday == 6 || date?.weekday == 7 ? 'Date cannot be a weekend.' : null;

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30),
    child: FDateField(
      controller: _controller,
      label: const Text('Appointment Date'),
      description: const Text('Select a date for your appointment'),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class FormDateFieldPage extends StatefulSample {
  FormDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  State<FormDateFieldPage> createState() => _FormDatePickerPageState();
}

class _FormDatePickerPageState extends StatefulSampleState<FormDateFieldPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FDateFieldController _startDateController;
  late final FDateFieldController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = FDateFieldController(vsync: this, validator: _validateStartDate);
    _endDateController = FDateFieldController(vsync: this, validator: _validateEndDate);
  }

  String? _validateStartDate(DateTime? date) {
    if (date == null) {
      return 'Please select a start date';
    }
    if (date.isBefore(DateTime.now())) {
      return 'Start date must be in the future';
    }
    return null;
  }

  String? _validateEndDate(DateTime? date) {
    if (date == null) {
      return 'Please select an end date';
    }
    if (_startDateController.value != null && date.isBefore(_startDateController.value!)) {
      return 'End date must be after start date';
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
          FDateField(
            controller: _startDateController,
            label: const Text('Start Date'),
            description: const Text('Select a start date'),
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(height: 20),
          FDateField(
            controller: _endDateController,
            label: const Text('End Date'),
            description: const Text('Select an end date'),
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(height: 25),
          FButton(
            child: const Text('Submit'),
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
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
