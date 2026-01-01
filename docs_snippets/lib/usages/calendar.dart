import 'package:forui/forui.dart';

final calendar = FCalendar(
  control: FCalendarControl.managedDate(
    controller: FCalendarController.date(),
    initial: DateTime(2024, 9, 13),
    selectable: (date) => true,
    toggleable: true,
    truncateAndStripTimezone: true,
    onChange: (date) {},
  ),
  style: (style) => style.copyWith(),
  dayBuilder: (context, data, child) => child!,
  start: DateTime(2024),
  end: DateTime(2030),
  today: DateTime(2024, 7, 14),
  initialType: FCalendarPickerType.yearMonth,
  initialMonth: DateTime(2024, 9),
  onMonthChange: (date) {},
  onPress: (date) {},
  onLongPress: (date) {},
);
