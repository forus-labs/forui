part of 'calendar.dart';

@internal
class Month extends StatelessWidget {
  final FMonthStyle style;
  final DateTime month;
  final DateTime today;
  final bool Function(DateTime day) enabledPredicate;
  final bool Function(DateTime day) selectedPredicate;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;

  const Month({
    required this.style,
    required this.month,
    required this.today,
    required this.enabledPredicate,
    required this.selectedPredicate,
    required this.onPress,
    required this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (first, last) = _range(context);
    final days = _headers(context);
    for (var date = first; date.isBefore(last) || date.isAtSameMomentAs(last); date = date.plus(days: 1)) {
      final current = date.month == month.month;
      final selected = selectedPredicate(date);
      final today = date == this.today;

      days.add(
        enabledPredicate(date)
            ? EnabledDay(
                style: _style(style.enabled, current: current, selected: selected, today: today),
                date: date,
                onPress: onPress,
                onLongPress: onLongPress,
                today: today,
                selected: selected,
              )
            : DisabledDay(
                style: _style(style.disabled, current: current, selected: selected, today: today),
                date: date,
              ),
      );
    }

    return GridView.custom(
      physics: const ClampingScrollPhysics(),
      gridDelegate: const _GridDelegate(),
      childrenDelegate: SliverChildListDelegate(
        days,
        addRepaintBoundaries: false,
      ),
    );
  }

  (DateTime, DateTime) _range(BuildContext context) {
    final firstDayOfWeek = style.startDayOfWeek ?? DateTime.sunday; // TODO: Localization
    final firstDayOfMonth = month.firstDayOfMonth;
    var difference = firstDayOfMonth.weekday - firstDayOfWeek;
    if (difference < 0) {
      difference += 7;
    }

    final first = firstDayOfMonth.minus(days: difference);

    final lastDayOfWeek = firstDayOfWeek == DateTime.monday ? DateTime.sunday : firstDayOfWeek - 1;
    final lastDayOfMonth = month.lastDayOfMonth;
    difference = lastDayOfWeek - lastDayOfMonth.weekday;
    if (difference < 0) {
      difference += 7;
    }

    final last = lastDayOfMonth.plus(days: difference);
    
    return (first, last);
  }

  List<Widget> _headers(BuildContext context) {
    final firstDayOfWeek = style.startDayOfWeek ?? DateTime.sunday; // TODO: Localization
    final narrowWeekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']; // TODO: Localization

    return [
      for (int i = firstDayOfWeek, j = 0; j < DateTime.daysPerWeek; i = (i + 1) % DateTime.daysPerWeek, j++)
        ExcludeSemantics(
          child: Center(child: Text(narrowWeekdays[i - 1], style: style.headerTextStyle)),
        ),
    ];
  }

  FDayStateStyle _style(
    ({FDayStyle current, FDayStyle enclosing}) styles, {
    required bool current,
    required bool selected,
    required bool today,
  }) =>
      switch ((current, selected, today)) {
        (true, _, true) => styles.current.todayStyle,
        (false, _, true) => styles.enclosing.todayStyle,
        (true, true, false) => styles.current.selectedStyle,
        (false, true, false) => styles.enclosing.selectedStyle,
        (true, false, false) => styles.current.unselectedStyle,
        (false, false, false) => styles.enclosing.unselectedStyle,
      };
}

/// Based on Material [CalendarDatePicker]'s _DayPickerGridDelegate.
class _GridDelegate extends SliverGridDelegate {

  static const _dayPickerRowHeight = 42.0;
  static const _maxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.

  const _GridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final tileDimension = min(
      _dayPickerRowHeight,
      constraints.viewportMainAxisExtent / (_maxDayPickerRowCount + 1),
    );
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileDimension,
      childMainAxisExtent: tileDimension,
      crossAxisCount: DateTime.daysPerWeek,
      crossAxisStride: tileDimension,
      mainAxisStride: tileDimension,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_GridDelegate oldDelegate) => false;
}

/// A month's style.
final class FMonthStyle with Diagnosticable {
  /// The text style for the day of th week headers.
  final TextStyle headerTextStyle;

  /// The styles for the current month on display and the enclosing months when enabled.
  final ({FDayStyle current, FDayStyle enclosing}) enabled;

  /// The styles for the current month on display and the enclosing months when disabled.
  final ({FDayStyle current, FDayStyle enclosing}) disabled;

  /// The starting day of the week. Defaults to the current locale's preferred starting day of the week if null.
  ///
  /// Specifying [startDayOfWeek] will override the current locale's preferred starting day of the week.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * [startDayOfWeek] < [DateTime.monday]
  /// * [DateTime.sunday] < [startDayOfWeek]
  final int? startDayOfWeek;

  /// Creates a [FMonthStyle].
  const FMonthStyle({
    required this.headerTextStyle,
    required this.enabled, required this.disabled, this.startDayOfWeek,
  }):
    assert(
      startDayOfWeek == null || (DateTime.monday <= startDayOfWeek && startDayOfWeek <= DateTime.sunday),
      'startDayOfWeek must be between DateTime.monday (1) and DateTime.sunday (7).',
    );

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
      headerTextStyle: typography.sm.copyWith(color: colorScheme.secondaryForeground),
      enabled: (
        current: FDayStyle(
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
        enclosing: FDayStyle(
          todayStyle: FDayStateStyle.inherit(
            color: colorScheme.primaryForeground,
            textStyle: mutedTextStyle,
          ),
          unselectedStyle: FDayStateStyle.inherit(
            textStyle: mutedTextStyle,
            focusedColor: colorScheme.primaryForeground,
          ),
          selectedStyle: FDayStateStyle.inherit(
            color: colorScheme.primaryForeground,
            textStyle: mutedTextStyle,
          ),
        ),
      ),
      disabled: (
        current: disabled,
        enclosing: disabled,
      ),
    );
  }

  /// Returns a copy of this [FMonthStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// ```
  FMonthStyle copyWith({
    FDayStyle? currentEnabled,
    FDayStyle? enclosingEnabled,
    FDayStyle? currentDisabled,
    FDayStyle? enclosingDisabled,
  }) =>
      FMonthStyle(
        headerTextStyle: headerTextStyle,
        enabled: (
          current: currentEnabled ?? enabled.current,
          enclosing: enclosingEnabled ?? enabled.enclosing,
        ),
        disabled: (
          current: currentDisabled ?? disabled.current,
          enclosing: enclosingDisabled ?? disabled.enclosing,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabled.current', enabled.current))
      ..add(DiagnosticsProperty('enabled.enclosing', enabled.enclosing))
      ..add(DiagnosticsProperty('disabled.current', disabled.current))
      ..add(DiagnosticsProperty('disabled.enclosing', disabled.enclosing));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FMonthStyle &&
          runtimeType == other.runtimeType &&
          enabled == other.enabled &&
          disabled == other.disabled;

  @override
  int get hashCode => enabled.hashCode ^ disabled.hashCode;
}
