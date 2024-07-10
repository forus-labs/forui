part of '../calendar.dart';

/// Returns the [date].
@internal
Widget day(
  FCalendarDayPickerStyle monthStyle,
  LocalDate date,
  FocusNode focusNode,
  bool Function(LocalDate day) selectedPredicate,
  ValueChanged<LocalDate> onPress,
  ValueChanged<LocalDate> onLongPress, {
  required bool enabled,
  required bool current,
  required bool today,
  required bool selected,
}) {
  final styles = enabled ? monthStyle.enabled : monthStyle.disabled;
  final dayStyle = current ? styles.current : styles.enclosing;
  final style = switch ((today, selected)) {
    (_, true) => dayStyle.selectedStyle,
    (false, _) => dayStyle.unselectedStyle,
    (true, _) => dayStyle.todayStyle,
  };

  if (enabled) {
    return EnabledDay(
      style: style,
      date: date,
      focusNode: focusNode,
      selectedPredicate: selectedPredicate,
      onPress: onPress,
      onLongPress: onLongPress,
      today: today,
      selected: selected,
    );
  } else {
    return DisabledDay(style: style, date: date, selectedPredicate: selectedPredicate);
  }
}

@internal
class EnabledDay extends StatefulWidget {
  final FCalendarDayStateStyle style;
  final LocalDate date;
  final FocusNode focusNode;
  final bool Function(LocalDate day) selectedPredicate;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;
  final bool today;
  final bool selected;

  const EnabledDay({
    required this.style,
    required this.date,
    required this.focusNode,
    required this.selectedPredicate,
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
      ..add(DiagnosticsProperty('selectedPredicate', selectedPredicate, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress, level: DiagnosticLevel.debug))
      ..add(FlagProperty('today', value: today, ifTrue: 'today', level: DiagnosticLevel.debug))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected', level: DiagnosticLevel.debug));
  }
}

class _EnabledDayState extends State<EnabledDay> {
  bool _focused = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_updateFocused);
  }

  @override
  void didUpdateWidget(EnabledDay old) {
    super.didUpdateWidget(old);
    old.focusNode.removeListener(_updateFocused);
    widget.focusNode.addListener(_updateFocused);
  }
  
  @override
  Widget build(BuildContext context) => Focus(
        focusNode: widget.focusNode,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: Semantics(
            label: '${widget.date}${widget.today ? ', Today' : ''}', // TODO: localization
            button: true,
            selected: widget.selected,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () => widget.onPress(widget.date),
              onLongPress: () => widget.onLongPress(widget.date),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: widget.selectedPredicate(widget.date.yesterday) ? Radius.zero : const Radius.circular(4),
                    right: widget.selectedPredicate(widget.date.tomorrow) ? Radius.zero : const Radius.circular(4),
                  ),
                  color: _focused || _hovered ? widget.style.focusedBackgroundColor : widget.style.backgroundColor,
                ),
                child: Center(
                  child: Text(
                    '${widget.date.day}', // TODO: localization
                    style: _focused || _hovered ? widget.style.focusedTextStyle : widget.style.textStyle,
                  ),
                ),
              ),
            ),
          ),
        ),
      );


  @override
  void dispose() {
    widget.focusNode.removeListener(_updateFocused);
    super.dispose();
  }

  void _updateFocused() => setState(() => _focused = widget.focusNode.hasFocus);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('focused', value: _hovered, ifTrue: 'focused'));
  }
}

@internal
class DisabledDay extends StatelessWidget {
  final FCalendarDayStateStyle style;
  final LocalDate date;
  final bool Function(LocalDate day) selectedPredicate;

  const DisabledDay({
    required this.style,
    required this.date,
    required this.selectedPredicate,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: style.backgroundColor,
          ),
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
      ..add(DiagnosticsProperty('date', date, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('selectedPredicate', selectedPredicate));
  }
}

/// A calender day's style.
///
/// [selectedStyle] takes precedence over [unselectedStyle] and [todayStyle]. For example, if the current date is
/// selected, [selectedStyle] will be applied.
final class FCalendarDayStyle with Diagnosticable {
  /// The current date's style.
  final FCalendarDayStateStyle todayStyle;

