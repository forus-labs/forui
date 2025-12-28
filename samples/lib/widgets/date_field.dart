import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class DateFieldPage extends Sample {
  DateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget sample(BuildContext _) =>
      const FDateField(label: Text('Appointment Date'), description: Text('Select a date for your appointment'));
}

@RoutePage()
class CalendarDateFieldPage extends Sample {
  CalendarDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget sample(BuildContext _) => const FDateField.calendar(
    label: Text('Appointment Date'),
    description: Text('Select a date for your appointment'),
  );
}

@RoutePage()
class InputDateFieldPage extends Sample {
  InputDateFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) =>
      const FDateField.input(label: Text('Appointment Date'), description: Text('Select a date for your appointment'));
}

@RoutePage()
class ClearableDateFieldPage extends Sample {
  ClearableDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget sample(BuildContext _) => FDateField(
    control: .managed(initial: .now()),
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
    // {@highlight}
    clearable: true,
    // {@endhighlight}
  );
}

@RoutePage()
class ValidatorDateFieldPage extends Sample {
  ValidatorDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  Widget sample(BuildContext _) => FDateField(
    control: .managed(
      // {@highlight}
      validator: (date) => date?.weekday == 6 || date?.weekday == 7 ? 'Date cannot be a weekend.' : null,
      // {@endhighlight}
    ),
    label: const Text('Appointment Date'),
    description: const Text('Select a date for your appointment'),
  );
}

@RoutePage()
class FormDateFieldPage extends StatefulSample {
  FormDateFieldPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  State<FormDateFieldPage> createState() => _FormDateFieldPageState();
}

class _FormDateFieldPageState extends StatefulSampleState<FormDateFieldPage> {
  final _key = GlobalKey<FormState>();
  late final _startController = FDateFieldController(
    validator: (date) => switch (date) {
      null => 'Please select a start date',
      final date when date.isBefore(.now()) => 'Start date must be in the future',
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
        FDateField(
          control: .managed(controller: _startController),
          label: const Text('Start Date'),
          description: const Text('Select a start date'),
          autovalidateMode: .disabled,
        ),
        const SizedBox(height: 20),
        FDateField(
          control: .managed(
            validator: (date) => switch (date) {
              null => 'Please select an end date',
              final date when _startController.value != null && date.isBefore(_startController.value!) =>
                'Start date must be in the future',
              _ => null,
            },
          ),
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
  );
}
