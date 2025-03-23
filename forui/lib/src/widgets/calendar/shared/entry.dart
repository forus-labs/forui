import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

part 'entry.style.dart';

/// A calendar day's data.
typedef FCalendarDayData =
    ({FCalendarDayPickerStyle style, DateTime date, bool current, bool today, bool selectable, bool selected});

@internal
abstract class Entry extends StatelessWidget {
  final FCalendarEntryStyle style;
  final ValueWidgetBuilder<FTappableData> builder;

  factory Entry.day({
    required FCalendarDayPickerStyle style,
    required FLocalizations localizations,
    required ValueWidgetBuilder<FCalendarDayData> dayBuilder,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool today,
    required Predicate<LocalDate> selectable,
    required Predicate<LocalDate> selected,
    required ValueChanged<LocalDate> onPress,
    required ValueChanged<LocalDate> onLongPress,
  }) {
    final canSelect = selectable(date);
    final isSelected = selected(date);

    final styles = canSelect ? style.selectableStyles : style.unselectableStyles;
    final dayStyle = current ? styles.current : styles.enclosing;
    final entryStyle = isSelected ? dayStyle.selectedStyle : dayStyle.unselectedStyle;

    Widget builder(BuildContext context, FTappableData data, Widget? _) {
      final yesterday = isSelected && selected(date.yesterday) ? Radius.zero : entryStyle.radius;
      final tomorrow = isSelected && selected(date.tomorrow) ? Radius.zero : entryStyle.radius;
      return dayBuilder(
        context,
        (
          style: style,
          date: date.toNative(),
          current: current,
          today: today,
          selectable: canSelect,
          selected: isSelected,
        ),
        _Content(
          style: entryStyle,
          borderRadius: BorderRadiusDirectional.horizontal(start: yesterday, end: tomorrow),
          text: (FLocalizations.of(context) ?? FDefaultLocalizations()).day(date.toNative()),
          data: data,
          current: today,
        ),
      );
    }

    return canSelect
        ? _SelectableEntry(
          focusNode: focusNode,
          date: date,
          semanticLabel: localizations.fullDate(date.toNative()),
          selected: isSelected,
          onPress: onPress,
          onLongPress: onLongPress,
          style: entryStyle,
          builder: builder,
        )
        : _UnselectableEntry(style: entryStyle, builder: builder);
  }

  factory Entry.yearMonth({
    required FCalendarYearMonthPickerStyle style,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool selectable,
    required ValueChanged<LocalDate> onPress,
    required String Function(LocalDate) format,
  }) {
    final entryStyle = selectable ? style.enabledStyle : style.disabledStyle;

    Widget builder(BuildContext _, FTappableData data, Widget? _) => _Content(
      style: entryStyle,
      borderRadius: BorderRadius.all(entryStyle.radius),
      text: format(date),
      data: data,
      current: current,
    );

    return selectable
        ? _SelectableEntry(
          focusNode: focusNode,
          date: date,
          semanticLabel: format(date),
          onPress: onPress,
          style: entryStyle,
          builder: builder,
        )
        : _UnselectableEntry(style: entryStyle, builder: builder);
  }

  const Entry._({required this.style, required this.builder});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _SelectableEntry extends Entry {
  final FocusNode focusNode;
  final LocalDate date;
  final String semanticLabel;
  final bool selected;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate>? onLongPress;

  const _SelectableEntry({
    required this.focusNode,
    required this.date,
    required this.semanticLabel,
    required this.onPress,
    required super.style,
    required super.builder,
    this.selected = false,
    this.onLongPress,
  }) : super._();

  @override
  Widget build(BuildContext _) => FTappable(
    style: style.tappableStyle,
    semanticLabel: semanticLabel,
    semanticSelected: selected,
    focusNode: focusNode,
    excludeSemantics: true,
    onPress: () => onPress(date),
    onLongPress: () => onLongPress?.call(date),
    builder: builder,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(DiagnosticsProperty('date', date))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

class _UnselectableEntry extends Entry {
  const _UnselectableEntry({required super.style, required super.builder}) : super._();

  @override
  Widget build(BuildContext context) =>
      ExcludeSemantics(child: builder(context, (focused: false, hovered: false, pressed: false), null));
}

class _Content extends StatelessWidget {
  final FCalendarEntryStyle style;
  final BorderRadiusGeometry borderRadius;
  final String text;
  final FTappableData data;
  final bool current;

  const _Content({
    required this.style,
    required this.borderRadius,
    required this.text,
    required this.data,
    required this.current,
  });

  @override
  Widget build(BuildContext _) {
    var textStyle = data.hovered || data.pressed ? style.hoveredTextStyle : style.textStyle;
    if (current) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: data.focused ? Border.all(color: style.focusedBorderColor) : null,
        borderRadius: borderRadius,
        color: data.hovered || data.pressed ? style.hoveredBackgroundColor : style.backgroundColor,
      ),
      child: Center(child: Text(text, style: textStyle)),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(StringProperty('text', text))
      ..add(StringProperty('state', data.toString()))
      ..add(FlagProperty('current', value: current, ifTrue: 'current'));
  }
}

/// A calendar entry's style.
final class FCalendarEntryStyle with Diagnosticable, _$FCalendarEntryStyleFunctions {
  /// The day's background color.
  @override
  final Color backgroundColor;

  /// The day's text style.
  @override
  final TextStyle textStyle;

  /// The hovered day's background color. Defaults to [backgroundColor].
  @override
  final Color hoveredBackgroundColor;

  /// The hovered day's text style. Defaults to [textStyle].
  @override
  final TextStyle hoveredTextStyle;

  /// The border color when an entry is focused.
  @override
  final Color focusedBorderColor;

  /// The entry border's radius. Defaults to `Radius.circular(4)`.
  @override
  final Radius radius;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FCalendarEntryStyle].
  FCalendarEntryStyle({
    required this.backgroundColor,
    required this.textStyle,
    required this.focusedBorderColor,
    required this.radius,
    required this.tappableStyle,
    Color? hoveredBackgroundColor,
    TextStyle? hoveredTextStyle,
  }) : hoveredBackgroundColor = hoveredBackgroundColor ?? backgroundColor,
       hoveredTextStyle = hoveredTextStyle ?? textStyle;
}
