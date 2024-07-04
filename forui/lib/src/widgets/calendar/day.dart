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

@internal
class EnabledDay extends StatefulWidget {
  final FDayStateStyle style;
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
          child: GestureDetector(
            onTap: () => widget.onPress(widget.date),
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

final class FMonthStyle {
  final ({FDayStyle enabled, FDayStyle disabled}) current;
  final ({FDayStyle enabled, FDayStyle disabled}) enclosing;

  FMonthStyle({
    required this.current,
    required this.enclosing,
  });

  // factory FMonthStyle.inherit({required FColorScheme colorScheme, required FTypography typography}) {
  //   final currentEnabledTextStyle = typography.sm.copyWith(color: colorScheme.foreground);
  //   final currentDisabledTextStyle = typography.sm.copyWith(color: colorScheme.mutedForeground);
  //   return FMonthStyle(
  //     current: (
  //       enabled: FDayStyle(
  //         todayStyle: FDayStateStyle(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: colorScheme.secondary,
  //           ),
  //           textStyle: currentEnabledTextStyle,
  //         ),
  //         unselectedStyle: FDayStateStyle(
  //           decoration: const BoxDecoration(),
  //           textStyle: currentEnabledTextStyle,
  //           focusedDecoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: colorScheme.secondary,
  //           ),
  //         ),
  //         selectedStyle: FDayStateStyle(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: colorScheme.foreground,
  //           ),
  //           textStyle: typography.sm.copyWith(color: colorScheme.background),
  //         ),
  //       ),
  //       disabled: FDayStyle(
  //         todayStyle: FDayStateStyle(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: colorScheme.primaryForeground,
  //           ),
  //           textStyle: currentDisabledTextStyle,
  //           focusedTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
  //         ),
  //         unselectedStyle: FDayStateStyle(
  //           decoration: const BoxDecoration(),
  //           textStyle: currentDisabledTextStyle,
  //         ),
  //         selectedStyle: FDayStateStyle(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: colorScheme.primaryForeground,
  //           ),
  //           textStyle: currentDisabledTextStyle,
  //           focusedTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
  //         ),
  //       ),
  //     ),
  //     enclosing: (
  //       enabled:
  //     ),
  //   );
  // }
}

/// A calender day's style.
class FDayStyle {
  /// The current date's style.
  final FDayStateStyle todayStyle;

  /// The unselected dates' style.
  final FDayStateStyle unselectedStyle;

  /// The selected dates' style.
  final FDayStateStyle selectedStyle;

  /// Creates a [FDayStyle].
  FDayStyle({
    required this.todayStyle,
    required this.unselectedStyle,
    required this.selectedStyle,
  });
}

/// A calendar day state's style.
final class FDayStateStyle {
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

  /// Creates a copy of this [FDayStateStyle] but with the given fields replaced with the new values.
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
