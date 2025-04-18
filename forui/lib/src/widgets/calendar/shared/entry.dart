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
  final ValueWidgetBuilder<Set<WidgetState>> builder;

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

    final entryStyle = current ? style.current : style.enclosing;

    Widget builder(BuildContext context, Set<WidgetState> states, Widget? _) {
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
          states: {...states, if (isSelected) WidgetState.selected, if (!canSelect) WidgetState.disabled},
          current: today,
        ),
      );
    }

    return canSelect
        ? _SelectableEntry(
          focusNode: focusNode,
          date: date,
          semanticsLabel: localizations.fullDate(date.toNative()),
          selected: isSelected,
          onPress: onPress,
          onLongPress: onLongPress,
          style: entryStyle,
          builder: builder,
        )
        : _UnselectableEntry(style: entryStyle, builder: builder);
  }

  factory Entry.yearMonth({
    required FCalendarEntryStyle style,
    required LocalDate date,
    required FocusNode focusNode,
    required bool current,
    required bool selectable,
    required ValueChanged<LocalDate> onPress,
    required String Function(LocalDate) format,
  }) {
    Widget builder(BuildContext _, Set<WidgetState> states, Widget? _) => _Content(
      style: style,
      borderRadius: BorderRadius.all(style.radius),
      text: format(date),
      states: {...states, if (!selectable) WidgetState.disabled},
      current: current,
    );

    return selectable
        ? _SelectableEntry(
          focusNode: focusNode,
          date: date,
          semanticsLabel: format(date),
          onPress: onPress,
          style: style,
          builder: builder,
        )
        : _UnselectableEntry(style: style, builder: builder);
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
  final String semanticsLabel;
  final bool selected;
  final ValueChanged<LocalDate> onPress;
  final ValueChanged<LocalDate>? onLongPress;

  const _SelectableEntry({
    required this.focusNode,
    required this.date,
    required this.semanticsLabel,
    required this.onPress,
    required super.style,
    required super.builder,
    this.selected = false,
    this.onLongPress,
  }) : super._();

  @override
  Widget build(BuildContext _) => FTappable(
    semanticsLabel: semanticsLabel,
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
      ..add(StringProperty('semanticLabel', semanticsLabel))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

class _UnselectableEntry extends Entry {
  const _UnselectableEntry({required super.style, required super.builder}) : super._();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(child: builder(context, {}, null));
}

class _Content extends StatelessWidget {
  final FCalendarEntryStyle style;
  final BorderRadiusGeometry borderRadius;
  final String text;
  final Set<WidgetState> states;
  final bool current;

  const _Content({
    required this.style,
    required this.borderRadius,
    required this.text,
    required this.states,
    required this.current,
  });

  @override
  Widget build(BuildContext _) {
    var textStyle = style.textStyle.resolve(states);
    if (current) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    final borderColor = style.borderColor.resolve(states);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: borderColor == null ? null : Border.all(color: borderColor),
        borderRadius: borderRadius,
        color: style.backgroundColor.resolve(states),
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
      ..add(StringProperty('state', states.toString()))
      ..add(FlagProperty('current', value: current, ifTrue: 'current'));
  }
}

/// A calendar entry's style.
final class FCalendarEntryStyle with Diagnosticable, _$FCalendarEntryStyleFunctions {
  /// The day's background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Color> backgroundColor;

  /// The border.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Color?> borderColor;

  /// The day's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The entry border's radius. Defaults to `Radius.circular(4)`.
  @override
  final Radius radius;

  /// Creates a [FCalendarEntryStyle].
  FCalendarEntryStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textStyle,
    required this.radius,
  });
}
