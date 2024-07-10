part of '../calendar.dart';

/// Returns the [date].
@internal
Widget day(
  FCalendarDayPickerStyle pickerStyle,
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
  final styles = enabled ? pickerStyle.enabledStyles : pickerStyle.disabledStyles;
  final dayStyle = current ? styles.current : styles.enclosing;
  final style = selected ? dayStyle.selectedStyle : dayStyle.unselectedStyle;

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
    return DisabledDay(style: style, date: date, today: today, selectedPredicate: selectedPredicate);
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
  Widget build(BuildContext context) {
    var textStyle = _focused || _hovered ? widget.style.focusedTextStyle : widget.style.textStyle;
    if (widget.today) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return Focus(
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
                  child: Text('${widget.date.day}', style: textStyle), // TODO: localization
                ),
              ),
            ),
          ),
        ),
      );
  }


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
  final bool today;
  final bool Function(LocalDate day) selectedPredicate;

  const DisabledDay({
    required this.style,
    required this.date,
    required this.today,
    required this.selectedPredicate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = style.textStyle;
    if (today) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: selectedPredicate(date.yesterday) ? Radius.zero : const Radius.circular(4),
              right: selectedPredicate(date.tomorrow) ? Radius.zero : const Radius.circular(4),
            ),
            color: style.backgroundColor,
          ),
          child: Center(
            child: Text('${date.day}', style: textStyle), // TODO: localization
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
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('selectedPredicate', selectedPredicate));
  }
}

/// A calender day's style.
final class FCalendarDayStyle with Diagnosticable {
  /// The selected dates' style.
  final FCalendarDayStateStyle selectedStyle;
  /// The unselected dates' style.
  final FCalendarDayStateStyle unselectedStyle;

  /// Creates a [FCalendarDayStyle].
  const FCalendarDayStyle({
    required this.unselectedStyle,
    required this.selectedStyle,
  });

  /// Returns a copy of this [FCalendarDayStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FDayStyle(
  ///   selectedStyle: ...,
  ///   unselectedStyle: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   unselectedStyle: ...,
  /// );
  ///
  /// print(style.selectedStyle == copy.selectedStyle); // true
  /// print(style.unselectedStyle == copy.unselectedStyle); // false
  /// ```
  FCalendarDayStyle copyWith({
    FCalendarDayStateStyle? selectedStyle,
    FCalendarDayStateStyle? unselectedStyle,
  }) =>
      FCalendarDayStyle(
        selectedStyle: selectedStyle ?? this.selectedStyle,
        unselectedStyle: unselectedStyle ?? this.unselectedStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedStyle', selectedStyle))
      ..add(DiagnosticsProperty('unselectedStyle', unselectedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarDayStyle &&
          runtimeType == other.runtimeType &&
          unselectedStyle == other.unselectedStyle &&
          selectedStyle == other.selectedStyle;

  @override
  int get hashCode => unselectedStyle.hashCode ^ selectedStyle.hashCode;
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
