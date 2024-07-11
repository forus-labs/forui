part of '../calendar.dart';

/// The maximum number of rows in a month. In this case, a 31 day month that starts on Saturday.
@internal
const maxDayPickerGridRows = 7;

/// The height & width of a day in a [DayPicker].
@internal
const maxDayPickerTileDimension = 42.0;

@internal
class DayPicker extends StatefulWidget {
  final FCalendarDayPickerStyle style;
  final LocalDate month;
  final LocalDate today;
  final LocalDate? focused;
  final bool Function(LocalDate day) enabledPredicate;
  final bool Function(LocalDate day) selectedPredicate;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  const DayPicker({
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
  State createState() => _DayPickerState();

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

class _DayPickerState extends State<DayPicker> {
  final SplayTreeMap<LocalDate, FocusNode> _days = SplayTreeMap();

  @override
  void initState() {
    super.initState();

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
    for (var date = first; date <= last; date = date.tomorrow) {
      _days[date] = FocusNode(skipTraversal: true, debugLabel: '$date');
    }

    if (_days[widget.focused] case final focusNode?) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      width: DateTime.daysPerWeek * maxDayPickerTileDimension,
      child: GridView.custom(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const _GridDelegate(),
        childrenDelegate: SliverChildListDelegate(
          [
            ..._headers(context),
            for (final MapEntry(key: date, value: focusNode) in _days.entries)
              day(
                widget.style,
                date,
                focusNode,
                widget.selectedPredicate,
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
      ),
    );

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
  void didUpdateWidget(DayPicker old) {
    super.didUpdateWidget(old);
    assert(old.month == widget.month, 'We assumed that a new DayPicker is created each time we navigate to a new month.');

    if (_days[widget.focused] case final focusNode? when old.focused != widget.focused) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _days.values) {
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
        childCrossAxisExtent: maxDayPickerTileDimension,
        childMainAxisExtent: maxDayPickerTileDimension,
        crossAxisCount: DateTime.daysPerWeek,
        crossAxisStride: maxDayPickerTileDimension,
        mainAxisStride: maxDayPickerTileDimension,
        reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
      );

  @override
  bool shouldRelayout(_GridDelegate oldDelegate) => false;
}

/// A day picker's style.
final class FCalendarDayPickerStyle with Diagnosticable {
  /// The text style for the day of th week headers.
  final TextStyle headerTextStyle;

  /// The styles of the current month on display and the enclosing months, when enabled.
  final ({FCalendarDayStyle current, FCalendarDayStyle enclosing}) enabledStyles;

  /// The styles of the current month on display and the enclosing months, when disabled.
  final ({FCalendarDayStyle current, FCalendarDayStyle enclosing}) disabledStyles;

  /// The starting day of the week. Defaults to the current locale's preferred starting day of the week if null.
  ///
  /// Specifying [startDayOfWeek] will override the current locale's preferred starting day of the week.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * [startDayOfWeek] < [DateTime.monday]
  /// * [DateTime.sunday] < [startDayOfWeek]
  final int? startDayOfWeek;

  /// Creates a [FCalendarDayPickerStyle].
  const FCalendarDayPickerStyle({
    required this.headerTextStyle,
    required this.enabledStyles,
    required this.disabledStyles,
    this.startDayOfWeek,
  }) : assert(
          startDayOfWeek == null || (DateTime.monday <= startDayOfWeek && startDayOfWeek <= DateTime.sunday),
          'startDayOfWeek must be between DateTime.monday (1) and DateTime.sunday (7).',
        );

  /// Creates a [FCalendarDayPickerStyle] that inherits from the given [colorScheme] and [typography].
  factory FCalendarDayPickerStyle.inherit({required FColorScheme colorScheme, required FTypography typography}) {
    final textStyle = typography.sm.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w500);
    final mutedTextStyle =
        typography.sm.copyWith(color: colorScheme.mutedForeground.withOpacity(0.5), fontWeight: FontWeight.w500);

    final disabled = FCalendarDayStyle(
      selectedStyle: FCalendarDayStateStyle.inherit(
        backgroundColor: colorScheme.primaryForeground,
        textStyle: mutedTextStyle,
      ),
      unselectedStyle: FCalendarDayStateStyle.inherit(
        backgroundColor: colorScheme.background,
        textStyle: mutedTextStyle,
      ),
    );

    return FCalendarDayPickerStyle(
      headerTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
      enabledStyles: (
        current: FCalendarDayStyle(
          selectedStyle: FCalendarDayStateStyle.inherit(
            backgroundColor: colorScheme.foreground,
            textStyle: typography.sm.copyWith(color: colorScheme.background, fontWeight: FontWeight.w500),
          ),
          unselectedStyle: FCalendarDayStateStyle.inherit(
            backgroundColor: colorScheme.background,
            textStyle: textStyle,
            focusedBackgroundColor: colorScheme.secondary,
          ),
        ),
        enclosing: FCalendarDayStyle(
          selectedStyle: FCalendarDayStateStyle.inherit(
            backgroundColor: colorScheme.primaryForeground,
            textStyle: mutedTextStyle,
          ),
          unselectedStyle: FCalendarDayStateStyle.inherit(
            backgroundColor: colorScheme.background,
            textStyle: mutedTextStyle,
            focusedBackgroundColor: colorScheme.primaryForeground,
          ),
        ),
      ),
      disabledStyles: (
        current: disabled,
        enclosing: disabled,
      ),
    );
  }

  /// Returns a copy of this [FCalendarDayPickerStyle] but with the given fields replaced with the new values.
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
  FCalendarDayPickerStyle copyWith({
    TextStyle? headerTextStyle,
    FCalendarDayStyle? enabledCurrent,
    FCalendarDayStyle? enabledEnclosing,
    FCalendarDayStyle? disabledCurrent,
    FCalendarDayStyle? disabledEnclosing,
    int? startDayOfWeek,
  }) =>
      FCalendarDayPickerStyle(
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        enabledStyles: (
          current: enabledCurrent ?? enabledStyles.current,
          enclosing: enabledEnclosing ?? enabledStyles.enclosing,
        ),
        disabledStyles: (
          current: disabledCurrent ?? disabledStyles.current,
          enclosing: disabledEnclosing ?? disabledStyles.enclosing,
        ),
        startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(DiagnosticsProperty('enabled.current', enabledStyles.current))
      ..add(DiagnosticsProperty('enabled.enclosing', enabledStyles.enclosing))
      ..add(DiagnosticsProperty('disabled.current', disabledStyles.current))
      ..add(DiagnosticsProperty('disabled.enclosing', disabledStyles.enclosing))
      ..add(IntProperty('startDayOfWeek', startDayOfWeek));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarDayPickerStyle &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          enabledStyles == other.enabledStyles &&
          disabledStyles == other.disabledStyles &&
          startDayOfWeek == other.startDayOfWeek;

  @override
  int get hashCode => headerTextStyle.hashCode ^ enabledStyles.hashCode ^ disabledStyles.hashCode ^ startDayOfWeek.hashCode;
}
