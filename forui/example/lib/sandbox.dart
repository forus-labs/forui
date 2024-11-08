import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

enum Notification { all, direct, nothing }

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FRadioSelectGroupController<Notification> controller = FRadioSelectGroupController();
  late FPopoverController popoverController;

  @override
  void initState() {
    super.initState();
    popoverController = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => FCalendar(
    controller: FCalendarController.dates(
      initialSelections: {DateTime.utc(2024, 7, 17), DateTime.utc(2024, 7, 20)},
    ),
    start: DateTime.utc(2000),
    end: DateTime.utc(2030),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
