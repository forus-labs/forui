import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

enum Notification { all, direct, nothing }

// change to text widgets.
const a = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late FCalendarController<DateTime?> calendarController = FCalendarController.date();
  late FPickerController controller = FPickerController(initialIndexes: [2, 5]);
  late FTimePickerController timeController = FTimePickerController()..addValueListener((value) => print(value));

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 300, width: 300, child: FTimePicker(controller: timeController)),
      FButton(
        label: const Text('Funny button'),
        onPress: () => timeController.animateTo(FTime(Random().nextInt(24), Random().nextInt(61))),
      ),
    ],
  );

  @override
  void dispose() {
    calendarController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
