import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample.dart';

@RoutePage()
class LineCalendarPage extends Sample {
  LineCalendarPage({
    @queryParam super.theme,
  }) : super(maxWidth: 600);

  @override
  Widget sample(BuildContext context) {
    final date = DateTime.now().subtract(const Duration(days: 1));
    final yesterday = DateTime.utc(date.year, date.month, date.day);
    return FLineCalendar(
      controller: FCalendarController.date(initialSelection: yesterday),
    );
  }
}
