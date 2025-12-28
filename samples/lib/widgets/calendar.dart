import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class CalendarPage extends Sample {
  CalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FCalendar(
    // {@highlight}
    control: .managedDate(),
    // {@endhighlight}
    start: DateTime(2000), end: DateTime(2040),
  );
}

@RoutePage()
class DatesCalendarPage extends Sample {
  DatesCalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FCalendar(
    // {@highlight}
    control: .managedDates(initial: {DateTime(2024, 7, 17), DateTime(2024, 7, 20)}),
    // {@endhighlight}
    start: DateTime(2000),
    today: DateTime(2024, 7, 15),
    end: DateTime(2030),
  );
}

@RoutePage()
class UnselectableCalendarPage extends Sample {
  UnselectableCalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FCalendar(
    control: .managedDates(
      initial: {DateTime(2024, 7, 17), DateTime(2024, 7, 20)},
      // {@highlight}
      selectable: (date) => !{DateTime.utc(2024, 7, 18), DateTime.utc(2024, 7, 19)}.contains(date),
      // {@endhighlight}
    ),
    start: DateTime(2000),
    today: DateTime(2024, 7, 15),
    end: DateTime(2030),
  );
}

@RoutePage()
class RangeCalendarPage extends Sample {
  RangeCalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FCalendar(
    // {@highlight}
    control: .managedRange(initial: (DateTime(2024, 7, 17), DateTime(2024, 7, 20))),
    // {@endhighlight}
    start: DateTime(2000),
    today: DateTime(2024, 7, 15),
    end: DateTime(2030),
  );
}
