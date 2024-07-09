part of 'calendar.dart';

@internal
class PagedMonth extends StatefulWidget {
  final DateTime initialDate;
  final PageController? controller;

  const PagedMonth({required this.initialDate, this.controller, super.key});

  @override
  State<PagedMonth> createState() => _PagedMonthState();
}

class _PagedMonthState extends State<PagedMonth> {
  @override
  Widget build(BuildContext context) {
    final style = FCalendarDayPickerStyle.inherit(colorScheme: context.theme.colorScheme, typography: context.theme.typography);
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: context.theme.style.borderRadius,
          border: Border.all(
            color: context.theme.colorScheme.border,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: SizedBox(
          width: dayDimension * DateTime.daysPerWeek,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(
                style: FCalendarHeaderStyle.inherit(colorScheme: colorScheme, typography: typography),
                month: widget.initialDate,
                onPrevious: () {},
                onNext: () {},
              ),
              SizedBox(
                height: dayDimension * maxMonthRows,
                child: PageView.builder(
                  itemBuilder: (context, index) => DayPicker(
                    focused: null,
                    style: style,
                    month: widget.initialDate.toLocalDate(),
                    today: DateTime(2024, 7, 8).toLocalDate(),
                    enabledPredicate: (_) => true,
                    selectedPredicate: (_) => false,
                    onPress: print,
                    onLongPress: print,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
