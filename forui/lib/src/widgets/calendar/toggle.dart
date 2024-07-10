part of 'calendar.dart';

/// The toggle's height. This is a workaround to the pickers being in a stack alongside the toggle.
@internal
const toggleHeight = 31.0;

class Toggle extends StatefulWidget {
  final FCalendarStyle style;
  final LocalDate month;

  const Toggle({
    super.key,
    required this.style,
    required this.month,
  });

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) =>
      SizedBox(
        height: toggleHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.month.month} ${widget.month.year}', style: widget.style.headerStyle.headerTextStyle),
          ],
        ),
      ); // TODO: Localization
}
