import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class LineCalendarPage extends StatefulSample {
  LineCalendarPage({
    @queryParam super.theme,
  }) : super(maxWidth: 600);

  @override
  State<LineCalendarPage> createState() => _State();
}

class _State extends StatefulSampleState<LineCalendarPage> {
  late FCalendarController<DateTime?> controller =
      FCalendarController.date(initialSelection: DateTime.now().subtract(const Duration(days: 1)));

  @override
  Widget sample(BuildContext context) => FLineCalendar(controller: controller);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
