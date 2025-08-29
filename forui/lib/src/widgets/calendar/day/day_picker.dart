import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/calendar/shared/entry.dart';

part 'day_picker.design.dart';

@internal
class DayPicker extends StatefulWidget {
  static const maxRows = 7;

  final FCalendarDayPickerStyle style;
  final FLocalizations localization;
  final ValueWidgetBuilder<FCalendarDayData> dayBuilder;
  final LocalDate month;
  final LocalDate today;
  final LocalDate? focused;
  final Predicate<LocalDate> selectable;
  final Predicate<LocalDate> selected;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate> onLongPress;

  const DayPicker({
    required this.style,
    required this.localization,
    required this.dayBuilder,
    required this.month,
    required this.today,
    required this.focused,
    required this.selectable,
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
      ..add(DiagnosticsProperty('localization', localization))
      ..add(ObjectFlagProperty.has('dayBuilder', dayBuilder))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('today', today))
      ..add(DiagnosticsProperty('focused', focused))
      ..add(ObjectFlagProperty.has('selectable', selectable))
      ..add(ObjectFlagProperty.has('selected', selected))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
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
    final firstDayOfWeek = widget.style.startDayOfWeek ?? widget.localization.firstDayOfWeek;
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
    width: DateTime.daysPerWeek * widget.style.tileSize,
    child: GridView.custom(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: _GridDelegate(widget.style.tileSize),
      childrenDelegate: SliverChildListDelegate(addRepaintBoundaries: false, [
        ..._headers(context),
        for (final MapEntry(key: date, value: focusNode) in _days.entries)
          Entry.day(
            style: widget.style,
            localizations: widget.localization,
            dayBuilder: widget.dayBuilder,
            date: date,
            focusNode: focusNode,
            current: date.month == widget.month.month,
            today: date == widget.today,
            selectable: widget.selectable,
            selected: widget.selected,
            onPress: widget.onPress,
            onLongPress: widget.onLongPress,
          ),
      ]),
    ),
  );

  List<Widget> _headers(BuildContext _) {
    final firstDayOfWeek = widget.style.startDayOfWeek ?? widget.localization.firstDayOfWeek;
    final narrowWeekdays = widget.localization.narrowWeekDays;

    return [
      for (int i = firstDayOfWeek, j = 0; j < DateTime.daysPerWeek; i++, j++)
        ExcludeSemantics(
          child: Center(child: Text(narrowWeekdays[i % DateTime.daysPerWeek], style: widget.style.headerTextStyle)),
        ),
    ];
  }

  @override
  void didUpdateWidget(DayPicker old) {
    super.didUpdateWidget(old);
    assert(old.month == widget.month, 'Current month must not change.');

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

// Based on Material [CalendarDatePicker]'s _DayPickerGridDelegate.
class _GridDelegate extends SliverGridDelegate {
  final double tileSize;

  const _GridDelegate(this.tileSize);

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) => SliverGridRegularTileLayout(
    childCrossAxisExtent: tileSize,
    childMainAxisExtent: tileSize,
    crossAxisCount: DateTime.daysPerWeek,
    crossAxisStride: tileSize,
    mainAxisStride: tileSize,
    reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
  );

  @override
  bool shouldRelayout(_GridDelegate oldDelegate) => tileSize != oldDelegate.tileSize;
}

/// A day picker's style.
class FCalendarDayPickerStyle with Diagnosticable, _$FCalendarDayPickerStyleFunctions {
  /// The text style for the day of th week headers.
  @override
  final TextStyle headerTextStyle;

  /// The styles of dates in the current month.
  @override
  final FCalendarEntryStyle current;

  /// The styles of dates in the enclosing months.
  @override
  final FCalendarEntryStyle enclosing;

  /// The starting day of the week. Defaults to the current locale's preferred starting day of the week if null.
  ///
  /// Specifying [startDayOfWeek] will override the current locale's preferred starting day of the week.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [startDayOfWeek] < [DateTime.monday]
  /// * [DateTime.sunday] < [startDayOfWeek]
  @override
  final int? startDayOfWeek;

  /// The tile's size. Defaults to 42.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [tileSize] is not positive.
  @override
  final double tileSize;

  /// Creates a [FCalendarDayPickerStyle].
  const FCalendarDayPickerStyle({
    required this.headerTextStyle,
    required this.current,
    required this.enclosing,
    this.startDayOfWeek,
    this.tileSize = 42,
  }) : assert(
         startDayOfWeek == null || (DateTime.monday <= startDayOfWeek && startDayOfWeek <= DateTime.sunday),
         'startDayOfWeek ($startDayOfWeek) must be between DateTime.monday (1) and DateTime.sunday (7)',
       ),
       assert(0 < tileSize, 'tileSize ($tileSize) must be positive');

  /// Creates a [FCalendarDayPickerStyle] that inherits its properties.
  factory FCalendarDayPickerStyle.inherit({required FColors colors, required FTypography typography}) {
    final mutedTextStyle = typography.base.copyWith(
      color: colors.disable(colors.mutedForeground),
      fontWeight: FontWeight.w500,
    );

    final background = {
      WidgetState.disabled & WidgetState.selected: colors.primaryForeground,
      WidgetState.disabled: colors.background,
    };

    final border = {
      WidgetState.disabled & WidgetState.selected & WidgetState.focused: colors.primaryForeground,
      WidgetState.disabled & WidgetState.focused: colors.background,
      WidgetState.focused: colors.foreground,
    };

    return FCalendarDayPickerStyle(
      headerTextStyle: typography.xs.copyWith(color: colors.mutedForeground),
      current: FCalendarEntryStyle(
        backgroundColor: FWidgetStateMap({
          ...background,
          WidgetState.selected: colors.foreground,
          ~WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): colors.secondary,
          WidgetState.any: colors.background,
        }),
        borderColor: FWidgetStateMap(border),
        textStyle: FWidgetStateMap({
          WidgetState.disabled: mutedTextStyle,
          WidgetState.selected: typography.base.copyWith(color: colors.background, fontWeight: FontWeight.w500),
          WidgetState.any: typography.base.copyWith(color: colors.foreground, fontWeight: FontWeight.w500),
        }),
        radius: const Radius.circular(4),
      ),
      enclosing: FCalendarEntryStyle(
        backgroundColor: FWidgetStateMap({
          ...background,
          WidgetState.selected: colors.primaryForeground,
          ~WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): colors.secondary,
          WidgetState.any: colors.background,
        }),
        borderColor: FWidgetStateMap(border),
        textStyle: FWidgetStateMap.all(mutedTextStyle),
        radius: const Radius.circular(4),
      ),
    );
  }
}
