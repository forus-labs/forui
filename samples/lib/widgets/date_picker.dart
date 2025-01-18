import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class DatePickerPage extends Sample {
  DatePickerPage({
    @queryParam super.theme,
    super.alignment = Alignment.topCenter,
  });

  @override
  Widget sample(BuildContext context) => const Padding(
        padding: EdgeInsets.only(top: 30),
        child: FDatePicker(
          label: Text('Appointment Date'),
          description: Text('Select a date for your appointment'),
        ),
      );
}

@RoutePage()
class CalendarDatePickerPage extends Sample {
  CalendarDatePickerPage({
    @queryParam super.theme,
    super.alignment = Alignment.topCenter,
  });

  @override
  Widget sample(BuildContext context) => const Padding(
        padding: EdgeInsets.only(top: 30),
        child: FDatePicker.calendar(
          label: Text('Appointment Date'),
          description: Text('Select a date for your appointment'),
        ),
      );
}

@RoutePage()
class InputDatePickerPage extends Sample {
  InputDatePickerPage({
    @queryParam super.theme,
  });

  @override
  Widget sample(BuildContext context) => FDatePicker.input(
        label: const Text('Appointment Date'),
        description: const Text('Select a date for your appointment'),
      );
}

@RoutePage()
class ValidatorDatePickerPage extends StatefulSample {
  ValidatorDatePickerPage({
    @queryParam super.theme,
    super.alignment = Alignment.topCenter,
  });

  @override
  State<ValidatorDatePickerPage> createState() => _ValidationDatePickerPageState();
}

class _ValidationDatePickerPageState extends StatefulSampleState<ValidatorDatePickerPage>
    with SingleTickerProviderStateMixin {
  late final FDatePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FDatePickerController(vsync: this, validator: _validate);
  }

  String? _validate(DateTime? date) => date?.weekday == 6 || date?.weekday == 7 ? 'Date cannot be a weekend.' : null;

  @override
  Widget sample(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: FDatePicker(
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
class FormDatePickerPage extends StatefulSample {
  FormDatePickerPage({
    @queryParam super.theme,
    super.alignment = Alignment.topCenter,
  });

  @override
  State<FormDatePickerPage> createState() => _FormDatePickerPageState();
}

class _FormDatePickerPageState extends StatefulSampleState<FormDatePickerPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FDatePickerController _startDateController;
  late final FDatePickerController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = FDatePickerController(
      vsync: this,
      validator: _validateStartDate,
    );
    _endDateController = FDatePickerController(
      vsync: this,
      validator: _validateEndDate,
    );
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
              FDatePicker(
                controller: _startDateController,
                label: const Text('Start Date'),
                description: const Text('Select a start date'),
                autovalidateMode: AutovalidateMode.disabled,
              ),
              const SizedBox(height: 20),
              FDatePicker(
                controller: _endDateController,
                label: const Text('End Date'),
                description: const Text('Select an end date'),
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
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
