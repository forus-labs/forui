// dart format width=80
// ignore_for_file: avoid_redundant_argument_values

import 'package:forui/forui.dart';

final calendar = FCalendar(
  // {@category "Core"}
  style: (style) => style,
  start: .utc(1900),
  end: .utc(2100),
  today: .now(),
  initialMonth: .now(),
  initialType: .day,
  // {@endcategory}
  // {@category "Control"}
  control: .managedDate(),
  // {@endcategory}
  // {@category "Appearance"}
  dayBuilder: FCalendar.defaultDayBuilder,
  // {@endcategory}
  // {@category "Callbacks"}
  onMonthChange: (month) {},
  onPress: (date) {},
  onLongPress: (date) {},
  // {@endcategory}
);

// {@category "Control" "`.lifted()`"}
/// Lifted state control for external state management.
final FCalendarControl<Object?> lifted = .lifted(
  selectable: (date) => true,
  selected: (date) => false,
  select: (date) {},
);

// {@category "Control" "`.managedDate()` with internal controller"}
/// Single date selection with internal management.
final FCalendarControl<DateTime?> managedDateInternal = .managedDate(
  initial: null,
  selectable: (date) => true,
  toggleable: true,
  truncateAndStripTimezone: true,
  onChange: (date) {},
);

// {@category "Control" "`.managedDate()` with external controller"}
/// Single date selection with external controller.
final FCalendarControl<DateTime?> managedDateExternal = .managedDate(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .date(
    initial: null,
    selectable: (date) => true,
    toggleable: true,
    truncateAndStripTimezone: true,
  ),
  onChange: (date) {},
);

// {@category "Control" "`.managedDates()` with internal controller"}
/// Multiple dates selection with internal management.
final FCalendarControl<Set<DateTime>> managedDatesInternal = .managedDates(
  initial: {},
  selectable: (date) => true,
  truncateAndStripTimezone: true,
  onChange: (dates) {},
);

// {@category "Control" "`.managedDates()` with external controller"}
/// Multiple dates selection with external controller.
final FCalendarControl<Set<DateTime>> managedDatesExternal = .managedDates(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .dates(
    initial: {},
    selectable: (date) => true,
    truncateAndStripTimezone: true,
  ),
  onChange: (dates) {},
);

// {@category "Control" "`.managedRange()` with internal controller"}
/// Range selection with internal management.
final FCalendarControl<(DateTime, DateTime)?> managedRangeInternal =
    .managedRange(
      initial: null,
      selectable: (date) => true,
      truncateAndStripTimezone: true,
      onChange: (range) {},
    );

// {@category "Control" "`.managedRange()` with external controller"}
/// Range selection with external controller.
final FCalendarControl<(DateTime, DateTime)?>
managedRangeExternal = .managedRange(
  // For demonstration purposes only. Don't create a controller inline, store it in a State instead.
  controller: .range(
    initial: (.utc(2000), .utc(2001)),
    selectable: (date) => true,
    truncateAndStripTimezone: true,
  ),
  onChange: (range) {},
);
