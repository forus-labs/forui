part of '../calendar.dart';

/// Returns the current year/month.
@internal
Widget yearMonth(
  FCalendarYearMonthPickerStyle pickerStyle,
  LocalDate date,
  ValueChanged<LocalDate> onPress,
  String Function(LocalDate) localize, {
  required bool enabled,
  required bool current,
}) {
  final style = enabled ? pickerStyle.enabledStyle : pickerStyle.disabledStyle;
  if (enabled) {
    return EnabledYearMonth(
      style: style,
      date: date,
      onPress: onPress,
      localize: localize,
      current: current,
    );
  } else {
    return DisabledYearMonth(
      style: style,
      date: date,
      localize: localize,
      current: current,
    );
  }
}

@internal
class EnabledYearMonth extends StatefulWidget {
  final FCalendarYearMonthPickerStateStyle style;
  final LocalDate date;
  final bool current;
  final ValueChanged<LocalDate> onPress;
  final String Function(LocalDate) localize;

  const EnabledYearMonth({
    required this.style,
    required this.date,
    required this.current,
    required this.onPress,
    required this.localize,
    super.key,
  });

  @override
  State<EnabledYearMonth> createState() => _EnabledYearMonthState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('date', date, level: DiagnosticLevel.debug))
      ..add(FlagProperty('current', value: current, ifTrue: 'current', level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('localize', localize, level: DiagnosticLevel.debug));
  }
}

class _EnabledYearMonthState extends State<EnabledYearMonth> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    var textStyle = _hovered ? widget.style.focusedTextStyle : widget.style.textStyle;
    if (widget.current) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Semantics(
        label: widget.localize(widget.date),
        button: true,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: () => widget.onPress(widget.date),
          child: DecoratedBox(
            decoration: _hovered ? widget.style.focusedDecoration : widget.style.decoration,
            child: Center(
              child: Text(widget.localize(widget.date), style: textStyle),
            ),
          ),
        ),
      ),
    );
  }
}

@internal
class DisabledYearMonth extends StatelessWidget {
  final FCalendarYearMonthPickerStateStyle style;
  final LocalDate date;
  final bool current;
  final String Function(LocalDate) localize;

  const DisabledYearMonth({
    required this.style,
    required this.date,
    required this.current,
    required this.localize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = style.textStyle;
    if (current) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: style.decoration,
        child: Center(
          child: Text(localize(date), style: textStyle),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('date', date, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('current', current))
      ..add(DiagnosticsProperty('localize', localize));
  }
}

final class FCalendarYearMonthPickerStyle with Diagnosticable {
  final FCalendarYearMonthPickerStateStyle enabledStyle;
  final FCalendarYearMonthPickerStateStyle disabledStyle;

  FCalendarYearMonthPickerStyle({required this.enabledStyle, required this.disabledStyle});

  FCalendarYearMonthPickerStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          enabledStyle: FCalendarYearMonthPickerStateStyle(
            decoration: const BoxDecoration(),
            textStyle: typography.sm.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w500),
            focusedDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorScheme.secondary,
            ),
          ),
          disabledStyle: FCalendarYearMonthPickerStateStyle(
            decoration: const BoxDecoration(),
            textStyle: typography.sm
                .copyWith(color: colorScheme.mutedForeground.withOpacity(0.5), fontWeight: FontWeight.w500),
          ),
        );
}

final class FCalendarYearMonthPickerStateStyle with Diagnosticable {
  final BoxDecoration decoration;
  final TextStyle textStyle;
  final BoxDecoration focusedDecoration;
  final TextStyle focusedTextStyle;

  FCalendarYearMonthPickerStateStyle({
    required this.decoration,
    required this.textStyle,
    BoxDecoration? focusedDecoration,
    TextStyle? focusedTextStyle,
  })  : focusedDecoration = focusedDecoration ?? decoration,
        focusedTextStyle = focusedTextStyle ?? textStyle;
}
