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
  final ValueChanged<DateTime> onLongPress;
  final bool today;
  final bool selected;

  const EnabledDay({
    required this.style,
    required this.date,
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
      ..add(DiagnosticsProperty('onPress', onPress, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('onLongPress', onLongPress, level: DiagnosticLevel.debug))
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
            onLongPress: () => widget.onLongPress(widget.date),
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

/// A month's style.
final class FMonthStyle with Diagnosticable {
  /// The enabled and disabled styles for the current month on display.
  final ({FDayStyle enabled, FDayStyle disabled}) current;

  /// The enabled and disabled styles for the months enclosing the current month on display.
  final ({FDayStyle enabled, FDayStyle disabled}) enclosing;

  /// Creates a [FMonthStyle].
  const FMonthStyle({
    required this.current,
    required this.enclosing,
  });

  /// Creates a [FMonthStyle] that inherits from the given [colorScheme] and [typography].
  factory FMonthStyle.inherit({required FColorScheme colorScheme, required FTypography typography}) {
    final textStyle = typography.sm.copyWith(color: colorScheme.foreground);
    final mutedTextStyle = typography.sm.copyWith(color: colorScheme.mutedForeground);

    final disabled = FDayStyle(
      todayStyle: FDayStateStyle.inherit(
        color: colorScheme.primaryForeground,
        textStyle: mutedTextStyle,
      ),
      unselectedStyle: FDayStateStyle.inherit(
        textStyle: mutedTextStyle,
      ),
      selectedStyle: FDayStateStyle.inherit(
        color: colorScheme.primaryForeground,
        textStyle: mutedTextStyle,
      ),
    );

    return FMonthStyle(
      current: (
        enabled: FDayStyle(
          todayStyle: FDayStateStyle.inherit(
            color: colorScheme.secondary,
            textStyle: textStyle,
          ),
          unselectedStyle: FDayStateStyle.inherit(
            textStyle: textStyle,
            focusedColor: colorScheme.secondary,
          ),
          selectedStyle: FDayStateStyle.inherit(
            color: colorScheme.foreground,
            textStyle: typography.sm.copyWith(color: colorScheme.background),
          ),
        ),
        disabled: disabled,
      ),
      enclosing: (
        enabled: FDayStyle(
          todayStyle: FDayStateStyle.inherit(
            color: colorScheme.primaryForeground,
            textStyle: mutedTextStyle,
            focusedTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
          ),
          unselectedStyle: FDayStateStyle.inherit(
            textStyle: mutedTextStyle,
          ),
          selectedStyle: FDayStateStyle.inherit(
            color: colorScheme.primaryForeground,
            textStyle: mutedTextStyle,
            focusedTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
          ),
        ),
        disabled: disabled,
      ),
    );
  }

  /// Returns a copy of this [FMonthStyle] but with the given fields replaced with the new values.
  FMonthStyle copyWith({
    FDayStyle? currentEnabled,
    FDayStyle? currentDisabled,
    FDayStyle? enclosingEnabled,
    FDayStyle? enclosingDisabled,
  }) =>
      FMonthStyle(
        current: (
          enabled: currentEnabled ?? current.enabled,
          disabled: currentDisabled ?? current.disabled,
        ),
        enclosing: (
          enabled: enclosingEnabled ?? enclosing.enabled,
          disabled: enclosingDisabled ?? enclosing.disabled,
        ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FMonthStyle &&
          runtimeType == other.runtimeType &&
          current == other.current &&
          enclosing == other.enclosing;

  @override
  int get hashCode => current.hashCode ^ enclosing.hashCode;
}

/// A calender day's style.
final class FDayStyle with Diagnosticable {
  /// The current date's style.
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
      ..add(DiagnosticsProperty<FDayStateStyle>('todayStyle', todayStyle))
      ..add(DiagnosticsProperty<FDayStateStyle>('unselectedStyle', unselectedStyle))
      ..add(DiagnosticsProperty<FDayStateStyle>('selectedStyle', selectedStyle));
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
  }): this(
    decoration: color == null ? const BoxDecoration() : BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: color,
    ),
    textStyle: textStyle,
    focusedDecoration: (focusedColor ?? color) == null ? const BoxDecoration(): BoxDecoration(
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
