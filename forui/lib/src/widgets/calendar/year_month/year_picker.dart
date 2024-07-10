part of '../calendar.dart';

@internal
class YearPicker extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate start;
  final LocalDate end;
  final LocalDate current;
  final ValueChanged<LocalDate> onPress;

  const YearPicker({
    required this.style,
    required this.start,
    required this.end,
    required this.current,
    required this.onPress,
    super.key,
  });

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  static const _columns = 3;

  static int delta(LocalDate start, LocalDate end) => ((end.year - start.year + 1) / 12).ceil();

  final GlobalKey key = GlobalKey();
  late LocalDate _current;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _current = widget.current.truncate(to: DateUnit.years);
    _controller = PageController(initialPage: delta(widget.start, widget.end));
  }

  @override
  Widget build(BuildContext context) {
    final initial = widget.start.truncate(to: DateUnit.years);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Controls(
            style: widget.style.headerStyle,
            onPrevious: _first ? null : _handlePrevious,
            onNext: _last ? null : _handleNext,
          ),
        ),
        Expanded(
          child: PageView.builder(
            key: key,
            controller: _controller,
            itemBuilder: (context, index) => GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.618,
              ),
              children: [
                for (var year = initial.plus(years: index * 12), i = 0; i < 12; year = year.plus(years: 1), i++)
                  yearMonth(
                    widget.style.yearMonthPickerStyle,
                    year,
                    widget.onPress,
                    (date) => '${date.year}', // TODO: localize
                    enabled: widget.start <= year && year <= widget.end,
                    current: widget.current.year == year.year,
                  )
              ],
            ),
            itemCount: delta(widget.start, widget.end),
          ),
        ),
      ],
    );
  }

  /// Navigate to the next month.
  void _handleNext() {
    if (!_last) {
      _controller.nextPage(
        duration: widget.style.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  /// Navigate to the previous month.
  void _handlePrevious() {
    if (!_first) {
      _controller.previousPage(
        duration: widget.style.pageAnimationDuration,
        curve: Curves.ease,
      );
    }
  }

  /// True if the earliest allowable years are displayed.
  bool get _first => delta(widget.start, _current) == 0;

  /// True if the latest allowable years are displayed.
  bool get _last {
    return delta(widget.start, _current) == delta(widget.start, widget.end);
  }
}
