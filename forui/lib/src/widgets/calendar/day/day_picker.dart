import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/shared/entry.dart';

@internal
class DayPicker extends StatefulWidget {
  static const maxRows = 7;
  static const tileDimension = 42.0;

  final FCalendarDayPickerStyle style;
  final LocalDate month;
  final LocalDate today;
  final LocalDate? focused;
  final Predicate<LocalDate> canSelect;
  final Predicate<LocalDate> selected;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  const DayPicker({
    required this.style,
    required this.month,
    required this.today,
    required this.focused,
    required this.canSelect,
    required this.selected,
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
      ..add(DiagnosticsProperty('selectable', canSelect))
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('onPress', onPress))
      ..add(DiagnosticsProperty('onLongPress', onLongPress));
  }
}

class _DayPickerState extends State<DayPicker> {
  final SplayTreeMap<LocalDate, FocusNode> _days = SplayTreeMap();

  @override
  void initState() {
    super.initState();

    final (first, last) = _range;
    for (var date = first; date <= last; date = date.tomorrow) {
      _days[date] = FocusNode(skipTraversal: true, debugLabel: '$date');
    }

    if (_days[widget.focused] case final focusNode?) {
      focusNode.requestFocus();
    }
  }

  (LocalDate, LocalDate) get _range {
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

  @override
  Widget build(BuildContext context) => SizedBox(
        width: DateTime.daysPerWeek * DayPicker.tileDimension,
        child: GridView.custom(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const _GridDelegate(),
          childrenDelegate: SliverChildListDelegate(
            addRepaintBoundaries: false,
            [
              ..._headers(context),
              for (final MapEntry(key: date, value: focusNode) in _days.entries)
                Entry.day(
                  style: widget.style,
                  date: date,
                  focusNode: focusNode,
                  current: date.month == widget.month.month,
                  today: date == widget.today,
                  canSelect: widget.canSelect,
                  selected: widget.selected,
                  onPress: widget.onPress,
                  onLongPress: widget.onLongPress,
                ),
            ],
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
    assert(old.month == widget.month, 'current month must not change.');

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
        childCrossAxisExtent: DayPicker.tileDimension,
        childMainAxisExtent: DayPicker.tileDimension,
        crossAxisCount: DateTime.daysPerWeek,
        crossAxisStride: DayPicker.tileDimension,
        mainAxisStride: DayPicker.tileDimension,
        reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
      );

  @override
  bool shouldRelayout(_GridDelegate oldDelegate) => false;
}

/// A day picker's style.
final class FCalendarDayPickerStyle with Diagnosticable {
  /// The text style for the day of th week headers.
  final TextStyle headerTextStyle;

  /// The styles of selectable dates in the current month on display and the enclosing months.
  final ({FCalendarDayStyle current, FCalendarDayStyle enclosing}) selectableStyles;

  /// The styles of unselectable dates in the current month on display and the enclosing months.
  final ({FCalendarDayStyle current, FCalendarDayStyle enclosing}) unselectableStyles;

  /// The starting day of the week. Defaults to the current locale's preferred starting day of the week if null.
  ///
  /// Specifying [startDayOfWeek] will override the current locale's preferred starting day of the week.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [startDayOfWeek] < [DateTime.monday]
  /// * [DateTime.sunday] < [startDayOfWeek]
  final int? startDayOfWeek;

  /// Creates a [FCalendarDayPickerStyle].
  const FCalendarDayPickerStyle({
    required this.headerTextStyle,
    required this.selectableStyles,
    required this.unselectableStyles,
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
      selectedStyle: FCalendarEntryStyle(
        backgroundColor: colorScheme.primaryForeground,
        textStyle: mutedTextStyle,
        focusedBorderColor: colorScheme.primaryForeground,
        radius: const Radius.circular(4),
      ),
      unselectedStyle: FCalendarEntryStyle(
        backgroundColor: colorScheme.background,
        textStyle: mutedTextStyle,
        focusedBorderColor: colorScheme.background,
        radius: const Radius.circular(4),
      ),
    );

    return FCalendarDayPickerStyle(
      headerTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
      selectableStyles: (
        current: FCalendarDayStyle(
          selectedStyle: FCalendarEntryStyle(
            backgroundColor: colorScheme.foreground,
            textStyle: typography.sm.copyWith(color: colorScheme.background, fontWeight: FontWeight.w500),
            focusedBorderColor: colorScheme.foreground,
            radius: const Radius.circular(4),
          ),
          unselectedStyle: FCalendarEntryStyle(
            backgroundColor: colorScheme.background,
            textStyle: textStyle,
            hoveredBackgroundColor: colorScheme.secondary,
            focusedBorderColor: colorScheme.foreground,
            radius: const Radius.circular(4),
          ),
        ),
        enclosing: FCalendarDayStyle(
          selectedStyle: FCalendarEntryStyle(
            backgroundColor: colorScheme.primaryForeground,
            textStyle: mutedTextStyle,
            focusedBorderColor: colorScheme.foreground,
            radius: const Radius.circular(4),
          ),
          unselectedStyle: FCalendarEntryStyle(
            backgroundColor: colorScheme.background,
            textStyle: mutedTextStyle,
            hoveredBackgroundColor: colorScheme.primaryForeground,
            focusedBorderColor: colorScheme.foreground,
            radius: const Radius.circular(4),
          ),
        ),
      ),
      unselectableStyles: (current: disabled, enclosing: disabled),
    );
  }

  /// Returns a copy of this [FCalendarDayPickerStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FMonthStyle(
  ///   headerTextStyle: ...,
  ///   selectableCurrent: ...,
  ///   // Other arguments omitted for brevity.
  /// );
  ///
  /// final copy = style.copyWith(
  ///   selectableCurrent: ...,
  /// );
  ///
  /// print(style.headerTextStyle == copy.headerTextStyle); // true
  /// print(style.selectableStyles.current == copy.selectableStyles.current); // false
  /// ```
  @useResult
  FCalendarDayPickerStyle copyWith({
    TextStyle? headerTextStyle,
    FCalendarDayStyle? selectableCurrent,
    FCalendarDayStyle? selectableEnclosing,
    FCalendarDayStyle? unselectableCurrent,
    FCalendarDayStyle? unselectableEnclosing,
    int? startDayOfWeek,
  }) =>
      FCalendarDayPickerStyle(
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        selectableStyles: (
          current: selectableCurrent ?? selectableStyles.current,
          enclosing: selectableEnclosing ?? selectableStyles.enclosing,
        ),
        unselectableStyles: (
          current: unselectableCurrent ?? unselectableStyles.current,
          enclosing: unselectableEnclosing ?? unselectableStyles.enclosing,
        ),
        startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(DiagnosticsProperty('selectableStyles.current', selectableStyles.current))
      ..add(DiagnosticsProperty('selectableStyles.enclosing', selectableStyles.enclosing))
      ..add(DiagnosticsProperty('unselectableStyles.current', unselectableStyles.current))
      ..add(DiagnosticsProperty('unselectableStyles.enclosing', unselectableStyles.enclosing))
      ..add(IntProperty('startDayOfWeek', startDayOfWeek));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCalendarDayPickerStyle &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          selectableStyles == other.selectableStyles &&
          unselectableStyles == other.unselectableStyles &&
          startDayOfWeek == other.startDayOfWeek;

  @override
  int get hashCode =>
      headerTextStyle.hashCode ^ selectableStyles.hashCode ^ unselectableStyles.hashCode ^ startDayOfWeek.hashCode;
}

/// A calender day's style.
final class FCalendarDayStyle with Diagnosticable {
  /// The selected dates' style.
  final FCalendarEntryStyle selectedStyle;

  /// The unselected dates' style.
  final FCalendarEntryStyle unselectedStyle;

  /// Creates a [FCalendarDayStyle].
  const FCalendarDayStyle({
    required this.unselectedStyle,
    required this.selectedStyle,
  });

  /// Returns a copy of this [FCalendarDayStyle] but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FCalendarDayStyle(
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
  @useResult
  FCalendarDayStyle copyWith({
    FCalendarEntryStyle? selectedStyle,
    FCalendarEntryStyle? unselectedStyle,
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
