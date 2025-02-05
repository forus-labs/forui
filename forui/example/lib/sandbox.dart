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
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 20),
          FPagination(
            controller: FPaginationController(
              length: 20,
              page: 4,
            ),
          ),
          const SizedBox(height: 20),
          const FLabel(
            axis: Axis.horizontal,
            label: Text('Label'),
            description: Text('Description'),
            error: Text('Error'),
            state: FLabelState.error,
            child: SizedBox(
              width: 200,
              height: 20,
              child: Placeholder(),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }
}
