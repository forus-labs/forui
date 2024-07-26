import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FCalendar(
            controller: FCalendarValueController(),
            initialType: FCalendarPickerType.yearMonth,
            start: DateTime.utc(2000),
            end: DateTime.utc(2030),
          ),
        ],
      );
}
