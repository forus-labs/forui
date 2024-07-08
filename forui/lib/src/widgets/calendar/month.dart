part of 'calendar.dart';

const _maxMonthRows = 6; // A 31 day month that starts on Saturday.
const _monthDayDimension = 40.0;

@internal
class Month extends StatefulWidget {
  final FMonthStyle style;
  final DateTime month;
  final DateTime today;
  final DateTime? focused;
  final bool Function(DateTime day) enabledPredicate;
  final bool Function(DateTime day) selectedPredicate;
  final ValueChanged<DateTime> onPress;
  final ValueChanged<DateTime> onLongPress;

  const Month({
    required this.style,
    required this.month,
    required this.today,
    required this.focused,
    required this.enabledPredicate,
    required this.selectedPredicate,
    required this.onPress,
    required this.onLongPress,
    super.key,
  });

  @override
  State createState() => _MonthState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(ObjectFlagProperty('enabledPredicate', enabledPredicate, ifNull: 'null'))
      ..add(ObjectFlagProperty('selectedPredicate', selectedPredicate, ifNull: 'null'))
      ..add(ObjectFlagProperty('onPress', onPress, ifNull: 'null'))
      ..add(ObjectFlagProperty('onLongPress', onLongPress, ifNull: 'null'));
  }
}

class _MonthState extends State<Month> {
  List<FocusNode> _dayFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _dayFocusNodes = [
      for (int i = 0; i < (DateTime.daysPerWeek * _maxMonthRows); i++) FocusNode(skipTraversal: true, debugLabel: 'Day $i'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final (first, last) = _range(context);
    return GridView.custom(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const _GridDelegate(),
      childrenDelegate: SliverChildListDelegate(
        [
          ..._headers(context),
          for (var date = first, i = 0; date.isBefore(last) || date.isAtSameMomentAs(last); date = date.plus(days: 1), i++)
            day(
              widget.style,
              date,
              _dayFocusNodes[i],
              widget.onPress,
              widget.onLongPress,
              enabled: widget.enabledPredicate(date),
              current: date.month == widget.month.month,
              today: date == widget.today,
              selected: widget.selectedPredicate(date),
            ),
        ],
        addRepaintBoundaries: false,
      ),
    );
  }

  (DateTime, DateTime) _range(BuildContext context) {
    final firstDayOfWeek = widget.style.startDayOfWeek ?? DateTime.sunday; // TODO: Localization
    final firstDayOfMonth = widget.month.firstDayOfMonth;
    var difference = firstDayOfMonth.weekday - firstDayOfWeek;
    if (difference < 0) {
      difference += 7;
    }

    final first = firstDayOfMonth.minus(days: difference);

    final lastDayOfWeek = firstDayOfWeek == DateTime.monday ? DateTime.sunday : firstDayOfWeek - 1;
    final lastDayOfMonth = widget.month.lastDayOfMonth;
    difference = lastDayOfWeek - lastDayOfMonth.weekday;
    if (difference < 0) {
      difference += 7;
    }

    final last = lastDayOfMonth.plus(days: difference);

    return (first, last);
  }

  List<Widget> _headers(BuildContext context) {
    final firstDayOfWeek = widget.style.startDayOfWeek ?? DateTime.sunday; // TODO: Localization
    final narrowWeekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']; // TODO: Localization

    return [
      for (int i = firstDayOfWeek, j = 0; j < DateTime.daysPerWeek; i = (i + 1) % DateTime.daysPerWeek, j++)
        ExcludeSemantics(
          child: Center(child: Text(narrowWeekdays[i - 1], style: widget.style.headerTextStyle)),
        ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final focused = widget.focused;
    if (focused != null && focused.month == widget.month.month) {
      _dayFocusNodes[focused.day - 1].requestFocus(); // TODO: fix this
    }
  }

  @override
  void dispose() {
    for (final node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}

/// Based on Material [CalendarDatePicker]'s _DayPickerGridDelegate.
class _GridDelegate extends SliverGridDelegate {
  const _GridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) => SliverGridRegularTileLayout(
      childCrossAxisExtent: _monthDayDimension,
      childMainAxisExtent: _monthDayDimension,
      crossAxisCount: DateTime.daysPerWeek,
      crossAxisStride: _monthDayDimension,
      mainAxisStride: _monthDayDimension,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );

  @override
  bool shouldRelayout(_GridDelegate oldDelegate) => false;
}

/// A month's style.
final class FMonthStyle with Diagnosticable {
  /// The text style for the day of th week headers.
  final TextStyle headerTextStyle;

  /// The styles of the current month on display and the enclosing months, when enabled.
  final ({FDayStyle current, FDayStyle enclosing}) enabled;

  /// The styles of the current month on display and the enclosing months, when disabled.
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
    required this.enabled,
    required this.disabled,
    this.startDayOfWeek,
  }) : assert(
          startDayOfWeek == null || (DateTime.monday <= startDayOfWeek && startDayOfWeek <= DateTime.sunday),
          'startDayOfWeek must be between DateTime.monday (1) and DateTime.sunday (7).',
        );

  /// Creates a [FMonthStyle] that inherits from the given [colorScheme] and [typography].
  factory FMonthStyle.inherit({required FColorScheme colorScheme, required FTypography typography}) {
    final textStyle = typography.sm.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w500);
    final mutedTextStyle = typography.sm.copyWith(color: colorScheme.mutedForeground.withOpacity(0.5), fontWeight: FontWeight.w500);

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
      headerTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
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
            textStyle: typography.sm.copyWith(color: colorScheme.background, fontWeight: FontWeight.w500),
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
  /// final style = FMonthStyle(
  ///   headerTextStyle: ...,
  ///   enabledCurrent: ...,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(
  ///   enabledCurrent: ...,
  /// );
  ///
  /// print(style.headerTextStyle == copy.headerTextStyle); // true
  /// print(style.enabled.current == copy.enabled.current); // false
  /// ```
  FMonthStyle copyWith({
    TextStyle? headerTextStyle,
    FDayStyle? enabledCurrent,
    FDayStyle? enabledEnclosing,
    FDayStyle? disabledCurrent,
    FDayStyle? disabledEnclosing,
    int? startDayOfWeek,
  }) =>
      FMonthStyle(
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        enabled: (
          current: enabledCurrent ?? enabled.current,
          enclosing: enabledEnclosing ?? enabled.enclosing,
        ),
        disabled: (
          current: disabledCurrent ?? disabled.current,
          enclosing: disabledEnclosing ?? disabled.enclosing,
        ),
        startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(DiagnosticsProperty('enabled.current', enabled.current))
      ..add(DiagnosticsProperty('enabled.enclosing', enabled.enclosing))
      ..add(DiagnosticsProperty('disabled.current', disabled.current))
      ..add(DiagnosticsProperty('disabled.enclosing', disabled.enclosing))
      ..add(IntProperty('startDayOfWeek', startDayOfWeek));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FMonthStyle &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          enabled == other.enabled &&
          disabled == other.disabled &&
          startDayOfWeek == other.startDayOfWeek;

  @override
  int get hashCode => headerTextStyle.hashCode ^ enabled.hashCode ^ disabled.hashCode ^ startDayOfWeek.hashCode;
}
