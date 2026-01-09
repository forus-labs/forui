import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class LineCalendarPage extends Example {
  LineCalendarPage({@queryParam super.theme}) : super(maxWidth: 600);

  @override
  Widget example(BuildContext _) => FLineCalendar(control: .managed(initial: .now().subtract(const Duration(days: 1))));
}
