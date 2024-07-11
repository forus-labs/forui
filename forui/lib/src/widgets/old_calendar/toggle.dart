part of 'calendar.dart';

/// The toggle's height. This is a workaround to the pickers being in a stack alongside the toggle.
@internal
const toggleHeight = 31.0;

class Toggle extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate month;
  final ValueNotifier<FCalendarPickerMode> mode;
  final AnimationController yearMonthPickerController;

  const Toggle({
    super.key,
    required this.style,
    required this.month,
    required this.mode,
    required this.yearMonthPickerController,
  });

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    widget.mode.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        widget.yearMonthPickerController.forward();
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      SizedBox(
        height: toggleHeight,
        child: GestureDetector(
          onTap: () {
            final value = widget.mode.value;
            if (value == FCalendarPickerMode.day) {
              widget.mode.value = FCalendarPickerMode.yearMonth;
            } else {
              widget.mode.value = FCalendarPickerMode.day;
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.month.month} ${widget.month.year}', style: widget.style.headerStyle.headerTextStyle), // TODO: Localization
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(_controller),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FAssets.icons.chevronRight(
                    height: 15,
                    colorFilter: ColorFilter.mode(
                      context.theme.colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
