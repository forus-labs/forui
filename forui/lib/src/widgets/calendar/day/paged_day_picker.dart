part of '../calendar.dart';

@internal
class PagedDayPicker extends StatefulWidget {
  final FCalendarDayPickerStyle style;
  final PageController controller;
  final LocalDate first;
  final LocalDate last;
  final LocalDate today;
  final LocalDate? focused;
  final bool Function(DateTime day) enabledPredicate;
  final bool Function(DateTime day) selectedPredicate;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;

  const PagedDayPicker({
    required this.controller,
    required this.style,
    required this.first,
    required this.last,
    required this.today,
    required this.enabledPredicate,
    required this.selectedPredicate,
    required this.onPress,
    required this.onLongPress,
    this.focused,
    super.key,
  });

  @override
  State<PagedDayPicker> createState() => _PageDayPickerState();
}

class _PageDayPickerState extends State<PagedDayPicker> {
  static int offset(LocalDate first, LocalDate last) {
    if (last.year == first.year) {
      return last.month - first.month;
    }

    final years = min(0, last.year - first.year - 1);
    final months = last.month + 12 - first.month;

    return years * 12 + months;
  }

  final GlobalKey _pageViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: dayDimension * maxMonthRows,
    child: PageView.builder(
      key: _pageViewKey,
      itemBuilder: (context, index) => DayPicker(
        focused: widget.focused,
        style: widget.style,
        month: widget.first.plus(months: index),
        today: widget.today,
        enabledPredicate: (_) => true,
        selectedPredicate: widget.selectedPredicate,
        onPress: print,
        onLongPress: print,
      ),
      itemCount: offset(widget.first, widget.last),
    ),
  );
}
