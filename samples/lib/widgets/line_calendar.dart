import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class LineCalendarPage extends Sample {
  LineCalendarPage({@queryParam super.theme}): super(maxWidth: 600);

  @override
  Widget sample(BuildContext _) => FLineCalendar(control: .managed(initial: .now().subtract(const Duration(days: 1))));
}
