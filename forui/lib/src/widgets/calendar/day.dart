part of 'calendar.dart';

// Possible states
// current month, unselected
// current month, today/focused/hovered
// current month, selected
// current month, disabled

// previous month, unselected
// previous month, today/focused/hovered
// previous month, selected
// previous month, disabled

// class DayStyle {
//   final DayStateStyle unselected;
//   final DayStateStyle today;
//   final DayStateStyle selected;
//
//   DayStyle({
//     required this.unselected,
//     required this.today,
//     required this.selected,
//   });
// }

@internal
class EnabledDay extends StatefulWidget {
  final FDayStyle style;
  final DateTime date;
  final ValueChanged<DateTime> onPress;
  final bool today;
  final bool selected;

  const EnabledDay({
    required this.style,
    required this.date,
    required this.onPress,
    required this.today,
    required this.selected,
    super.key,
  });

  @override
  State<EnabledDay> createState() => _EnabledDayState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('date', date, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(FlagProperty('today', value: today, ifTrue: 'today', level: DiagnosticLevel.debug))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', level: DiagnosticLevel.debug));
  }
}

class _EnabledDayState extends State<EnabledDay> {
  bool focused = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => focused = true),
        onExit: (_) => setState(() => focused = false),
        child: Semantics(
          label: '${widget.date}${widget.today ? ', Today' : ''}', // TODO: localization
          button: true,
          selected: widget.selected,
          excludeSemantics: true,
          child: DecoratedBox(
            decoration: focused ? widget.style.focusedDecoration : widget.style.decoration,
            child: Center(
              child: Text(
                '${widget.date.day}', // TODO: localization
                style: focused ? widget.style.focusedTextStyle : widget.style.textStyle,
              ),
            ),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

@internal
class DisabledDay extends StatelessWidget {
  final FDayStyle style;
  final DateTime date;

  const DisabledDay({
    required this.style,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: DecoratedBox(
          decoration: style.decoration,
          child: Center(
            child: Text('${date.day}', style: style.textStyle), // TODO: localization
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('date', date, level: DiagnosticLevel.debug));
  }
}



/// A calendar day's style.
class FDayStyle {
  /// The unfocused day's decoration.
  final BoxDecoration decoration;

  /// The unfocused day's text style.
  final TextStyle textStyle;

  /// The focused day's decoration.
  final BoxDecoration focusedDecoration;

  /// The focused day's text style.
  final TextStyle focusedTextStyle;

  /// Creates a [FDayStyle].
  const FDayStyle({
    required this.decoration,
    required this.textStyle,
    required this.focusedDecoration,
    required this.focusedTextStyle,
  });

  /// Creates a copy of this [FDayStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FDayStyle(
  ///   decoration: ...,
  ///   textStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   textStyle: ...,
  /// );
  ///
  /// print(style.decoration == copy.decoration); // true
  /// print(style.textStyle == copy.textStyle); // false
  /// ```
  FDayStyle copyWith({
    BoxDecoration? decoration,
    TextStyle? textStyle,
    BoxDecoration? focusedDecoration,
    TextStyle? focusedTextStyle,
  }) =>
      FDayStyle(
        decoration: decoration ?? this.decoration,
        textStyle: textStyle ?? this.textStyle,
        focusedDecoration: focusedDecoration ?? this.focusedDecoration,
        focusedTextStyle: focusedTextStyle ?? this.focusedTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDayStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          textStyle == other.textStyle &&
          focusedDecoration == other.focusedDecoration &&
          focusedTextStyle == other.focusedTextStyle;

  @override
  int get hashCode => decoration.hashCode ^ textStyle.hashCode ^ focusedDecoration.hashCode ^ focusedTextStyle.hashCode;
}
