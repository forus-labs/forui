part of 'calendar.dart';

/// Returns the [date].
@internal
Widget day(
  FMonthStyle monthStyle,
  LocalDate date,
  FocusNode focusNode,
  ValueChanged<DateTime> onPress,
  ValueChanged<DateTime> onLongPress, {
  required bool enabled,
  required bool current,
  required bool today,
  required bool selected,
}) {
  final styles = enabled ? monthStyle.enabled : monthStyle.disabled;
  final dayStyle = current ? styles.current : styles.enclosing;
  final style = switch ((today, selected)) {
    (true, _) => dayStyle.todayStyle,
    (_, true) => dayStyle.selectedStyle,
    (_, false) => dayStyle.unselectedStyle,
  };

  if (enabled) {
    return EnabledDay(
      style: style,
      date: date,
      focusNode: focusNode,
      onPress: onPress,
      onLongPress: onLongPress,
      today: today,
      selected: selected,
    );
  } else {
    return DisabledDay(style: style, date: date);
  }
}

@internal
class EnabledDay extends StatefulWidget {
  final FDayStateStyle style;
  final LocalDate date;
  final FocusNode focusNode;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;
  final bool today;
  final bool selected;

  const EnabledDay({
    required this.style,
    required this.date,
    required this.focusNode,
    required this.onPress,
    required this.onLongPress,
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
      ..add(DiagnosticsProperty('focusNode', focusNode, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress, level: DiagnosticLevel.debug))
      ..add(FlagProperty('today', value: today, ifTrue: 'today', level: DiagnosticLevel.debug))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', level: DiagnosticLevel.debug));
  }
}

class _EnabledDayState extends State<EnabledDay> {
  bool focused = false;

  @override
  Widget build(BuildContext context) => Focus(
        focusNode: widget.focusNode,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => focused = true),
          onExit: (_) => setState(() => focused = false),
          child: Semantics(
            label: '${widget.date}${widget.today ? ', Today' : ''}', // TODO: localization
            button: true,
            selected: widget.selected,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () => widget.onPress(widget.date.toNative()),
              onLongPress: () => widget.onLongPress(widget.date.toNative()),
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
  final FDayStateStyle style;
  final LocalDate date;

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

/// A calender day's style.
///
/// [todayStyle] takes precedence over [unselectedStyle] and [selectedStyle]. For example, if the current date is
/// selected, [todayStyle] will be applied.
final class FDayStyle with Diagnosticable {
  /// The current date's style.
  ///
  /// This style takes precedence over [unselectedStyle] and [selectedStyle]. For example, if the current date is
  /// selected, [todayStyle] will be applied.
  final FDayStateStyle todayStyle;

  /// The unselected dates' style.
  final FDayStateStyle unselectedStyle;

  /// The selected dates' style.
  final FDayStateStyle selectedStyle;

  /// Creates a [FDayStyle].
  const FDayStyle({
    required this.todayStyle,
    required this.unselectedStyle,
    required this.selectedStyle,
  });

  /// Returns a copy of this [FDayStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FDayStyle(
  ///   todayStyle: ...,
  ///   unselectedStyle: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   unselectedStyle: ...,
  /// );
  ///
  /// print(style.todayStyle == copy.todayStyle); // true
  /// print(style.unselectedStyle == copy.unselectedStyle); // false
  /// ```
  FDayStyle copyWith({
    FDayStateStyle? todayStyle,
    FDayStateStyle? unselectedStyle,
    FDayStateStyle? selectedStyle,
  }) =>
      FDayStyle(
        todayStyle: todayStyle ?? this.todayStyle,
        unselectedStyle: unselectedStyle ?? this.unselectedStyle,
        selectedStyle: selectedStyle ?? this.selectedStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('todayStyle', todayStyle))
      ..add(DiagnosticsProperty('unselectedStyle', unselectedStyle))
      ..add(DiagnosticsProperty('selectedStyle', selectedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDayStyle &&
          runtimeType == other.runtimeType &&
          todayStyle == other.todayStyle &&
          unselectedStyle == other.unselectedStyle &&
          selectedStyle == other.selectedStyle;

  @override
  int get hashCode => todayStyle.hashCode ^ unselectedStyle.hashCode ^ selectedStyle.hashCode;
}

/// A calendar day state's style.
final class FDayStateStyle with Diagnosticable {
  /// The unfocused day's decoration.
  final BoxDecoration decoration;

  /// The unfocused day's text style.
  final TextStyle textStyle;

  /// The focused day's decoration. Defaults to [decoration].
  final BoxDecoration focusedDecoration;

  /// The focused day's text style. Defaults to [textStyle].
  final TextStyle focusedTextStyle;

  /// Creates a [FDayStateStyle].
  FDayStateStyle({
    required this.decoration,
    required this.textStyle,
    BoxDecoration? focusedDecoration,
    TextStyle? focusedTextStyle,
  })  : focusedDecoration = focusedDecoration ?? decoration,
        focusedTextStyle = focusedTextStyle ?? textStyle;

  /// Creates a [FDayStateStyle] that inherits the given colors.
  FDayStateStyle.inherit({
    required TextStyle textStyle,
    Color? color,
    Color? focusedColor,
    TextStyle? focusedTextStyle,
  }) : this(
          decoration: color == null
              ? const BoxDecoration()
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: color,
                ),
          textStyle: textStyle,
          focusedDecoration: (focusedColor ?? color) == null
              ? const BoxDecoration()
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: focusedColor ?? color,
                ),
          focusedTextStyle: focusedTextStyle ?? textStyle,
        );

  /// Returns a copy of this [FDayStateStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FDayStateStyle(
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
  FDayStateStyle copyWith({
    BoxDecoration? decoration,
    TextStyle? textStyle,
    BoxDecoration? focusedDecoration,
    TextStyle? focusedTextStyle,
  }) =>
      FDayStateStyle(
        decoration: decoration ?? this.decoration,
        textStyle: textStyle ?? this.textStyle,
        focusedDecoration: focusedDecoration ?? this.focusedDecoration,
        focusedTextStyle: focusedTextStyle ?? this.focusedTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('focusedDecoration', focusedDecoration))
      ..add(DiagnosticsProperty('focusedTextStyle', focusedTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FDayStateStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          textStyle == other.textStyle &&
          focusedDecoration == other.focusedDecoration &&
          focusedTextStyle == other.focusedTextStyle;

  @override
  int get hashCode => decoration.hashCode ^ textStyle.hashCode ^ focusedDecoration.hashCode ^ focusedTextStyle.hashCode;
}
