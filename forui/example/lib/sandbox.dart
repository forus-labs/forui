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

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 250,
        child: FPicker(
          style: context.theme.pickerStyle,
          controller: controller,
          children: [
            FPickerWheel(
              flex: 3,
              loop: true,
              children: a.map(Text.new).toList(),
            ),
            FPickerWheel(
              flex: 3,
              loop: true,
              children: a.map(Text.new).toList(),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }
}