  /// The unselected dates' style.
  final FCalendarDayStateStyle unselectedStyle;

  /// The selected dates' style.
  ///
  /// This style takes precedence over [unselectedStyle] and [todayStyle]. For example, if the current date is
  /// selected, [todayStyle] will be applied.
  final FCalendarDayStateStyle selectedStyle;

  /// Creates a [FCalendarDayStyle].
  const FCalendarDayStyle({
    required this.todayStyle,
    required this.unselectedStyle,
    required this.selectedStyle,
  });

  /// Returns a copy of this [FCalendarDayStyle] but with the given fields replaced with the new values.
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
  FCalendarDayStyle copyWith({
    FCalendarDayStateStyle? todayStyle,
    FCalendarDayStateStyle? unselectedStyle,
    FCalendarDayStateStyle? selectedStyle,
  }) =>
      FCalendarDayStyle(
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
      other is FCalendarDayStyle &&
          runtimeType == other.runtimeType &&
          todayStyle == other.todayStyle &&
          unselectedStyle == other.unselectedStyle &&
          selectedStyle == other.selectedStyle;

  @override
  int get hashCode => todayStyle.hashCode ^ unselectedStyle.hashCode ^ selectedStyle.hashCode;
}

/// A calendar day state's style.
final class FCalendarDayStateStyle with Diagnosticable {
  /// The unfocused day's background color.
  final Color backgroundColor;

  /// The unfocused day's text style.
  final TextStyle textStyle;

  /// The focused day's background color. Defaults to [backgroundColor].
  final Color focusedBackgroundColor;

  /// The focused day's text style. Defaults to [textStyle].
  final TextStyle focusedTextStyle;

  /// Creates a [FCalendarDayStateStyle].
  FCalendarDayStateStyle({
    required this.backgroundColor,
    required this.textStyle,
    Color? focusedBackgroundColor,
    TextStyle? focusedTextStyle,
  })  : focusedBackgroundColor = focusedBackgroundColor ?? backgroundColor,
        focusedTextStyle = focusedTextStyle ?? textStyle;

  /// Creates a [FCalendarDayStateStyle] that inherits the given colors.
  FCalendarDayStateStyle.inherit({
    required Color backgroundColor,
    required TextStyle textStyle,
    Color? focusedBackgroundColor,
    TextStyle? focusedTextStyle,
  }) : this(
          backgroundColor: backgroundColor,
          textStyle: textStyle,
          focusedBackgroundColor: focusedBackgroundColor ?? backgroundColor,
          focusedTextStyle: focusedTextStyle ?? textStyle,
        );

  /// Returns a copy of this [FCalendarDayStateStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FDayStateStyle(
  ///   backgroundColor: ...,
  ///   textStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   textStyle: ...,
  /// );
  ///
  /// print(style.backgroundColor == copy.backgroundColor); // true
  /// print(style.textStyle == copy.textStyle); // false
  /// ```
  FCalendarDayStateStyle copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    Color? focusedBackgroundColor,
    TextStyle? focusedTextStyle,
  }) =>
      FCalendarDayStateStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textStyle: textStyle ?? this.textStyle,
        focusedBackgroundColor: focusedBackgroundColor ?? this.focusedBackgroundColor,
        focusedTextStyle: focusedTextStyle ?? this.focusedTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('focusedBackgroundColor', focusedBackgroundColor))
      ..add(DiagnosticsProperty('focusedTextStyle', focusedTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarDayStateStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          textStyle == other.textStyle &&
          focusedBackgroundColor == other.focusedBackgroundColor &&
          focusedTextStyle == other.focusedTextStyle;

  @override
  int get hashCode => backgroundColor.hashCode ^ textStyle.hashCode ^ focusedBackgroundColor.hashCode ^ focusedTextStyle.hashCode;
}
